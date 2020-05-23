#include "..\..\shared\defines.hpp"

disableSerialization;

params ["_paramIndex"];

private _param = GET_CURRENT_PARAM_BY_INDEX(_paramIndex);
private _paramType = PARAM_GET_TYPE(_param);

private _isMultiSelect = PARAM_IS_MULTISELECT(_param);
private _hasOptions = PARAM_HAS_OPTIONS(_param);

private _dialog = nil;

if (_isMultiSelect) then {
  // MULTISELECT
  createDialog "bulwarkParamMultiSelect_Dialog";
  _dialog = findDisplay 9998;
  private _checkboxesTable = _dialog displayCtrl 100;
  private _options = PARAM_GET_OPTIONS(_param);
  private _selectedValues = PARAM_GET_VALUE(_param);
  {
    private _row = ctAddRow _checkboxesTable;
    private _rowControls = (_row select 1);
    (_rowControls select 0) ctrlSetBackgroundColor [0, 0, 0, 0.3];
    (_rowControls select 2) ctrlSetText PARAM_GET_OPTION_NAME(_x);
    private _isSelected = PARAM_GET_OPTION_ID(_x) in _selectedValues;
    (_rowControls select 1) cbSetChecked _isSelected;
  } forEach _options;
} else {
  if (_hasOptions) then {
    // DROPDOWN
    createDialog "bulwarkParamSelect_Dialog";
    _dialog = findDisplay 9998;
    private _selectControl = _dialog displayCtrl 100;
    {
      _selectControl lbAdd PARAM_GET_OPTION_NAME(_x);
    } forEach PARAM_GET_OPTIONS(_param);

    private _selectedOptionIndex = PARAM_GET_OPTION_INDEX_FOR_ID(_param, PARAM_GET_VALUE(_param));
    _selectControl lbSetCurSel _selectedOptionIndex;
  } else {
    // EDIT CONTROL
    createDialog "bulwarkParamEdit_Dialog";
    _dialog = findDisplay 9998;
    private _editControl = _dialog displayCtrl 100;
    _editControl ctrlSetText format [ "%1", PARAM_GET_VALUE(_param) ];
  };
};

private _titleControl = _dialog displayCtrl 1;
_titleControl ctrlSetText format ["Change %1", PARAM_GET_TITLE(_param)];

private _descControl = _dialog displayCtrl 2;
_descControl ctrlSetText PARAM_GET_DESC(_param);

private _okControl = _dialog displayCtrl 3;
_okControl buttonSetAction format["%1 call lobby_fnc_updateParamFromDialog", _paramIndex];

