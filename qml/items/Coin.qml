import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: item
    entityType: "coin"

    width: img.width
    height: img.height

    z: 1.1

    scale: 0.0

    property int value

    property real targetX
    property real targetY

    property real velX: -200 + 400 * Math.random()
    property real velY: -500 - 500 * Math.random()

    signal collected

    Component.onCompleted: state = "shown"

    Image {
        id: img
        source: "../../assets/img/misc/coin.png"
    }

    CircleCollider {
        id: collider

        radius: img.width/2

        bodyType: Body.Dynamic
        body.active: true

        restitution: 0.3
        density: 1

        linearVelocity: Qt.point(velX, velY)

        fixture {
            categories: Box.Category2
            collidesWith: Box.Category1
        }
    }

    MouseArea {
        anchors.fill: img
        anchors.margins: -mm

        propagateComposedEvents: true

        onPressed: {
            audioManager.playCoinSfx();
            item.state = "collected";
            mouse.accepted = false;
        }
    }

    Timer {
        interval: 4000 + 100 * Math.round(Math.random() * 10)

        running: true

        onTriggered: item.state = "collected"
    }

    states: [
        State {
            name: "thrown"
            PropertyChanges {
                target: item
                scale: 1.0
            }
        },
        State {
            name: "collected"
            PropertyChanges {
                target: collider
                body.active: false
                linearVelocity: Qt.point(0, 0)
            }
        }
    ]

    transitions: [
        Transition {
            from: ""
            to: "shown"

            NumberAnimation {
                target: item
                property: "scale"
                to: 1.0
                duration: 250
                easing.type: Easing.OutQuart
            }
        },
        Transition {
            from: "shown"
            to: "collected"

            NumberAnimation {
                target: item
                property: "x"
                to: targetX
                duration: 500
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: item
                property: "y"
                to: targetY
                duration: 500
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: item
                property: "scale"
                to: 0.2
                duration: 500
                easing.type: Easing.OutQuad
            }

            onRunningChanged: {
                if ((state == "collected") && (!running))
                    collected();
            }
        }
    ]
}

