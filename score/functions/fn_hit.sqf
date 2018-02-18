_dmg = _this select 2;
_instigator = _this select 3;
if (isPlayer _instigator) then {
    [_instigator, SCORE_HIT + (SCORE_DAMAGE_BASE * _dmg)] remoteExec ["killPoints_fnc_add", 0];
};
