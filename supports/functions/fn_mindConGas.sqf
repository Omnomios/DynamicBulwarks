/**
*  fn_mindConGas
*
*  spawns gas that makes hostile AI join your Squad
*
*  Domain: Server
**/


_player = _this select 0;
_targetPos = _this select 1;

//play grenade animation
disableUserInput true;
_player playAction "ThrowPrepare";
sleep 1;
_player playAction "ThrowGrenade";
sleep 1;
disableUserInput false;

//if there's a target place at target otherwise place 30m infront of player
sleep 1.5;
if (count _targetPos == 0) then {
  _targetPos = _player getRelPos [30, 0]//refund the support if looking at sky when activated
};
_smoker = "SmokeShellPurple" createVehicle _targetPos;
sleep 2;

//create smoke grenade and recruit AI
for [{_i=0}, {_i<8}, {_i=_i+1}] do {
  _nearAI = _smoker nearEntities _i;
  _aiToJoin = [];
  {
    if (side _x == east && _x isKindOf "Man") then {
      _aiToJoin join _player;
      _aiToJoin pushBack _x;
    };
  }foreach _nearAI;
  MIND_CONTROLLED_AI = MIND_CONTROLLED_AI + _aiToJoin;
  publicVariable "MIND_CONTROLLED_AI";
  sleep 1;
};
deleteVehicle _smoker;
