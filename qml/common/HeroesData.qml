import QtQuick 2.0

import "../logic"

JSONListModel {
    id: model

    source: "../data/heroes.json"
    query: "$.heroes[*]"

    onCountChanged: {
        if(count < 1) return;

        var entry = model.model.get(count-1);
        var stored = storage.getHero(count-1);

        entry.experience = stored.experience;
        entry.level = stored.level;
    }

    Component.onDestruction: {
        for(var i = 0; i < count; i++) {
            var entry = model.model.get(i);
            var stored = storage.getHero(i);

            stored.experience = entry.experience;
            stored.level = entry.level;

            storage.setHero(i, stored);
        }
    }
}

