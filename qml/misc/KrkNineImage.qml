import VPlay 2.0
import QtQuick 2.0

Item {

    property alias source1: img1.source
    property alias source2: img2.source
    property alias source3: img3.source
    property alias source4: img4.source
    property alias source5: img5.source
    property alias source6: img6.source
    property alias source7: img7.source
    property alias source8: img8.source
    property alias source9: img9.source

    BackgroundImage {
        id: img5

        anchors.centerIn: parent

        width: parent.width - img4.width - img6.width + 2
        height: parent.height - img8.height - img2.height + 2
    }



    BackgroundImage {
        id: img8

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        width: parent.width - img7.width - img9.width
        height: img7.height
    }

    BackgroundImage {
        id: img2

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        width: parent.width - img1.width - img3.width
        height: img1.height
    }



    BackgroundImage {
        id: img4

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        width: img7.width
        height: parent.height - img7.height - img1.height
    }

    BackgroundImage {
        id: img6

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        width: img9.width
        height: parent.height - img9.height - img3.height
    }


    MultiResolutionImage  {
        id: img7
        anchors.top: parent.top
        anchors.left: parent.left
    }

    MultiResolutionImage  {
        id: img9
        anchors.top: parent.top
        anchors.right: parent.right
    }

    MultiResolutionImage  {
        id: img1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    MultiResolutionImage  {
        id: img3
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }
}
