params ["_wave"];

private _budget = [_wave, (playersNumber west)] call hostiles_fnc_getInfantryBudgetForWave;
private _infantryToSpawnWithCosts = [HOSTILE_INFANTRY_COSTS, _budget] call hostiles_fnc_getVehiclesWithBudget;
_infantryToSpawnWithCosts;