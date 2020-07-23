/*
* Function extracts string from config. If unexpected datatype nil is returned.
* Expects: [_config,_entry]
*/
params ["_config", "_entry"];

private _value = [_config, _entry] call BIS_fnc_returnConfigEntry;

if (isNil "_value") then {
    nil
}
else
{
    if (typeName _value == "STRING") then {
        _value
    } 
	else 
	{
		nil
    };
};