/**
*  fn_airStrike
*
*  Calls CAS jet to attack passed location
*
*  Domain: Server
**/
params ["_player", "_targetPos", "_aircraft"];

if (count _targetPos == 0) then {
  [_player, "airStrike"] remoteExec ["BIS_fnc_addCommMenuItem", _player]; //refund the support if looking at sky when activated
}else{
  _smoker = "SmokeShellRed" createVehicle [_targetPos select 0, _targetPos select 1, 10];
  _smoker setVelocity [0,0,-100];
  _smoker setVectorDirandUp [[0,0,-1],[0.1,0.1,1]];
  _angle = round random 180;

  // Spawn CAS
  _group = createGroup WEST;
  _cas = _group createUnit ["ModuleCAS_F", _targetPos , [], 0, ""];
  _cas setDir _angle;
  _cas setVariable ["vehicle", _aircraft, true];
  _cas setVariable ["type", 1, true];
};
