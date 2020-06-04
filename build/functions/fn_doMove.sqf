params ["_object", "_movePos", "_caller"];

_callerPos = getPosATL (_caller);
_objectPos = getPosATL (_object);
_destinationPos = [
	(_objectPos select 0) + (_movePos select 0),
	(_objectPos select 1) + (_movePos select 1),
	(_objectPos select 2) + (_movePos select 2)
];

[_object, _destinationPos, _caller] remoteExecCall ["build_fnc_doMoveLocal", 0];
