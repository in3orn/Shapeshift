import VPlayApps 1.0
import QtQuick 2.0

Item {
    id: item

    width: text.width
    height: text.height

    property int duration
    property int time

    property alias running: timer.running

    signal stopped
    signal triggered

    Timer {
        id: timer
        interval: 100

        repeat: true
        running: false

        onTriggered: {
            item.time -= 100
            if(item.time <= 0) {
                timer.stop();
                item.triggered();
            }
        }
    }

    KrkText {
        id: text
        text: getTimeString()

        font.pixelSize: titleFontSize
        font.bold: true
    }

    function getTimeString() {
        return Qt.formatDateTime(new Date(time), "ss:mmm");
    }

    function clear() {
        time = duration;
    }

    function start() {
        timer.start();
    }

    function stop() {
        timer.stop();
        stopped();
    }
}
