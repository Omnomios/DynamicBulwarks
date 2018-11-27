/**
*  fn_revivePlayer
*
* Makes player invincible for 15 seconds after being revived by a medikit
*
*  Domain: Server
**/


_player = _this select 0;

for "_i" from 1 to 15 do {
  [_player, 0] remoteExec ["setDamage", 0];
  sleep 1;
};

[_player, true] remoteExec ["allowDamage", 0];
