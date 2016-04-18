import VPlay 2.0
import QtQuick 2.0

import QtQuick.Layouts 1.1

import "../misc"
import "../scenes"
import "../common"

KrkDialog {
    id: item

    property string title

    property int stars

    signal playAgainPressed()
    signal menuPressed()

    Rectangle {
        anchors.fill: parent

        color: "black"

        opacity: 0.85
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: mm

        Item { Layout.fillHeight: true }

        KrkText {
            id: titleLabel

            text: title

            Layout.alignment: Qt.AlignCenter
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter

            Repeater {
                model: 3

                delegate: MultiResolutionImage {
                    width: 160

                    source: "../../assets/img/misc/star" +
                            (stars > model.index ? "-on.png" : "-off.png")
                    fillMode: Image.PreserveAspectFit
                }
            }
        }

        KrkTextButton {
            text: qsTr("Repeat")
            onClicked: playAgainPressed();

            Layout.alignment: Qt.AlignCenter
        }

        KrkTextButton {
            text: qsTr("Menu")
            onClicked: menuPressed();

            Layout.alignment: Qt.AlignCenter
        }

        Item { Layout.fillHeight: true }
    }
}

