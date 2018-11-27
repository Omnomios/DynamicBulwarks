/**
*  fn_droneControl
*
*  Spawns a controlable drone for 1 minute
*
*  Domain: Server
**/

_player = _this select 0;
_uavSpawnPos = [_player, 1500, 1550, 0, 1] call BIS_fnc_findSafePos;
_dirToPlayer = _uavSpawnPos getDir _player;
_playerPos = getPos _player;

_player addweapon "B_UavTerminal";
_player connectTerminalToUAV objNull;
_drone = [[_uavSpawnPos select 0, _uavSpawnPos select 1, (_playerPos select 2) + 500], _dirToPlayer + 35, "B_UAV_02_F", WEST] call BIS_fnc_spawnVehicle;
_supportUav = _drone select 0;
_uavGroup = _drone select 2;
mainZeus addCuratorEditableObjects [[_supportUav], true];

_bulwarkPos = position bulwarkBox;
_loiterWP = (_uavGroup) addWaypoint [[_bulwarkPos select 0, _bulwarkPos select 1, (_bulwarkPos select 2) + 500], 0];
_loiterWP setWaypointType "LOITER";
_loiterWP setWaypointLoiterType "CIRCLE_L";
_loiterWP setWaypointLoiterRadius 600;
_uavGroup setCurrentWaypoint _loiterWP;

sleep 2;

_bool = _player connectTerminalToUAV _supportUav;
_player remoteControl driver _supportUav;
driver _supportUav switchCamera "Internal";

sleep 600;
if (alive _supportUav) then {
  _supportUav setDamage 1;
};
