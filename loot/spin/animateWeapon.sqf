//
// Animate the weapon raising and lowering.
//
//TODO: less code duplication
if(_this select 0 == 1) then {
    liftDelay = 0;
    while {liftDelay < 1} do {
        _pos = [_lPos, _hPos, liftDelay, 0.1] call BIS_fnc_lerp;
        lootWeapon setpos [(getpos _lootBox select 0), (getpos _lootBox select 1), _pos];
        sleep 0.03;
        liftDelay = liftDelay + 0.01;
    };
};
if(_this select 0 == 2) then {
    liftDelay = 1;
    while {liftDelay > 0} do {
        _pos = [_lPos, _hPos, liftDelay, 0.1] call BIS_fnc_lerp;
        lootWeapon setpos [(getpos _lootBox select 0), (getpos _lootBox select 1), _pos];
        sleep 0.03;
        liftDelay = liftDelay - 0.005;
    };
};
