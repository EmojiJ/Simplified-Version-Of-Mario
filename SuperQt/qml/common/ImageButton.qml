import QtQuick 2.0
import Felgo 3.0
import QtQuick.Controls.Styles 1.0

GameButton{
    id:imageButton

    height:parent.height

    property int borderWidth: 1
    property color borderColor: "black"
    property int radius: 3
    //  property color initColor: "white"
    //property color lastColor:"black"

    property color color: "white"
    property alias image: image

    property alias hoverRectangle: hoverRectangle


    style: ButtonStyle {
      background: Rectangle {
        border.width: imageButton.borderWidth
        border.color: imageButton.borderColor
        radius: imageButton.radius

        // add a gradient as background
        gradient: Gradient {

          GradientStop { position: 0.0; color: imageButton.color }

          //tint color,to make it a little darker and use it as second color
          GradientStop { position: 1.0; color: Qt.tint(imageButton.color,"#24000000")}
        }
      }
    }


    MultiResolutionImage {
      id: image

      anchors.fill: parent
      anchors.margins: 1

      //设定图片显示模式,有如下可选值
      // 1.Image.Stretch –图片自适应
      //2.Image.PreserveAspectFit –图片均匀缩放,不需要裁剪 3.Image.PreserveAspectCrop –图片自动裁剪
      //4.Image.Tile –图片是水平和垂直方向复制的
      //5.Image.TileVertically –图片是水平方向复制的
      //6.Image.TileHorizontally –图片是垂直方向复制的
      //7.Iamge.Pad –图片不经过转换

      fillMode: Image.PreserveAspectFit
    }

    Rectangle {
      id: hoverRectangle

      anchors.fill: parent

      radius: imageButton.radius
      color: "white"

      // when the mouse hovers over the button, this rectangle is slightly visible
      opacity: hovered ? 0.3 : 0
    }
  }


