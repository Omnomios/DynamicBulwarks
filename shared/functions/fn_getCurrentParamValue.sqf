#include "..\defines.hpp"
params ["_paramId"];

private _param = GET_CURRENT_PARAM_BY_ID(_paramId);
private _value = PARAM_GET_VALUE(_param);
if (PARAM_IS_MULTISELECT(_param)) then {
    private _values = [];
    {
        private _option = PARAM_GET_OPTION_BY_ID(_param, _x);
        if (!isNil "_option") then {
            _values pushBack PARAM_GET_OPTION_VALUE(_option);
        } else {
            [format ["Failed to find option id %1 for param %2 in multiselect", _x, PARAM_GET_TITLE(_param)], "PARAM"] call shared_fnc_log;
        };
    } forEach _value;
    _values;
} else {
    if (PARAM_HAS_OPTIONS(_param)) then {
        private _option = PARAM_GET_OPTION_BY_ID(_param, _value);
        if (isNil "_option") then {
            [format ["Failed to find option id %1 for param %2. Using first option", _value, PARAM_GET_TITLE(_param)], "PARAM"] call shared_fnc_log;
            _option = PARAM_GET_OPTION_BY_INDEX(_param, 0);
        };
        PARAM_GET_OPTION_VALUE(_option);
    } else {
        _value;
    };
};