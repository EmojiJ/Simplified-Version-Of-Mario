import Felgo 3.0
import QtQuick 2.0


Scene {
    id:sceneBase

    width: 480
    height: 320

    //默认值设置为0,在main.qml中将通过PropertyChanges更改
    opacity: 0

    //不透明性>0时可见
    // this improves the performance
    visible: opacity > 0

    //场景可见时启用
    enabled: visible
}
