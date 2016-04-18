import QtQuick 2.0

Character {
    id: item

    manaBar.visible: false

    property bool frog: false

    image.source: frog ? "../../assets/img/heroes/frog.png" : getImage()

    Timer {
        interval: 10000
        running: playing && actHealth > 0
        repeat: true

        onTriggered: {
            if(!frog) {
                var damage = minDamage + Math.round((maxDamage - minDamage) * Math.random());
                attack(damage);

                interval = 5000 + Math.round(Math.random() * 5000);
            }
        }
    }

    function setToFrog() {
        maxHealth = 1;
        actHealth = 1;
        frog = true;
    }
}
