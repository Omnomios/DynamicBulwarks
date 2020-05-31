//
// Takes a set of costs and a budget and selects items until the budget is exhausted
//
// Inputs:
// _vehicleCosts - an array of 2-tuples containing the class and the cost
// _budget - a number representing the total budget for this wave
// 
// Outputs:
// An array of 2-tuples containing a class and cost to spawn

params ["_vehicleCosts", "_budget"];

private _vehiclesInBudget = [] + _vehicleCosts;

private _budgetRemaining = _budget;
private _vehiclesToSpawn = [];
while { count _vehiclesInBudget > 0 } do {
    _vehiclesInBudget = _vehiclesInBudget select { (_x select 1) <= _budgetRemaining };
    // format ["Still in budget: %1", _vehiclesInBudget] call shared_fnc_log;
    if (count _vehiclesInBudget > 0) then {
        private _vehicleToBuy = selectRandom _vehiclesInBudget;
        // format ["Buying vehicle: %1", _vehicleToBuy] call shared_fnc_log;
        _vehiclesToSpawn pushBack _vehicleToBuy;
        _budgetRemaining = _budgetRemaining - (_vehicleToBuy select 1);
    };
};

// [format ["Vehicles to spawn with budget %1:", _budget], "VEH"] call shared_fnc_log;
// {
//     [format ["  Class: %1", _x], "VEH"] call shared_fnc_log;
// } forEach _vehiclesToSpawn;

_vehiclesToSpawn;