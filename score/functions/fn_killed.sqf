_instigator = _this select 2;
if (isPlayer _instigator) then {
    [_instigator, 100] call killPoints_fnc_add;
    systemChat format ["%1", player getVariable "killPoints"];
};
