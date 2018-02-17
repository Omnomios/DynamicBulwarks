_unitClasses = _this select 0;
_attackWave   = _this select 1;
_unitCount   = _this select 2;

if (_attackWave < 40) then { //determine AI skill based on Wave
	hosSkill = (_attackWave / 40);
} else {
	hosSkill = 1;
};

sleep 0.5;

_attGroupBand = createGroup [east, true];
_groupPos = [bulwarkCity, 150, 300,1,0] call BIS_fnc_findSafePos;
for ("_i") from 1 to _unitCount do {
	_banditSpaned = objNull;
	_infBandit = selectRandom _unitClasses;
	hint ("spawning: " + str _infBandit);
	//sleep 1;
	_infBandit createUnit [_groupPos, _attGroupBand, "_banditSpaned = this", hosSkill];
	if (isNull _banditSpaned) then {hint "falied to spawn";} else {
		_banditSpaned doMove (getPos (selectRandom playableUnits));
		_banditSpaned setUnitAbility hosSkill; //todo https://community.bistudio.com/wiki/CfgAISkill
		_banditSpaned setSkill ["aimingAccuracy", hosSkill];
		_banditSpaned setSkill ["aimingSpeed", hosSkill];
		_banditSpaned setSkill ["aimingShake", hosSkill];
		_banditSpaned setSkill ["spotTime", hosSkill];
		_banditSpaned addEventHandler ["Hit", killPoints_fnc_hit];
		_banditSpaned addEventHandler ["Killed", killPoints_fnc_killed];
		//hint ("current skill " + str (skill _banditSpaned));
		//sleep 1;
	};
};
