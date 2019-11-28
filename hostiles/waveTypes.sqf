/*
*All functions with the DBW_ tag used in this file can be found in hostiles\createWave.sqf. Here is a list of what parameters these functions expect and/or return:
* DBW_determineAndSpawnIfVehicleWave - expects nothing and returns nothing. If you don't want vehicles spawning in your special wave leave it out.
* DBW_getHostileListsAndKillMulti - Expects nothing. Returns Array of Clasnames, NUMBER (KillpointsMultiplier). First is an array of classnames. Second one is score mutliplier for killpoints. If you want to use another list of classNames or a specific one: Use the function to just grab the score multi. Example: Defector Wave
* DBW_initGroup - Expects Group,KillpointsMultiplier (NUMBER) -- Function initializes units in the group. Gives them waypoints, adds to Zeus and so on.
* DBW_getHostileAmount - expects nothing and returns NUMBER of hostiles that should spawn in the wave. 
* DBW_spawnGroup - Expects: Array of classnames, NUMBER (groupsize), Position. Returns: The created group. -- spawns a group.
* DBW_setGroupSkill - Expects Group,NUMBER (Skill) -- sets units skill values
* DBW_giveGroupRandPriWeap - Expects Group, ARRAY (Weapons) -- gives units in group random primary weapons
* DBW_giveGroupRandSecWeap - Expects Group, ARRAY (Weapons) -- gives units in group random secondary weapons (pistols)
*/


DBW_SUICIDEWAVE = {
	execVM "hostiles\suicideWave.sqf";
	execVM "hostiles\suicideAudio.sqf";
	["SpecialWarning",["SUICIDE BOMBERS! Don't Let Them Get Close!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_amountGroups = floor (_amount / 5);
	_amountLeftovers = _amount - (_amountGroups * 5);
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amountGroups do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,5,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		{
			removeAllWeapons _x;
			_x addEventHandler ["Killed", CreateHostiles_fnc_suiExplode];
		} forEach (units _group);
		private _init = [_group,_scoreMulti] call DBW_initGroup;
	};
	for ("_i") from 1 to _amountLeftovers do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,1,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
	};
	waveSpawned = true;
};

DBW_SPECMORTARWAVE = {
	[] execVM "hostiles\specMortar.sqf";
	["SpecialWarning",["MORTAR! FIND IT BEFORE IT DESTROYS THE BULWARK!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_NORMALWAVE;
};

DBW_SPECCIVS = {
	[] execVM "hostiles\civWave.sqf";
	["SpecialWarning",["CIVILIANS Are Fleeing! Don't Shoot Them!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_NORMALWAVE;
};

DBW_NIGHTWAVE = {
	currentTime = daytime;
	skipTime (24 - currentTime);
	nightWave = true;
	["SpecialWarning",["They mostly come at night. Mostly..."]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_NORMALWAVE;

};

DBW_FOGWAVE = {
	15 setFog 1;
	["SpecialWarning",["A dense fog is rolling in!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_NORMALWAVE;
};

DBW_SWITCHAROOWAVE = { //want to add garrisoned units in surrounding buildings. Making the player do some room clearing to make wave more intresting.
	execVM "hostiles\specSwticharooWave.sqf";
	["SpecialWarning",["You were overrun! Take back the bulwark!! Quickly!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	_secCount = 0;
	_deadUnconscious = [];
	sleep 1;
	while {EAST countSide allUnits > 0} do {
		_allHCs = entities "HeadlessClient_F";
		_allHPs = allPlayers - _allHCs;
		{
			if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
				_deadUnconscious pushBack _x;
			};
		} foreach _allHPs;
		_respawnTickets = [west] call BIS_fnc_respawnTickets;
		if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
			sleep 1;

			//Check that Players have not been revived
			_deadUnconscious = [];
			{
				if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
					_deadUnconscious pushBack _x;
				};
			} foreach _allHPs;
			if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
				sleep 1;
				if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
					missionFailure = true;
				};
			};
		};
	};
};

DBW_DEMINEWAVE = {
	demineWave = true;
	droneSquad = [];
	execVM "hostiles\droneFire.sqf";
	["SpecialWarning",["Look up! They're sending drones!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	for "_i" from 1 to 30 do {
		if ((floor random 2) == 0 && droneCount <= 15) then {
			droneCount = droneCount + 1;
			_aicrew = creategroup EAST;
			_location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
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
	};
	[] call DBW_NORMALWAVE;
};

DBW_DEFECTORWAVE = {
	["SpecialWarning",["NATO Defectors Are Attacking Us!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_amountGroups = floor (_amount / 5);
	_amountLeftovers = _amount - (_amountGroups * 5);
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amountGroups do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,5,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
	};
	for ("_i") from 1 to _amountLeftovers do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,1,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
	};
	waveSpawned = true;
};

DBW_MGWAVE = {
	["SpecialWarning",["MG Wave, take cover!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_amountGroups = floor (_amount / 5);
	_amountLeftovers = _amount - (_amountGroups * 5);
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amountGroups do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,5,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		private _giveSniper = [_group,List_MG] call DBW_giveGroupRandPriWeap;
	};
	for ("_i") from 1 to _amountLeftovers do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,1,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		private _giveSniper = [_group,List_MG] call DBW_giveGroupRandPriWeap;
	};
	waveSpawned = true;
};

DBW_SNIPERWAVE = {
	["SpecialWarning",["Sniper Wave, take cover!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_amountGroups = floor (_amount / 5);
	_amountLeftovers = _amount - (_amountGroups * 5);
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amountGroups do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,5,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		private _giveSniper = [_group,List_Sniper] call DBW_giveGroupRandPriWeap;
	};
	for ("_i") from 1 to _amountLeftovers do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,1,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		private _giveSniper = [_group,List_Sniper] call DBW_giveGroupRandPriWeap;
	};
	waveSpawned = true;
};

DBW_NORMALWAVE = {	//could probably break this into one more functions to remove repeating code between special waves and make creating new special waves easier
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_amountGroups = floor (_amount / 5);
	_amountLeftovers = _amount - (_amountGroups * 5);
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amountGroups do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		_group = [_classArray,5,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		if (RANDOM_WEAPONS) then {
			[_group,List_Primaries] call DBW_giveGroupRandPriWeap;
		};
	};
	for ("_i") from 1 to _amountLeftovers do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,1,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		if (RANDOM_WEAPONS) then {
			[_group,List_Primaries] call DBW_giveGroupRandPriWeap;
		};
	};
	waveSpawned = true;
};

DBW_PISTOLWAVE = {
	["TaskAssigned",["In-coming","Wave " + str attkWave]] remoteExec ["BIS_fnc_showNotification", 0];
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_amountGroups = floor (_amount / 5);
	_amountLeftovers = _amount - (_amountGroups * 5);
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amountGroups do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,5,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		private _randWeap = [_group,List_Secondaries] call DBW_giveGroupRandSecWeap;
		{
			if ((floor random 4) == 1) then {
				_x additem "FirstAidKit";
			};
		} forEach (units _group);
	};
	for ("_i") from 1 to _amountLeftovers do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,1,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		private _randWeap = [_group,List_Secondaries] call DBW_giveGroupRandSecWeap;
	};
	waveSpawned = true;
};
//Requires IFA3_AIO_LITE start
DBW_FLAMEWAVE = {
	["SpecialWarning",["FLAMETHROWER WAVE, INCOMING!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_amountGroups = floor (_amount / 5);
	_amountLeftovers = _amount - (_amountGroups * 5);
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amountGroups do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,5,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		{
			_unit = _x;
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeBackpack _unit;
			// "Add weapons";
			_unit addWeapon "LIB_M2_Flamethrower";
			_unit addPrimaryWeaponItem "LIB_M2_Flamethrower_Mag";
			// "Add containers";
			_unit addBackpack "B_LIB_US_M2Flamethrower";
			// "Add items to containers";
			_unit addItemToVest "FirstAidKit";
			for "_i" from 1 to 5 do {_unit addItemToVest "LIB_No77";};
			for "_i" from 1 to 20 do {_unit addItemToBackpack "LIB_No77";};
			_unit enableStamina false;
		} forEach (units _group);
	};
	for ("_i") from 1 to _amountLeftovers do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,1,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		{
			_unit = _x;
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeBackpack _unit;
			// "Add weapons";
			_unit addWeapon "LIB_M2_Flamethrower";
			_unit addPrimaryWeaponItem "LIB_M2_Flamethrower_Mag";
			// "Add containers";
			_unit addBackpack "B_LIB_US_M2Flamethrower";
			// "Add items to containers";
			_unit addItemToVest "FirstAidKit";
			for "_i" from 1 to 5 do {_unit addItemToVest "LIB_No77";};
			for "_i" from 1 to 20 do {_unit addItemToBackpack "LIB_No77";};
			_unit enableStamina false;
		} forEach (units _group);
	};
	waveSpawned = true;
};

DBW_PTRDWAVE = {
	["SpecialWarning",["MG Wave, take cover!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_amountGroups = floor (_amount / 5);
	_amountLeftovers = _amount - (_amountGroups * 5);
	_skill = attkWave * 0.02 * 2;
	for ("_i") from 1 to _amountGroups do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,5,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		private _givePTRD = [_group,["LIB_PTRD"]] call DBW_giveGroupRandPriWeap;
		{
			for ("_i") from 1 to 6 do {
				_x addMagazine "LIB_1Rnd_145x114";
			};
		} forEach (units _group);
	};
	for ("_i") from 1 to _amountLeftovers do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _group = [_classArray,1,_location] call DBW_spawnGroup;
		waitUntil {sleep 0.5;!isNil "_group"};
		private _setSkill = [_group,_skill] call DBW_setGroupSkill;
		private _init = [_group,_scoreMulti] call DBW_initGroup;
		private _givePTRD = [_group,["LIB_PTRD"]] call DBW_giveGroupRandPriWeap;
		{
			for ("_i") from 1 to 6 do {
				_x addMagazine "LIB_1Rnd_145x114";
			};
		} forEach (units _group);
	};
	waveSpawned = true;
};
//Requires IFA3_AIO_LITE end
