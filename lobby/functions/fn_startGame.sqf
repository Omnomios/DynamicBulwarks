"Starting game" call shared_fnc_log;
publicVariable "CurrentBulwarkParams";

// Start the server
remoteExec ["server_fnc_startServer", 2];

// Start the players.  This will also get run every
// time a player joins.
remoteExec ["player_fnc_startPlayer", 0, true];
