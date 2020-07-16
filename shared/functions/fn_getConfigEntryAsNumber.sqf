params ["_config", "_entry"];

private _value = [_config, _entry] call BIS_fnc_returnConfigEntry;

if (isNil "_value") then {
    nil
} else {
    if (typeName _value == "SCALAR") then {
        _value
    } else {
        if (typeName _value == "STRING") then {
            call compile _value
        } else {
            nil
        };
    };
};