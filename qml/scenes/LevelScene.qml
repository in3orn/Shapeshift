import VPlay 2.0
import QtQuick 2.0

import QtQuick.Layouts 1.1

import "../common"
import "../misc"
import "../items"

KrkScene {
    id: scene

    signal playPressed(int collection)
    signal itemPressed(int collection, int item)

    property int level: -1

    ColumnLayout {
        anchors.fill: gameWindowAnchorItem
        anchors.margins: mm

        KrkText {
            text: levelsData.model.get(level) !== undefined ? levelsData.model.get(level).name : ""

            font.pixelSize: titleFontSize

            Layout.alignment: Qt.AlignCenter
        }

        KrkText {
            text: qsTr("Stars") + storage.getLevel(level).stars

            Layout.alignment: Qt.AlignCenter
        }

        Item { Layout.fillHeight: true }

        KrkTextButton {
            text: qsTr("Play")

            enabled: levelsData.model.get(level) !== undefined ? levelsData.model.get(level).unlocked : false

            onClicked: playPressed(level)

            Layout.alignment: Qt.AlignCenter
        }
    }
}

