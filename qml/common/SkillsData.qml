import QtQuick 2.0

import "../logic"

JSONListModel {
    id: model

    property int type

    source: "../data/heroes.json"
    query: "$.heroes[" + type + "].skills[*]"

    signal skillActivated(int num);
    signal skillDeactivated(int num);

    Timer {
        id: timer

        interval: 1000
        running: true
        repeat: true

        onTriggered: updateSkills();
    }

    onTypeChanged: {
        //TODO uwaga! to jest bledogenne!!
        //traci wszystkie zmiany, jesli nie byly wczesniej zapisane w storage!!
        updateJSONModel();
    }

    onCountChanged: {
//        var index = count-1;
//        var stats = storage.getSkillStats(index);
//        var item = model.model.get(index);

//        var active = item.active;
//        active.time = stats.active.time;
//        active.since = stats.active.since;

//        var inactive = item.inactive;
//        inactive.time = stats.inactive.time;
//        inactive.since = stats.inactive.since;

//        item.level = stats.level;
//        item.inactive = inactive;
//        item.active = active;

//        updateSkill(index);
    }

    Component.onDestruction: {
        for(var i = 0; i < count; i++) {
            var item = model.model.get(i);
//            storage.setSkillStats(i, {
//                                      level: item.level,
//                                      active: {
//                                          time: item.active.time,
//                                          since: item.active.since
//                                      },
//                                      inactive: {
//                                          time: item.inactive.time,
//                                          since: item.inactive.since
//                                      }
//                                  });
        }
    }

    function activateSkill(num) {
        var item = model.model.get(num);
        var active = item.active;

        active.since = new Date().getTime();
        active.time = active.duration;
        item.active = active;

        skillActivated(num);
    }

    function updateSkills() {
//        for(var i = 0; i < model.model.count; i++) {
//            updateSkill(i);
//        }
    }

    function updateSkill(num) {
        var item = model.model.get(num);

        if(item.active.time > 0) {
            var active = item.active;

            active.time = active.since + active.duration - new Date().getTime();
            item.active = active;

            if(active.time <= 0) {
                var inactive = item.inactive;

                inactive.since = new Date().getTime();
                inactive.time = inactive.duration;
                item.inactive = inactive;

                skillDeactivated(num);
            }
        }

        if(item.inactive.time > 0) {
            var inactive = item.inactive;
            inactive.time = inactive.since + inactive.duration - new Date().getTime();
            item.inactive = inactive;
        }
    }
}

