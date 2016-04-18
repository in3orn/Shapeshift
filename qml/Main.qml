import VPlay 2.0
import QtQuick 2.0

import "scenes"

GameWindow {
    id: gameWindow

    width: 640
    height: 960

    activeScene: splash

    licenseKey: "8ABA47064DADAD5F53D648686E4899DF14578B48ED96B954E95DCB13F58E4266609DB0C581D78FED2F464DCED927F648E9FE284D7E21A71B80EEB66B270C1EF32600214E095EBB27427C4697CAD6649EA148BC31FC852BDE9DF2062009BFE8A47BF8CED217E8C8D9C95DB613BB61C8E2B9AB2BEDDC1A40420039D62FE4A28F9DA19998C70D1432CFF2089ABBF4008D59FF02AEAF47E7E64992829C751E1CB47001DF5C5283E7BFFA6BFA07DF37608EC89C4FEF814B956621991F7C47DE8EB0DB973ACA9892ABAAA7646AF299D9312D66CE660CBEB08D2850C950C0B2AC9E2094C1C2E5D99ADBF8FC69DA2CD03352C245DCF31F23E3FF8CFF60C84256FF07E8707F79B98694458B78B6EE570273EEB9E7F61643933B89814C65097D35E1C1F4C750028776B9D7830EB6C203040AD04580"

    property alias window: gameWindow

    Component.onCompleted: {
        splash.opacity = 1
        mainItemDelay.start()
    }

    Timer {
        id: mainItemDelay
        interval: 500
        onTriggered: {
            mainItemLoader.source = "MainItem.qml"
        }
    }

    Loader {
        id: mainItemLoader
        onLoaded: if(item) hideSplashDelay.start()
    }

    Timer {
        id: hideSplashDelay
        interval: 200
        onTriggered: {
            splash.opacity = 0
        }
    }

    SplashScene {
        id: splash
    }
}

