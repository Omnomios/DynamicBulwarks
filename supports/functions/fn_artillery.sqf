/**
*  fn_artillery
*
*  Calls Atillery
*
*  Domain: Server
**/ 

params ["_player", "_targetPos", "_ammo", ["_accuracy", 25], ["_barrageCount", 1]];

if (count _targetPos == 0) then {
  [_player, "artillery"] remoteExec ["BIS_fnc_addCommMenuItem", _player]; //refund the support if looking at sky when activated
}else{ 
  // Spawn CAS
  sleep random [10, 12, 16];
  for [{ _i = 0 }, { _i < _barrageCount }, { _i = _i + 1 }] do { 
	sleep random [1, 2, 3];	  
	_pos = [[[_targetPos, _accuracy]],[]] call BIS_fnc_randomPos;
	_group = createGroup WEST;
	_cas = _group createUnit ["ModuleOrdnance_F", _pos , [], 0, ""]; 
	_cas setVariable ["type", _ammo, true];
  };
};
 