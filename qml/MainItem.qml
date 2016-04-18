import VPlay 2.0
import QtQuick 2.0

import "common"
import "scenes"
import "logic"

Item {
    id: mainItem

    property alias storage: storage
    property alias player: storage.player

    property alias customFont: customFont
    property alias audioManager: audioManager

    AudioManager {
        id: audioManager
    }

    BackgroundMusic {
        id: music
        source: "../assets/music/background.mp3"
        muted: !settings.musicEnabled
    }

    FontLoader {
        id: customFont
        source: "../assets/font/calibri.ttf"
    }

    Settings {
        id: settings
    }

    KrkStorage {
        id: storage
    }

    LevelsData {
        id: levelsData
    }

    HeroesData {
        id: heroesData
    }

    SkillsData {
        id: skillsData

        type: 3*player.shifted + player.type
    }

    GameScene {
        id: gameScene

        onBackButtonPressed: {
            stopGame();
            mainItem.state = "levels";
        }
    }

    MenuScene {
        id: menuScene

        onPlayPressed: mainItem.state = "levels";

        onHeroPressed: openHero();

        onBackButtonPressed: {
            nativeUtils.displayMessageBox("Really quit the game?", "", 2);
        }

        Connections {
            target: window.activeScene === menuScene ? nativeUtils : null
            onMessageBoxFinished: {
                if(accepted) {
                    Qt.quit()
                }
            }
        }
    }

    LevelsScene {
        id: levelsScene

        onBackButtonPressed: mainItem.state = "menu";
        onLevelPressed: openLevel(level);
        onPlayPressed: openGame(level);
    }

    LevelScene {
        id: levelScene

        onBackButtonPressed: mainItem.state = "levels";
        onItemPressed: openItem(level, item);
        onPlayPressed: openGame(level);
    }

    HeroScene {
        id: heroScene

        onBackButtonPressed: mainItem.state = "menu";
    }

    state: "menu"

    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {
            name: "levels"
            PropertyChanges {target: levelsScene; opacity: 1}
            PropertyChanges {target: window; activeScene: levelsScene}
        },
        State {
            name: "level"
            PropertyChanges {target: levelScene; opacity: 1}
            PropertyChanges {target: window; activeScene: levelScene}
        },
        State {
            name: "hero"
            PropertyChanges {target: heroScene; opacity: 1}
            PropertyChanges {target: window; activeScene: heroScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        },
        State {
            name: "gameNetwork"
            PropertyChanges {target: gameNetworkScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameNetworkScene}
        }
    ]

    function openHero() {
        heroScene.type = player.type;

        mainItem.state = "hero";
    }

    function openLevel(level) {
        levelScene.level = level;

        mainItem.state = "level";
    }

    function openGame(level) {
        gameScene.level = level;
        gameScene.initGame();
        gameScene.state = "wait";

        mainItem.state = "game";
    }
}

