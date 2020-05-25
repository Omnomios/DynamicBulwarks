#include "..\..\shared\bulwark.hpp"

{
	[_x, false] remoteExec ["setUnconscious", 0];
	_X action ["CancelAction", _X];
	_X switchMove "PlayerStand";
	[ "#rev", 1, _x ] remoteExecCall ["BIS_fnc_reviveOnState", _x];
	_x setDamage 0;
} forEach allPlayers;

private _maxWaves = (BULWARK_PARAM_MAX_WAVES call shared_fnc_getCurrentParamValue);

attkWave = 0;
publicVariable "attkWave";
suicideWave = false;

waveUnits = [[],[],[]];
revivedPlayers = [];
MIND_CONTROLLED_AI = [];
wavesSinceArmour = 0;
wavesSinceCar = 0;
wavesSinceSpecial = 0;
SatUnlocks = [];
publicVariable 'SatUnlocks';

//spawn start loot
if (isServer) then {
	call loot_fnc_init;
	call loot_fnc_startPreSpawn;
	call loot_fnc_startRevealPreSpawnedLoot;
};

sleep 15;
runMissionLoop = true;
missionFailure = false;

// start in build phase
missionNamespace setVariable ["buildPhase", true, true];

while {runMissionLoop} do {

	//Reset the AI position checks
	AIstuckcheck = 0;
	AIStuckCheckArray = [];

	[] call bulwark_fnc_startWave;

	while {runMissionLoop} do {
		sleep 1; // We don't need to update this very often

		//Check if all hostiles dead
		if (EAST countSide allUnits == 0) exitWith {};

		_respawnTickets = [west] call BIS_fnc_respawnTickets;
		if(_respawnTickets <= 0) then {
			// Players will lose the game if they are all dead or unconscious

			// Get all human players in this wave cycle
			// moved to contain players that respawned in this wave
			_allHCs = entities "HeadlessClient_F";
			_allHPs = allPlayers - _allHCs;

			private _deadOrUnconscious = _allHPs select { (!alive _x) || ((lifeState _x) == "INCAPACITATED") };
			if (count _deadOrUnconscious >= count _allHPs) then {
				runMissionLoop = false;
				missionFailure = true;
				"End1" call BIS_fnc_endMissionServer;
			};
		};
	};

	if(missionFailure) exitWith {};

	if (attkWave == _maxWaves) exitWith {
		"End2" call BIS_fnc_endMissionServer;
	};

	[] call bulwark_fnc_endWave;
};
