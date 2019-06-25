import QtQuick 2.0
import Felgo 3.0

EntityBase{
    id:finish
    entityType: "finish"

    width:gameScene.gridSize
    height: gameScene.gridSize

    MultiResolutionImage{
        id:finishImage
        source: "../../assets/finish/finish.png"
        anchors.fill: finishCollider
        visible: true
    }

    BoxCollider{
        id:finishCollider
        bodyType: Body.Static
        anchors.fill: parent

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player"){
                gameScene.pass = true
                moveTouchButton.deleteMoveButton()
                jumpTouchButton.deleteJumpButton()
                audio.playSound("finish")
                gameRunning = false
            }
        }




    }

}
