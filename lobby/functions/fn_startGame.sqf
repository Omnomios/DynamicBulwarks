// Validate the game can start
#include "..\..\shared\bulwark.hpp"
if (count ([BULWARK_PARAM_FILTER_FACTIONS] call shared_fnc_getCurrentParamValue) == 0) then {
    ["No factions selected!", "Please select at least one enemy faction."] call lobby_fnc_displayError;
} else {
    "Starting game" call shared_fnc_log;
    publicVariable "CurrentBulwarkParams";

    // Start the server
    remoteExec ["server_fnc_startServer", 2];

    // Start the players.  This will also get run every
    // time a player joins.
    remoteExec ["player_fnc_startPlayer", 0, true];
};
