/**
*  fn_add
*
* Subtracts points from the specified player. Server authoritative
* to allow for shared points.
*
*  Domain: Any
**/
#include "..\..\shared\bulwark.hpp"

params ["_player", "_points"];

if (isServer) then {
	private _killPoints = [_player] call killPoints_fnc_get;
	if(_killPoints - _points >= 0) then {
		_killPoints = _killPoints - _points;
	};

	// Perform the actual change on the server
	[_player, _killPoints] call killPoints_fnc_change;
} else {
	[_player, _points] call killPoints_fnc_spend;
}