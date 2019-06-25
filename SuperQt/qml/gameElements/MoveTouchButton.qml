import Felgo 3.0
import QtQuick 2.0

Item {
    id:moveTouchButton
  // 只能visible在触控环境下和非menu状态下
  visible: !system.desktopPlatform && gameScene.state !== "menu"
  enabled: visible


  height: 60
  width: 160


  anchors.left: gameScene.gameWindowAnchorItem.left
  anchors.bottom: gameScene.gameWindowAnchorItem.bottom
  anchors.leftMargin: 10

  // 双轴控制器控制player左右移动
  property var controller


  Rectangle {
    id: backgroundLeft


    width: parent.width / 2
    height: parent.height

    anchors.left: parent.left


    radius: height


    color: "#74d6f7"
    opacity: 0.5

    visible: false
  }

  MultiResolutionImage {
    id: imageLeft

    source: "../../assets/ui/arrow_left.png"


    anchors.fill: backgroundLeft

    fillMode: Image.PreserveAspectFit

    scale: 0.5
  }


  Rectangle {
    id: backgroundRight

    width: parent.width / 2
    height: parent.height
    anchors.right: parent.right
    radius: height


    color: "#74d6f7"
    opacity: 0.5
    visible: false
  }

  MultiResolutionImage {
    id: imageRight

    source: "../../assets/ui/arrow_right.png"
    anchors.fill: backgroundRight
    fillMode: Image.PreserveAspectFit

    scale: 0.5
  }


  MultiPointTouchArea {
    anchors.fill: parent

    // 设置点击的x轴位置
    onPressed: {
      if(touchPoints[0].x < width/2) {
        controller.xAxis = -1
        backgroundLeft.visible = true
      }
      else {
        controller.xAxis = 1
        backgroundRight.visible = true
      }
    }

    onUpdated: {
      if(touchPoints[0].x < width/2)
        controller.xAxis = -1
      else
        controller.xAxis = 1
    }

    onReleased: {
      controller.xAxis = 0
      backgroundLeft.visible = false
      backgroundRight.visible = false
    }
  }
  function deleteMoveButton() {
       moveTouchButton.visible=false
      controller.xAxis = 0
      backgroundLeft.visible = false
      backgroundRight.visible = false

}
  function addMoveButton() {
      !system.desktopPlatform ? moveTouchButton.visible = true : moveTouchButton.visible = false
      moveTouchButton.enabled = true
  }
}
