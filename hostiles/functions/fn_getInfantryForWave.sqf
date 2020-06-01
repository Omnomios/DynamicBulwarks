params ["_wave"];

private _budget = [_wave, (playersNumber west)] call hostiles_fnc_getInfantryBudgetForWave;

// The infantry cost cap is proportional to how close to the cap wave we are, with a
// minimum cap of 1.
private _infantryCostCap = 1 + _wave / INFANTRY_COST_WAVE_CAP * (INFANTRY_COST_SPAN - 1);
format ["Infantry cost cap for wave: %1: %2", _wave, _infantryCostCap] call shared_fnc_log;
private _infantryUnderCap = [];

{
    private _cost = _x select 1;
    if(_cost <= _infantryCostCap) then {
        _infantryUnderCap pushBack _x;
    }
} forEach HOSTILE_INFANTRY_COSTS;

private _infantryToSpawnWithCosts = [_infantryUnderCap, _budget] call hostiles_fnc_getVehiclesWithBudget;
_infantryToSpawnWithCosts;