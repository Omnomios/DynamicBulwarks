sleep 5;

_CenterPos = _this;
attkWave = 0;
activeLoot = [];
//mrkrs = [];

//spawn start loot
if (isServer) then {
	execVM "loot\spawnLoot.sqf";
};

sleep 15;

while {true} do {
	attkWave = (attkWave + 1);
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
	while {true} do {
		//get hostiles to keep moving towards player - loop updating player pos?
		if (east countSide allUnits == 0) exitWith {
			hint "wave Complete";
		};
		if ({alive _x} count allPlayers isEqualTo 0) then {
			"End1" call BIS_fnc_endMissionServer;
		};
		{if (side _x == east) then {
			_x doMove ([getPos (selectRandom playableUnits), 2, 20,1,0] call BIS_fnc_findSafePos);
			};
		} foreach allUnits;
		sleep 10;
		{if ((_x distance bulwarkCity) > 150) then {
			["Warning: Leaving mission area!"] remoteExec ["BIS_fnc_dynamicText", _x];
		};
		} foreach playableUnits;
		{if ((_x distance bulwarkCity) > 175) then {
			_x setpos BulwarkRoomPos;
		};
		} foreach playableUnits;
	};

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
