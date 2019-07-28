/**
*  createWave
*
*  Creates all the hostiles for the given round
*
*  Domain: Server
**/
_armourStartWave = "ARMOUR_START_WAVE" call BIS_fnc_getParamValue;

if (attkWave < (_armourStartWave + 5)) then {
	ArmourChance = 0;
	ArmourMaxSince = 0;
	ArmourCount = 0;
	carChance = 3;
	carMaxSince = 2;
	carCount = 1;
};

if (attkWave >= (_armourStartWave + 5) && attkWave < (_armourStartWave + 10)) then {
	ArmourChance = 4;
	ArmourMaxSince = 4;
	ArmourCount = 1;
	carChance = 3;
	carMaxSince = 3;
	carCount = 1 + (floor (playersNumber west / 4));
};

if (attkWave >= (_armourStartWave + 10) && attkWave < (_armourStartWave + 15)) then {
	ArmourChance = 3;
	ArmourMaxSince = 3;
	ArmourCount = 1 + (floor (playersNumber west / 4));
	carChance = 2;
	carMaxSince = 2;
	carCount = 2 + (floor (playersNumber west / 4));
};

if (attkWave >= (_armourStartWave + 15) && attkWave < (_armourStartWave + 20)) then {
	ArmourChance = 2;
	ArmourMaxSince = 2;
	ArmourCount = 2 + (floor (playersNumber west / 4));
	carChance = 1;
	carMaxSince = 2;
	carCount = 2 + (floor (playersNumber west / 4));
};

if (attkWave >= (_armourStartWave + 20)) then {
	ArmourChance = 2;
	ArmourMaxSince = 1;
	ArmourCount = 3 + (floor (playersNumber west / 4));
	carChance = 1;
	carMaxSince = 1;
	carCount = 3 + (floor (playersNumber west / 4));
};

if ((attkWave >= _armourStartWave && (floor random ArmourChance) == 1) || (attkWave >= _armourStartWave && wavesSinceArmour >= ArmourMaxSince)) then {
	_spwnVec = execVM "hostiles\spawnVehicle.sqf";
	waitUntil {scriptDone _spwnVec};
	wavesSinceArmour = 0;
}else{
	if (attkWave >= _armourStartWave) then {
		wavesSinceArmour = wavesSinceArmour + 1;
	};
};

if ((attkWave >= _armourStartWave && (floor random carChance) == 1) || (attkWave >= _armourStartWave && wavesSinceArmour >= carMaxSince)) then {
	_spwnVec = execVM "hostiles\spawnCar.sqf";
	waitUntil {scriptDone _spwnVec};
	wavesSinceCar = 0;
}else{
	if (attkWave >= _armourStartWave) then {
		wavesSinceCar = wavesSinceCar + 1;
	};
};

_noOfPlayers = 1 max floor ((playersNumber west) * HOSTILE_TEAM_MULTIPLIER);
_multiplierBase = HOSTILE_MULTIPLIER;
_SoldierMulti = attkWave / 5;

if (attkWave <= 2) then {
	_multiplierBase = 1
};

_squadCount = floor (attkWave * _multiplierBase);
for ("_i") from 1 to (floor (attkWave * _multiplierBase)) do {
	_script = [HOSTILE_LEVEL_1, attkWave, _noOfPlayers, HOSTILE_LEVEL_1_POINT_SCORE] execVM "hostiles\spawnSquad.sqf";
	waitUntil {scriptDone _script};
};

if (attkWave > 6) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [HOSTILE_LEVEL_2, attkWave, _noOfPlayers, HOSTILE_LEVEL_2_POINT_SCORE] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};

if (attkWave > 12) then {
	for ("_i") from 0 to (floor (_SoldierMulti)) do {
		_script = [HOSTILE_LEVEL_3, attkWave, _noOfPlayers, HOSTILE_LEVEL_3_POINT_SCORE] execVM "hostiles\spawnSquad.sqf";
		waitUntil {scriptDone _script};
	};
};

waveSpawned = true;
