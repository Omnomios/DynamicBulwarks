sleep 5;

_CenterPos = _this;
attkWave = 0;
publicVariable "attkWave";
activeLoot = [];
//mrkrs = [];

waveUnits = [[],[],[]];
revivedPlayers = [];

//spawn start loot
if (isServer) then {
	execVM "loot\spawnLoot.sqf";
};

sleep 15;
runMissionLoop = true;
missionFailure = false;

while {runMissionLoop} do {
	for ("_i") from 0 to 14 do {
		if(_i > 10) then {"beep_target" remoteExec ["playsound", 0];} else {"readoutClick" remoteExec ["playsound", 0];};
		[format ["<t>%1</t>", 15-_i], 0, 0, 1, 0] remoteExec ["BIS_fnc_dynamicText", 0];
		sleep 1;
	};

	// Get all human players in this wave cycle
	_allHCs = entities "HeadlessClient_F";
	_allHPs = allPlayers - _allHCs;

	[] remoteExec ["killPoints_fnc_updateHud", -2];

	attkWave = (attkWave + 1);
	publicVariable "attkWave";

	//Reset the AI position checks
	AIstuckcheck = 0;
	AIStuckCheckArray = [];

	["TaskAssigned",["In-coming","Wave " + str attkWave]] remoteExec ["BIS_fnc_showNotification", 0];
	[9999] remoteExec ["setPlayerRespawnTime", 0];
	if (isServer) then {
		// Delete
		_final = waveUnits select 2;
		{deleteVehicle _x} foreach _final;
		// Shuffle
		waveUnits set [2, waveUnits select 1];
		waveUnits set [1, waveUnits select 0];
		waveUnits set [0, []];
		// Spawn
		_createHostiles = execVM "hostiles\createWave.sqf";
		waitUntil {scriptDone _createHostiles};
	};
	if (attkWave > 1 && isServer) then { //if first wave give player extra time before spawning enemies
		{deleteMarker _x} foreach lootDebugMarkers;
		{deleteVehicle _x} foreach activeLoot;
		_spawnLoot = execVM "loot\spawnLoot.sqf";
		waitUntil { scriptDone _spawnLoot};
	};

	while {runMissionLoop} do {

		//Check if all hostiles dead
		if (east countSide allUnits == 0) exitWith {};
		//check if all players dead or unconscious
		_deadUnconscious = [];
		{
			if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
				_deadUnconscious pushBack _x;
			};
		} foreach _allHPs;

		if (count (_allHPs - _deadUnconscious) <= 0) then {
			runMissionLoop = false;
			missionFailure = true;
			"End1" call BIS_fnc_endMissionServer;
		};
		//Check AI behavior
		sleep 5;
		{
			if (side _x == east) then {
				_x allowFleeing 0;
				if ((_x findNearestEnemy _x) == objNull) then {
					_x setBehaviour "CARELESS";
				} else {
					_x setBehaviour "AWARE";
				};
			};
		} foreach allUnits;

		//Move hostiles towards neaest player
		{
			if (side _x == east) then {
				thisNPC = _x;
				gotoPlayerDistance = 9999;
 				{
					_playerHostDistance = (getPos thisNPC) distance _x;
					if ((_playerHostDistance < gotoPlayerDistance) && (alive _x)) then {
						goToPlayer = _x;
						gotoPlayerDistance = _playerHostDistance;
					};
				} forEach _allHPs;
				_doMovePos = getPos goToPlayer;
				if (gotoPlayerDistance > 15) then {
					thisNPC doMove _doMovePos;
				} else {
					thisNPC doMove [(_doMovePos select 0) + (random [-7.5, 7.5, 0]), (_doMovePos select 1) + (random [-7.5, 7.5, 0]), _doMovePos select 2];
				};
			};
		} foreach allUnits;

		//Move Stuck AIs after 60 seconds
		if (AIstuckcheck == 0) then {
			{
				if (side _x == east) then {
					AIStuckCheckArray pushBack [_x, getPos _x];
				};
			} forEach allUnits;
		};
		AIstuckcheck = AIstuckcheck + 1;
		if (AIstuckcheck == 30) then {
			{
				_AItoCheck = _x select 0;
				_oldAIPos = _x select 1;
				nearestPlayerDistance = 9999;
				{
					_playerHostDistance = (getPos _AItoCheck) distance _x;
					if ((_playerHostDistance < nearestPlayerDistance)) then {
						nearestPlayerDistance = _playerHostDistance;
					};
				} forEach _allHPs;
				if ((alive _AItoCheck) && (((getPos _AItoCheck) distance _oldAIPos) < 10 ) && (nearestPlayerDistance > 60)) then {
					deleteVehicle _AItoCheck;
				};
			} forEach AIStuckCheckArray;
			AIstuckcheck = 0;
			AIStuckCheckArray = [];
		};
		// Mission area protection
		{if ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 0.9) then {
			["Warning: Leaving mission area!",0, 0.1] remoteExec ["BIS_fnc_dynamicText", _x];
		};
		} foreach _allHPs;

		{if ((_x distance2D bulwarkCity) > BULWARK_RADIUS * 1.1) then {
			_newLoc = [bulwarkBox] call bulwark_fnc_findPlaceAround;
			_x setPosASL _newLoc;
		};
		} foreach _allHPs;
	};

	if(missionFailure) exitWith {};

	["TaskSucceeded",["Complete","Wave " + str attkWave + " complete!"]] remoteExec ["BIS_fnc_showNotification", 0];
	[0] remoteExec ["setPlayerRespawnTime", 0];

	{
	if ((lifeState _x == "DEAD") || (lifeState _x == "INCAPACITATED")) then {
		forceRespawn _x;
	};
	} foreach allPlayers;

	sleep 20+(attkWave*6);
};
