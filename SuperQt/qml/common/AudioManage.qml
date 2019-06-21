import Felgo 3.0
import QtQuick 2.0

Item {
    id:audioManager

    BackgroundMusic {
        id:menuBgm
        source: ""
        autoPlay:true
    }

    BackgroundMusic {
        id:playMusic
        autoPlay: false
        source: ""
    }

    SoundEffect {
        id: plaerJump
        source: ""
    }

    SoundEffect {
        id:collectCoin
        source: ""
    }

    SoundEffect {
        id:click
        source: ""
    }

    SoundEffect {
      id: finish
      source: ""
    }

    SoundEffect {
      id: playerHit
      source: ""
    }

    SoundEffect {
      id: collectMushroom
      source: ""
    }

    SoundEffect {
      id: opponentJumperDie
      source: ""
    }

    SoundEffect {
      id: playerDie
      source: ""
    }

    function closeMenuBgm()
    {
        menuBgm.stop()
    }

    function openMenuBgm()
    {
        menuBgm.play()
    }

    function openPlayMusic()
    {
        playMusic.play()
    }

    function closePlayMusic()
    {
        playMusic.stop()
    }

    function playSound(sound) {
        if(sound === "playerJump")
            playerJump.play()
        else if(sound === "collectCoin")
            collectCoin.play()
        else if(sound === "click")
            click.play()
        else if(sound === "finish")
            finish.play()
        else if(sound === "playerDie")
            playerDie.play()
        else if(sound === "playHit")
            playerHit.play()
        else if(sound === "collectMushroom")
            collectMushroom.play()
        else if(sound === "opponentJumperDie")
            opponentJumperDie.play()
    }
}
