params ["_wave", "_players"];

private _budget = (INFANTRY_COST_SPAN + HOSTILE_MULTIPLIER * _wave) * (_players * HOSTILE_TEAM_MULTIPLIER); 
//[format ["Vehicle budget: %1", _budget], "VEH"] call shared_fnc_log;

_budget;