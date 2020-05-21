#include "..\..\shared\defines.hpp"

params ["_control"];

disableSerialization;

private _selectedIndex = lbCurSel _control;
private _selectedSet = _control lbText _selectedIndex;
private _selectedSetType = _control lbValue _selectedIndex;

[format ["Selected set %1 with type %2", _selectedSet, _selectedSetType], "PARAM"] call shared_fnc_log;
_params = [_selectedSet, _selectedSetType] call shared_fnc_loadParameterSet;

if(isNil "_params") then {
    [format ["Failed to load parameter set %1", _selectedSet], "ERR"] call shared_fnc_log;
    if (_selectedSet != PARAMSETS_DEFAULT_SET_NAME) then {
        ["Falling back to Default", "PARAM"] call shared_fnc_log;
        _control lbSetCurSel 0;
    } else {
        ["Giving up", "ERR"] call shared_fnc_log;
    };
} else {
    CurrentBulwarkParams = _params;
    _selectedSet call shared_fnc_saveSelectedParameterSet;
    [{!isNull findDisplay 9999}, {findDisplay 9999 call lobby_fnc_populateDialogParams}] call CBA_fnc_waitUntilAndExecute;
};

