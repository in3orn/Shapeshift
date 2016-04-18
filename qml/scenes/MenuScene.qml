import VPlay 2.0
import QtQuick 2.0

import QtQuick.Layouts 1.1

import "../misc"

KrkScene {
    id: scene

    signal playPressed()
    signal heroPressed()

    ColumnLayout {
        anchors.fill: gameWindowAnchorItem
        anchors.margins: mm

        KrkTextButton {
            id: playButton
            Layout.alignment: Qt.AlignCenter

            text: qsTr("Play")
            onClicked: playPressed();
        }

        KrkTextButton {
            id: heroButton
            Layout.alignment: Qt.AlignCenter

            text: qsTr("Hero")
            onClicked: heroPressed();
        }

        KrkTextButton {
            id: exitButton
            Layout.alignment: Qt.AlignCenter

            text: qsTr("Exit")
            onClicked: backButtonPressed();
        }
    }

    KrkTextButton {
        anchors.top: gameWindowAnchorItem.top
        anchors.right: gameWindowAnchorItem.right
        anchors.margins: mm

        width: 120
        height: width

        text: "S"
        textColor: settings.musicEnabled ? "white" : "red"

        source: "../../assets/img/buttons/button-small.png"

        onClicked: {
            settings.musicEnabled = !settings.musicEnabled;
        }
    }
}

