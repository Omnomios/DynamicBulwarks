params ["_object", "_caller", "_drop"];

private _objectPos = getPosATL _object;
private _objectDir = vectorDir _object;
private _objectUp = vectorUp _object;

detach _object;

[_object, _objectPos, _objectDir, _objectUp, _caller, _drop] remoteExec ["build_fnc_doPlace", 2];
