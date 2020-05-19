/**
*  fn_revivePlayer
*
* Makes player invincible for 15 seconds after being revived by a medikit
*
*  Domain: Server
**/


_player = _this select 0;
_player playActionNow "agonyStart";
sleep 5;
_player playAction "agonyStop";
_player setDamage 0;

sleep 10;

_player setVariable ["RevByMedikit", false, true];
