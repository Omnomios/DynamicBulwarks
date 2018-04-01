/**
*  spawnInfantry
*
*  Creates a single unit in a random location
*
*  Domain: Server
**/

_unitClasses = _this select 0;
_attackWave   = _this select 1;

if (_attackWave < 40) then { //determine AI skill based on Wave
	hosSkill = (_attackWave / 40);
} else {
	hosSkill = 1;
};

sleep 0.5;

_attGroupBand = createGroup [EAST, true];
_location = [bulwarkCity, BULWARK_RADIUS, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
_unitClass = selectRandom _unitClasses;
_unit = objNull;
_unit = _attGroupBand createUnit [_unitClass, _location, [], 0.5, "FORM"];
sleep 0.3;
waitUntil {!isNull _unit};

[_unit] join _attGroupBand;
_unit doMove (getPos (selectRandom playableUnits));
_unit setUnitAbility hosSkill; //todo https://community.bistudio.com/wiki/CfgAISkill
_unit setSkill ["aimingAccuracy", hosSkill];
_unit setSkill ["aimingSpeed", hosSkill];
_unit setSkill ["aimingShake", hosSkill];
_unit setSkill ["spotTime", hosSkill];
_unit addEventHandler ["Hit", killPoints_fnc_hit];
_unit addEventHandler ["Killed", killPoints_fnc_killed];

mainZeus addCuratorEditableObjects [[_unit], true];

removeAllAssignedItems _unit;
