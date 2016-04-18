import VPlay 2.0
import QtQuick 2.0

import "../misc"

KrkButton {
    id: item

    property int number
    property int type

    property bool selected

    source: "../../assets/img/misc/field-" + type + ".png"

    errorText.text: "locked!"
    errorText.rotation: 45
    errorText.font.pixelSize: titleFontSize
}
