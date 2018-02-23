_player = _this select 0;
if(!isNull _player) then {
    ["Initialize", [_player, [west], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
};
