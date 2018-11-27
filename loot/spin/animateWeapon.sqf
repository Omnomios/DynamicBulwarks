/**
*  spin/animateWeapon
*
*  Raises and lowers the weapon holder for the loot box
*
*  Domain: Server
**/

//TODO: less code duplication

_boxPos       = _this select 1;
_lPos         = _this select 2;
_hPos         = _this select 3;
_targetWeapon = _this select 4;

if(_this select 0 == 1) then {
    _liftDelay = 0;
    while {_liftDelay < 1} do {
        _pos = [_lPos, _hPos, _liftDelay, 0.1] call BIS_fnc_lerp;
        [_targetWeapon, [(_boxPos select 0), (_boxPos select 1), (_boxPos select 2) + _pos]] remoteExec ["setPosATL", 0];
        sleep 0.03;
        _liftDelay = _liftDelay + 0.01;
    };
};
if(_this select 0 == 2) then {
    _liftDelay = 1;
    while {_liftDelay > 0} do {
        _pos = [_lPos, _hPos, _liftDelay, 0.1] call BIS_fnc_lerp;
        [_targetWeapon, [(_boxPos select 0), (_boxPos select 1), (_boxPos select 2) + _pos]] remoteExec ["setPosATL", 0];
        sleep 0.025;
        _liftDelay = _liftDelay - 0.005;
    };
};
