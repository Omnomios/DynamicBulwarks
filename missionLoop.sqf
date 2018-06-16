sleep 5;

_downTime = ("DOWN_TIME" call BIS_fnc_getParamValue);

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

		//Move hostiles towards nearest player
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

				// If it's a vehicle move to a place 15m from the player.
				// TODO: check to see if that spot is empty
				if(thisNPC isKindOf "LandVehicle") then {
					_dir = thisNPC getDir goToPlayer;
	                _doMovePos = goToPlayer getPos [20, _dir];
				};

				if (gotoPlayerDistance > 15) then {
					thisNPC doMove _doMovePos;
				} else {
					thisNPC doMove [(_doMovePos select 0) + (random [-7.5, 7.5, 0]), (_doMovePos select 1) + (random [-7.5, 7.5, 0]), _doMovePos select 2];
				};
			};
		} foreach allUnits;

		//Add objects to zeus
		{
			mainZeus addCuratorEditableObjects [[_x], true];
		} foreach _allHPs;
	};

	if(missionFailure) exitWith {};

	["TaskSucceeded",["Complete","Wave " + str attkWave + " complete!"]] remoteExec ["BIS_fnc_showNotification", 0];
	[0] remoteExec ["setPlayerRespawnTime", 0];

	{
		// Try to force the spectator mode off when players are revived.
		["Terminate"] remoteExec ["BIS_fnc_EGSpectator", _x];

		// Revive players that died at the end of the round.
		if ((lifeState _x == "DEAD") || (lifeState _x == "INCAPACITATED")) then {
			forceRespawn _x;
		};
	} foreach allPlayers;

	sleep _downTime;
};
