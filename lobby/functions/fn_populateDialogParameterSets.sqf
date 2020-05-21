#include "..\..\shared\defines.hpp"

disableSerialization;

params ["_dialog"];
format ["Populating dialog parameter sets: %1", _dialog] call shared_fnc_log;

private _selectedSet = call shared_fnc_loadSelectedParameterSet;
private _selectedSetIndex = 0;

// Populate the configuration set dropdown
private _paramsList = _dialog displayCtrl 100;
lbClear _paramsList;
private _paramSets = call shared_fnc_getParameterSets;
{
  [format ["Adding parameter set %1", _x], "PARAM"] call shared_fnc_log;
  private _newEntryIndex = _paramsList lbAdd PARAMSET_GET_TITLE(_x);
  _paramsList lbSetValue [_newEntryIndex, PARAMSET_GET_TYPE(_x)];
  if (PARAMSET_GET_TITLE(_x) == _selectedSet) then {
      _selectedSetIndex = _newEntryIndex;
  }
} forEach _paramSets;

// This should cause the current parameter set to get loaded
_paramsList lbSetCurSel _selectedSetIndex;
