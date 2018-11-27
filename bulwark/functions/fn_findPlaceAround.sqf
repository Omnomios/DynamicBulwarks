_spawnObject = _this select 0;

// increase z to prevent false intersection with ground
_spawnObjectPos = (getPosASL _spawnObject) vectorAdd [0,0,0.2] ;

_foundPos = _spawnObjectPos;

for ("_i") from 0 to 7 do {
	_relPos = [ _spawnObjectPos, 2, 45 * _i] call BIS_fnc_relPos;
	if(!lineIntersects [ _spawnObjectPos, _relPos, _spawnObject]) exitWith {_foundPos = _relPos;};
};

_foundPos;