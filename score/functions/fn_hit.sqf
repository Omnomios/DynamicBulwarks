_dmg = _this select 2;
_instigator = _this select 3;
if (isPlayer _instigator) then {
    [_instigator, 10] call addKillPoints;
    systemChat format ["%1", player getVariable "killPoints"];
};
