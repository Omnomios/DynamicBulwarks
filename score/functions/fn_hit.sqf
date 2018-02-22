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
    };
};
