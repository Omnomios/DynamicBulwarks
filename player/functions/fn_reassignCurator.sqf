params ["_player"];

if(!isServer) then {
    _player remoteExecCall ["player_fnc_reassignCurator", 2];
} else {
    format ["Player %1 is Zeus", _player] call shared_fnc_log;
    private _curatorUnit = _player getVariable ["curatorUnit", nil];
    _player assignCurator _curatorUnit;
};
