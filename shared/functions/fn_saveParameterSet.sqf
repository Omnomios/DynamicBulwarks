#include "..\defines.hpp"

params ["_setName", "_params"];

[format ["Saving parameter set %1", _setName], "PARAM"] call shared_fnc_log;

private _savedParams = [];

{
    private _param = _x;
    private _paramId = PARAM_GET_ID(_param);
    private _paramValue = PARAM_GET_VALUE(_param);
    _savedParams pushBack [_paramId, _paramValue];
    [format ["Added param %1 with value %2", PARAM_GET_TITLE(_param), _paramValue], "PARAM"] call shared_fnc_log;
} forEach _params;

[_setName, _savedParams] call shared_fnc_setProfileParam;

private _savedParamSets = call shared_fnc_getSavedParameterSets;

if (_savedParamSets find _setName == -1) then {
    [format ["Adding new parameter set %1", _setName], "PARAM"] call shared_fnc_log;
    _savedParamSets pushBack _setName;
    [_savedParamSets] call shared_fnc_setSavedParameterSets;
};

[format ["Parameter set %1 saved", _setName], "PARAM"] call shared_fnc_log;
