params ["_player", "_object", "_pos", "_dir"];

[_player, _object, _dir, _pos] remoteExecCall ["build_fnc_doPickupLocal", 0];

_player setVariable ["buildItemHeld", true, true];
_object setVariable ["buildItemHeld", true, true];
