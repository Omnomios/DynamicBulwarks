/**
*  spawnSquad
*
*  Creates a squad of units in a random location
*
*  Domain: Server
**/

_randWeapons = "RANDOM_WEAPONS" call BIS_fnc_getParamValue;

if (defectorWave) then { //determine if defect wave and spawn from List defined in EditMe.sqf
	unitClasses = DEFECTOR_CLASS;
} else {
	unitClasses = _this select 0;
};
_attackWave  = _this select 1;
_unitCount   = _this select 2;
_killPointMulti  = _this select 3;

hosSkill = 0.05;
if (_attackWave < 5) then { //determine AI skill based on Wave
	hosSkill = 0.05;
};
if (_attackWave < 10 && _attackWave >= 5) then {
	hosSkill = 0.075;
};
if (_attackWave < 15 && _attackWave >= 10) then {
	hosSkill = 0.1;
};
if (_attackWave < 20 && _attackWave >= 15) then {
	hosSkill = 0.15;
};
if (_attackWave < 25 && _attackWave >= 20) then {
	hosSkill = 0.2;
};
if (_attackWave < 25 && _attackWave >= 20) then {
	hosSkill = 0.4;
};
if (_attackWave < 30 && _attackWave >= 25) then {
	hosSkill = 0.5;
};
if (_attackWave >= 30) then {
	hosSkill = 1;
};

sleep 0.5;

_location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
for ("_i") from 1 to _unitCount do {
	_attGroupBand = createGroup [EAST, true];
	_unitClass = selectRandom unitClasses;
	_unit = objNull;
	_unit = _attGroupBand createUnit [_unitClass, _location, [], 0.5, "FORM"];
	sleep 0.3;
	waitUntil {!isNull _unit};

	[_unit] join _attGroupBand;
	_unit doMove (getPos (selectRandom playableUnits));
	_unit setUnitAbility hosSkill; //todo https://community.bistudio.com/wiki/CfgAISkill
	_unit setSkill ["aimingAccuracy", hosSkill];
	_unit setSkill ["aimingSpeed", (hosSkill * 0.75)];
	_unit setSkill ["aimingShake", hosSkill];
	_unit setSkill ["spotTime", 0.05];
	_unit addEventHandler ["Hit", killPoints_fnc_hit];
	_unit addEventHandler ["Killed", killPoints_fnc_killed];
	removeAllAssignedItems _unit;
	_unit setVariable ["points", []];
	_unit setVariable ["killPointMulti", _killPointMulti];

	if (_randWeapons == 1) then {
		_unitPrimaryWeap = primaryWeapon _unit;
		_primaryAmmoTpyes = getArray (configFile >> "CfgWeapons" >> _unitPrimaryWeap >> "magazines");
		{
			if (_x in _primaryAmmoTpyes) then {
				_unit removeMagazineGlobal _x;
			};
		}forEach magazines _unit;
		_unitPrimaryToAdd = selectRandom List_Primaries;
		_unitMagToAdd = selectRandom getArray (configFile >> "CfgWeapons" >> _unitPrimaryToAdd >> "magazines");
		_unit addWeaponGlobal _unitPrimaryToAdd;
		_unit addPrimaryWeaponItem _unitMagToAdd;
		_unit addMagazine _unitMagToAdd;
		_unit addMagazine _unitMagToAdd;
		_unit addMagazine _unitMagToAdd;
		_unit selectWeapon _unitPrimaryToAdd;
	};

	if(_attackWave <= PISTOL_HOSTILES) then {
		removeAllWeapons _unit;
		_unit addMagazine "16Rnd_9x21_Mag";
		_unit addMagazine "16Rnd_9x21_Mag";
		_unit addWeapon "hgun_P07_F";
		if ((floor random 4) == 1) then {
			_unit additem "FirstAidKit";
		};
	};

	if (suicideWave) then {
		removeAllWeapons _unit;
		_unit addEventHandler ["Killed", CreateHostiles_fnc_suiExplode];
	};

	if (demineWave && (floor random 2 == 0) && droneCount <= 15) then {
		droneCount = droneCount + 1;
		_aicrew = creategroup EAST;
		_drone = [_location, 50, "C_IDAP_UAV_06_antimine_F", _aicrew] call BIS_fnc_spawnVehicle;
		droneSquad pushback _aicrew;
		_wp1 = _aicrew addWaypoint [position bulwarkBox, 0];
		_wp1 setWaypointType "SAD";
		_leadah = leader _aicrew;
		_leadah flyInHeight 30;
		_leadah setSkill 1;
		sleep 0.5;
		mainZeus addCuratorEditableObjects [[_drone select 0], true];
		_leadah addEventHandler ["Hit", killPoints_fnc_hit];
		_leadah addEventHandler ["Killed", {
			params ["_unit", "_killer", "_instigator", "_useEffects"];
			call killPoints_fnc_killed;
			_scriptedCharge = "HandGrenade" createVehicle (getPos _unit);
			_scriptedCharge setdamage 1;
			deleteVehicle _unit;
		}];
		_leadah setVariable ["killPointMulti", HOSTILE_CAR_POINT_SCORE];
	};
	mainZeus addCuratorEditableObjects [[_unit], true];
	unitArray = waveUnits select 0;
	unitArray append [_unit];
};
