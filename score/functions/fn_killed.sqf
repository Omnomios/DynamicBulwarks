if (isServer) then {
    _instigator = _this select 2;
    if (isPlayer _instigator) then {
        [_instigator, SCORE_KILL] call killPoints_fnc_add;
    };
};
