/**
*  createWave
*
*  Creates all the hostiles for the given round
*
*  Domain: Server
**/

hosSkill = 1;
_noOfPlayers = 1 max floor ((playersNumber west) * HOSTILE_TEAM_MULTIPLIER);
_multiplierBase = HOSTILE_MULTIPLIER;
_SoldierMulti = attkWave / 5;

if (attkWave == 1) then {
	_multiplierBase = 1
};

_squadCount = floor (attkWave * _multiplierBase);
for ("_i") from 1 to (floor (attkWave * _multiplierBase)) do {
	_script = [HOSTILE_LEVEL_1, attkWave, _noOfPlayers] execVM "hostiles\spawnSquad.sqf";
	waitUntil {scriptDone _script};
};

if (attkWave > 2) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [HOSTILE_LEVEL_2, attkWave, _noOfPlayers] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};

if (attkWave > 7) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [HOSTILE_LEVEL_3, attkWave, _noOfPlayers] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};

if (attkWave > 14) then {
	for ("_i") from 0 to (floor (_SoldierMulti / 5)) do {
		_script = [HOSTILE_LEVEL_4, attkWave, _noOfPlayers] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};
