import VPlay 2.0
import QtQuick 2.0
import QtQuick.Layouts 1.1

import "../misc"

Item {
    id: item

    signal attack(int damage)
    signal die()

    property int maxHealth
    property int actHealth

    property int maxMana
    property int actMana

    property int maxDamage
    property int minDamage

    property bool playing

    property alias mirror: image.mirror

    property real dfltHeight

    property int type

    property bool shifted: false

    property alias image: image

    property alias healthBar: healthBar
    property alias manaBar: manaBar

    property real mltDamage: 1
    property real mltHeal: 1


    width: 200
    height: 400

    MultiResolutionImage {
        id: image

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        source: getImage()

        Component.onCompleted: dfltHeight = height;
    }

    ColumnLayout {
        anchors.bottom: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: mm

        KrkProgressBar {
            id: healthBar

            Layout.alignment: Qt.AlignCenter

            value: actHealth
            maxValue: maxHealth

            mainColor: "#00aa00"
            secondColor: "#003300"
        }

        KrkProgressBar {
            id: manaBar

            Layout.alignment: Qt.AlignCenter

            value: actMana
            maxValue: maxMana

            mainColor: "#0000cc"
            secondColor: "#000055"
        }
    }

    MovementAnimation {
        id: waver

        target: image
        property: "height"
        velocity: 75 + Math.round(Math.random() * 25)
        running: actHealth > 0
        maxPropertyValue: dfltHeight + 20
        minPropertyValue: dfltHeight - 20
        onLimitReached: velocity = -velocity;
    }

    KrkText {
        id: damageText

        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height / 2

        color: "#aa0000"

        text: ""
        style: Text.Outline
        styleColor: "black"

        opacity: 0

        function reset(value) {
            text = value;
            y = parent.height/2;
            opacity = 1.0;
        }
    }

    PropertyAnimation {
        id: damageTextOpacityAnimation
        target: damageText
        property: "opacity"
        duration: 1000
        to: 0
    }

    PropertyAnimation {
        id: damageTextYAnimation
        target: damageText
        property: "y"
        duration: 1000
        to: 0
    }

    KrkText {
        id: healText

        anchors.horizontalCenter: parent.horizontalCenter
        y: item.height / 2

        color: "#00aa00"

        text: ""
        style: Text.Outline
        styleColor: "black"

        opacity: 0

        function reset(value) {
            text = value;
            y = parent.height/2;
            opacity = 1.0;
        }
    }

    PropertyAnimation {
        id: healTextOpacityAnimation
        target: healText
        property: "opacity"
        duration: 1000
        to: 0
    }

    PropertyAnimation {
        id: healTextYAnimation
        target: healText
        property: "y"
        duration: 1000
        to: 0
    }

    onShiftedChanged: {
        if(shifted) {
            switch(type) {
            case 0:
                maxHealth *= 2;
                actHealth *= 2;

                mltHeal = 1.5;
                break;
            case 1:
                maxHealth *= 1.5;
                actHealth *= 1.5;

                mltDamage = 2.0;
                break;
            case 2:
                mltHeal = 2.0;
                mltDamage = 2.0;
                break;
            }

            animate();
        } else {
            mltDamage = 1.0;
            mltHeal = 1.0;
        }
    }

    function init() {
        actHealth = maxHealth;
        actMana = 0;

        playing = true;
    }

    function stop() {
        playing = false;
    }

    function heal(value) {
        healText.reset(value);

        healTextOpacityAnimation.restart();
        healTextYAnimation.restart();

        actHealth += value;
        if(actHealth > maxHealth)
            actHealth = maxHealth;
    }

    function damage(damage) {
        damageText.reset(damage);

        damageTextOpacityAnimation.restart();
        damageTextYAnimation.restart();

        actHealth -= damage;
        if(actHealth <= 0) {
            actHealth = 0;
            die();
        }
    }

    function gainMana(value) {
        actMana += value;
        if(actMana > maxMana)
            actMana = maxMana;
    }

    function drainMana(value) {
        actMana -= value;
        if(actMana < 0) {
            damage(-5 * actMana);
            actMana = 0;
        }
    }

    function getImage() {
        if(shifted) {
            return "../../assets/img/heroes/shifted-" + type + ".png";
        } else {
            return "../../assets/img/heroes/druid-" + type + ".png"
        }
    }

    function animate() {
        for(var i = 0; i < clouds.model; i++) {
            clouds.itemAt(i).restart();
        }
    }

















    Repeater {
        id: clouds

        model: 4

        MultiResolutionImage {
            id: cloud
            source: "../../assets/img/misc/cloud-" + model.index + ".png"
            anchors.verticalCenter: parent.verticalCenter

            property alias oAnimation: oAnimation
            property alias xAnimation: xAnimation

            opacity: 0.0

            PropertyAnimation {
                id: oAnimation
                target: cloud
                property: "opacity"
                duration: 1000
                to: 0
            }

            PropertyAnimation {
                id: xAnimation
                target: cloud
                property: "x"
                duration: 1000
                to: model.index % 2 ? -2*parent.width : 2*parent.width
            }

            function restart() {
                x = parent.width / 2;
                opacity = 1.0;

                xAnimation.restart();
                oAnimation.restart();
            }
        }
    }
}
