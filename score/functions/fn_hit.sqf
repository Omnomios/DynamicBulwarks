/**
*  fn_hit
*
*  Event handler for unit hit.
*
*  Domain: Event
**/

if (isServer) then {
    _unit = _this select 0;
    _dmg = _this select 2;
    _instigator = _this select 3;
    if (isPlayer _instigator) then {
        [_instigator, SCORE_HIT + (SCORE_DAMAGE_BASE * _dmg)] call killPoints_fnc_add;
        _pointsArr = _unit getVariable "points";
        _pointsArr pushBack SCORE_HIT + (SCORE_DAMAGE_BASE * _dmg);
        _unit setVariable ["points", _pointsArr];

        [_unit, round (SCORE_HIT + (SCORE_DAMAGE_BASE * _dmg)), [0.1, 1, 0.1]] remoteExec ["killPoints_fnc_hitMarker", _instigator];
    };
};
