import QtQuick 2.0

Item {
    id: player

    property string name

    property bool shifted
    property int type

    property int maxHealth: 100
    property int actHealth: maxHealth

    property int maxMana: 12
    property int actMana: maxMana

    property int maxDamage: 5
    property int minDamage: 2
}
