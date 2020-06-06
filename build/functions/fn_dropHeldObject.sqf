params ["_player"];

_holdSpec = _player getVariable ["heldObject", nil];
if(!isNil "_holdSpec") then {
    _func = _holdSpec select 0;
    _args = _holdSpec select 1;

    [format ["Calling drop function: %1 Args: %2", _func, _args], "BUILD"] call shared_fnc_log;
    _args call compile ("call " + _func);
    _player call build_fnc_unregisterHeldObject;
};