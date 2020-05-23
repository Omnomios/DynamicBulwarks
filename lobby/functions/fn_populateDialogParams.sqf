#include "..\..\shared\defines.hpp"

disableSerialization;

params ["_dialog"];
[format ["Populating params dialog: %1", _dialog], "PARAM"] call shared_fnc_log;

// Adjust the button states
private _parameterSetControl = _dialog displayCtrl 100;
private _selectedIndex = lbCurSel _parameterSetControl;
private _selectedSet = _parameterSetControl lbText _selectedIndex;
private _selectedSetType = _parameterSetControl lbValue _selectedIndex;

private _saveButton = _dialog displayCtrl 3;
_saveButton ctrlEnable (_selectedSetType != PARAMSET_TYPE_BUILTIN);

// (Re)populate the parameters list for the current parameters
private _paramsConfigTable = _dialog displayCtrl 200;
ctClear _paramsConfigTable;

private _currentCategory = "";

{
  private _param = _x;
  // Add the header if needed
  if (_currentCategory != PARAM_GET_CATEGORY(_param)) then {
    _currentCategory = PARAM_GET_CATEGORY(_param);
    private _header = ctAddHeader _paramsConfigTable;
    private _headerControls = (_header select 1);
    (_headerControls select 0) ctrlSetBackgroundColor [1, 1, 1, 0.5];
    (_headerControls select 1) ctrlSetText _currentCategory;
    (_headerControls select 2) ctrlSetText "Value";
  };

  // Add a row for this parameter
  private _row = ctAddRow _paramsConfigTable;
  private _rowControls = (_row select 1);
  (_rowControls select 0) ctrlSetBackgroundColor [0, 0, 0, 0.3];
  (_rowControls select 1) ctrlSetText PARAM_GET_TITLE(_param);

  // EDIT CONTROL
  private _optionValue = PARAM_GET_VALUE(_param);
  
  if(PARAM_HAS_OPTIONS(_param)) then {
    if(PARAM_IS_MULTISELECT(_param)) then {
      // MULTISELECT
      _optionValue = "";
      {
        private _value = _x;
        private _option = PARAM_GET_OPTION_BY_ID(_param, _value);
        if (!isNil "_option") then {
          if (_optionValue != "") then {
            _optionValue = _optionValue + ", ";
          };
          _optionValue = _optionValue + PARAM_GET_OPTION_NAME(_option);
        };
      } forEach PARAM_GET_VALUE(_param);
    } else {
      // DROPDOWN
      private _option = PARAM_GET_OPTION_BY_ID(_param, PARAM_GET_VALUE(_param));
      _optionValue = PARAM_GET_OPTION_NAME(_option);
    };
  };

  (_rowControls select 2) ctrlSetText (format ["%1", _optionValue]);
  (_rowControls select 3) ctrlSetText "Change";
  (_rowControls select 3) buttonSetAction format["%1 call lobby_fnc_showChangeParamDialog", _forEachIndex];
} forEach CurrentBulwarkParams;
