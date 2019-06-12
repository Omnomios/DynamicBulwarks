/**
*  fn_civKilled
*
*  Event handler for civilian unit death.
*
*  Domain: Event
**/

if (isServer) then {
    _instigator = _this select 2;
    if (isPlayer _instigator) then {
        [_instigator, SCORE_KILL * 10] call killPoints_fnc_spend;
        ["Alarm"] remoteExec ["playSound", _instigator];
    };
};
