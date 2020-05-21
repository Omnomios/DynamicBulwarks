/**
*  fn_add
*
*  Adds score to the specified player
*
*  Domain: Server
**/
#include "..\..\shared\bulwark.hpp"

params ["_player", "_points"];

if (isServer) then {
	switch (KILLPOINTS_MODE) do {
		case KILLPOINTS_MODE_PRIVATE: {
			_killPoints = call killPoints_fnc_get;
			_killPoints = round (_killPoints + _points);
			_player setVariable ["killPoints", _killPoints, true];
		};
		case KILLPOINTS_MODE_SHARED: {
		};
		case KILLPOINTS_MODE_SHAREABLE: {
		};
	};

	[] remoteExec ["killPoints_fnc_updateHud", _player];
};
