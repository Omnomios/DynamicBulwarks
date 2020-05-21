#include "..\..\shared\defines.hpp"

disableSerialization;

params ["_paramIndex"];

private _param = GET_CURRENT_PARAM_BY_INDEX(_paramIndex);
private _paramType = PARAM_GET_TYPE(_param);

private _isMultiSelect = PARAM_IS_MULTISELECT(_param);
private _hasOptions = PARAM_HAS_OPTIONS(_param);

private _dialog = findDisplay 9998;
private _editControl = _dialog displayCtrl 100;

private _newParamValue = if (_isMultiSelect) then {
  // TODO MULTISELECT
  0;
} else {
  if (_hasOptions) then {
    // DROPDOWN
    lbCurSel _editControl;
  } else {
    // EDIT CONTROL
    (ctrlText 100) call shared_fnc_getNumberFromString;
  };
};

if (!isNil "_newParamValue") then {
  PARAM_SET_VALUE(_param, _newParamValue);
  format ["Set parameter %1 to %2", PARAM_GET_TITLE(_param), _newParamValue] call shared_fnc_log;
  (findDisplay 9999) call lobby_fnc_populateDialogParams;
} else {
  format ["Cancel set parameter %1", PARAM_GET_TITLE(_param)] call shared_fnc_log;
};

closeDialog 1;
