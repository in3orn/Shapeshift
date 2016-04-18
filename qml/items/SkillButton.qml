import VPlay 2.0
import QtQuick 2.0

import "../misc"

KrkButton {
    id: item

    signal infoClicked()

    property bool shifted

    property int value
    property int type
    property int mana
    property int skillType

    errorText.text: "no mana"

    width: 200
    height: 200

    source: clickable ? "../../assets/img/skills/skill-0-0-on.png" :
                        "../../assets/img/skills/skill-0-0-off.png"

    Rectangle {
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        width: 120
        height: 60

        color: getColor()
        border.width: 8
        border.color: "black"

        KrkText {
            anchors.centerIn: parent

            color: shifted ? "green" : "white"

            visible: value > 0

            text: value
            font.pixelSize: smallFontSize
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        width: 60
        height: 60

        color: clickable ? "#0000cc" : "#333333"
        border.width: 8
        border.color: "black"

        KrkText {
            anchors.centerIn: parent

            color: "white"

            text: mana
            font.pixelSize: smallFontSize
        }
    }

    Rectangle {
        anchors.right: parent.right
        anchors.top: parent.top

        width: 60
        height: 60

        color: "#0000cc"
        border.width: 8
        border.color: "black"

        KrkText {
            anchors.centerIn: parent

            color: "white"

            text: "i"
            font.pixelSize: smallFontSize
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                audioManager.playClickSfx();
                parent.scale = 1.0;
                infoClicked();
            }
            onPressed: parent.scale = 0.85;
            onReleased: parent.scale = 1.0;
            onCanceled: parent.scale = 1.0;
        }
    }

    function getColor() {
        if(!clickable)
            return "#333333";

        if(skillType < 2)
            return "#aa0000";

        if(skillType < 4)
            return "#00aa00";

        return "orange";
    }
}
