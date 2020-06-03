//
// This function places a held item, using either the drop or the place mechanics
//

params ["_object", "_objectPos", "_objectDir", "_objectUp", "_caller", "_drop"];

[format ["DoPlace: Pos: %1 Dir: %2 Up: %3", _objectPos, _objectDir, _objectUp], "BUILD"] call shared_fnc_log;

private _serverObjectPos = getPosATL _object;
private _serverObjectDir = vectorDir _object;
private _serverObjectUp = vectorUp _object;
[format ["Server before placement: Pos: %1 Dir: %2 Up: %3", _serverObjectPos, _serverObjectDir, _serverObjectUp], "BUILD"] call shared_fnc_log;

detach _object;

_serverObjectPos = getPosATL _object;
_serverObjectDir = vectorDir _object;
_serverObjectUp = vectorUp _object;
[format ["Server after detach: Pos: %1 Dir: %2 Up: %3", _serverObjectPos, _serverObjectDir, _serverObjectUp], "BUILD"] call shared_fnc_log;

if (!_drop) then {
    [format ["Setting position: %1", _objectPos], "BUILD"] call shared_fnc_log;
	_object enableSimulationGlobal false;
	_object setPosATL _objectPos;
	_object enableSimulationGlobal true;
} else {
    _object setVehiclePosition [_object, [], 0, 'CAN_COLLIDE'];
};

{
	_object enableCollisionWith _x;
} forEach playableUnits;

_object setVectorDirAndUp [_objectDir, _objectUp];
//_object setVectorDirAndUp [_serverObjectDir, _serverObjectUp];

_serverObjectPos = getPosATL _object;
_serverObjectDir = vectorDir _object;
_serverObjectUp = vectorUp _object;
[format ["Server after placement: Pos: %1 Dir: %2 Up: %3", _serverObjectPos, _serverObjectDir, _serverObjectUp], "BUILD"] call shared_fnc_log;

[_object, _caller] remoteExec ["build_fnc_setPlacedItemActions", 0];

_caller setVariable ["buildItemHeld", false, true];
_object setVariable ["buildItemHeld", false, true];
PLAYER_OBJECT_LIST pushBack _object;

sleep 0.1;

//[_object] execVM 'bulwark\solidObject.sqf';