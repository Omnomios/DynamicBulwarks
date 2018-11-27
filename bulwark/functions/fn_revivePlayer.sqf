/**
*  fn_revivePlayer
*
* MAkes player invincible for 15 seconds after being revived by a medikit
*
*  Domain: Server
**/


_player = _this select 0;

_disabledAI = [];

for "_i" from 1 to 15 do {
  [_player, 0] remoteExec ["setDamage", 0];
  _nearAi = _player nearEntities 5;
  {
    _x disableAI "ALL";
    _disabledAI pushback _x;
  } forEach _nearAI;
  sleep 1;
};

[_player, true] remoteExec ["allowDamage", 0];

{
  _x enableAI "ALL";
} forEach _disabledAI;
