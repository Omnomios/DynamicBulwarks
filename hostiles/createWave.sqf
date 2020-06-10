#include "..\shared\bulwark.hpp"

DBW_determineAndSpawnIfVehicleWave = {
	if (attkWave < (ARMOUR_START_WAVE + 5)) then {
		ArmourChance = 0;
		ArmourMaxSince = 0;
		ArmourCount = 0;
	};

	if (attkWave >= (ARMOUR_START_WAVE + 5) && attkWave < (ARMOUR_START_WAVE + 10)) then {
		ArmourChance = 4;
		ArmourMaxSince = 4;
		ArmourCount = 1;
	};

	if (attkWave >= (ARMOUR_START_WAVE + 10) && attkWave < (ARMOUR_START_WAVE + 15)) then {
		ArmourChance = 3;
		ArmourMaxSince = 3;
		ArmourCount = 1 + (floor (playersNumber west / 4));
	};

	if (attkWave >= (ARMOUR_START_WAVE + 15) && attkWave < (ARMOUR_START_WAVE + 20)) then {
		ArmourChance = 2;
		ArmourMaxSince = 2;
		ArmourCount = 2 + (floor (playersNumber west / 4));
	};

	if (attkWave >= (ARMOUR_START_WAVE + 20)) then {
		ArmourChance = 2;
		ArmourMaxSince = 1;
		ArmourCount = 3 + (floor (playersNumber west / 4));
	};

	if ((attkWave >= ARMOUR_START_WAVE && (floor random ArmourChance) == 0) || (attkWave >= ARMOUR_START_WAVE && wavesSinceArmour >= ArmourMaxSince)) then {
		private _vehiclesToSpawnWithCosts = attkWave call hostiles_fnc_getVehiclesForWave;
		private _vehiclesToSpawn = [];
		{
			_vehiclesToSpawn pushBack (_x select 0);
		} foreach _vehiclesToSpawnWithCosts;
		
		[_vehiclesToSpawn] call compileFinal preprocessFileLineNumbers "hostiles\spawnVehicle.sqf";
		wavesSinceArmour = 0;
	}
	else
	{
		if (attkWave >= ARMOUR_START_WAVE) then {
			wavesSinceArmour = wavesSinceArmour + 1;
		};
	};
};

DBW_getHostileListsAndKillMulti = { 
	_classArray = objNull;
	_scoreMulti = objNull;
	if (attkWave <= 5) then {
		_classArray = LIST_HOSTILE_LEVEL_1;
		_scoreMulti = HOSTILE_LEVEL_1_POINT_SCORE;
	};
	if (attkWave <= 10 && {attkWave > 5}) then {
		_classArray = LIST_HOSTILE_LEVEL_2;
		_scoreMulti = HOSTILE_LEVEL_2_POINT_SCORE;
	};
	if (attkWave <= 15 && {attkWave > 10}) then {
		_classArray = LIST_HOSTILE_LEVEL_3;
		_scoreMulti = HOSTILE_LEVEL_3_POINT_SCORE;
	};
	if (attkWave > 15) then {
		_classArray = LIST_HOSTILE_LEVEL_4;
		_scoreMulti = HOSTILE_LEVEL_4_POINT_SCORE;
	};
	[_classArray,_scoreMulti]
};

DBW_getHostileAmount = { //determines how many units need to be spawned
	_playerAmountMulti = ((playersNumber west) * HOSTILE_TEAM_MULTIPLIER) - HOSTILE_TEAM_MULTIPLIER; //Hostile_TEAM_MULTIPLIER only has an effect if 2 or more people are online this way
	_difficultyMulti = HOSTILE_MULTIPLIER; //multiplies everything
	_waveScaleBase = 1; //adds 2 to base value each wave
	_baseValue = _waveScaleBase + _playerAmountMulti; //actual base value with player amount
	_amountTotal = floor (_baseValue * attkWave * _difficultyMulti);
	_amountTotal
};

CWS_getHostileScoreMultiplier = {
	params ["_cost"];
	private _offset = (_cost - 1) / (INFANTRY_COST_CAP - 1);
	HOSTILE_INFANTRY_POINT_SCORE + _offset;
};

DBW_spawnHostile = {
	params["_unitClass","_pos"];
	_group = createGroup [EAST,true];
	_unit = _group createUnit [_unitClass, _pos, [], 0.5, "FORM"];
	sleep 0.3;
	waitUntil {!isNull _unit};
	[_unit] join _group;
	_unit //return
};

DBW_giveRandPriWeap = {
	params ["_unit","_weaponsArr"];
	_unitPrimaryWeap = primaryWeapon _unit;
	_primaryAmmoTpyes = getArray (configFile >> "CfgWeapons" >> _unitPrimaryWeap >> "magazines");
	{
		if (_x in _primaryAmmoTpyes) then {
		_unit removeMagazineGlobal _x;
		};
	} forEach magazines _unit;
	_weap = selectRandom _weaponsArr;
	_unitPrimaryToAdd = _weap;
	_unitMagToAdd = selectRandom getArray (configFile >> "CfgWeapons" >> _unitPrimaryToAdd >> "magazines");
	_unit addWeaponGlobal _unitPrimaryToAdd;
	_unit addPrimaryWeaponItem _unitMagToAdd;
	_unit addMagazine _unitMagToAdd;
	_unit addMagazine _unitMagToAdd;
	_unit addMagazine _unitMagToAdd;
	_unit selectWeapon _unitPrimaryToAdd;
};

DBW_giveRandSecWeap = {
	params ["_unit","_weaponsArr"];
	removeAllWeapons _unit;
	_unitSecondaryToAdd = selectRandom _weaponsArr;
	_unitMagToAdd = selectRandom getArray (configFile >> "CfgWeapons" >> _unitSecondaryToAdd >> "magazines");
	_unit addWeaponGlobal _unitSecondaryToAdd;
	_unit addPrimaryWeaponItem _unitMagToAdd;
	_unit addMagazine _unitMagToAdd;
	_unit addMagazine _unitMagToAdd;
	_unit addMagazine _unitMagToAdd;
	_unit selectWeapon _unitSecondaryToAdd;
};

DBW_setSkill = {	//WIP - setSkill general,reloadSpeed,spotDistance could be used
	params["_unit","_value"];
	_unit setSkill ["aimingAccuracy", _value];
	_unit setSkill ["aimingSpeed", (_value * 0.75)];
	_unit setSkill ["aimingShake", _value];
	_unit setSkill ["spotTime", 0.05];
};
//gives units required eventhandler and makes them move towards the player
DBW_initUnit = {
	params["_unit","_killpointsMulti"];
	_unit addEventHandler ["Hit", killPoints_fnc_hit];
	_unit addEventHandler ["Killed", hostiles_fnc_eventKilled];
	removeAllAssignedItems _unit;
	_unit setVariable ["points", []];
	_unit setVariable ["killPointMulti", _killpointsMulti];
	mainZeus addCuratorEditableObjects [[_unit], true];
	_unit call hostiles_fnc_addUnitToWaveForCleanup;
	_unit doMove (getPos (selectRandom playableUnits));
};

/* need function to limit amount of AI active at the same time, 
maybe check amount units alive before spawning a group and waituntil it lowers under certain threshold before actually spawning the next group. 
Would make units slowly be spawned during the wave instead of feeling like an additional waves
 */
