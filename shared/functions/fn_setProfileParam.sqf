params ["_paramName", "_value"];

private _saveKey = "CWS_BULWARK_SAVE_PARAMS";

private _savedParams = profileNamespace getVariable _saveKey;
if(isNil "_savedParams") then {
    [format ["No saved params for %1", _saveKey], "PARAM"] call shared_fnc_log;
    profileNamespace setVariable [_saveKey, []];
} else {
    private _singleParam = (_savedParams select {(_x select 0) == _paramName}) select 0;
    if(isNil "_singleParam") then {
        [format ["Saving value: %1 for param: %2", _value, _paramName], "PARAM"] call shared_fnc_log;
        _savedParams pushBack [_paramName, _value];
    } else {
        [format ["Overwriting value: %1 with: %2 for param: %3", (_singleParam select 1), _value, _paramName], "PARAM"] call shared_fnc_log;
        // _singleparam is an reference to array in _savedParams, we can use "set"
        _singleParam set [1, _value];
    };
};

// Save params to profile namespace
profileNamespace setVariable [_saveKey, _savedParams];
saveProfileNamespace;
