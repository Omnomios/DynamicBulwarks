/**
*  hostiles/lists
*
*  Populates global arrays with various unit types
*
*  Domain: Server
**/
LIST_HOSTILE_LEVEL_1 = [] + HOSTILE_LEVEL_1_WHITELIST;
LIST_HOSTILE_LEVEL_2 = [] + HOSTILE_LEVEL_2_WHITELIST;
LIST_HOSTILE_LEVEL_3 = [] + HOSTILE_LEVEL_3_WHITELIST;
LIST_HOSTILE_LEVEL_4 = [] + HOSTILE_LEVEL_4_WHITELIST;
LIST_DEFECTOR_CLASS = [] + DEFECTOR_CLASS_WHITELIST;
LIST_PARATROOP_CLASS = [] + PARATROOP_CLASS_WHITELIST;
HOSTILE_ARMED_CARS = [] + HOSTILE_ARMED_CARS_WHITELIST;
HOSTILE_ARMOUR = [] + HOSTILE_ARMOUR_WHITELIST;
_allHostiles = HOSTILE_LEVEL_1 + HOSTILE_LEVEL_2 + HOSTILE_LEVEL_3 + DEFECTOR_CLASS + PARATROOP_CLASS;
private _allSides = (configFile >> "CfgGroups") call BIS_fnc_getCfgSubClasses;
{
	private _side = _x;
	private _factions = (configFile >> "CfgGroups" >> _side) call BIS_fnc_getCfgSubClasses;
	{
		private _faction = _x;
		private _groupTypes = (configFile >> "CfgGroups" >> _side >> _faction) call BIS_fnc_getCfgSubClasses;
		{
			private _groupType = _x;
			private _groups = (configFile >> "CfgGroups" >> _side >> _faction >> _groupType) call BIS_fnc_getCfgSubClasses;
			{
				private _group = _x;
				if (_group in _allHostiles) then {
					private _units = (configFile >> "CfgGroups" >> _side >> _faction >> _groupType >> _group) call BIS_fnc_getCfgSubClasses;
					{
						private _unit = _x;
						private _unitClass = getText (configFile >> "CfgGroups" >> _side >> _faction >> _groupType >> _group >> _x >> "vehicle");
						if (_group in HOSTILE_LEVEL_1) then {LIST_HOSTILE_LEVEL_1 append [_unitClass];};
						if (_group in HOSTILE_LEVEL_2) then {LIST_HOSTILE_LEVEL_2 append [_unitClass];};
						if (_group in HOSTILE_LEVEL_3) then {LIST_HOSTILE_LEVEL_3 append [_unitClass];};
            if (_group in HOSTILE_LEVEL_4) then {LIST_HOSTILE_LEVEL_4 append [_unitClass];};
            if (_group in DEFECTOR_CLASS) then {LIST_DEFECTOR_CLASS append [_unitClass];};
            if (_group in PARATROOP_CLASS) then {LIST_PARATROOP_CLASS append [_unitClass];};
					} forEach _units;
				};
			} forEach _groups;
		} forEach _groupTypes;
	} forEach _factions;
} forEach _allSides;

if (VEHICLE_WHITELIST_MODE != 1) then
{
  //armour
    _armouredVehicles = [];
    _cfgVehicles = configFile >> "CfgVehicles";
    _entries = count _cfgVehicles;
    _realentries = _entries - 1;
    for "_x" from 0 to (_realentries) do {
      _checked_veh = _cfgVehicles select _x;
      _classname = configName _checked_veh;
      if (isClass _checked_veh) then { // CHECK IF THE SELECTED ENTRY IS A CLASS
        _filter = [_checked_veh] call DBW_filter;
        if (_filter) then {
          _vehclass = getText (_checked_veh >> "vehicleClass");
          _scope = getNumber (_checked_veh >> "scope");
          _simulation_paracheck = getText (_checked_veh >> "simulation");
          _actual_vehclass = getText (_checked_veh >> "vehicleClass");
          _textSing = getText (_checked_veh >> "textSingular");
          if (_actual_vehclass == "Armored" || _textSing == "APC" || _textSing == "tank") then {
            if (_vehclass == _vehClass && _scope != 0 && _simulation_paracheck != "parachute") exitWith {
              _armouredVehicles pushback _classname;
            };
          };
        };
      };
    };
    HOSTILE_ARMOUR = HOSTILE_ARMOUR + _armouredVehicles - HOSTILE_VEHICLE_BLACKLIST;
  //cars
    _armedCars = [];
    _cfgVehicles = configFile >> "CfgVehicles";
    _entries = count _cfgVehicles;
    _realentries = _entries - 1;
    for "_x" from 0 to (_realentries) do {
      _checked_veh = _cfgVehicles select _x;
      _classname = configName _checked_veh;
      if (isClass _checked_veh) then {
        _filter = [_checked_veh] call DBW_filter;
        if (_filter) then {
          _vehclass = getText (_checked_veh >> "vehicleClass");
          _scope = getNumber (_checked_veh >> "scope");
          _simulation_paracheck = getText (_checked_veh >> "simulation");
          _actual_vehclass = getText (_checked_veh >> "vehicleClass");
          _textSing = getText (_checked_veh >> "textSingular");
          if (_actual_vehclass == "Car" || _textSing == "car") then {
            turretWeap = false;
            if (isClass (_checked_veh >> "Turrets")) then {
              _vechTurrets = _checked_veh >> "Turrets";
              for "_turretIter" from 0 to (count _vechTurrets - 1) do {
                _weapsOnTurret = _vechTurrets select _turretIter;
                if (!(getarray (_weapsOnTurret >> "weapons") isEqualTo [])) then {
                  turretWeap = true;
                };
              };
            };
            if (_vehclass == _vehClass && _scope != 0 && turretWeap) exitWith {
              _armedCars pushback _classname;
            };
          };
        };
      };
    };
    HOSTILE_ARMED_CARS = HOSTILE_ARMED_CARS + _armedCars - HOSTILE_VEHICLE_BLACKLIST;
};
