params ["_object", "_caller", "_drop"];

private _objectPos = getPosATL _object;
private _objectDir = vectorDir _object;
private _objectUp = vectorUp _object;

detach _object;

[_object, _objectPos, _objectDir, _objectUp, _caller, _drop] remoteExec ["build_fnc_doPlace", 2];

// _objectPos = getPosATL (_object);
// detach _object;
// 
// [_object, _caller, _objectPos] remoteExec ["build_fnc_doPlacement", 0];
// 
// _object setVehiclePosition [_object, [], 0, 'CAN_COLLIDE'];
// 
// [_object, _caller] remoteExec ["build_fnc_doPostPlacement", 0];
// 
// _caller setVariable ["buildItemHeld", false, true];
// _object setVariable ["buildItemHeld", false, true];
// PLAYER_OBJECT_LIST pushBack _object;
// sleep 0.1;
// [[_object], 'bulwark\solidObject.sqf'] remoteExec ['execVM', 2];