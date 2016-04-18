import VPlay 2.0
import QtQuick 2.0

Item {
    id: item
    anchors.fill: parent

    opacity: 0
    visible: opacity > 0
    enabled: opacity === 1

    property int fadeTime: 250

    MouseArea { anchors.fill: parent }

    states: [
        State {
            name: "shown"
            PropertyChanges {target: item; opacity: 1}
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "shown"
            reversible: true

            ParallelAnimation {
                NumberAnimation {
                    properties: "opacity";
                    duration: fadeTime;
                    easing.type: Easing.InOutQuad
                }
            }
        }
    ]
}

