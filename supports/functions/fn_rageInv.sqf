_player = _this select 0;
_disabledAI = [];

while {true} do {
  [_player, 0] remoteExec ["setDamage", 0];
  _nearAi = _player nearEntities 5;
  {
    _x disableAI "ALL";
    _disabledAI pushback _x;
  } forEach _nearAI;
  _invincible = _player getVariable "invincible";
  if (!_invincible) exitWith {};
  /*_checkNearAI = _player nearEntities 5;
  _newNearAI = _nearAi - _checkNearAI;
  {
    _x enableAI "ALL";
    _disabledAI pushback _x;
  } forEach _newNearAI; */
};

{
  _x enableAI "ALL";
} forEach _disabledAI;
