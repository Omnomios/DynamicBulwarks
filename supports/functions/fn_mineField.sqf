/**
*  fn_mineField.sqf
*
*  Cluster Mine Artillery Shell on target
*
*  Domain: Server
**/

_player = _this select 0;
_targetPos = _this select 1;

if (count _targetPos == 0) then {
  [player, "mineField"] call BIS_fnc_addCommMenuItem;
}else{
  sleep 4;
  _shell = "Mine_155mm_AMOS_range" createvehicle [_targetPos select 0, _targetPos select 1, 200];
  _shell setVelocity [0,0,-100];
  _shell setVectorDirandUp [[0,0,-1],[0.1,0.1,1]];
};
