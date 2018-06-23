sleep 5;

_downTime = ("DOWN_TIME" call BIS_fnc_getParamValue);
_specialWaves = ("SPECIAL_WAVES" call BIS_fnc_getParamValue);

_CenterPos = _this;
attkWave = 0;
publicVariable "attkWave";
//activeLoot = [];
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

// start in build phase
bulwarkBox setVariable ["buildPhase", true, true];

[west, RESPAWN_TICKETS] call BIS_fnc_respawnTickets;

while {runMissionLoop} do {

	//Reset the AI position checks
	AIstuckcheck = 0;
	AIStuckCheckArray = [];

	[] call bulwark_fnc_startWave;

	while {runMissionLoop} do {

		// Get all human players in this wave cycle // moved to contain players that respawned in this wave
		_allHCs = entities "HeadlessClient_F";
		_allHPs = allPlayers - _allHCs;

		//Check if all hostiles dead
		if (east countSide allUnits == 0) exitWith {};
		//check if all players dead or unconscious
		_deadUnconscious = [];
		{
			if ((!alive _x) || ((lifeState _x) == "INCAPACITATED")) then {
				_deadUnconscious pushBack _x;
			};
		} foreach _allHPs;
		
		_respawnTickets = [west] call BIS_fnc_respawnTickets;
		if (count (_allHPs - _deadUnconscious) <= 0 && _respawnTickets <= 0) then {
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
					if (!suicideWave) then {
						_x setBehaviour "AWARE";
					} else {
						_x setBehaviour "CARELESS";
					};
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

	[] call bulwark_fnc_endWave;

};
