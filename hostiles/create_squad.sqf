hosSkill = (attkWave / 40);
_noOfPlayers = playersNumber west;
_multiplierBase = 1.5;
_SoldierMulti = attkWave / 5;

_squadCount = floor (attkWave * _multiplierBase);
for ("_i") from 1 to (floor (attkWave * _multiplierBase)) do {
	_script = [HOSTILE_LEVEL_1, attkWave, _noOfPlayers] execVM "hostiles\spawn_group.sqf";
	waitUntil {scriptDone _script};
};

if (attkWave > 5) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [HOSTILE_LEVEL_2, attkWave, _noOfPlayers] execVM "hostiles\spawn_group.sqf";
		waitUntil {scriptDone _script};
	};
};

if (attkWave > 10) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [HOSTILE_LEVEL_3, attkWave, _noOfPlayers] execVM "hostiles\spawn_group.sqf";
		waitUntil {scriptDone _script};
	};
};

if (attkWave > 15 && (random 5) == 1) then {
	_spwnVec = execVM "hostiles\spawn_vehc.sqf";
	waitUntil {scriptDone _spwnVec};
};
