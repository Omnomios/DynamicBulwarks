// This should be a scheduled environment

if (hasInterface) then {
    player remoteExec ["server_fnc_registerPlayer", 2];
    call player_fnc_initPlayer;
};
