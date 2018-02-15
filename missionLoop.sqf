sleep 5;

_CenterPos = _this;
attkWave = 0;
activeLoot = [];
mrkrs = [];

//spawn start loot
if (isServer) then {
	execVM "loot\spawnLoot.sqf";
};
sleep 15;
while {true} do {
	attkWave = (attkWave + 1);
	["TaskAssigned",["In-coming","Wave " + str attkWave]] remoteExec ["BIS_fnc_showNotification", 0];
	//setPlayerRespawnTime 9999;
	{9999 remoteExec ["setPlayerRespawnTime", _x]} foreach playableUnits;
	if (isServer) then {
		{deleteVehicle _x} foreach activeLoot;
	};
	hint "creating hostiles";
	if (isServer) then {
		_createHostiles = execVM "hostiles\create_squad.sqf";
		waitUntil { scriptDone _createHostiles};
	};
	//hint "done spawning hostiles";
	if (isServer) then {
		_spawnLoot = execVM "loot\spawnLoot.sqf";
		waitUntil { scriptDone _spawnLoot};
	};
	hint "done spawning loot";
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
	//setPlayerRespawnTime 0;
	{0 remoteExec ["setPlayerRespawnTime", _x]} foreach playableUnits;
	sleep 40;
};