import Felgo 3.0
import QtQuick 2.0

Item {
  id: jumpTouchButton


  visible: !system.desktopPlatform && gameScene.state !=="menu"
  enabled: visible


  height: 60
  width: 80


  anchors.right: gameScene.gameWindowAnchorItem.right
  anchors.bottom: gameScene.gameWindowAnchorItem.bottom
  anchors.rightMargin: 10

  signal pressed
  signal released

  // ImageButton的背景，只能在按下时可见，作为用户的视觉反馈
  Rectangle {
    id: background

    anchors.fill: parent


    radius: height

    color: "#74d6f7"
    opacity: 0.5

    visible: false
  }

  MultiResolutionImage {
    id: image

    source: "../../assets/ui/arrow_up.png"


    anchors.fill: background

    fillMode: Image.PreserveAspectFit


    scale: 0.5
  }


  MouseArea {
    anchors.fill: parent

    onPressed: {
      jumpTouchButton.pressed() // start jump
      background.visible = true
    }


    onReleased: {
      jumpTouchButton.released()
      background.visible = false
    }
  }
}
