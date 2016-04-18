import VPlay 2.0
import QtQuick 2.0

Rectangle {
    id: progressBar

    property real maxValue: 1
    property real value

    property color mainColor: "#00aa00"
    property color secondColor: "#003300"
    property color borderColor: "black"

    width: 400
    height: 60

    color: secondColor
    border {
        width: 8
        color: borderColor
    }

    KrkText {
        id: progressBarText

        text: value + "/" + maxValue
        color: "white"
        anchors.centerIn: parent

        font.pixelSize: smallFontSize
    }

    Rectangle {
        id: progressBarFront

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: parent.border.width

        width: (parent.width - 2*parent.border.width) * progressBar.value / progressBar.maxValue
        height: parent.height - 2*parent.border.width

        color: mainColor

        clip: true

        KrkText {
            id: progressBarFrontText

            text: value + "/" + maxValue
            color: "white"
            x: progressBarText.x - progressBar.border.width
            y: progressBarText.y - progressBar.border.width

            font.pixelSize: smallFontSize
        }
    }
}
