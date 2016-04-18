import VPlay 2.0
import QtQuick 2.0

Item {
    id: button

    signal clicked
    signal pressed
    signal released
    signal canceled
    signal pressAndHold

    width: sprite.width
    height: sprite.height

    property alias source: sprite.source

    property bool clickable: true

    property alias errorText: errorText

    MultiResolutionImage {
        id: sprite
        source: "../../assets/img/buttons/button-small.png"

        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: mouseArea
        enabled: button.enabled
        anchors.fill: button
        hoverEnabled: true

        onClicked: {
            if(clickable) {
                audioManager.playClickSfx();
                button.scale = 1.0;
                button.clicked();
            } else {
                runError();
            }
        }
        onPressed: {
            button.scale = 0.85;
            button.pressed();
        }
        onReleased: {
            button.scale = 1.0;
            button.released();
        }
        onCanceled: {
            button.scale = 1.0;
            button.canceled();
        }

        onPressAndHold: {
            button.scale = 0.85;
            button.pressAndHold();
        }
    }

    KrkText {
        id: errorText

        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 2

        z: 1

        color: "#aa0000"

        text: ""
        style: Text.Outline
        styleColor: "black"

        opacity: 0

        function reset() {
            y = parent.height / 2;
            opacity = 1.0;
        }
    }

    PropertyAnimation {
        id: errorTextOpacityAnimation
        target: errorText
        property: "opacity"
        duration: 2000
        to: 0
    }

    PropertyAnimation {
        id: errorTextYAnimation
        target: errorText
        property: "y"
        duration: 2000
        to: 0
    }

    function runError() {
        audioManager.playCraftSfx();
        if(errorText.text !== "") {
            errorText.reset();

            errorTextOpacityAnimation.restart();
            errorTextYAnimation.restart();
        }
    }
}

