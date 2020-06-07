params ["_wave"];

private _budget = [_wave, (playersNumber west)] call hostiles_fnc_getInfantryBudgetForWave;

private _infantryInWindow = [];
private _windowSizeModifier = 0.9;

// This loop causes the window to expand in case we don't actually
// find any units (some mod sets have poor unit cost distributions)
while { count _infantryInWindow == 0 } do {
    _windowSizeModifier = _windowSizeModifier + 0.1;
    private _costWindow = [1, INFANTRY_COST_CAP, INFANTRY_COST_WAVE_CAP, INFANTRY_COST_WINDOW_SIZE * _windowSizeModifier, _wave] call hostiles_fnc_getCostWindowForWave;
    {
        private _cost = _x select 1;
        if(_cost >= _costWindow select 0 && _cost <= _costWindow select 1) then {
            _infantryInWindow pushBack _x;
        }
    } forEach HOSTILE_INFANTRY_COSTS;
};

private _infantryToSpawnWithCosts = [_infantryInWindow, _budget] call hostiles_fnc_getUnitsWithBudget;
_infantryToSpawnWithCosts;