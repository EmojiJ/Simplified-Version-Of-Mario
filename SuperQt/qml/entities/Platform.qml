import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
  id: platform
  entityType: "platform"

  size: 2 // must be >= 2 and even (2,4,6,...)

  Row {
    id: tileRow
    Tile {
      pos: "left"
      image: "../../assets/platform/left.png"
    }
    Repeater {
      model: size-2
      Tile {
        pos: "mid"
        image: "../../assets/platform/mid" + index%2 + ".png"
      }
    }
    Tile {
      pos: "right"
      image: "../../assets/platform/right.png"
    }
  }

  BoxCollider {
    id: collider
    anchors.fill: parent

    bodyType: Body.Static

    fixture.onBeginContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") {
        console.debug("contact platform begin")

        player.contacts++

      }
    }

    fixture.onEndContact: {
      var otherEntity = other.getBody().target
      if(otherEntity.entityType === "player") {
        console.debug("contact platform end")

        // if the player leaves a platform, we decrease its number of active contacts
        player.contacts--

      }
    }
  }
}
