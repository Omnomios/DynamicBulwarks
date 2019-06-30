/**
*  fn_civKilled
*
*  Event handler for civilian unit death.
*
*  Domain: Event
**/

if (isServer) then {
    _unit = _this select 0;
    _instigator = _this select 2;
    if (isPlayer _instigator) then {
        [_instigator, SCORE_KILL * 10] call killPoints_fnc_spend;
        ["Alarm"] remoteExec ["playSound", _instigator];
        [_unit, round SCORE_KILL* -10, [1, 0.1, 0.1]] remoteExec ["killPoints_fnc_hitMarker", _instigator];
    };
};
