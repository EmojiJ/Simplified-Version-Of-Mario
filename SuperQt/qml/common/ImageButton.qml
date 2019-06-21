import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls.Styles 1.0


GameButton {
    id: imageButton

    height: parent.height

    property int borderWidth: 1
    property color borderColor: "#000000"
    property int radius: 3
    property color initColor:"#ffffff"
    property color lastColor: "#000000"
    property alias image: image
    property alias hoverRectangle: hoverRectangle

    style: ButtonStyle {
        background: Rectangle {
            border.width: imageButton.borderWidth
            border.color: imageButton.borderColor
            radius: imageButton.radius

            gradient: Gradient {
                GradientStop {
                    position: 0.0; color: imageButton.initColor }
                GradientStop {
                    position: 1.0; color: imageButton.lastColor }
            }
        }

    }

    //the image displayed
    MultiResolutionImage{
        id:image

        anchors.fill: parent
        anchors.margins: 1

        fillMode: Image.PreserveAspectFit
    }

    //鼠标悬停在按钮上时，这个矩形略微可见
    Rectangle {
        id: hoverRectangle
        anchors.fill: parent
        radius: imageButton.radius
        color: "white"

        opacity: hovered ? 0.3 : 0
    }
}
