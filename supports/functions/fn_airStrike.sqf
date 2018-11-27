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
  _angle = round random 180;

  // Spawn CAS
  _center = createCenter sideLogic;
  _group = createGroup _center;
  _cas = _group createUnit ["ModuleCAS_F", _targetPos , [], 0, ""];
  _cas setDir _angle;
  _cas setVariable ["vehicle", _aircraft, true];
  _cas setVariable ["type", 1, true];
};
