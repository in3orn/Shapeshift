import VPlay 2.0
import QtQuick 2.0

import QtQuick.Layouts 1.1

import "../common"
import "../items"
import "../misc"
import "../logic"

KrkScene {
    id: scene

    property int exp: 0

    property int level: -1

    property int actField: -1

    property int tutorialPhase: 0

    CardLogic { id: cardLogic }

    ListModel {
        id: fields

        Component.onCompleted: {
            for(var i = 0; i < 4; i++) {
                append({
                           number: i,
                           type: 0,
                           enabled: false
                       });
            }
        }
    }

    ListModel {
        id: allCards

        Component.onCompleted: {
            for(var i = 1; i < 4; i++) {
                for(var j = 1; j < 4; j++) {
                    for(var k = 1; k < 4; k++) {
                        append({
                                   type0: 0,
                                   type1: i,
                                   type2: j,
                                   type3: k
                               });

                        append({
                                   type0: i,
                                   type1: 0,
                                   type2: j,
                                   type3: k
                               });

                        append({
                                   type0: i,
                                   type1: j,
                                   type2: 0,
                                   type3: k
                               });

                        append({
                                   type0: i,
                                   type1: j,
                                   type2: k,
                                   type3: 0
                               });
                    }
                }
            }
        }
    }

    ListModel {
        id: cardsLeft

        Component.onCompleted: {
            for(var i = 0; i < 4; i++) {
                append({
                           type0: 0,
                           type1: 0,
                           type2: 0,
                           type3: 0
                       });
            }
        }
    }

    ListModel {
        id: cardsRight

        Component.onCompleted: {
            for(var i = 0; i < 4; i++) {
                append({
                           type0: 0,
                           type1: 0,
                           type2: 0,
                           type3: 0
                       });
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: mm

        spacing: mm

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Character {
                id: hero

                shifted: player.shifted
                type: player.type

                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: mm
                anchors.leftMargin: 10 * mm

                maxHealth: storage.player.maxHealth
                maxMana: storage.player.maxMana

                maxDamage: storage.player.maxDamage
                minDamage: storage.player.minDamage

                onDie: scene.state = "defeat";
            }

            Enemy {
                id: boss

                mirror: true

                type: Math.round(Math.random() * 2.49)

                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: mm
                anchors.rightMargin: 10 * mm

                maxHealth: 100 + level * 10
                maxMana: 12

                minDamage: 8 + level
                maxDamage: 15 + level * 3

                onAttack: hero.damage(damage);

                onDie: scene.state = "victory";
            }
        }

        MultiResolutionImage {
            Layout.fillWidth: true

            source: "../../assets/img/misc/spell-deck.png"

            RowLayout {
                anchors.centerIn: parent

                spacing: mm

                Repeater {
                    model: skillsData.model

                    delegate: SkillButton {
                        clickable: (!hero.shapeshifted || model.type !== 4) && isSkillEnabled(model.index);

                        type: player.type
                        shifted: player.shifted
                        mana: model.mana
                        value: getBetterValue(model)
                        skillType: model.type

                        onClicked: activateSkill(model.index);

                        onPressAndHold: {
                            skillInfoDialog.title = model.name;
                            skillInfoDialog.type = model.type;
                            skillInfoDialog.mana = model.mana;
                            skillInfoDialog.value = model.value;

                            skillInfoDialog.state = "shown"
                        }

                        onReleased: skillInfoDialog.state = "";
                        onCanceled: skillInfoDialog.state = "";

                        onInfoClicked: {
                            skillInfoDialog.title = model.name;
                            skillInfoDialog.type = model.type;
                            skillInfoDialog.mana = model.mana;
                            skillInfoDialog.value = model.value;

                            skillInfoDialog.state = "shown"
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            spacing: mm

            ColumnLayout {
                spacing: mm

                Repeater {
                    model: cardsLeft

                    delegate: Card {
                        width: 200
                        height: 200

                        type0: model.type0
                        type1: model.type1
                        type2: model.type2
                        type3: model.type3

                        onClicked: {
                            if(cardLogic.isMatching(cardsLeft.get(model.index), fields)) {
                                cardLogic.initNextCard(model.index, cardsLeft, allCards);
                                hero.gainMana(3);
                            } else {
                                hero.drainMana(3);
                                runError();
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
            }

            GridLayout {
                rowSpacing: mm
                columnSpacing: mm

                columns: 2

                Repeater {
                    model: fields

                    delegate: Field {
                        type: model.type
                        number: model.number

                        width: 300
                        height: 300

                        onClicked: {
                            if(cardLogic.canShift(cardsLeft, fields) && cardLogic.canShift(cardsRight, fields)) {
                                actField = number;

                                var field = fields.get(number);
                                if(field.type === 3) field.type = 1;
                                else field.type++;
                            } else {
                                hero.drainMana(1);
                                runError();
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
            }

            ColumnLayout {
                anchors.margins: mm

                spacing: mm

                Repeater {
                    model: cardsRight

                    delegate: Card {
                        width: 200
                        height: 200

                        type0: model.type0
                        type1: model.type1
                        type2: model.type2
                        type3: model.type3

                        onClicked: {
                            if(cardLogic.isMatching(cardsRight.get(model.index), fields)) {
                                cardLogic.initNextCard(model.index, cardsRight, allCards);
                                hero.gainMana(3);
                            } else {
                                hero.drainMana(3);
                                runError();
                            }
                        }
                    }
                }
            }
        }
    }

    WaitScreen {
        id: waitScreen

        anchors.fill: gameWindowAnchorItem

        z: 1

        onActivated: scene.state = "play";
    }

    GameOverScreen {
        id: gameOverScreen

        anchors.fill: gameWindowAnchorItem

        onPlayAgainPressed: {
            scene.state = "wait";
        }

        onMenuPressed: {
            backButtonPressed();
        }

        z: 1
    }

    KrkDialog {
        id: skillInfoDialog

        anchors.fill: gameWindowAnchorItem

        property string title
        property int mana
        property int type
        property int value

        Rectangle {
            anchors.fill: parent

            color: "black"
            opacity: 0.75
        }

        ColumnLayout {
            anchors.centerIn: parent

            KrkText {
                Layout.alignment: Qt.AlignCenter

                text: skillInfoDialog.title
                font.pixelSize: titleFontSize
            }

            KrkText {
                Layout.alignment: Qt.AlignCenter

                text: "Mana cost: " + skillInfoDialog.mana
                font.pixelSize: normalFontSize
            }

            KrkText {
                Layout.alignment: Qt.AlignCenter

                text: skillInfoDialog.getText()
                font.pixelSize: normalFontSize
            }

            KrkTextButton {
                Layout.alignment: Qt.AlignCenter

                text: "OK"
                onClicked: skillInfoDialog.state = "";
            }
        }

        function getText() {
            switch(type) {
            case 0:
                return "Deal " + value + " damage.";
            case 1:
                return "Deal " + value * 12 + " damage over 3 sec.";
            case 2:
                return "Heal " + value + " health.";
            case 3:
                return "Heal " + value * 12 + " health over 3 sec.";
            case 4:
                return "Shift to the " + title;
            default:
                return "";
            }
        }
    }

    Timer {
        id: damageTimer
        repeat: timeLeft > 300
        running: false
        interval: 250

        property int timeLeft
        property int minDamage: 1
        property int maxDamage: 1

        onTriggered:  {
            var damage = minDamage;

            if(maxDamage > minDamage) {
                damage += Math.round(Math.random() * (maxDamage - minDamage));
            }

            boss.damage(damage);
            timeLeft -= interval;

            exp += damage;
        }
    }

    Timer {
        id: healTimer
        repeat: timeLeft > 300
        running: false
        interval: 250

        property int timeLeft
        property int minValue: 1
        property int maxValue: 1

        onTriggered:  {
            var value = minValue;

            if(maxValue > minValue) {
                value += Math.round(Math.random() * (maxValue - minValue));
            }

            hero.heal(value);
            timeLeft -= interval;
        }
    }

    Timer {
        id: tutorialTimer

        property int phase

        interval: 1000

        onTriggered: {
            if(tutorialPhase === 1) {
                tutorialPhase++;
                boss.setToFrog();
                start();
            } else if(tutorialPhase < 8) {
                tutorialDialog.state = "shown";
            }
        }
    }

    KrkDialog {
        id: tutorialDialog

        anchors.fill: gameWindowAnchorItem
        visible: level === 0

        Rectangle {
            anchors.fill: parent

            color: "black"
            opacity: 0.75
        }

        ColumnLayout {
            anchors.centerIn: parent

            KrkText {
                Layout.alignment: Qt.AlignCenter

                text: tutorialDialog.getTitle();
                font.pixelSize: titleFontSize
            }
            KrkText {
                Layout.alignment: Qt.AlignCenter

                text: tutorialDialog.getText();
                font.pixelSize: normalFontSize
            }

            MultiResolutionImage {
                Layout.alignment: Qt.AlignCenter

                source: tutorialPhase <= 7 ? "../../assets/img/tutorial/tutorial-" + tutorialPhase + ".png" : ""
            }

            RowLayout {
                spacing: mm

                KrkTextButton {
                    Layout.alignment: Qt.AlignCenter
                    text: tutorialPhase < 7 ? "Next" : "OK"
                    onClicked: {
                        tutorialDialog.performAction();
                    }
                }
                KrkTextButton {
                    Layout.alignment: Qt.AlignCenter
                    text: "Skip"
                    onClicked: {
                        tutorialDialog.state = "";
                        tutorialPhase = 100;
                    }
                }
            }
        }

        function getTitle() {
            switch(tutorialPhase) {
            case 0:
                return "Watch out!";
            case 2:
                return "Ha ha ha!"
            case 3:
                return "Skills";
            case 4:
                return "No mana";
            case 5:
                return "Pattern";
            case 6:
                return "Cards";
            case 7:
                return "Change patern";
            default:
                return "";
            }
        }

        function getText() {
            switch(tutorialPhase) {
            case 0:
                return "Your opponent is about to\n" +
                        "SHAPESHIFT!\n";
            case 2:
                return "Something went wrong :D\n" +
                        "Let's finish him!";
            case 3:
                return "Use SKILLs to\n" +
                        "ATTACK your oponent.\n";
            case 4:
                return "Skills cost MANA.\n" +
                        "Let's gain some!";
            case 5:
                return "This is the mana PATTERN.";
            case 6:
                return "Find CARDS matching PATTERN\n" +
                        "to gain MANA.\n\n" +
                        "Wrong CARD will drain your MANA!\n";
            case 7:
                return "You can shift PATTERN SHAPEs\n" +
                        "ONLY IF there is NO card\n" +
                        "matching current PATTERN.\n";
            default:
                return "";
            }
        }

        function performAction() {
            if(tutorialPhase === 0) {
                tutorialDialog.state = "";
                tutorialTimer.start();
            }

            tutorialPhase++;

            if(tutorialPhase > 7) {
                tutorialDialog.state = "";
            }
        }
    }

    state: "wait"

    states: [
        State {
            name: "wait"
            PropertyChanges { target: waitScreen; state: "shown" }
            StateChangeScript { script: initGame() }
        },
        State {
            name: "play"
            StateChangeScript { script: playGame() }
        },
        State {
            name: "defeat"
            PropertyChanges { target: gameOverScreen; title: "Defeat!"; state: "shown"}
            StateChangeScript { script: applyDefeat(); }
        },
        State {
            name: "victory"
            PropertyChanges { target: gameOverScreen; title: "Victory!"; state: "shown"}
            StateChangeScript { script: applyVictory(); }
        }
    ]

    onLevelChanged: {

    }

    onBackButtonPressed: {
        if(state === "play") applyDefeat();
    }

    function initGame() {

    }

    function playGame() {
        player.shifted = false;

        initFields();
        cardLogic.shuffleCards(allCards);
        cardLogic.initCards(cardsLeft, allCards);
        cardLogic.initCards(cardsRight, allCards);

        hero.maxHealth = player.maxHealth;
        hero.init();

        boss.maxHealth = 100 + level * 10;
        boss.init();
        boss.frog = false;

        if(level === 0) {
            tutorialTimer.start();
        }

        tutorialPhase = 0;
    }

    function stopGame() {
        hero.stop();
        boss.stop();
    }

    function applyDefeat() {
        stopGame();
        audioManager.playAwwSfx();

        gameOverScreen.stars = 0;
    }

    function applyVictory() {
        stopGame();
        audioManager.playApplauseSfx();

        var entry = levelsData.model.get(level);
        entry.stars = 1 + Math.floor(2.9 * hero.actHealth / hero.maxHealth);

        gameOverScreen.stars = entry.stars;

        console.debug(JSON.stringify(entry));

        if(level+1 < levelsData.model.count) {
            var nextEntry = levelsData.model.get(level+1);
            nextEntry.unlocked = true;

            console.debug(JSON.stringify(nextEntry));
            console.debug(JSON.stringify(levelsData.model.get(level+1)));
        }
    }

    function initFields() {
        for(var i = 0; i < fields.count; i++) {
            var rand = 1 + Math.round(2 * Math.random());
            var field = fields.get(i);
            field.type = rand;
        }
    }

    function isSkillEnabled(number) {
        var skill = skillsData.model.get(number);
        return hero.actMana >= skill.mana;
    }

    function activateSkill(number) {
        var skill = skillsData.model.get(number);
        if(isSkillEnabled(number)) {
            hero.actMana -= skill.mana;
            switch(skill.type) {
            case 0:
                var damage = Math.round(getValue(skill) * hero.mltDamage);
                boss.damage(damage);
                exp += damage;
                break;
            case 1:
                damageTimer.timeLeft = 3000;
                damageTimer.restart();
                damageTimer.minDamage = Math.round(getValue(skill) * hero.mltDamage);
                damageTimer.maxDamage = damageTimer.minDamage;
                break;
            case 2:
                hero.heal(Math.round(getValue(skill) * hero.mltHeal));
                break;
            case 3:
                healTimer.timeLeft = 3000;
                healTimer.restart();
                healTimer.minValue = Math.round(getValue(skill) * hero.mltHeal);
                healTimer.maxValue = healTimer.minValue;
                break;
            case 4:
                player.shifted = true;
                break;
            default:
                break;
            }
        }
    }

    function getValue(skill) {
        return skill.value;
    }

    function getBetterValue(skill) {
        var value = skill.value;
        if(skill.type < 2) {
            value *= hero.mltDamage;

            if(skill.type === 1)
                value *= 12;

            return value;
        }

        if(skill.type < 4) {
            value *= hero.mltHeal;

            if(skill.type === 3)
                value *= 12;

            return value;
        }

        return skill.value;
    }
}

