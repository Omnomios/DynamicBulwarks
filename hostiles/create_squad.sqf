hosSkill = (attkWave / 40);
_noOfPlayers = count playableUnits;
_multiplierBase = (1.5 * _noOfPlayers);
hint str _multiplierBase;
sleep 1;

for ("_i") from 0 to (floor (attkWave * _multiplierBase)) do {
	_spwnBandit = execVM "hostiles\spawn_bandits.sqf";
	waitUntil {scriptDone _spwnBandit};
};

//if (attkWave < 4) then {
//	for ("_i") from 0 to 1 do {
//		_spwnBandit = execVM "hostiles\spawn_bandits.sqf";
//		waitUntil {scriptDone _spwnBandit};
//	};
//};

if (attkWave > 10) then {
	for ("_i") from 0 to (floor (attkWave / 5)) do {
		_spwnSoldier = execVM "hostiles\spawn_soldiers.sqf";
		waitUntil {scriptDone _spwnSoldier};
	};
};

if (attkWave > 20) then {
	for ("_i") from 0 to (floor (attkWave / 5)) do {
		_spwnViper = execVM "hostiles\spawn_vipers.sqf";
		waitUntil {scriptDone _spwnViper};
	};
};

if (attkWave > 20 && (random 5) == 1) then {
	_spwnVec = execVM "hostiles\spawn_Vec.sqf";
	waitUntil {scriptDone _spwnVec};
};