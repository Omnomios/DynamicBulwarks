/**
*  fn_spend
*
*  Subtract from specified players score if the player has the score
*
*  Domain: Server
**/
#include "..\..\shared\bulwark.hpp"

params ["_player", "_points"];

if (isServer) then {
	switch (KILLPOINTS_MODE) do {
		case KILLPOINTS_MODE_PRIVATE: {
			_killPoints = call killPoints_fnc_get;

			// REVIEW: It would be weird to fail this condition...
			if(_killPoints - _points >= 0) then {
				_killPoints = _killPoints - _points;
				_player setVariable ["killPoints", _killPoints, true];
			};
		};
		case KILLPOINTS_MODE_SHARED: {
		};
		case KILLPOINTS_MODE_SHAREABLE: {
		};
	};

	[] remoteExec ["killPoints_fnc_updateHud", _player];
};
