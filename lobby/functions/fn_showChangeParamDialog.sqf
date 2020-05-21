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
  createDialog "bulwarkParamMultiselect_Dialog";
  _dialog = findDisplay 9998;
} else {
  if (_hasOptions) then {
    // DROPDOWN
    createDialog "bulwarkParamSelect_Dialog";
    _dialog = findDisplay 9998;
    private _selectControl = _dialog displayCtrl 100;
    {
      _selectControl lbAdd PARAM_GET_OPTION_NAME(_x);
    } forEach PARAM_GET_OPTIONS(_param);

    _selectControl lbSetCurSel PARAM_GET_VALUE(_param);
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

