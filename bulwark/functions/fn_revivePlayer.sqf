/**
*  fn_revivePlayer
*
* Makes player invincible for 15 seconds after being revived by a medikit
*
*  Domain: Server
**/


_player = _this select 0;

sleep 15;

_player setVariable ["RevByMedikit", false, true];
