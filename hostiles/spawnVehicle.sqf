/**
*  spawnVehicle
*
*  Creates a single vehicle in a random location
*
*  Domain: Server
**/

_listVeh = _this select 0;
for "_i" from 0 to (floor (attkWave / 10) - 1) do {
	_cfgVehicles = configFile >> "CfgVehicles";
	_entries = count _cfgVehicles;  // GO INTO CFGVEHICLES AND CHECK NUMBER OF ENTRIES
	_realentries = _entries - 1;
	_found = false;
	_location = [bulwarkCity, BULWARK_RADIUS, BULWARK_RADIUS + 150,10,0] call BIS_fnc_findSafePos;
	_nearRoad = ([_location, 300] call BIS_fnc_nearestRoad );
	if (! (isNull (_nearRoad)) && (count (_nearRoad nearEntities ["LandVehicle", 10])) ==0 ) then {
		_location = getpos (_nearRoad  );
		_location  = [_location select 0, _location select 1, (_location select 2)+2];
		
	};


	_foundVeh = _listVeh call BIS_fnc_selectRandom;
	_createdVehFnc = [_location, 0, _foundVeh, EAST] call bis_fnc_spawnvehicle;
	_targetplayer = (selectRandom playableUnits);
	if ((_createdVehFnc select 0 )isKindOf "LandVehicle" && !(isNull ( [getpos _targetplayer, 55] call BIS_fnc_nearestRoad )) ) then {
	_createdVehFnc select 0 doMove (getPos ([getpos _targetplayer, 55] call BIS_fnc_nearestRoad )); //[_targetplayer, 55] call BIS_fnc_nearestRoad 
	}
	else
	{
	_createdVehFnc select 0 doMove (getPos (selectRandom playableUnits));
	};
	(_createdVehFnc select 0) setdir (getDir (_nearRoad));
	mainZeus addCuratorEditableObjects [[_createdVehFnc select 0], true];
	_tankcrew = fullCrew (_createdVehFnc select 0);
	{
		_x select 0 addEventHandler ["Hit", killPoints_fnc_hit];
		_x select 0 addEventHandler ["Killed", killPoints_fnc_killed];
		_x select 0 setVariable ["killPointMulti", HOSTILE_ARMOUR_POINT_SCORE];
		unitArray = waveUnits select 0;
		unitArray append [_x select 0];
	} forEach _tankcrew;
};
