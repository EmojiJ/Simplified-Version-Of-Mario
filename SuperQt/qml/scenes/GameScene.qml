import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../levels"
import "../common"
import "../gameElements"

SceneBase{
   id: gameScene

    width: 480
    height: 320
    gridSize: 32

    property int offsetBeforeScrollingStarts: 240
    property bool gameRunning: false
    property alias pass:passRec.visible

    property alias dieRec: infoRec.visible

    property alias level1Visible:level1.visible
    property alias level2Visible: level2.visible

    property int levelFlag: 0


    Rectangle {
        anchors.fill: gameScene.gameWindowAnchorItem
        color: "#74d6f7"
    }

    //背景视觉层
    ParallaxScrollingBackground {
        id:bcg1
        sourceImage: "../../assets/background/layer2.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // 设置和player相同速度
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
        // 和比率想乘产生视觉差
        ratio: Qt.point(0.3,0)
    }
    ParallaxScrollingBackground {
        id:bcg2
        sourceImage: "../../assets/background/layer1.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
        ratio: Qt.point(0.6,0)
    }



    // this is the moving item containing the level and player
    Item {
        id: viewPort
        height: level1.height
        width: level1.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-player.x : 0

        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 25)

        }



        EntityManager {
            id: entityManager
            entityContainer: levelFlag === 0 ? level1 : level2
        }

        Level1 {
            id: level1
            visible: true
        }

        Levels2{
            id:level2
            visible:false
        }

        Player {
            id: player
            x: 20
            y: 100
        }

        ResetSensor {
            id:resetsensor
            width: player.width
            height: 10
            x: player.x
            anchors.bottom: viewPort.bottom

            onContact: {
                gameRunning = false
                audio.closePlayMusic()
                infoRec.visible = true
            }


            Rectangle {
               // anchors.fill: parent
                anchors.top: parent.bottom
                color: "yellow"
                opacity: 0.5
            }
        }
    }
    Timer{
        id: gameTimer
        running: gameRunning
        repeat: true

        onTriggered:{
            player.time--
            if(player.time === 0)
            {
                gameRunning = false
                audio.closePlayMusic()
                infoRec.visible = true

            }
        }

    }

    Row {
        anchors.top: parent.top
        z: 2

        Text {id:scoreText;width:100; color: "#00ff00";height:40; font.pixelSize: 20;text:"Score:" + player.score}

        Text {id:timeText; height:40;
            color:"deeppink";font.pixelSize: 20;text:"Time: "+player.time}
    }

    Rectangle{
        id:infoRec
        visible: false
        width: 380
        height: 250
        z:10
        radius: height / 10

        anchors.centerIn: parent
        color:"lightgrey"

        Text{
            id:text1
            text:"Game Over!"
            color: "red"
            anchors.centerIn: parent
            font.pixelSize:  20
            font.family: "Arial"
        }

        Rectangle{
            id:rec1
            height:60
            width:80
            color: parent.color
            //color: "lightgrey"
            radius: height
           // visible: false

           anchors.left: parent.left
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 10
           anchors.leftMargin: 60

           Text {
               anchors.centerIn: parent
               text: "Restart"
               color: "darkblue"
               font.pixelSize: 14
               font.family: "Arial"

              MouseArea {
                                   anchors.fill: parent
                                   onClicked: {


                                       audio.playSound("click")
                                       infoRec.visible = false




                                      // player.contacts = 0
                                       player.x = 20
                                       player.y = 100

                                       player.isBig = false

                                       // reset coins
                                       var coins = entityManager.getEntityArrayByType("coin")
                                       for(var coin in coins) {
                                           coins[coin].reset()
                                       }
                                       level2.setMushroomVisible()
                                       player.resetImageAnchor()

                                       level1.resetBlock()
                                       level2.resetBlock()
                                       player.score = 0
                                       if(levelFlag === 0){
                                           player.time = 25
                                       }
                                       else if(levelFlag === 1){
                                           player.time = 30
                                       }
                                       //player.contacts = 0
                                       player.visible = true
                                       gameRunning = true

                                       //player.contacts = 0

                                       audio.openPlayMusic()
                                   }
                               }
           }
        }

        Rectangle{
            id:rec2
            height:60
            width:80
            color: parent.color
           // color: "lightgrey"
            radius: height
           // visible: false

           anchors.right: parent.right
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 10
           anchors.rightMargin: 60

           Text {
               anchors.centerIn: parent
               text: "Menu"
               color: "green"
               font.pixelSize: 14
               font.family: "Arial"
               MouseArea{
                   anchors.fill: parent
                   onClicked: {
                       audio.playSound("click")
                       infoRec.visible = false
                       //                        gameRunning = true
                       player.x = 20
                       player.y = 100
                       player.score = 0
                       //player.contacts = 0

                       level1.resetBlock()
                       level2.resetBlock()
                       player.visible = true

                       //player.contacts = 0
                       player.time = 25
                       var coins = entityManager.getEntityArrayByType("coin")
                       for(var coin in coins) {
                           coins[coin].reset()
                       }
                       gameWindow.state = "menu"

                   }
               }
           }
        }
    }

  /*      Row{
            x:80
            anchors.bottom:parent.bottom
            Text{
                text:"Restart"
                width: 200
                font.pixelSize:  14
                font.family: "Arial"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        player.visible = true
                        audio.playSound("click")
                        infoRec.visible = false
                        gameRunning = true
                        //reset player's position

                        player.x = 20
                        player.y = 100

                        player.isBig = false
                        // reset coins
                        var coins = entityManager.getEntityArrayByType("coin")
                        for(var coin in coins) {
                            coins[coin].reset()
                        }
                        level2.setMushroomVisible()
                        player.resetImageAnchor()

                        level1.resetBlock()
                        level2.resetBlock()
                        player.score = 0
                        if(levelFlag === 0){
                            player.time = 25
                        }
                        else if(levelFlag === 1){
                            player.time = 30
                        }

                        audio.openPlayMusic()
                    }
                }
            }


            Text{
                text:"Menu"
                height:40
                font.pixelSize:  14
                font.family: "Arial"
                //anchors.fill: parent
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        audio.playSound("click")
                        infoRec.visible = false
                        //                        gameRunning = true
                        player.x = 20
                        player.y = 100
                        player.score = 0
                        player.time = 25
                        var coins = entityManager.getEntityArrayByType("coin")
                        for(var coin in coins) {
                            coins[coin].reset()
                        }
                        gameWindow.state = "menu"
                    }
                }
            }

        }
        */


    Rectangle{
        id:passRec
        visible: false
        width: 380
        height: 250
        z:10
        radius: height / 10
        anchors.centerIn: parent
        color:"lightgreen"
        Text{
            id:text3
            text:"Congratulations,Pass!"
            color: "red"
            anchors.centerIn: parent
            font.pixelSize:  20
            font.family: "Arial"
        }
        Rectangle{
            height:60
            width:80
            color: parent.color
            //color: "lightgreen"
            radius: height
           // visible: false

           anchors.left: parent.left
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 10
           anchors.leftMargin: 60

           Text {
               anchors.centerIn: parent
               text: "Next"
               color: "magenta"
               font.pixelSize: 14
               font.family: "Arial"
               MouseArea{
                   anchors.fill: parent
                   onClicked: {
                       audio.playSound("click")
                       levelFlag = 1
                       passRec.visible = false
                       gameRunning = true
                       level2.resetBlock()
                       level2.setMushroomVisible()

                       level1.visible = false
                       level2.visible = true
                       level2.createAllCoin()
                      //reset player's position

                       player.x = 20
                       player.y = 100
                      // player.contacts = 0
                       player.score = 0
                       player.time = 20
                       audio.openPlayMusic()
                   }
               }
           }
        }

        Rectangle{
            height:60
            width:80
            color: parent.color
            //color: "lightgreen"
            radius: height
           // visible: false

           anchors.right: parent.right
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 10
           anchors.rightMargin: 60

           Text {
               anchors.centerIn: parent
               text: "Menu"
               color: "yellow"
               font.pixelSize: 14
               font.family: "Arial"

               MouseArea{
                   anchors.fill: parent
                   onClicked: {
                       audio.playSound("click")
                       passRec.visible = false
                       //                        gameRunning = true
                       player.x = 20
                       player.y = 100
                     //  player.contacts = 0
                       player.score = 0
                       //player.contacts = 0
                      // player.visible = true
                       level1.resetBlock()
                       level2.resetBlock()
                       player.time = 20
                       var coins = entityManager.getEntityArrayByType("coin")
                       for(var coin in coins) {
                           coins[coin].reset()
                       }
                       gameWindow.state = "menu"

                   }
               }
           }
        }
        /*
        Row{
            x:80
            anchors.bottom:parent.bottom
            Text{
                text:"Next"
                width: 200
                font.pixelSize:  14
                font.family: "Arial"
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        audio.playSound("click")
                        levelFlag = 1
                        passRec.visible = false
                        gameRunning = true
                        level1.visible = false
                        level2.visible = true
                        level2.createAllCoin()
                       //reset player's position

                        player.x = 20
                        player.y = 100
                        player.score = 0
                        player.time = 26
                        audio.openPlayMusic()
                    }
                }
            }


            Text{
                text:"Menu"
                height:40
                font.pixelSize:  14
                font.family: "Arial"
                //anchors.fill: parent
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        audio.playSound("click")
                        passRec.visible = false
                        //                        gameRunning = true
                        player.x = 20
                        player.y = 100
                        player.score = 0
                        player.time = 20
                        var coins = entityManager.getEntityArrayByType("coin")
                        for(var coin in coins) {
                            coins[coin].reset()
                        }
                        gameWindow.state = "menu"

                    }
                }
            }

        }
        */
    }

    MoveTouchButton {
      id: moveTouchButton

      // pass TwoAxisController to moveTouchButton
      controller: controller
    }


    JumpTouchButton {
      id: jumpTouchButton

      onPressed: player.jump(true)
      onReleased: player.endJump()
    }


    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        onInputActionPressed: {
            //            if(gameRunning===true){
            console.debug("key pressed actionName " + actionName)
            if(actionName == "up") {
               if(player.y>=20){
                player.jump(true)
            }
          }
        }
        onInputActionReleased: {
            //end jump when releasing the up button
            if(actionName=="up") {
                player.endJump()
            }
     }
}
}
