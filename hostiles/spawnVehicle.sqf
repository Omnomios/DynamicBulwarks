/**
*  spawnVehicle
*
*  Creates a single vehicle in a random location
*
*  Domain: Server
**/

_cfgVehicles = configFile >> "CfgVehicles";
_entries = count _cfgVehicles;  // GO INTO CFGVEHICLES AND CHECK NUMBER OF ENTRIES
_realentries = _entries - 1;
_found = false;
_location = [bulwarkCity, BULWARK_RADIUS, BULWARK_RADIUS + 150,1,0] call BIS_fnc_findSafePos;

_foundVeh = "";
while {!_found} do {
	_checked_veh = _cfgVehicles select round (random _realentries);
	_classname = configName _checked_veh;
	if (isClass _checked_veh) then { // CHECK IF THE SELECTED ENTRY IS A CLASS
		_vehclass = getText (_checked_veh >> "vehicleClass");
		_scope = getNumber (_checked_veh >> "scope");
		_simulation_paracheck = getText (_checked_veh >> "simulation");
		_actual_vehclass = getText (_checked_veh >> "vehicleClass");
		if (_vehclass == _vehClass && _scope != 0 && _simulation_paracheck != "parachute" && _classname != "O_MBT_02_arty_F" && _actual_vehclass == "Armored") exitWith {
			_foundVeh = _classname;
			_found = true;
		};
	};
};
_createdVehFnc = [_location, 0, _foundVeh, east] call bis_fnc_spawnvehicle;
_createdVehFnc select 0 doMove (getPos (selectRandom playableUnits));
sleep 2;
