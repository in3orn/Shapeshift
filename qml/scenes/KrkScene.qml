import VPlay 2.0
import QtQuick 2.0

import "../misc"

Scene {
    id: scene

    width: 1280
    height: 1920

    opacity: 0

    readonly property int titleFontSize: 96
    readonly property int normalFontSize: 64
    readonly property int smallFontSize: 32

    readonly property real mm: 20
    readonly property real m2: 10

    BackgroundImage {
        anchors.fill: gameWindowAnchorItem
        source: "../../assets/img/misc/background.png"
        fillMode: Image.PreserveAspectCrop
    }
}

