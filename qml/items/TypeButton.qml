import QtQuick 2.0

Rectangle {
    id: item

    signal clicked(int number)

    property int number

    radius: 10;

    color: getColor();

    MouseArea {
        anchors.fill: parent

        onPressed: parent.scale = 0.95;
        onReleased: parent.scale = 1.0;
        onCanceled: parent.scale = 1.0;

        onClicked: item.clicked(number);
    }

    function getColor() {
        switch(number) {
        case 1:
            return "red";
        case 2:
            return "green";
        case 3:
            return "blue";
        default:
            return "gray";
        }
    }
}
