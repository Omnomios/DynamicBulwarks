/**
*  fn_add
*
* Adds points from the specified player. Server authoritative
* to allow for shared points.
*
*  Domain: Any
**/
#include "..\..\shared\bulwark.hpp"

params ["_player", "_points"];

if (isServer) then {
	format ["%1 Adding %2 points", _player, _points] call shared_fnc_log;
	private _killPoints = [_player] call killPoints_fnc_get;
	private _killPoints = round (_killPoints + _points);

	// Perform the actual change on the server
	[_player, _killPoints] call killPoints_fnc_change;
} else {
	format ["Sending remote: Add %1 Adding %2 points", _player, _points] call shared_fnc_log;
	[_player, _points] remoteExecCall ["killPoints_fnc_add", 2];
};