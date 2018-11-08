/**
*  fn_startWave
*
*  starts a new Wave
*
*  Domain: Server
**/


["Terminate"] remoteExec ["BIS_fnc_EGSpectator", 0];
[] remoteExec ["killPoints_fnc_updateHud", 0];

for ("_i") from 0 to 14 do {
	if(_i > 10) then {"beep_target" remoteExec ["playsound", 0];} else {"readoutClick" remoteExec ["playsound", 0];};
	[format ["<t>%1</t>", 15-_i], 0, 0, 1, 0] remoteExec ["BIS_fnc_dynamicText", 0];
	sleep 1;
};

attkWave = (attkWave + 1);
publicVariable "attkWave";

[] remoteExec ["killPoints_fnc_updateHud", 0];

_respawnTickets = [west] call BIS_fnc_respawnTickets;
if (_respawnTickets <= 0) then {
	RESPAWN_TIME = 99999;
	publicVariable "RESPAWN_TIME";
};
[RESPAWN_TIME] remoteExec ["setPlayerRespawnTime", 0];

bulwarkBox setVariable ["buildPhase", false, true];

//determine if suicide bomber round

if ((attkWave > 15) && (floor random 10 == 1) && (_specialWaves == 1)) then {
	suicideWave = true;
	execVM "hostiles\suicideWave.sqf";
	execVM "hostiles\suicideAudio.sqf";
} else {
	suicideWave = false;
};

//Notify start of wave and type of wave
if (suicideWave) then {
	["SpecialWarning",["SUICIDE BOMBERS! Don't Let Them Get Close!"]] remoteExec ["BIS_fnc_showNotification", 0];
	["Alarm"] remoteExec ["playSound", 0];
} else {
	["TaskAssigned",["In-coming","Wave " + str attkWave]] remoteExec ["BIS_fnc_showNotification", 0];
};

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

if (attkWave > 1) then { //if first wave give player extra time before spawning enemies
	{deleteMarker _x} foreach lootDebugMarkers;
	[] call loot_fnc_cleanup;
	_spawnLoot = execVM "loot\spawnLoot.sqf";
	waitUntil { scriptDone _spawnLoot};
};
