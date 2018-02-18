sleep 5;

_CenterPos = _this;
attkWave = 0;
publicVariable "attkWave";
activeLoot = [];
//mrkrs = [];

//spawn start loot
if (isServer) then {
	execVM "loot\spawnLoot.sqf";
};

sleep 15;
_runMissionLoop = true;
_missionFailure = false;

while {_runMissionLoop} do {
	attkWave = (attkWave + 1);
	publicVariable "attkWave";
	[player] remoteExec ["killPoints_fnc_updateHud", -2];

	["TaskAssigned",["In-coming","Wave " + str attkWave]] remoteExec ["BIS_fnc_showNotification", 0];
	//{9999 remoteExec ["setPlayerRespawnTime", _x]} foreach playableUnits;
	[9999] remoteExec ["setPlayerRespawnTime", 0];
	if (isServer) then {
		_createHostiles = execVM "hostiles\create_squad.sqf";
		waitUntil { scriptDone _createHostiles};
	};
	if (attkWave > 1 && isServer) then { //if first wave give player extra time before spawning enemies
		{deleteMarker _x} foreach lootDebugMarkers;
		{deleteVehicle _x} foreach activeLoot;
		_spawnLoot = execVM "loot\spawnLoot.sqf";
		waitUntil { scriptDone _spawnLoot};
	};
	while {_runMissionLoop} do {
		// Get all human players in this wave cycle
		_allHCs = entities "HeadlessClient_F";
		_allHPs = allPlayers - _allHCs;

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
			_x doMove ([getPos (selectRandom _allHPs), 2, 20,1,0] call BIS_fnc_findSafePos);
			};
		} foreach allUnits;
		sleep 10;

		// Mission area protection
		{if ((_x distance bulwarkCity) > BULWARK_RADIUS*0.9) then {
			["Warning: Leaving mission area!",0, 0.1] remoteExec ["BIS_fnc_dynamicText", _x];
		};
		} foreach _allHPs;

		{if ((_x distance bulwarkCity) > BULWARK_RADIUS*1.2) then {
			_x setpos BulwarkRoomPos;
		};
		} foreach _allHPs;
	};

	if(_missionFailure) exitWith {};

	["TaskSucceeded",["Complete","Wave " + str attkWave + " complete!"]] remoteExec ["BIS_fnc_showNotification", 0];
	//{0 remoteExec ["setPlayerRespawnTime", 0]} foreach playableUnits;
	[0] remoteExec ["setPlayerRespawnTime", 0];

	{
	if ((lifeState _x == "DEAD") || (lifeState _x == "INCAPACITATED")) then {
		forceRespawn _x;
	};
	} foreach allPlayers;

	sleep 40;
};
