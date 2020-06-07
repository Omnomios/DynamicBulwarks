params ["_wave"];

private _budget = _wave call hostiles_fnc_getVehicleBudgetForWave;

private _vehiclesInWindow = [];
private _windowSizeModifier = 0.9;
while { count _vehiclesInWindow == 0 } do {
    _windowSizeModifier = _windowSizeModifier + 0.1;
    private _costWindow = [1, VEHICLE_COST_CAP, VEHICLE_COST_WAVE_CAP, VEHICLE_COST_WINDOW_SIZE * _windowSizeModifier, _wave] call hostiles_fnc_getCostWindowForWave;
    {
        private _cost = _x select 1;
        if(_cost >= _costWindow select 0 && _cost <= _costWindow select 1) then {
            _vehiclesInWindow pushBack _x;
        }
    } forEach HOSTILE_ARMOUR_COSTS;
};

private _vehiclesToSpawnWithCosts = [_vehiclesInWindow, _budget] call hostiles_fnc_getUnitsWithBudget;
_vehiclesToSpawnWithCosts;