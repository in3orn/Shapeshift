import VPlay 2.0
import QtQuick 2.0

KrkScene {

    Rectangle {
        anchors.fill: gameWindowAnchorItem
        color: "white"
    }

    MultiResolutionImage {
        anchors.centerIn: parent
    }
}

