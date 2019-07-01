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
//_drone = [[_uavSpawnPos select 0, _uavSpawnPos select 1, (_playerPos select 2) + 500], _dirToPlayer + 35, "B_UAV_02_F", WEST] call BIS_fnc_spawnVehicle;
//_drone = [[_uavSpawnPos select 0, _uavSpawnPos select 1, (_playerPos select 2) + 500], _dirToPlayer + 35, "B_T_VTOL_01_armed_F", WEST] call BIS_fnc_spawnVehicle;
_drone = [[_uavSpawnPos select 0, _uavSpawnPos select 1, (_playerPos select 2) + 500], _dirToPlayer + 35, 'uns_AC47_cia', WEST] call BIS_fnc_spawnVehicle;
 	
_supportUav = _drone select 0;

_uavGroup = _drone select 2;
{_x disableAI 'AUTOCOMBAT'} forEach (units _uavGroup);
mainZeus addCuratorEditableObjects [[_supportUav], true];

_bulwarkPos = position bulwarkBox;
_loiterWP = (_uavGroup) addWaypoint [[_bulwarkPos select 0, _bulwarkPos select 1, (_bulwarkPos select 2) + 500], 0];
_loiterWP setWaypointType "LOITER";
_loiterWP setWaypointLoiterType "CIRCLE_L";
_loiterWP setWaypointLoiterRadius 400;
_loiterWP setWaypointCombatMode "BLUE";
_uavGroup setCurrentWaypoint _loiterWP;

sleep 0.1;
_supportUav setVelocityModelSpace [0, 150, 0];
//for "_i" from 1 to 10 do { _supportUav addMagazineTurret ["CUP_2000Rnd_TE1_Red_Tracer_762x51_M134_M",[1]];  };



sleep 2;

daMan = ((crew _supportUav) select 1);
_bool = _player connectTerminalToUAV _supportUav;

_player remoteControl daMan;
gunner _supportUav switchCamera "Internal";
SupportUAV = _supportUav;
//objnull remotecontrol _unit;
//[player, (gunner _supportUav), true] spawn BIS_fnc_moduleRemoteControl;
_supportUav flyInHeight 200;
 [_supportUav] spawn {
 _supportUav = _this select 0;
 sleep 5;
 //waitUntil {((UAVControl daMan) select 1 == '' ) || !(alive player)};
 waitUntil {(cameraon != vehicle daMan ) || !(alive player) || !(alive _supportUav)};

 objnull remotecontrol daMan; 
 player switchCamera 'internal';
 _supportUav setDamage 1;
 };
sleep 600;
if (alive _supportUav) then {
	objnull remotecontrol daMan; 
	player switchCamera 'internal';
  _supportUav setDamage 1;

};
