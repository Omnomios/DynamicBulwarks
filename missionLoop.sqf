sleep 5;

_CenterPos = _this;
attkWave = 0;
publicVariable "attkWave";
activeLoot = [];
//mrkrs = [];

waveUnits = [[],[],[]];

//spawn start loot
if (isServer) then {
	execVM "loot\spawnLoot.sqf";
};

sleep 15;
_runMissionLoop = true;
_missionFailure = false;

while {_runMissionLoop} do {
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

	["TaskAssigned",["In-coming","Wave " + str attkWave]] remoteExec ["BIS_fnc_showNotification", 0];
	//{9999 remoteExec ["setPlayerRespawnTime", _x]} foreach playableUnits;
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
		_createHostiles = execVM "hostiles\create_squad.sqf";
		waitUntil {scriptDone _createHostiles};
	};
	if (attkWave > 1 && isServer) then { //if first wave give player extra time before spawning enemies
		{deleteMarker _x} foreach lootDebugMarkers;
		{deleteVehicle _x} foreach activeLoot;
		_spawnLoot = execVM "loot\spawnLoot.sqf";
		waitUntil { scriptDone _spawnLoot};
	};
	while {_runMissionLoop} do {
		//get hostiles to keep moving towards player - loop updating player pos?
		if (east countSide allUnits == 0) exitWith {
			hint "wave Complete";
		};
		if ({alive _x} count allPlayers isEqualTo 0) then {
			_runMissionLoop = false;
			_missionFailure = true;
			"End1" call BIS_fnc_endMissionServer;
		};
		{if (side _x == east) then {
			while {true} do {
				_goToPlayer = selectRandom _allHPs;
				if (alive _goToPlayer) exitWith {
					_goToPlayerPos = getPos _goToPlayer;
					_x doMove [(_goToPlayerPos select 0) + (random [-20,20,0]),(_goToPlayerPos select 1) + (random [-20,20,0]),0];
				};
			};
		};
		} foreach allUnits;
		sleep 10;

		// Mission area protection
		{if ((_x distance bulwarkCity) > BULWARK_RADIUS * 0.9) then {
			["Warning: Leaving mission area!",0, 0.1] remoteExec ["BIS_fnc_dynamicText", _x];
		};
		} foreach _allHPs;

		{if ((_x distance bulwarkCity) > BULWARK_RADIUS * 1.1) then {
			_newLoc = [BulwarkRoomPos, 0, 5, 1, 0] call BIS_fnc_findSafePos;
			_x setpos _newLoc;
		};
		} foreach _allHPs;
	};

	if(_missionFailure) exitWith {};

	["TaskSucceeded",["Complete","Wave " + str attkWave + " complete!"]] remoteExec ["BIS_fnc_showNotification", 0];
	[0] remoteExec ["setPlayerRespawnTime", 0];

	{
	if ((lifeState _x == "DEAD") || (lifeState _x == "INCAPACITATED")) then {
		forceRespawn _x;
	};
	} foreach allPlayers;

	sleep 20+(attkWave*6);
};
