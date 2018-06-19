_object = _this select 0;
_caller = _this select 1;
_pos = _this select 2;

_playerArr = [_caller];
_allPlayers = playableUnits - _playerArr;
_closestPlayerDist = 9999;

{
	_playerDistance = _object distance2d _x;
	if ((_playerDistance < _closestPlayerDist)) then {
	  _closestPlayerDist = _playerDistance;
	};
} forEach _allPlayers;

if (_closestPlayerDist > 5) then {

	if (isNil "_pos") then {
		[_object, _caller] call BIS_fnc_attachToRelative ;
	} else {
		_object attachTo [_caller, _pos, "Pelvis"];
	};

	{
		[_object, _x] remoteExec ["disableCollisionWith", 0];
	} forEach playableUnits;

	removeAllActions _object;

	_caller addAction [
		"<t color='#00ffff'>Place Object</t>",
		'[_this select 3, _this select 1, _this select 2] call build_fnc_drop;',
		_object
	];

} else {

	hint 'players too close';

};




