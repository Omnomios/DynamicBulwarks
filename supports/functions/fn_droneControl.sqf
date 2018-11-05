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
_drone = [[_uavSpawnPos select 0, _uavSpawnPos select 1, (_playerPos select 2) + 300], _dirToPlayer, "B_UAV_02_F", WEST] call BIS_fnc_spawnVehicle;
_supportUav = _drone select 0;
_uavGroup = _drone select 2;
mainZeus addCuratorEditableObjects [[_supportUav], true];

_loiterWP = (_uavGroup) addWaypoint [position bulwarkBox, 0];
_loiterWP setWaypointLoiterRadius 600;
_uavGroup setCurrentWaypoint _loiterWP;

sleep 2;

_bool = _player connectTerminalToUAV _supportUav;
_player remoteControl driver _supportUav;
driver _supportUav switchCamera "Internal";

sleep 120;
if (alive _supportUav) then {
  _supportUav setDamage 1;
};
