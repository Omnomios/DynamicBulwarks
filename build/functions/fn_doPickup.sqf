params ["_player", "_object", "_pos", "_dir"];

if (isNil "_pos") then {
    [_player, _object] remoteExecCall ["build_fnc_doPickupLocal", 0];
} else {
    [_player, _object, _pos, _dir] remoteExecCall ["build_fnc_doPickupLocal", 0];
};

_player setVariable ["buildItemHeld", true, true];
_object setVariable ["buildItemHeld", true, true];
