/**
*  spawnVehicle
*
*  Creates a single vehicle in a random location
*
*  Domain: Server
**/

for "_i" from 1 to (carCount) do {
	_cfgVehicles = configFile >> "CfgVehicles";
	_entries = count _cfgVehicles;  // GO INTO CFGVEHICLES AND CHECK NUMBER OF ENTRIES
	_realentries = _entries - 1;
	_found = false;
	_location = [bulwarkCity, BULWARK_RADIUS, BULWARK_RADIUS + 150,10,0] call BIS_fnc_findSafePos;

	_foundVeh = "";
	while {!_found} do {
		_checked_veh = _cfgVehicles select round (random _realentries);
		_classname = configName _checked_veh;
		if (isClass _checked_veh) then { // CHECK IF THE SELECTED ENTRY IS A CLASS
			_vehclass = getText (_checked_veh >> "vehicleClass");
			_scope = getNumber (_checked_veh >> "scope");
			_simulation_paracheck = getText (_checked_veh >> "simulation");
			_actual_vehclass = getText (_checked_veh >> "vehicleClass");
			turretWeap = false;
			if (isClass (_checked_veh >> "Turrets")) then {
				//hint "turret class true";
				_vechTurrets = _checked_veh >> "Turrets";
				for "_turretIter" from 0 to (count _vechTurrets - 1) do {
					//hint "checking vech turrets";
					_weapsOnTurret = _vechTurrets select _turretIter;
					if (!(getarray (_weapsOnTurret >> "weapons") isEqualTo [])) then {
						turretWeap = true;
					};
				};
			};
			if (_vehclass == _vehClass && _scope != 0 && _actual_vehclass == "Car" && turretWeap) exitWith {
				_foundVeh = _classname;
				_found = true;
			};
		};
	};
	_createdVehFnc = [_location, 0, _foundVeh, EAST] call bis_fnc_spawnvehicle;
	_createdVehFnc select 0 doMove (getPos (selectRandom playableUnits));
	mainZeus addCuratorEditableObjects [[_createdVehFnc select 0], true];
	carCrew = group (_createdVehFnc select 0);
	{
		_x addEventHandler ["Hit", killPoints_fnc_hit];
		_x addEventHandler ["Killed", killPoints_fnc_killed];
		_x setVariable ["killPointMulti", HOSTILE_CAR_POINT_SCORE];
	} forEach units carCrew;
};
