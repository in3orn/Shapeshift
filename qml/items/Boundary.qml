import VPlay 2.0
import QtQuick 2.0

EntityBase {
    id: item
    entityType: "boundary"

    BoxCollider {
      id: collider
      anchors.fill: parent
      bodyType: Body.Static
      fixture.categories: getCategory(item.enabled)
    }

    function getCategory(enabled) {
        if(enabled)
            return Box.Category1
        else
            return Box.Category2
    }
}

