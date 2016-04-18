import QtQuick 2.0

import "../logic"

JSONListModel {
    id: model

    source: "../data/levels.json"
    query: "$.levels[*]"

    onCountChanged: {
        if(count < 1) return;

        var entry = model.model.get(count-1);
        var stored = storage.getLevel(count-1);

        entry.unlocked = stored.unlocked;
        entry.stars = stored.stars;
    }

    Component.onDestruction: {
        for(var i = 0; i < count; i++) {
            var entry = model.model.get(i);
            var stored = storage.getLevel(i);

            stored.unlocked = entry.unlocked;
            stored.stars = entry.stars;

            storage.setLevel(i, stored);
        }
    }
}

