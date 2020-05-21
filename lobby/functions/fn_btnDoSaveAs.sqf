disableSerialization;

private _setName = ctrlText 100;

format ["Tring to save as set %1", _setName] call shared_fnc_log;
_setName call lobby_fnc_doSave;

closeDialog 1;