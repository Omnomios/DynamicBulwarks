/**
*  fn_mindConGas
*
*  spawns gas that makes hostile AI join your Squad
*
*  Domain: Server
**/


_player = _this select 0;
_targetPos = _this select 1;


sleep 2;
_smoker = "SmokeShellPurple" createVehicle _targetPos;
sleep 2;
for [{_i=0}, {_i<15}, {_i=_i+1}] do {
  _nearAI = _smoker nearEntities _i;
  _aiToJoin = [];
  {
    if (side _x == east && _x isKindOf "Man") then {
      _aiToJoin pushBack _x;
      MIND_CONTROLLED_AI pushBack _x;
    };
  }foreach _nearAI;
  sleep 1;
  _aiToJoin join _player;
};
deleteVehicle _smoker;
