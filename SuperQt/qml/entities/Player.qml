import Felgo 3.0
import QtQuick 2.0

EntityBase {
    id: player
    entityType: "player"
    width: 32
    height: 32


    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x
    property int score: 0
    property int time: 25
    property int jumpForceLeft: 20
    property bool isBig: false
    scale: isBig ? 1 : 0.7

    Behavior on scale {
        NumberAnimation {
            duration: 500
        }
    }

    // contacts属性用于确定玩家是否与任何固体对象（如地面或平台）保持联系，因为在这种情况下玩家正在行走，这使得能够跳跃。 contacts> 0  -->walking state
    property int contacts: 0


    state: contacts > 0 ? "walking" : "jumping"
    onStateChanged: console.debug("player.state " + state)

    // animate player
    MultiResolutionImage {
        id: image
        anchors.bottom: player.bottom

        anchors.bottomMargin: -9
        source: "../../assets/player/run.png"

    }

    BoxCollider {
        id: collider
        height: parent.height
        width: 30
        anchors.horizontalCenter: parent.horizontalCenter
        // 这个collider必须是动态的，因为我们通过施加force和impulses来移动它
        bodyType: Body.Dynamic
        fixedRotation: true // we are running, not rolling...
        bullet: true // 超精度的碰撞检测
        sleepingAllowed: false
        // 应用双轴控制器的水平值作为力来左右移动
        force: Qt.point(controller.xAxis*170*32,0)
        // 限制水平速度
        onLinearVelocityChanged: {
            if(linearVelocity.x > 170) linearVelocity.x = 170
            if(linearVelocity.x < -170) linearVelocity.x = -170
        }

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target

            // contact金币，收集金币，加分加时间
            if(otherEntity.entityType === "coin") {
                console.debug("contact coin begin")
                otherEntity.collect()
                score += 1
                time += 0.5
            }
        }
    }

    Timer {
      id: ascentControl

      // 每隔15ms触发一次定时器
      interval: 15
      repeat: true//if false trigger once at interval and then stop

      onTriggered: {
//jumpForceLeft 大于零， 设置玩家垂直速度让他跳跃
          if(jumpForceLeft > 0) {

          var verticalImpulse = 0

          // 开始跳时设置垂直速度为0,
          // 用一个大的impulse值，以获得高的初始速度
          if(jumpForceLeft == 20) {
            verticalVelocity = 0

            verticalImpulse = -normalJumpForce
          }
          // 更慢的增加垂直速度
          else if(jumpForceLeft >= 14) {
            verticalImpulse = -normalJumpForce / 5
          }
          // 最大跳跃时间大约三分之一后进一步减少verticalImpulse
          else {
            verticalImpulse = -normalJumpForce / 15
          }
          // 随着时间推移减小jumpImpulse可以更自然的跳跃，更精确地控制跳跃高度

          // apply the impulse
          collider.applyLinearImpulse(Qt.point(0, verticalImpulse))

          // decrease jumpForceLeft
          jumpForceLeft--
        }
      }
    }



    // 这个计时器用来减慢玩家水平移动速度
    Timer {
        id: updateTimer
        // set this interval as high as possible to improve performance, but as low as needed so it still looks good
        interval: 60
        running: true
        repeat: true
        onTriggered: {
            var xAxis = controller.xAxis;

            // 如果x轴为0（没有移动命令），我们将玩家放慢速度直到他停下来
            if(xAxis == 0) {
                if(Math.abs(player.horizontalVelocity) > 10) player.horizontalVelocity /= 1.5
                else player.horizontalVelocity = 0
            }
        }
    }

    function jump() {
        console.debug("jump requested at player.state " + state)
        if(player.state == "walking") {
            console.debug("do the jump")
            // 跳跃只需要设置向上速度
            collider.linearVelocity.y = -420
            audio.playSound("playerJump")
        }
    }

    function endJump() {

     ascentControl.stop()
    //reset jumpForceLeft
    jumpForceLeft = 20
    }

    function resizeImageAnchor() {
        image.anchors.bottomMargin = 0
    }

    function resetImageAnchor() {
        image.anchors.bottomMargin = -9
    }
}



