_instigator = _this select 2;
if (isPlayer _instigator) then {
    [_instigator, 100] remoteExec ["killPoints_fnc_add", 0];
};
