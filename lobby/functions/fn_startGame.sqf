"Starting game" call shared_fnc_log;
publicVariable "CurrentBulwarkParams";
// TODO: Move this function and the ones below into a
// game section - they don't belong in the lobby.

// Start the server
remoteExec ["lobby_fnc_startGameServer", 2];

// Start the players
remoteExec ["lobby_fnc_startGamePlayer", 0, true];

