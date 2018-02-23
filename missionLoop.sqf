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
	while {_runMissionLoop} do {
		//Check if all hostiles dead
		if (east countSide allUnits == 0) exitWith {
			hint "wave Complete";
		};
		//check if all players dead or unconscious
		_deadUnconscious = [];
		{
			if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
				_deadUnconscious pushBack _x;
			};
		} foreach _allHPs;
		if (count (_allHPs - _deadUnconscious) <= 0) then {
			"End1" call BIS_fnc_endMissionServer;
		};
		//Move mostiles towards neaest player
		sleep 1;
		{
			if (side _x == east) then {
			thisNPC = _x;
			_gotoPlayerDistance = 9999;
 			{
				_playerDistance = (getPos thisNPC) distance _x;
				if ((_playerDistance < _gotoPlayerDistance) && (alive _x)) then {
					goToPlayer = _x;
				};
			} forEach _allHPs;
			thisNPC doMove (getPos goToPlayer);
			};
		} foreach allUnits;

		sleep 10;

		// Mission area protection
		{if ((_x distance bulwarkCity) > BULWARK_RADIUS * 0.9) then {
			["Warning: Leaving mission area!",0, 0.1] remoteExec ["BIS_fnc_dynamicText", _x];
		};
		} foreach _allHPs;

		{if ((_x distance bulwarkCity) > BULWARK_RADIUS * 1.1) then {
			_newLoc = [bullwarkBox] call bulwark_fnc_findPlaceAround;
			_x setPosASL _newLoc;
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
