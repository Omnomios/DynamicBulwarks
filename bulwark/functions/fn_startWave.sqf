#include "..\..\shared\bulwark.hpp"
/**
*  fn_startWave
*
*  starts a new Wave
*
*  Domain: Server
**/

["Terminate"] remoteExec ["BIS_fnc_EGSpectator", 0];
[] remoteExec ["killPoints_fnc_updateHud", 0];

private "_time";
_time = DOWN_TIME;

while {_time > 0 && attkWave != 0} do {
	_time = _time - 1;  
	//shows timer in the hint box on the top right only after first round
	if (_time>0) then {
		hintSilent format["wave %1: \n %2",attkWave+1 , [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
	}else{
		hintSilent format["wave %1 incoming", attkWave+1];
	};
	
	//shows timer with sound in the middle of the screen
	if(_time <= 15) then {
		"beep_target" remoteExec ["playsound", 0];
		[format ["<t>%1</t>", _time], 0, 0, 1, 0] remoteExec ["BIS_fnc_dynamicText", 0];
	};
	sleep 1;
};


"Cleaning up..." call shared_fnc_log;

call hostiles_fnc_cleanupWaveUnits;

playersInWave = [];
_allHCs = entities "HeadlessClient_F";
_allHPs = allPlayers - _allHCs;
{ playersInWave pushBack getPlayerUID _x; } foreach _allHPs;
publicVariable "playersInWave";

attkWave = (attkWave + 1);
publicVariable "attkWave";

waveSpawned = false;

//If last wave was a night time wave then skip back to the time it was previously
if(!isNil "nightWave") then {
	if (nightWave) then {
		skipTime currentTime;
		nightWave = false;
	};
};

15 setFog 0;

[] remoteExec ["killPoints_fnc_updateHud", 0];

_respawnTickets = [west] call BIS_fnc_respawnTickets;
if (_respawnTickets <= 0) then {
	RESPAWN_TIME = 99999;
	publicVariable "RESPAWN_TIME";
};
[RESPAWN_TIME] remoteExec ["setPlayerRespawnTime", 0];

missionNamespace setVariable ["buildPhase", false, true];

"Determining special wave..." call shared_fnc_log;
//determine if Special wave
SpecialWaveType = "";
droneCount = 0;

if (enableSpecialWaves) then {
	if (attkWave < 10) then {
		randSpecChance = 4;
		maxSinceSpecial = 4;
		maxSpecialLimit = 1;
	};

	if (attkWave >= 10 && attkWave < 15) then {
		randSpecChance = 3;
		maxSinceSpecial = 3;
		maxSpecialLimit = 1;
	};

	if (attkWave >= 15) then {
		randSpecChance = 2;
		maxSinceSpecial = 2;
		maxSpecialLimit = 0;
	};

	if ((floor random randSpecChance == 1 || wavesSinceSpecial >= maxSinceSpecial) && attkWave >= 5 && wavesSinceSpecial >= maxSpecialLimit) then {
		specialWave = true;
		}
		else
		{
		wavesSinceSpecial = wavesSinceSpecial + 1;
		if (everyWaveSpecial) then {
			specialWave = true;
		}
		else
		{
			specialWave = false;
		};
	};


	//special wave selection
	if (specialWave && attkWave >= lowSpecialWaveStart) then {
		if (isNil "specialWavePool" || {count specialWavePool == 0}) then {
			if (attkWave < SpecialWaveStart) then {
				specialWavePool = lowSpecialWave_list;
			}
			else
			{
				specialWavePool = SpecialWave_list;
			};
		};
		specialWaveType = selectRandom specialWavePool;
		wavesSinceSpecial = 0;
		if (!specialWaveRepeat)  then {
			specialWavePool = specialWavePool - [specialWaveType];
		};
	};
};

"Clean up latent vehicles..." call shared_fnc_log;
//
// Clean up any destroyed land or air vehicles
//
{
	if (!alive _x) then {
		deleteVehicle _x;
	};
} foreach allMissionObjects "LandVehicle";

{
	if (!alive _x) then {
		deleteVehicle _x;
	};
} foreach allMissionObjects "Air";

"Spawn loot..." call shared_fnc_log;
//
// Spawn some loot
//
if (attkWave > 1) then { // We spawned loot in missionLoop already for wave 1.
	{deleteMarker _x} foreach lootDebugMarkers;
	// Remove the old loot and show the new loot
	call loot_fnc_cleanup;
	call loot_fnc_startRevealPreSpawnedLoot;
};

"Spawn Wave..." call shared_fnc_log;
// spawn
if (attkWave <= PISTOL_HOSTILES) then {
	SpecialWaveType = "pistolWave";
};

if (SpecialWaveType != "") then {
	[] call call compile format ["DBW_%1",SpecialWaveType]; //call compile toUpper format ["DBW_%1",SpecialWaveType]; //"call compile" compiles the string into the function name. The second "call" runs the function.
}
else
{
	["TaskAssigned",["In-coming","Wave " + str attkWave]] remoteExec ["BIS_fnc_showNotification", 0];
	[] call DBW_NORMALWAVE;
};
