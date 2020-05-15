"Starting game" call shared_fnc_log;
if (isServer) then {

    // Send the current params to all players
    publicVariable "CurrentBulwarkParams";

    //execVM "startGame.sqf";
    call compile preprocessFileLineNumbers "startGame.sqf";

    format ["Initializing players %1", allPlayers] call shared_fnc_log;
    remoteExec ["lobby_fnc_startPlayers", allPlayers, true];
};

