import VPlay 2.0
import QtQuick 2.0

import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

import "../common"
import "../misc"

KrkScene {
    id: scene

    signal playPressed(int level)
    signal levelPressed(int level)

    ColumnLayout {
        anchors.fill: gameWindowAnchorItem
        anchors.margins: mm

        KrkText {
            text: qsTr("Lands")

            font.pixelSize: titleFontSize

            Layout.alignment: Qt.AlignCenter
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            clip: true

            Flickable {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: mm

                width: contentWidth

                contentWidth: grid.width
                contentHeight: grid.height

                flickableDirection: Flickable.VerticalFlick

                GridLayout {
                    id: grid

                    columns: 2

                    rowSpacing: mm
                    columnSpacing: mm

                    Repeater {
                        model: levelsData.model

                        delegate: Item {
                            width: 540
                            height: 760

                            MultiResolutionImage {
                                id: mapTile
                                anchors.fill: parent

                                source: "../../assets/img/misc/map-tile.png"

                                visible: false
                            }

                            DropShadow {
                                anchors.fill: mapTile
                                horizontalOffset: 0
                                verticalOffset: 20
                                radius: 8.0
                                samples: 17
                                color: "#80000000"
                                source: mapTile
                            }

                            ColumnLayout {
                                anchors.fill: parent
                                anchors.margins: mm
                                anchors.bottomMargin: 1.5 * mm

                                spacing: mm

                                Item {
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true

                                    z: -1

                                    MultiResolutionImage {
                                        anchors.fill: parent
                                        anchors.margins: mm

                                        fillMode: Image.PreserveAspectCrop

                                        source: model.index > -1 ? "../../assets/img/levels/level-" + model.index + ".png" : ""

//                                        MouseArea {
//                                            anchors.fill: parent

//                                            onPressed: parent.scale = 0.95;
//                                            onReleased: parent.scale = 1.0;
//                                            onCanceled: parent.scale = 1.0;

//                                            onClicked: levelPressed(model.index);
//                                        }

                                        KrkText {
                                            Layout.alignment: Qt.AlignCenter

                                            text: model.name

                                            font.pixelSize: normalFontSize
                                        }
                                    }
                                }

                                KrkButton {
                                    Layout.alignment: Qt.AlignCenter

                                    source: "../../assets/img/buttons/button-box" + (enabled ? "-on.png" : "-off.png")

                                    enabled: model.unlocked

                                    property int stars: model.stars

                                    onClicked: playPressed(model.index);

                                    ColumnLayout {
                                        anchors.fill: parent
                                        anchors.margins: mm

                                        RowLayout {
                                            Layout.alignment: Qt.AlignCenter

                                            Repeater {
                                                model: 3

                                                delegate: MultiResolutionImage {
                                                    width: 40

                                                    source: "../../assets/img/misc/star" +
                                                            (stars > model.index ? "-on.png" : "-off.png")
                                                    fillMode: Image.PreserveAspectFit
                                                }
                                            }
                                        }

                                        KrkText {
                                            Layout.alignment: Qt.AlignCenter
                                            text: qsTr("Play")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        KrkTextButton {
            Layout.alignment: Qt.AlignCenter
            text: qsTr("Back")
            onClicked: backButtonPressed();
        }
    }
}

