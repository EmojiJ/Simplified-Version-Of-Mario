import Felgo 3.0
import QtQuick 2.0
import "../common"


SceneBase{
    id:menuScene

    Rectangle{
        id:bcg
        anchors.fill: menuScene.gameWindowAnchorItem


        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ccff99" }
            GradientStop { position: 0.9; color: "#ccffcc" }
            GradientStop { position: 1.0; color: "#ffffcc" }
        }

    }



    Rectangle{
        id:header
        height: 95

        radius: 20
        anchors.top: menuScene.gameWindowAnchorItem.top
        anchors.left: menuScene.gameWindowAnchorItem.left
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.margins: 5

                //color: "#ffcccc"
         color:"#ccffcc"

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
        anchors.topMargin: 70

        initColor:"#ffffcc"
        lastColor:"#ffff99"

        borderColor: "transparent"

        MouseArea{
            anchors.fill: parent
            onClicked : {
                audio.playSound("click")
                gameWindow.state = "game"
                gameScene.gameRunning = true

            }
        }


    }
}

