import VPlay 2.0
import QtQuick 2.0

import "../items"

Storage {
    id: storage

//    clearAllAtStartup: true

    property alias player: player

    Player {
        id: player
    }

    Component.onCompleted: {
        loadPlayerData();
    }

    Component.onDestruction: {
        savePlayerData();
    }

    function loadPlayerData() {
        var playerData = getPlayerData();

        player.type = playerData.type;
    }

    function savePlayerData() {
        var playerData = getPlayerData();

        playerData.type = player.type;

        setPlayerData(playerData);
    }

    function getPlayerData() {
        var result = getValue("Player");
        if(result !== undefined) return result;

        return {
            type: 0
        };
    }

    function setPlayerData(playerData) {
        setValue("Player", playerData);

        console.debug("[Settings] Player: " + JSON.stringify(playerData));
    }





    function getLevel(number) {
        var result = getEntry("Level", number);
        if(result !== undefined) return result;

        return {
            unlocked: number === 0,
            stars: 0
        };
    }

    function setLevel(number, entry) {
        setEntry("Level", number, entry);
    }

    function getHero(number) {
        var result = getEntry("Hero", number);
        if(result !== undefined) return result;

        return {
            experience: 0,
            level: 1
        };
    }

    function setHero(number, entry) {
        setEntry("Hero", number, entry);
    }




    function getEntry(name, number) {
        return getValue(name + "-" + number);
    }

    function setEntry(name, number, entry) {
        setValue(name + "-" + number, entry);

        console.debug("[Settings] " + name + "-" + number + ": " + JSON.stringify(entry));
    }
}
