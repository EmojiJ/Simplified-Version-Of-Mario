import Felgo 3.0
import QtQuick 2.0
import "common"
import "scenes"

GameWindow {
    id: gameWindow

    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    activeScene: menuScene

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPhone 4 & iPhone 4S
    screenWidth: 960
    screenHeight: 640


    GameScene {
        id: gameScene
    }

    FontLoader {
        id:marioFont
        source: "../assets/fonts/SuperMario256.ttf"
    }

    MenuScene {
        id: menuScene
    }

    AudioManage {
        id:audio
    }

  state: "menu"

  states: [
    State {
      name: "menu"
      PropertyChanges {target: menuScene; opacity: 1}
      PropertyChanges {target: gameWindow; activeScene: menuScene}
      StateChangeScript{name:"menuBgm";script: audio.openMenuBgm()}
      StateChangeScript{name:"playMusic";script: audio.closePlayMusic()}
    },
    State {
      name:"game"
      PropertyChanges {target: gameScene; opacity:1}
      PropertyChanges {target:gameWindow;activeScene:gameScene}
      StateChangeScript {name:"menuBgm";script: audio.closeMenuBgm()}
      StateChangeScript {name:"playMusic";script: audio.openPlayMusic()}

    }
  ]
}
