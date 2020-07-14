/*
EXAMPLE COMMIT ON HOW TO ADD SPECIAL WAVES: https://github.com/tiwaz1994/DynamicBulwarks/commit/20ebc7b432222ba7a78fbfd41007239389763119
*All functions with the DBW_ tag used in this file can be found in hostiles\createWave.sqf. Here is a list of what parameters these functions expect and/or return:
* DBW_determineAndSpawnIfVehicleWave - Expects nothing and returns nothing. If you don't want vehicles spawning in your special wave leave it out.
* DBW_getHostileListsAndKillMulti -    Expects nothing. Returns Array of Clasnames, NUMBER (KillpointsMultiplier). First is an array of classnames. Second one is score mutliplier for killpoints. If you want to use another list of classNames or a specific one: Use the function to just grab the score multi. Example: Defector Wave
* DBW_initUnit -                       Expects UNIT, NUMBER (KillpointsMultiplier) -- Function initializes UNIT. Gives them waypoints, adds to Zeus and so on.
* DBW_getHostileAmount -               Expects nothing and returns NUMBER of hostiles that should spawn in the wave. 
* DBW_spawnHostile -                   Expects ARRAY of classnames, ARRAY (Position). Returns: The created UNIT.
* DBW_setSkill -                       Expects UNIT, NUMBER (Skill) Returns Nothing -- sets units skill values
* DBW_giveRandPriWeap -                Expects UNIT, ARRAY (Weapons) Returns nothing -- gives UNIT random primary weapons
* DBW_giveRandSecWeap -                Expects UNIT, ARRAY (Weapons) Returns nothing -- gives UNIT random secondary weapons (pistols)
*/


DBW_SUICIDEWAVE = {
	execVM "hostiles\suicideWave.sqf";
	execVM "hostiles\suicideAudio.sqf";
	["SpecialWarning",["SUICIDE BOMBERS! Don't Let Them Get Close!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];

	_infantryToSpawnWithCosts = attkWave call hostiles_fnc_getInfantryForWave;
	_skill = attkWave * 0.02;

	{
		private _class = _x select 0;
		private _cost = _x select 1;
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		_unit = [_class,_location] call DBW_spawnHostile;
		private _setSkill = [_unit,_skill] call DBW_setSkill;
		removeAllWeapons _unit;
		_unit addEventHandler ["Killed", hostiles_fnc_suiExplode];
		private _init = [_unit, _cost call CWS_getHostileScoreMultiplier] call DBW_initUnit;

	}
	forEach _infantryToSpawnWithCosts;
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
		if ((count (_allHPs - _deadUnconscious)) <= 0 && (_respawnTickets <= 0)) then {
			sleep 1;

			//Check that Players have not been revived
			_deadUnconscious = [];
			{
				if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
					_deadUnconscious pushBack _x;
				};
			} foreach _allHPs;
			if ((count (_allHPs - _deadUnconscious)) <= 0 && (_respawnTickets <= 0)) then {
				sleep 1;
				if ((count (_allHPs - _deadUnconscious)) <= 0 && (_respawnTickets <= 0)) then {
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
	private _numDrones = ceil (attkWave / 3);
	for "_i" from 1 to _numDrones do {
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
			[_unit, _killer, _instigator] call killPoints_fnc_killed;
			_scriptedCharge = "HandGrenade" createVehicle (getPos _unit);
			_scriptedCharge setdamage 1;
			deleteVehicle _unit;
		}];
		_leadah setVariable ["killPointMulti", HOSTILE_CAR_POINT_SCORE];
	};
	[] call DBW_NORMALWAVE;
};

DBW_DEFECTORWAVE = {
	["SpecialWarning",["NATO Defectors Are Attacking Us!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amount do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _unit = [selectRandom LIST_DEFECTOR_CLASS,_location] call DBW_spawnHostile;
		private _setSkill = [_unit,_skill] call DBW_setSkill;
		private _init = [_unit,_scoreMulti] call DBW_initUnit;
	};
	waveSpawned = true;
};

DBW_MGWAVE = {
	["SpecialWarning",["MG Wave, take cover!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];

	_infantryToSpawnWithCosts = attkWave call hostiles_fnc_getInfantryForWave;
	_skill = attkWave * 0.02;
	{
		private _class = _x select 0;
		private _cost = _x select 1;
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _unit = [_class,_location] call DBW_spawnHostile;
		private _setSkill = [_unit,_skill] call DBW_setSkill;
		private _init = [_unit, _cost call CWS_getHostileScoreMultiplier] call DBW_initUnit;
		private _giveSniper = [_unit,LOOT_POOL_MG] call DBW_giveRandPriWeap;
	}
	forEach _infantryToSpawnWithCosts;

	waveSpawned = true;
};

DBW_SNIPERWAVE = {
	["SpecialWarning",["Sniper Wave, take cover!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];

	_infantryToSpawnWithCosts = attkWave call hostiles_fnc_getInfantryForWave;
	_skill = attkWave * 0.02;
	{
		private _class = _x select 0;
		private _cost = _x select 1;
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		private _unit = [_class,_location] call DBW_spawnHostile;
		private _setSkill = [_unit,_skill] call DBW_setSkill;
		private _init = [_unit, _cost call CWS_getHostileScoreMultiplier] call DBW_initUnit;
		private _giveSniper = [_unit,LOOT_POOL_SNIPER] call DBW_giveRandPriWeap;
	}
	forEach _infantryToSpawnWithCosts;

	waveSpawned = true;
};

DBW_NORMALWAVE = {
	[] call DBW_determineAndSpawnIfVehicleWave;

	_infantryToSpawnWithCosts = attkWave call hostiles_fnc_getInfantryForWave;
	_skill = attkWave * 0.02;
	{
		private _class = _x select 0;
		private _cost = _x select 1;
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		_unit = [_class,_location] call DBW_spawnHostile;
		private _setSkill = [_unit,_skill] call DBW_setSkill;
		private _init = [_unit, _cost call CWS_getHostileScoreMultiplier] call DBW_initUnit;
		if (RANDOM_WEAPONS) then {
			[_unit,LOOT_POOL_ALLWEAPONS] call DBW_giveRandPriWeap;
		};
	}
	forEach _infantryToSpawnWithCosts;

	waveSpawned = true;
};

DBW_PISTOLWAVE = {
	["TaskAssigned",["In-coming","Wave " + str attkWave]] remoteExec ["BIS_fnc_showNotification", 0];

	_infantryToSpawnWithCosts = attkWave call hostiles_fnc_getInfantryForWave;
	_skill = attkWave * 0.02;
	{
		private _class = _x select 0;
		private _cost = _x select 1;
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		_unit = [_class,_location] call DBW_spawnHostile;
		private _setSkill = [_unit,_skill] call DBW_setSkill;
		private _init = [_unit, _cost call CWS_getHostileScoreMultiplier] call DBW_initUnit;
		private _randWeap = [_unit,LOOT_POOL_HANDGUN] call DBW_giveRandSecWeap;
		if ((floor random 3) == 1) then {
			_unit additem (call bulwark_fnc_getFAKClass);
		};
	}
	forEach _infantryToSpawnWithCosts;
	waveSpawned = true;
};

//Requires IFA3_AIO_LITE start
DBW_FLAMEWAVE = {
	["SpecialWarning",["FLAMETHROWER WAVE, INCOMING!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amount do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		_unit = [selectRandom _classArray,_location] call DBW_spawnHostile;
		private _setSkill = [_unit,_skill] call DBW_setSkill;
		private _init = [_unit,_scoreMulti] call DBW_initUnit;
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeBackpack _unit;
			_unit addWeapon "LIB_M2_Flamethrower";
			_unit addPrimaryWeaponItem "LIB_M2_Flamethrower_Mag";
			_unit addBackpack "B_LIB_US_M2Flamethrower";
			_unit addItemToVest (call bulwark_fnc_getFAKClass);
			for "_i" from 1 to 5 do {_unit addItemToVest "LIB_No77";};
			for "_i" from 1 to 20 do {_unit addItemToBackpack "LIB_No77";};
			_unit enableStamina false;
	};
	waveSpawned = true;
};

DBW_PTRDWAVE = {
	["SpecialWarning",["PTRD Wave, incoming!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
	[] call DBW_determineAndSpawnIfVehicleWave;
	[] call DBW_getHostileListsAndKillMulti params ["_classArray","_scoreMulti"];
	_amount = call DBW_getHostileAmount;
	_skill = attkWave * 0.02;
	for ("_i") from 1 to _amount do {
		private _location = [bulwarkCity, BULWARK_RADIUS + 30, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;
		_unit = [selectRandom _classArray,_location] call DBW_spawnHostile;
		private _setSkill = [_unit,_skill] call DBW_setSkill;
		private _init = [_unit,_scoreMulti] call DBW_initUnit;
		private _givePTRD = [_unit,["LIB_PTRD"]] call DBW_giveRandPriWeap;
		for ("_i") from 1 to 6 do {
			_unit addMagazine "LIB_1Rnd_145x114";
		};
	};
	waveSpawned = true;
};
//Requires IFA3_AIO_LITE end
