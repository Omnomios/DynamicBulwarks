/**
*  spawnVehicle
*
*  Creates a single vehicle in a random location
*
*  Domain: Server
**/

for "_i" from 1 to (carCount) do {
	_location = [bulwarkCity, BULWARK_RADIUS, BULWARK_RADIUS + 150,10,0] call BIS_fnc_findSafePos;
	_foundVeh = selectRandom List_ArmedCars;
	_createdVehFnc = [_location, 0, _foundVeh, EAST] call bis_fnc_spawnvehicle;
	_createdVehFnc select 0 doMove (getPos (selectRandom playableUnits));
	mainZeus addCuratorEditableObjects [[_createdVehFnc select 0], true];
	carCrew = fullCrew (_createdVehFnc select 0);
	{
		_x select 0 addEventHandler ["Hit", killPoints_fnc_hit];
		_x select 0 addEventHandler ["Killed", killPoints_fnc_killed];
		_x select 0 setVariable ["killPointMulti", HOSTILE_CAR_POINT_SCORE];
		unitArray = waveUnits select 0;
		unitArray append [_x select 0];
	} forEach carCrew;
};
