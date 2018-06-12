_spawnObject = _this select 0;

_foundPos = getPosASL _spawnObject;

for ("_i") from 0 to 7 do {
	_relPos = [getPosASL _spawnObject, 2, 45 * _i] call BIS_fnc_relPos;
	if(!lineIntersects [ getPosASL _spawnObject, _relPos, _spawnObject]) exitWith {_foundPos = _relPos;};
};

_foundPos;
