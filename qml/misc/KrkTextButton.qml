import VPlay 2.0
import QtQuick 2.0

Item {
    id: button

    signal clicked
    signal pressed
    signal released

    width: sprite.width
    height: sprite.height

    property alias source: sprite.source

    property alias text: textItem.text
    property alias textColor: textItem.color

    MultiResolutionImage {
        id: sprite
        source: "../../assets/img/buttons/button-text.png"

        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }

    KrkText {
        id: textItem
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        enabled: button.enabled
        anchors.fill: button
        hoverEnabled: true

        onClicked: {
            button.scale = 1.0;
            button.clicked();
            audioManager.playClickSfx();
        }
        onPressed: {
            button.scale = 0.85;
        }
        onReleased: {
            button.scale = 1.0;
        }
        onCanceled: {
            button.scale = 1.0;
        }
    }
}

