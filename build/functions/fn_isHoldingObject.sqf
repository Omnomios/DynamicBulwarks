params ["_player"];
private _heldObject = _player getVariable ["heldObject", nil];
if(isNil "_heldObject") then {
    false;
} else {
    [format ["Held object for %1: %2", _player, _heldObject], "BUILD"] call shared_fnc_log;
    true;
};
