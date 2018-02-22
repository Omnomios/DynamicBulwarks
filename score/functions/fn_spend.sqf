/**
*  fn_spend
*
*  Subtract from specified players score if the player has the score
*
*  Domain: Server
**/

if (isServer) then {
	_player = _this select 0;
	_points = _this select 1;

	_killPoints = _player getVariable "killPoints";
	if(isNil "_killPoints") then {
		_killPoints = 0;
	};

	if(_killPoints - _points >= 0) then {
	    _killPoints = _killPoints - _points;
	    _player setVariable ["killPoints", _killPoints, true];
	    [] remoteExec ["killPoints_fnc_updateHud", _player];
	};
};
