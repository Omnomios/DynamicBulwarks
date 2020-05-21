"Starting game" call shared_fnc_log;
publicVariable "CurrentBulwarkParams";

// Start the server
remoteExec ["server_fnc_startServer", 2];

// Start the players
remoteExec ["player_fnc_startPlayer", 0, true];
