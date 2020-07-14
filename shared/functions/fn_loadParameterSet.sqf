#include "..\defines.hpp"

params ["_setName", "_setType"];

[format ["Loading params set %1 of type %2", _setName, _setType], "PARAM"] call shared_fnc_log;
private _paramSet = if (_setType == PARAMSET_TYPE_CUSTOM) then {
    [_setName, []] call shared_fnc_getProfileParam;
} else {
    private _defaultParameterSets = call shared_fnc_getDefaultParameterSets;
    private _paramSetIndex = _defaultParameterSets findIf { (_x select 0) == _setName };
    if(_paramSetIndex == -1) then {
        nil;
    } else {
        (_defaultParameterSets select _paramSetIndex) select 1;
    };
};

if (isNil "_paramSet") then {
    [format["Failed to find param set %1 of type %2", _setName, _setType], "PARAM"] call shared_fnc_log;
    nil;
} else {
    private _params = call shared_fnc_getDefaultParams;

    {
        private _savedParam = _x;
        private _paramId = SAVED_PARAM_GET_ID(_savedParam);
        private _paramIndex = _params findIf { _paramId == PARAM_GET_ID(_x) };
        if (_paramIndex != -1) then {
            private _param = GET_PARAM_BY_INDEX(_params, _paramIndex);
            PARAM_SET_VALUE(_param, SAVED_PARAM_GET_VALUE(_savedParam));
            [format ["Loaded param %1 with saved value %2", PARAM_GET_TITLE(_param), SAVED_PARAM_GET_VALUE(_savedParam)], "PARAM"] call shared_fnc_log;
        } else {
            [format ["Failed to find parameter with ID %1", _paramId], "PARAM"] call shared_fnc_log;
        };
    } forEach _paramSet;

    [format ["%1 params loaded", _setName], "PARAM"] call shared_fnc_log;
    _params;
};