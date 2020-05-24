/**
* Gets all infantry and vehicles for factions
* Stores results in variables
* - expects: "faction configName"
* - returns: [_allInfantry,_filteredVehicles]
**/
params ["_factionConfigName"];

/*grab all units for available factions*/
private _allLandVehicles = [];
private _allInfantry = [];
//private _allStaticWeapons = [];
//private allHelicopters = [];
//private allPlanes = [];
private _configArray = "([_x,'faction'] call BIS_fnc_returnConfigEntry) == _factionConfigName" configClasses (configFile >> "CfgVehicles");
{
    private _scope = [_x,"scope"] call BIS_fnc_returnConfigEntry;
    if (typeName _scope == "SCALAR") then {
        if (_scope >= 2) then {
            private _parents = [_x,true] call BIS_fnc_returnParents;
            //sort by type
            private _configName = configName _x;
            switch (true) do { 
                //case ("StaticWeapon" in _parents): {allStaticWeapons pushBack _configName;};
                case ("CAManBase" in _parents): 
                {
                    private _role =  [_x,"role"] call BIS_fnc_returnConfigEntry;
                    //probably need more filter, some unarmed units still get through | Using respawnWeapons config entry should give more reliable results.
                    if !(_role in ["Crewman","Civilian","Crew","Unarmed","Default"]) then {
                    _allInfantry pushBack _configName
                    };
                };
                case ("LandVehicle" in _parents): {_allLandVehicles pushBack _configName;};
                //case ("Helicopter" in _parents): {allHelicopters pushBack _configName};
                //case ("Plane" in _parents): {allPlanes pushBack _configName};
            };
        };
    };
} forEach _configArray;

private _filteredVehicles = [];
{
    private _checked_veh = configfile >> "CfgVehicles" >>_x;
    if (isClass _checked_veh) then {
        private _classname = _x;
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
        //filter out blacklisted vehicles
        if (isnil "HOSTILE_VEHICLE_BLACKLIST" || {!(_classname in HOSTILE_VEHICLE_BLACKLIST)}) then {
            // Filter our everything that cannot possibly be a threat
            private _inFilter = !_isArtillery &&
                _hasTurret &&
                (_vehclass == "Armored" || _vehclass == "Car") &&
                _simulation != "parachute";            
            if (_inFilter) then {
            _filteredVehicles pushBack _classname;
            };
        };
    };
} forEach _allLandVehicles;

[_allInfantry,_filteredVehicles] //return
