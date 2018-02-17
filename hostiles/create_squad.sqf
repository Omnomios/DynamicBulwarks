hosSkill = (attkWave / 40);
_noOfPlayers = count playableUnits;
//_multiplierBase = (1.5 * (_noOfPlayers/2));
_multiplierBase = 1.5;
_SoldierMulti = attkWave / 5;

for ("_i") from 0 to (floor (attkWave * _multiplierBase)) do {
	_script = [List_Bandits, attkWave, _noOfPlayers] execVM "hostiles\spawn_group.sqf";
	waitUntil {scriptDone _script};
};

if (attkWave > 5) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [List_ParaBandits, attkWave, _noOfPlayers] execVM "hostiles\spawn_group.sqf";
		waitUntil {scriptDone _script};
	};
};

if (attkWave > 10) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [List_Viper, attkWave, _noOfPlayers] execVM "hostiles\spawn_group.sqf";
		waitUntil {scriptDone _script};
	};
};

if (attkWave > 15 && (random 5) == 1) then {
	_spwnVec = execVM "hostiles\spawn_vehc.sqf";
	waitUntil {scriptDone _spwnVec};
};
