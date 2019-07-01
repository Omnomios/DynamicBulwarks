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

	//_foundVeh = "";
	// while {!_found} do {
		// _checked_veh = _cfgVehicles select round (random _realentries);
		// _classname = configName _checked_veh;
		// if (isClass _checked_veh) then { // CHECK IF THE SELECTED ENTRY IS A CLASS
			// _vehclass = getText (_checked_veh >> "vehicleClass");
			// _scope = getNumber (_checked_veh >> "scope");
			// _simulation_paracheck = getText (_checked_veh >> "simulation");
			// _actual_vehclass = getText (_checked_veh >> "vehicleClass");
			// if (_vehclass == _vehClass && _scope != 0 && _simulation_paracheck != "parachute" && _classname != "O_MBT_02_arty_F" && _actual_vehclass == "Armored") exitWith {
				// _foundVeh = _classname;
				// _found = true;
			// };
		// };
	// };
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
};
