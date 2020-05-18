params ["_classWhiteList", "_classBlackList"];

#define SCOPE_PRIVATE 0
#define SCOPE_PROTECTED 1
#define SCOPE_PUBLIC 2

private _cfgVehicles = "true" configClasses (configFile >> "CfgVehicles");
private _filteredVehicles = [] + _classWhiteList;

if (count _classWhiteList == 0) then {
    {
        private _checked_veh = _x;
        if (isClass _checked_veh) then {
            private _classname = configName _checked_veh;
            private _threatToSoldiers = getArray (_checked_veh >> "threat") select 0;
            private _scope = getNumber (_checked_veh >> "scope");
            private _vehclass = getText (_checked_veh >> "vehicleClass");
            private _simulation = getText (_checked_veh >> "simulation");
            private _isArtillery = getNumber (_checked_veh >> "artilleryScanner") > 0;

            private _hasTurret = false;
            private _turrets = [_classname, true] call BIS_fnc_allTurrets;
            {
                _turretConfigPath = [_classname,_x] call BIS_fnc_turretConfig;
                _turretWeapons = getArray (_turretConfigPath >> "weapons");
                if (count _turretWeapons > 0) then {
                    _hasTurret = true;
                };
            } forEach _turrets;

            // Filter our everything that cannot possibly be a threat
            private _inFilter = !(_classname in _classBlackList) &&
                _scope == SCOPE_PUBLIC &&
                !_isArtillery &&
                _hasTurret &&
                (_vehclass == "Armored" || _vehclass == "Car") &&
                _simulation != "parachute";
            
            if (_inFilter) then {
                _filteredVehicles pushBack _classname;
            };
        };
    } forEach _cfgVehicles;
};

// ["Allowed vehicles:", "VEH"] call shared_fnc_log;
// {
//     [format ["  Class: %1", _x], "VEH"] call shared_fnc_log;
// } forEach _filteredVehicles;

_filteredVehicles;