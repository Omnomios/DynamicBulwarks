params ["_player", "_object", "_pos", "_dir"];

if (isNil "_pos") then {
    [format ["DoPickup called for PLACED item %1 on player %2", _object, _player], "BUILD"] call shared_fnc_log;
} else {
    [format ["DoPickup called for NEW item %1 on player %2 with position: %3", _object, _player, _pos], "BUILD"] call shared_fnc_log;
};


if (isNil "_pos") then {
    [_object, _player] call BIS_fnc_attachToRelative;
} else {
    _object attachTo [_player, _pos, "Pelvis"];
    _playerDir = _player getRelDir _object;
    _dir = _this select 3;
    _holdDir = _playerDir + _dir;
    _object setdir _holdDir;
};

{
    [_object, _x] remoteExec ["disableCollisionWith", 0];
} forEach playableUnits;

[_object, _player] remoteExec ["build_fnc_setPickedUpItemActions", 0];

_player setVariable ["buildItemHeld", true, true];
_object setVariable ["buildItemHeld", true, true];
