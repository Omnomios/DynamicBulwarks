_player = _this select 0;
_points = _this select 1;

_killPoints = _player getVariable "killPoints";
if(isNil "_killPoints") then {
	_killPoints = 0;
};

_returnValue = false;

if(_killPoints - _points >= 0) then {
    _killPoints = _killPoints - _points;
    _player setVariable ["killPoints", _killPoints, true];
    _returnValue = true;
    [_player] remoteExec ["killPoints_fnc_updateHud", 0];
};

_returnValue;
