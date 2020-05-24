
#define SCOPE_PRIVATE 0
#define SCOPE_PROTECTED 1
#define SCOPE_PUBLIC 2

private _cfgVehicles = "true" configClasses (configFile >> "CfgVehicles");
private _filteredVehicles = [];
{
    // Current result is saved in variable _x
    private _checked_veh = _x;
    if (isClass _checked_veh) then {
        private _classname = configName _checked_veh;
        private _threatToSoldiers = getArray (_checked_veh >> "threat") select 0;
        private _scope = getNumber (_checked_veh >> "scope");
        private _vehclass = getText (_checked_veh >> "vehicleClass");
        private _textSingular = getText (_checked_veh >> "textSingular");
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

        private _isValidVehicleClass = (_vehclass == "Armored" || _vehclass == "Car" || _threatToSoldiers >= 0.1 && (_vehclass == "Autonomous" && (_textSingular == "UGV" || _textSingular == "tank")));

        // Filter our everything that cannot possibly be a threat
        private _inFilter = _scope == SCOPE_PUBLIC &&
            !_isArtillery &&
            _hasTurret &&
            _isValidVehicleClass &&
            _simulation != "parachute";
        
        if (_inFilter) then {
                _simulation_paracheck = getText (_checked_veh >> "simulation");
                _actual_vehclass = getText (_checked_veh >> "vehicleClass");
                _textSing = getText (_checked_veh >> "textSingular");
                private _cost = getNumber (_checked_veh >> "cost");
                private _type = getText (_checked_veh >> "type");
                _filteredVehicles pushBack _checked_veh;
        };
    };
} forEach _cfgVehicles;

private _sortedVehicles = _filteredVehicles;
_sortedVehicles = [+_sortedVehicles, [], { getNumber (_x >> "armor") }, "ASCEND"] call BIS_fnc_sortBy;
_sortedVehicles = [+_sortedVehicles, [], { getNumber (_x >> "cost") }, "ASCEND"] call BIS_fnc_sortBy;
_sortedVehicles = [+_sortedVehicles, [], { getArray (_x >> "threat") select 0 }, "DESCEND"] call BIS_fnc_sortBy;

    // if (_actual_vehclass == "Armored" || _textSing == "APC" || _textSing == "tank") then {
    // if (_vehclass == _vehClass && _scope != 0 && _simulation_paracheck != "parachute") exitWith {
    // };

CWS_getCostFactor = {
    params ["_cfg"];
    private _costBonusForUAVs = 3;
    private _cost = log (getNumber (_cfg >> "cost"));
    private _isAutonomous = getNumber (_cfg >> "isUav") == 1;
    if (_isAutonomous) then {
        _cost = _cost + _costBonusForUAVs;
    };
    _cost;
};

CWS_getThreatFactor = {
    params ["_cfg"];
    private _threatForNoThreatVehicles = 0.05;
    private _threat = getArray (_cfg >> "threat") select 0;
    if (_threat == 0) then {
        _threat = _threatForNoThreatVehicles;
    };

    _threat * 100;
};

CWS_getArmorFactor = {
    params ["_cfg"];
    private _armor = getNumber (_cfg >> "armor");
    8 * log (_armor/30);
};

CWS_getWaveCost = {
    params ["_vehCfg"];

    private _costFactor = _vehCfg call CWS_getCostFactor;
    private _threatFactor = _vehCfg call CWS_getThreatFactor;
    private _armorFactor = _vehCfg call CWS_getArmorFactor;
    private _waveCost = log (_threatFactor * (_costFactor + _armorFactor));
    _waveCost;
};

private _costSpan = 5;
private _lowestCost = 99999;
private _highestCost = 0;

{
    // Current result is saved in variable _x
    private _waveCost = _x call CWS_getWaveCost;
    _lowestCost = _lowestCost min _waveCost;
    _highestCost = _highestCost max _waveCost;
} forEach _filteredVehicles;

format ["%1 lowest, %2 highest", _lowestCost, _highestCost] call shared_fnc_log;

_sortedVehicles = [+_filteredVehicles, [], { _x call CWS_getWaveCost }, "DESCEND"] call BIS_fnc_sortBy;

{
    // Current result is saved in variable _x
    private _disp = getText (_x >> "displayName");
    private _cfgName = configName _x;
    private _tag = format ["%1 (%2)", _disp, _cfgName];
    private _vehclass = getText (_x >> "vehicleClass");
    private _cost = getNumber (_x >> "cost");
    private _armor = getNumber (_x >> "armor");
    private _threat = getArray (_x >> "threat") select 0;
    if (_threat == 0) then {
        _threat = 0.05;
    };
    //private _dmgResist = getNumber (_x >> "damageResistance");
    //private _crashProt = getNumber (_x >> "crewCrashProtection");

    private _costFactor = _x call CWS_getCostFactor;
    private _threatFactor = _threat call CWS_getThreatFactor;
    private _armorFactor = _armor call CWS_getArmorFactor;
    private _waveCost = 1 + ((_x call CWS_getWaveCost) - _lowestCost) / (_highestCost -_lowestCost) * (_costSpan - 1);
    [format ["%1: Class: %2 Cost: %3 Threat: %4 Armor: %5 CF: %6 TF: %7 AF: %8 WaveCost: %9", 
        [_tag, 48] call shared_fnc_padString, 
        [_vehclass, 8] call shared_fnc_padString,
        [format ["%1",_cost], 8] call shared_fnc_padString,
        [format ["%1",_threat], 4] call shared_fnc_padString,
        [format ["%1",_armor], 8] call shared_fnc_padString,
        [format ["%1",_costFactor], 7] call shared_fnc_padString,
        [format ["%1",_threatFactor], 7] call shared_fnc_padString,
        [format ["%1",_armorFactor], 7] call shared_fnc_padString,
        _waveCost],
        //[format ["%1",_dmgResist], 8] call shared_fnc_padString,
        //[format ["%1",_crashProt], 8] call shared_fnc_padString], 
        "VEHDEBUG"] call shared_fnc_log;
} forEach _sortedVehicles;