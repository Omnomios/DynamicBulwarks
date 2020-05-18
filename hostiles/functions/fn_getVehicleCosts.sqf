params ["_vehicleClasses"];

CWS_getCostFactor = {
    params ["_cost"];
    log _cost;
};

CWS_getThreatFactor = {
    params ["_threat"];
    _threat * 100;
};

CWS_getArmorFactor = {
    params ["_armor"];
    8 * log (_armor/30);
};

private _threatForNoThreatVehicles = 0.05;

CWS_getWaveCost = {
    params ["_vehCfg"];

    private _cost = getNumber (_vehCfg >> "cost");
    private _armor = getNumber (_vehCfg >> "armor");
    private _threat = getArray (_vehCfg >> "threat") select 0;
    if (_threat == 0) then {
        _threat = _threatForNoThreatVehicles;
    };

    private _costFactor = _cost call CWS_getCostFactor;
    private _threatFactor = _threat call CWS_getThreatFactor;
    private _armorFactor = _armor call CWS_getArmorFactor;
    private _waveCost = log (_threatFactor * (_costFactor + _armorFactor));
    _waveCost;
};

private _costSpan = 5;
private _lowestCost = 99999;
private _highestCost = 0;

private _vehicleCosts = [];

// Get raw vehicle costs
{
    // Current result is saved in variable _x
    private _vehicleConfig = configFile >> "CfgVehicles" >> _x;
    private _waveCost = _vehicleConfig call CWS_getWaveCost;
    _lowestCost = _lowestCost min _waveCost;
    _highestCost = _highestCost max _waveCost;
    _vehicleCosts pushBack [_x, _waveCost];
} forEach _vehicleClasses;

// Normalize vehicle costs to range 1 .. 5 (_costSpan)
{
    private _normalizedWaveCost = 1 + ((_x select 1) - _lowestCost) / (_highestCost -_lowestCost) * (_costSpan - 1);
    _x set [1, _normalizedWaveCost];
} forEach _vehicleCosts;

// ["Vehicles costs:", "VEH"] call shared_fnc_log;
// {
//     [format ["  Class: %1 Cost: %2", [_x select 0, 48] call shared_fnc_padString, _x select 1], "VEH"] call shared_fnc_log;
// } forEach _vehicleCosts;

_vehicleCosts;
