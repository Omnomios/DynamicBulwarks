params ["_paramName", "_defaultValue"];

private _saveKey = "CWS_BULWARK_SAVE_PARAMS";
private _value = nil;

 private _savedParams = profileNamespace getVariable _saveKey;
if(isNil "_savedParams") then {
    [format ["No saved params for %1", _saveKey], "PARAM"] call shared_fnc_log;
    profileNamespace setVariable [_saveKey, []];
    _value = _defaultValue;
} else {
    private _singleParam = (_savedParams select {(_x select 0) == _paramName}) select 0;
    if(isNil "_singleParam") then {
        [format ["No saved value for param: %1", _paramName], "PARAM"] call shared_fnc_log;
        _value = _defaultValue;
    } else {
        [format ["Found value: %1 for param: %2,", (_singleParam select 1), _paramName], "PARAM"] call shared_fnc_log;
        _value = _singleParam select 1;
    };
};

_value;