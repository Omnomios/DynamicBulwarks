_target = _this select 0;
_player = _this select 1;
_pointsMulti = ("SCORE_KILL" call BIS_fnc_getParamValue);

[_player, (50 * _pointsMulti)] remoteExecCall ["killPoints_fnc_add", 2];
[_player, "pointsLootSound"] remoteExec ["sound_fnc_say3DGlobal", 0];
_target remoteExec ["deleteVehicle", 2];
