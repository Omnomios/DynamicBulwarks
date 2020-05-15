#include "..\shared\bulwark.hpp"

_target = _this select 0;
_player = _this select 1;
_pointsMulti = (BULWARK_PARAM_SCORE_KILL call shared_fnc_getCurrentParamValue);

[_player, (50 * _pointsMulti)] remoteExecCall ["killPoints_fnc_add", 2];
[_player, "pointsLootSound"] remoteExec ["sound_fnc_say3DGlobal", 0];
_target remoteExec ["deleteVehicle", 2];
