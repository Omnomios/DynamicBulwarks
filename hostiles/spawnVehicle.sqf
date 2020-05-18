/**
*  spawnVehicle
*
*  Creates a single vehicle in a random location
*
*  Domain: Server
**/

params ["_vehicleClassesToSpawn"];

{
	format ["Spawning vehicle: %1", _x] call shared_fnc_log;
	_location = [bulwarkCity, BULWARK_RADIUS, BULWARK_RADIUS + 150,10,0] call BIS_fnc_findSafePos;
	_createdVehFnc = [_location, 0, _x, EAST] call bis_fnc_spawnvehicle;
	_createdVehFnc select 0 doMove (getPos (selectRandom playableUnits));
	mainZeus addCuratorEditableObjects [[_createdVehFnc select 0], true];
	_tankcrew = fullCrew (_createdVehFnc select 0);
	{
		_x select 0 addEventHandler ["Hit", killPoints_fnc_hit];
		_x select 0 addEventHandler ["Killed", killPoints_fnc_killed];
		_x select 0 setVariable ["killPointMulti", HOSTILE_ARMOUR_POINT_SCORE];
		_x select 0 call hostiles_fnc_addUnitToWaveForCleanup;
	} forEach _tankcrew;	
} forEach _vehicleClassesToSpawn;