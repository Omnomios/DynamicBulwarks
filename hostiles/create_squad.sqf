hosSkill = (attkWave / 40);
_noOfPlayers = count playableUnits;
_multiplierBase = (1.5 * _noOfPlayers);
hint str _multiplierBase;
sleep 1;

for ("_i") from 0 to (floor (attkWave * _multiplierBase)) do {
	_spwnBandit = execVM "hostiles\spawn_bandits.sqf";
	waitUntil {scriptDone _spwnBandit};
};

if (attkWave > 5) then {
	_SoldierMulti = attkWave / 5;
	for ("_i") from 0 to (floor (_SoldierMulti * _noOfPlayers)) do {
		_spwnSoldier = execVM "hostiles\spawn_soldiers.sqf";
		waitUntil {scriptDone _spwnSoldier};
	};
};

if (attkWave > 10) then {
	_ViperMulti = attkWave / 5;
	for ("_i") from 0 to (floor (_ViperMulti * _noOfPlayers)) do {
		_spwnViper = execVM "hostiles\spawn_vipers.sqf";
		waitUntil {scriptDone _spwnViper};
	};
};

if (attkWave > 15 && (random 5) == 1) then {
	_spwnVec = execVM "hostiles\spawn_Vec.sqf";
	waitUntil {scriptDone _spwnVec};
};