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
  private _selectedValues = [];
  for "_x" from 0 to (ctRowCount _editControl) - 1 do {
    private _rowControls = _editControl ctRowControls _x;
    private _checkbox = _rowControls select 1;
    if (cbChecked _checkbox) then {
      private _option = PARAM_GET_OPTION_BY_INDEX(_param, _x);
      _selectedValues pushBack PARAM_GET_OPTION_ID(_option);
    };
  };
  _selectedValues;
} else {
  if (_hasOptions) then {
    // DROPDOWN
    private _option = PARAM_GET_OPTION_BY_INDEX(_param, lbCurSel _editControl);
    PARAM_GET_OPTION_ID(_option);
  } else {
    // EDIT CONTROL
    (ctrlText 100) call shared_fnc_getNumberFromString;
  };
};

if (!isNil "_newParamValue") then {
  PARAM_SET_VALUE(_param, _newParamValue);
  [format ["Set parameter %1 to %2", PARAM_GET_TITLE(_param), _newParamValue], "PARAM"] call shared_fnc_log;
  (findDisplay 9999) call lobby_fnc_populateDialogParams;
} else {
  [format ["Cancel set parameter %1", PARAM_GET_TITLE(_param)], "PARAM"] call shared_fnc_log;
};

closeDialog 1;
