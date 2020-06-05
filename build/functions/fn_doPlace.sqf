params ["_object", "_objectPos", "_objectDir", "_objectUp", "_caller", "_drop"];

[_object, _objectPos, _objectDir, _objectUp, _caller, _drop] remoteExec ["build_fnc_doPlaceLocal", 0];

_caller setVariable ["buildItemHeld", false, true];
_object setVariable ["buildItemHeld", false, true];

PLAYER_OBJECT_LIST pushBack _object;

sleep 0.1;

[_object] execVM 'bulwark\solidObject.sqf';