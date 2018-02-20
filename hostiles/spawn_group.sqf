_unitClasses = _this select 0;
_attackWave  = _this select 1;
_unitCount   = _this select 2;

if (_attackWave < 40) then { //determine AI skill based on Wave
	hosSkill = (_attackWave / 40);
} else {
	hosSkill = 1;
};

sleep 0.5;

_attGroupBand = createGroup [east, true];
_location = [bulwarkCity, BULWARK_RADIUS, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
for ("_i") from 1 to _unitCount do {
	_unitClass = selectRandom _unitClasses;
	_unit = objNull;
	_unit = _attGroupBand createUnit [_unitClass, _location, [], 0.5, "CAN_COLLIDE"];
	sleep 0.3;
	waitUntil {!isNull _unit};
	_unit doMove (getPos (selectRandom playableUnits));
	_unit setUnitAbility hosSkill; //todo https://community.bistudio.com/wiki/CfgAISkill
	_unit setSkill ["aimingAccuracy", 0.05];
	_unit setSkill ["aimingSpeed", 0.05];
	_unit setSkill ["aimingShake", 0.05];
	_unit setSkill ["spotTime", 0.05];
	_unit addEventHandler ["Hit", killPoints_fnc_hit];
	_unit addEventHandler ["Killed", killPoints_fnc_killed];
};
