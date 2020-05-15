params ["_setName"];
disableSerialization;

format ["Saving set %1", _setName] call shared_fnc_log;

[_setName, CurrentBulwarkParams] call shared_fnc_saveParameterSet;

_setName call shared_fnc_saveSelectedParameterSet;
findDisplay 9999 call lobby_fnc_populateDialogParameterSets;

//[{ !isNull findDisplay 9999 }, { findDisplay 9999 call lobby_fnc_populateDialogParameterSets; }] call CBA_fnc_waitUntilAndExecute;