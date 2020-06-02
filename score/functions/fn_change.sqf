/**
*  fn_change
*
* Changes the killpoints to the specified value. If this is a shared points
* mode, every player gets the points.  Otherwise only the specified player
* gets the points. This will trigger a hud update
*
*  Domain: Server
**/
#include "..\..\shared\bulwark.hpp"

params ["_player", "_killPoints"];

if (isServer) then {
	format ["%1 Changing killpoints to %2", _player, _killPoints] call shared_fnc_log;
	if (KILLPOINTS_MODE == KILLPOINTS_MODE_SHARED) then {
		private _allPlayers = call BIS_fnc_listPlayers;
		{
			_x setVariable ["killPoints", _killPoints, true];
			[] remoteExec ["killPoints_fnc_updateHud", _x];
		} forEach _allPlayers;
	} else {
		_player setVariable ["killPoints", _killPoints, true];
		[] remoteExec ["killPoints_fnc_updateHud", _player];
	};
} else {
	["Called killPoints_fnc_change on a non-server", "ERR"] call shared_fnc_log;
};
