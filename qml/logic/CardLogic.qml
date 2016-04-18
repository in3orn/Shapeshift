import QtQuick 2.0

Item {
    function shuffleCards(allCards) {
        for(var i = 0; i < allCards.count; i++) {
            var num = Math.round(Math.random() * 3);
            var to = Math.round(Math.random() * (allCards.count-num));
            allCards.move(0, to, num);
        }
    }

    function initCards(cards, allCards) {
        for(var i = 0; i < cards.count; i++) {
            initNextCard(i, cards, allCards);
        }
    }

    function initNextCard(number, cards, allCards) {
        var temp = allCards.get(0);
        var card = cards.get(number);

        card.type0 = temp.type0;
        card.type1 = temp.type1;
        card.type2 = temp.type2;
        card.type3 = temp.type3;

        var to = Math.round(Math.random() * (allCards.count-1));
        allCards.move(0, to, 1);
    }

    function canShift(cards, fields) {
        for(var i = 0; i < cards.count; i++) {
            var card = cards.get(i);
            if(isMatching(card, fields))
                return false;
        }

        return true;
    }

    function isMatching(card, fields) {
        if(card.type0 > 0 && card.type0 !== fields.get(0).type) return false;
        if(card.type1 > 0 && card.type1 !== fields.get(1).type) return false;
        if(card.type2 > 0 && card.type2 !== fields.get(2).type) return false;
        if(card.type3 > 0 && card.type3 !== fields.get(3).type) return false;

        return true;
    }
}

