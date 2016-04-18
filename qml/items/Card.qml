import VPlay 2.0
import QtQuick 2.0

import QtQuick.Layouts 1.1

import "../misc"

KrkButton {
    id: item

    property int type0
    property int type1
    property int type2
    property int type3

    source: "../../assets/img/misc/card.png"

    errorText.text: "not match!"
    errorText.rotation: 45
    errorText.font.pixelSize: normalFontSize

    GridLayout {
        anchors.fill: parent
        anchors.margins: mm

        rowSpacing: mm
        columnSpacing: mm

        columns: 2

        Field {
            type: type0

            Layout.fillWidth: true
            Layout.fillHeight: true

            enabled: false
        }

        Field {
            type: type1

            Layout.fillWidth: true
            Layout.fillHeight: true

            enabled: false
        }

        Field {
            type: type2

            Layout.fillWidth: true
            Layout.fillHeight: true

            enabled: false
        }

        Field {
            type: type3

            Layout.fillWidth: true
            Layout.fillHeight: true

            enabled: false
        }
    }
}
