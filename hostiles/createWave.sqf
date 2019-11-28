DBW_determineAndSpawnIfVehicleWave = {
	_armourStartWave = "ARMOUR_START_WAVE" call BIS_fnc_getParamValue;

	if (attkWave < (_armourStartWave + 5)) then {
		ArmourChance = 0;
		ArmourMaxSince = 0;
		ArmourCount = 0;
		carChance = 3;
		carMaxSince = 2;
		carCount = 1;
	};

	if (attkWave >= (_armourStartWave + 5) && attkWave < (_armourStartWave + 10)) then {
		ArmourChance = 4;
		ArmourMaxSince = 4;
		ArmourCount = 1;
		carChance = 3;
		carMaxSince = 3;
		carCount = 1 + (floor (playersNumber west / 4));
	};

	if (attkWave >= (_armourStartWave + 10) && attkWave < (_armourStartWave + 15)) then {
		ArmourChance = 3;
		ArmourMaxSince = 3;
		ArmourCount = 1 + (floor (playersNumber west / 4));
		carChance = 2;
		carMaxSince = 2;
		carCount = 2 + (floor (playersNumber west / 4));
	};

	if (attkWave >= (_armourStartWave + 15) && attkWave < (_armourStartWave + 20)) then {
		ArmourChance = 2;
		ArmourMaxSince = 2;
		ArmourCount = 2 + (floor (playersNumber west / 4));
		carChance = 1;
		carMaxSince = 2;
		carCount = 2 + (floor (playersNumber west / 4));
	};

	if (attkWave >= (_armourStartWave + 20)) then {
		ArmourChance = 2;
		ArmourMaxSince = 1;
		ArmourCount = 3 + (floor (playersNumber west / 4));
		carChance = 1;
		carMaxSince = 1;
		carCount = 3 + (floor (playersNumber west / 4));
	};

	if ((attkWave >= _armourStartWave && (floor random ArmourChance) == 1) || (attkWave >= _armourStartWave && wavesSinceArmour >= ArmourMaxSince)) then {
		_spwnVec = execVM "hostiles\spawnVehicle.sqf";
		waitUntil {scriptDone _spwnVec};
		wavesSinceArmour = 0;
	}
	else
	{
		if (attkWave >= _armourStartWave) then {
			wavesSinceArmour = wavesSinceArmour + 1;
		};
	};
	if ((attkWave >= _armourStartWave && (floor random carChance) == 1) || (attkWave >= _armourStartWave && wavesSinceArmour >= carMaxSince)) then {
		_spwnVec = execVM "hostiles\spawnCar.sqf";
		waitUntil {scriptDone _spwnVec};
		wavesSinceCar = 0;
	}
	else
	{
		if (attkWave >= _armourStartWave) then {
			wavesSinceCar = wavesSinceCar + 1;
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
	_waveScaleBase = 2; //adds 2 to base value each wave
	_baseValue = _waveScaleBase + _playerAmountMulti; //base value based on player amount and wave level
	_amountTotal = floor (_baseValue * attkWave * _difficultyMulti);
	_amountTotal
};
DBW_spawnGroup = {
	params["_classArr","_groupSize","_pos"];
	_groupClassArr = [];
	for ("_i") from 1 to _groupSize do { //select random class for each unit in group
		private _unitClass = selectRandom _classArr;
		_groupClassArr append [_unitClass];
	};
	_group = [_pos,EAST,_groupClassArr] call BIS_fnc_spawnGroup;
	_group //return
};
DBW_giveGroupRandPriWeap = {
	params ["_group","_weaponsArr"];
	{
		_unit = _x;
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
	} forEach (units _group);
};

DBW_giveGroupRandSecWeap = {
	params ["_group","_weaponsArr"];
	{
		_unit = _x;
		removeAllWeapons _unit;
		_unitSecondaryToAdd = selectRandom _weaponsArr;
		_unitMagToAdd = selectRandom getArray (configFile >> "CfgWeapons" >> _unitSecondaryToAdd >> "magazines");
		_unit addWeaponGlobal _unitSecondaryToAdd;
		_unit addPrimaryWeaponItem _unitMagToAdd;
		_unit addMagazine _unitMagToAdd;
		_unit addMagazine _unitMagToAdd;
		_unit addMagazine _unitMagToAdd;
		_unit selectWeapon _unitSecondaryToAdd;
	} forEach (units _group);
};

DBW_setGroupSkill = {	//WIP - setSkill general,reloadSpeed,spotDistance could be used
	params["_group","_value"];
	{
	_x setSkill ["aimingAccuracy", _value];
	_x setSkill ["aimingSpeed", (_value * 0.75)];
	_x setSkill ["aimingShake", _value];
	_x setSkill ["spotTime", 0.05];
	} forEach (units _group);
};
//gives units required eventhandler and makes them move towards the player
DBW_initGroup = {
	params["_group","_killpointsMulti"];
	{
	_x addEventHandler ["Hit", killPoints_fnc_hit];
	_x addEventHandler ["Killed", killPoints_fnc_killed];
	removeAllAssignedItems _x;
	_x setVariable ["points", []];
	_x setVariable ["killPointMulti", _killpointsMulti];
	mainZeus addCuratorEditableObjects [[_x], true];
	unitArray = waveUnits select 0;
	unitArray append [_x];
	} forEach (units _group);
	_groupLeader = leader _group;
	_groupLeader doMove (getPos (selectRandom playableUnits));
};

/* need function to limit amount of AI active at the same time, 
maybe check amount units alive before spawning a group and waituntil it lowers under certain threshold before actually spawning the next group. 
Would make units slowly be spawned during the wave instead of feeling like an additional waves
 */
