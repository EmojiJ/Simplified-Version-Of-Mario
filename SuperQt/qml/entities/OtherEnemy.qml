import QtQuick 2.0
import Felgo 3.0


EntityBase {
    id: otherEnemy
    entityType: "otherEnemy"
    width: 42
    height: 24

    MultiResolutionImage {
        id: otherImage
        anchors.fill: parent
        source: "../../assets/opponent/spikes.png"
    }

    BoxCollider {
        id: otherCollider
        width: otherImage.width
        height: 8

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        collisionTestingOnlyMode: true
        bodyType: Body.Static

        fixture.onBeginContact: {
            var collidedEntity = other.getBody().target
            var collidedEntityType = collidedEntity.entityType
            if(collidedEntityType === "player"){
                if(player.isBig === false) {
                    //player.visible = false
                    audio.playSound("playerDie")

                    gameScene.dieRec = true
                    jumpTouchButton.deleteJumpButton()
                    moveTouchButton.deleteMoveButton()
                }
                else {
                    player.isBig = false
                    audio.playSound("opponentJumperDie")
                    player.resetImageAnchor()

                }
            }
        }
    }
}
