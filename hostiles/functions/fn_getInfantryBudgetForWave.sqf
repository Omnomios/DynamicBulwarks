params ["_wave", "_players"];

private _baseBudget = HOSTILE_MULTIPLIER * _wave * INFANTRY_COST_BUDGET_PER_WAVE;
private _playerCountMultiplier = _players * HOSTILE_TEAM_MULTIPLIER;
private _budget = 1 max (_baseBudget * _playerCountMultiplier);

// The budget must always be at least 1, which is the minimum cost of
// a single unit.

// format ["Max budget for wave: %1: %2", _wave, _budget] call shared_fnc_log;
_budget;