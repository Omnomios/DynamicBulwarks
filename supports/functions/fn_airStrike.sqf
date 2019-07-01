/**
*  fn_airStrike
*
*  Calls CAS jet to attack passed location
*
*  Domain: Server
**/
params ["_player", "_target", "_aircraft"];

if (isNull _target ) then {
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
  _cas setVariable ["type", 1, true]; */
  // credits to tetetet
  _caller = _player; 
//private _target =  nearestObject _targetPos; 
if (isNull _target) exitWith { 
 systemChat "No target"; 
 diag_log "callCAS: No target"; 
}; 
 
[_caller, "Calling Plane CAS"] remoteExec ["sideChat", _caller]; 
 
private _smokePos = getPos _target; 
private _smokeType = selectRandom [ 
     ["SmokeShell", "White"], 
     ["SmokeShellRed", "Red"], 
     ["SmokeShellGreen", "Green"], 
     ["SmokeShellYellow", "Yellow"], 
     ["SmokeShellPurple", "Purple"], 
     ["SmokeShellBlue", "Blue"], 
     ["SmokeShellOrange", "Orange"] 
     ]; 
private _smoke = createVehicle [_smokeType # 0, _smokePos, [], 0, "NONE"]; 
_smoke setPos [_smokePos select 0, _smokePos select 1, 5]; 
_smoke setDamage 1; 
[_caller, "Target marked with smoke, confirm visual"] remoteExec ["sideChat", _caller]; 
 
private _callsign = selectRandom ["Bonnet", "Bulldog", "Dragon", "Firefly", "Hornet", "Litterbug", "Loudmouth", "Mustang", 
          "Red Dog", "Tiger", "Zorro"]; 
 
private _logic = "Logic" createVehicleLocal (getPos _target); 
_logic setDir (random 360); 
_logic setVariable ["vehicle", selectRandom [ "uns_f100b_CAS", "uns_A1J_CAS", "uns_A4B_skyhawk_CAS" , "uns_F4J_CAS","uns_A7N_CAS" ]]; 
 
_logic setVariable ["type", 3]; 
_logic setVariable ["smoke", _smokeType # 1]; 
_logic setVariable ["callsign", _callsign]; 
_logic setVariable ["caller", _caller]; 
 
[_logic, _caller, true] spawn uns_mbox_fnc_moduleCAS; 
};
