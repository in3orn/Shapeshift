import VPlay 2.0
import QtQuick 2.0

Item {
    id: audioManager

    property bool muted: !settings.soundEnabled

    SoundEffectVPlay {
        id: applause
        source: "../../assets/sound/applause.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: aww
        source: "../../assets/sound/aww.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: click
        source: "../../assets/sound/click.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: coin
        source: "../../assets/sound/coin.wav"
        muted: audioManager.muted
    }

    SoundEffectVPlay {
        id: craft
        source: "../../assets/sound/craft.wav"
        muted: audioManager.muted
    }

    function playApplauseSfx() {
        if(muted) return;
        applause.play();
    }

    function playAwwSfx() {
        if(muted) return;
        aww.play();
    }

    function playClickSfx() {
        if(muted) return;
        click.play();
    }

    function playCoinSfx() {
        if(muted) return;
        coin.play();
    }

    function playCraftSfx() {
        if(muted) return;
        craft.play();
    }
}

