/**
*  fn_droneControl
*
*  Spawns a controlable drone for 600 seconds
*
*  Domain: Server
**/

_player = _this select 0;
_uavSpawnPos = [_player, 1500, 1550, 0, 1] call BIS_fnc_findSafePos;
_dirToPlayer = _uavSpawnPos getDir _player;
_playerPos = getPos _player;

_player addweapon "B_UavTerminal";
_player linkItem "B_UavTerminal";
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
[_player, driver _supportUav] remoteExec ["remoteControl", _player];
[driver _supportUav, "Internal"] remoteExec ["switchCamera", _player];
_loiterWP setWaypointType "LOITER";
_loiterWP setWaypointLoiterType "CIRCLE_L";
_loiterWP setWaypointLoiterRadius 600;
_uavGroup setCurrentWaypoint _loiterWP;

while {alive _supportUav} do {
  _loiterWP setWaypointType "LOITER";
  _loiterWP setWaypointLoiterType "CIRCLE_L";
  _loiterWP setWaypointLoiterRadius 600;
  _uavGroup setCurrentWaypoint _loiterWP;
  sleep 0.5;
  if (magazines _supportUav isEqualTo ["Laserbatteries"]) then {
    sleep 15;
    _supportUav setDamage 1;
    sleep 10;
    deleteVehicle _supportUav;
  };
};
