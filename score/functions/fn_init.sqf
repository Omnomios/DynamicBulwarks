_killPoints = player getVariable "killPoints";
if(isNil "_killPoints") then {
	_killPoints = 0;
};
player setVariable ["killPoints", _killPoints, true];
[player] call killPoints_fnc_updateHud;
