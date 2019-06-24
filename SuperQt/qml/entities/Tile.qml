import Felgo 3.0
import QtQuick 2.0

Item {
  width: gameScene.gridSize
  height: gameScene.gridSize
  property alias image: sprite.source
  property string pos: "mid" // can be either "mid","left" or "right"

  MultiResolutionImage {
    id: sprite
    // 需要anchors，因为开始和结束tile有草丛边缘所以比gridsize大，为简单起见忽略碰撞检测
    anchors.left: pos == "right" ? parent.left : undefined
    anchors.right: pos == "left" ? parent.right : undefined
  }
}
