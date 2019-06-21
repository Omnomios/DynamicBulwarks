/**
*  fn_killed
*
*  Event handler for unit death.
*
*  Domain: Event
**/

if (isServer) then {
    _unit = _this select 0;
    _instigator = _this select 2;
    if (isPlayer _instigator) then {
        [_instigator, SCORE_KILL] call killPoints_fnc_add;
        _killPoints = SCORE_KILL;
        _pointsArr = _unit getVariable "points";
        {
          _killPoints = _killPoints + _x;
        }forEach _pointsArr;
        [format ["<t size='0.5' color='#ff3300'>KILL %1</t>", (floor _killPoints)], -1, 1, 2.5, 0.1, 0.05] remoteExec ["BIS_fnc_dynamicText", _instigator];
    };
};
