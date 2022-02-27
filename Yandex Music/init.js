if ("mediaSession" in navigator && externalAPI) {
    navigator.mediaSession.setActionHandler("play", () => {
        externalAPI.togglePause(false);
    });
    navigator.mediaSession.setActionHandler("pause", () => {
        externalAPI.togglePause(true);
    });
    navigator.mediaSession.setActionHandler("seekto", ({ seekTime }) => {
        externalAPI.setPosition(seekTime);
    });
    const updateControls = () => {
        const controls = externalAPI.getControls();
        navigator.mediaSession.setActionHandler(
            "previoustrack",
            controls.prev ? externalAPI.prev : null,
        );
        navigator.mediaSession.setActionHandler(
            "nexttrack",
            controls.next ? externalAPI.next : null,
        );
    };
    externalAPI.on(externalAPI.EVENT_CONTROLS, updateControls);
    updateControls();

    externalAPI.on(externalAPI.EVENT_TRACK, () => {
        const track = externalAPI.getCurrentTrack();
        navigator.mediaSession.metadata = new MediaMetadata({
            title: track.title || "",
            artist: track.artists.map((a) => a.title).join(", "),
            album: track.album ? track.album.title : "",
            artwork: track.cover
                ? [
                      {
                          src:
                              "https://" + track.cover.replace("%%", "200x200"),
                          sizes: "200x200",
                          type: "image/jpeg",
                      },
                  ]
                : [],
        });
    });

    externalAPI.on(externalAPI.EVENT_PROGRESS, () => {
        const progress = externalAPI.getProgress();
        navigator.mediaSession.setPositionState({
            duration: progress.duration,
            playbackRate: externalAPI.getSpeed(),
            position: progress.position,
        });
    });
    externalAPI.on(externalAPI.EVENT_STATE, () => {
        navigator.mediaSession.playbackState = externalAPI.isPlaying()
            ? "playing"
            : "paused";
    });
}
