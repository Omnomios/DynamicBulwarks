/**
*  spawnSquad
*
*  Creates a squad of units in a random location
*
*  Domain: Server
**/


_unitClasses = _this select 0;
_attackWave  = _this select 1;
_unitCount   = _this select 2;

if (_attackWave < 40) then { //determine AI skill based on Wave
	hosSkill = (_attackWave / 40);
} else {
	hosSkill = 1;
};

sleep 0.5;

_location = [bulwarkCity, BULWARK_RADIUS, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
for ("_i") from 1 to _unitCount do {
	_attGroupBand = createGroup [EAST, true];
	_unitClass = selectRandom _unitClasses;
	_unit = objNull;
	_unit = _attGroupBand createUnit [_unitClass, _location, [], 0.5, "FORM"];
	_unit setVariable ["movingToSafePos", false];
	[_unit, "AmovPercMstpSnonWnonDnon_SaluteOut"] remoteExec ["switchMove", 0];
	sleep 0.3;
	waitUntil {!isNull _unit};

	[_unit] join _attGroupBand;
	_unit setUnitAbility 1; //todo https://community.bistudio.com/wiki/CfgAISkill
	_unit setSkill ["aimingAccuracy", 1];
	_unit setSkill ["aimingSpeed", 1];
	_unit setSkill ["aimingShake", 1];
	_unit setSkill ["spotTime", 1];
	_unit addEventHandler ["Hit", killPoints_fnc_hit];
	_unit addEventHandler ["Killed", killPoints_fnc_killed];
	_unit setVariable ["nearObject", 0];

	/*
	removeAllAssignedItems _unit;
	if (floor random 3 == 1) then {
		_unit addBackpack "B_LegStrapBag_black_F";
		_unit addItemToBackpack "FirstAidKit";
	};
	*/

	if (suicideWave) then {
		//removeAllWeapons _unit;
		_unit addEventHandler ["Killed", CreateHostiles_fnc_suiExplode];
	};

	mainZeus addCuratorEditableObjects [[_unit], true];

	_unitArray = waveUnits select 0;
	_unitArray append [_unit];
};
