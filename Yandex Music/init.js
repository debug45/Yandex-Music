(function () {
    if (!"mediaSession" in navigator) return;
    if (!externalAPI) return;

    const { mediaSession } = navigator;

    const handlePlay = () => {
        externalAPI.togglePause(false);
    };
    const handlePause = () => {
        externalAPI.togglePause(true);
    };
    const handlePrev = () => {
        const { prev } = externalAPI.getControls();
        prev ? externalAPI.prev() : externalAPI.setPosition(0);
    };
    const handleNext = () => {
        externalAPI.next();
    };
    const handleSeek = (details) => {
        const { seekTime } = details;
        externalAPI.setPosition(seekTime);
    };

    /**
     * @param {ExternalAPI~TrackInfo} track
     * @returns {MediaMetadata}
     */
    const getTrackMediaMetadata = (track) => {
        const coverUrl =
            track.cover && `https://${track.cover.replace("%%", "200x200")}`;
        const cover = coverUrl && {
            src: coverUrl,
            sizes: "200x200",
        };
        const artwork = [cover].filter(Boolean);

        const album = track.album ? track.album.title : "";
        const artist = track.artists.map((a) => a.title).join(", ");
        const title = track.title || "";

        return new MediaMetadata({
            artwork,
            artist,
            album,
            title,
        });
    };

    const updateMediaSessionMetadata = () => {
        const track = externalAPI.getCurrentTrack();
        mediaSession.metadata = getTrackMediaMetadata(track);
    };

    const updateMediaSessionProgress = () => {
        const { duration, position } = externalAPI.getProgress();
        const playbackRate = externalAPI.getSpeed();
        const stateDict = { duration, playbackRate, position };
        mediaSession.setPositionState(stateDict);
    };

    const updateMediaSessionPlaybackState = () => {
        mediaSession.playbackState = externalAPI.isPlaying()
            ? "playing"
            : "paused";
    };

    externalAPI.on(externalAPI.EVENT_TRACK, updateMediaSessionMetadata);
    externalAPI.on(externalAPI.EVENT_PROGRESS, updateMediaSessionProgress);
    externalAPI.on(externalAPI.EVENT_STATE, updateMediaSessionPlaybackState);

    mediaSession.setActionHandler("play", handlePlay);
    mediaSession.setActionHandler("pause", handlePause);
    mediaSession.setActionHandler("seekto", handleSeek);
    mediaSession.setActionHandler("previoustrack", handlePrev);
    mediaSession.setActionHandler("nexttrack", handleNext);

    updateMediaSessionMetadata();
    updateMediaSessionProgress();
    updateMediaSessionPlaybackState();
})();
