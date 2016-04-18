import VPlay 2.0
import QtQuick 2.0

import QtQuick.Layouts 1.1

import "../common"
import "../misc"
import "../items"

KrkScene {
    id: scene

    property int type: -1

    ColumnLayout {
        anchors.fill: gameWindowAnchorItem
        anchors.margins: mm

        KrkText {
            text: type >= 0 ? heroesData.model.get(type).name : ""

            font.pixelSize: titleFontSize

            Layout.alignment: Qt.AlignCenter
        }

        KrkText {
            text: "Level: " + (type >= 0 ? heroesData.model.get(type).level : "")

            font.pixelSize: normalFontSize

            Layout.alignment: Qt.AlignCenter
        }

        KrkText {
            text: "Exp.: " + (type >= 0 ? heroesData.model.get(type).experience : "")

            font.pixelSize: normalFontSize

            Layout.alignment: Qt.AlignCenter
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter

            KrkTextButton {
                Layout.alignment: Qt.AlignCenter

                text: "<<"
                textColor: enabled ? "white" : "gray"
                source: "../../assets/img/buttons/button-small.png"
                enabled: type > 0;
                onClicked: type--;
            }

            MultiResolutionImage {
                source: "../../assets/img/heroes/druid-" + Math.max(0, type)+ ".png"
            }

            KrkTextButton {
                Layout.alignment: Qt.AlignCenter

                text: ">>"
                textColor: enabled ? "white" : "gray"
                source: "../../assets/img/buttons/button-small.png"
                enabled: type < 2;
                onClicked: type++;
            }
        }

        Item { Layout.fillHeight: true }

        KrkTextButton {
            Layout.alignment: Qt.AlignCenter
            text: qsTr("Ok")
            onClicked: {
                player.type = type;
                backButtonPressed();
            }
        }

        KrkTextButton {
            Layout.alignment: Qt.AlignCenter
            text: qsTr("Back")
            onClicked: backButtonPressed();
        }

    }
}

