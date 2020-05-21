#include "..\defines.hpp"
params ["_paramId"];

private _param = GET_CURRENT_PARAM_BY_ID(_paramId);
private _value = PARAM_GET_VALUE(_param);
if (PARAM_IS_MULTISELECT(_param)) then {
    private _values = [];
    {
        private _option = PARAM_GET_OPTION_BY_INDEX(_param, _value);
        _values pushBack PARAM_GET_OPTION_VALUE(_option);
    } forEach _value;
    _values;
} else {
    if (PARAM_HAS_OPTIONS(_param)) then {
        private _option = PARAM_GET_OPTION_BY_INDEX(_param, _value);
        PARAM_GET_OPTION_VALUE(_option);
    } else {
        _value;
    };
};