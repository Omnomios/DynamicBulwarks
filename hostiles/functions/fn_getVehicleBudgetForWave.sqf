params ["_wave"];

private _budget = 1 + ARMOUR_WAVE_SCALING * (_wave - ARMOUR_START_WAVE) * VEHICLE_COST_BUDGET_PER_WAVE; 
//[format ["Vehicle budget: %1", _budget], "VEH"] call shared_fnc_log;

_budget;