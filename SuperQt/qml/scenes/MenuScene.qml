import QtQuick 2.0
import Felgo 3.0
import "../common"

SceneBase{
    id:menuScene

    Rectangle{
        id:bcg
        anchors.fill: menuScene.gameWindowAnchorItem


        gradient: Gradient {
            GradientStop { position: 0.0; color: "#4595e6" }
            GradientStop { position: 0.9; color: "#80bfff" }
            GradientStop { position: 0.95; color: "#009900" }
            GradientStop { position: 1.0; color: "#804c00" }
        }

    }



    Rectangle{
        id:header
        height: 95

        radius: height / 4
        anchors.top: menuScene.gameWindowAnchorItem.top
        anchors.left: menuScene.gameWindowAnchorItem.left
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.margins: 5

        //        color: "#ffcccc"
        color:"#cce6ff"

        MultiResolutionImage {
            fillMode: Image.PreserveAspectFit

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.topMargin: 10

            source: "../../assets/menu/header.png"
        }

    }

    ImageButton{
        id:playButton
        image.source: "../../assets/menu/playButton.png"

        width: 150
        height: 40

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 40
        color: "#cce6ff"
   //     initColor:"#cce6ff"
     //   lastColor:"#cce6ff"

        radius: height / 4
        borderColor: "transparent"

        MouseArea{
            anchors.fill: parent
            onClicked : {
                audio.playSound("click")
                gameWindow.state = "game"
                gameScene.gameRunning = true
                gameScene.level1Visible = true
                gameScene.level2Visible = false
            }
        }


    }


}
