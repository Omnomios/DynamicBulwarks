/**
*  fn_revivePlayer
*
* Makes player invincible for 15 seconds after being revived by a medikit
*
*  Domain: Server
**/


_player = _this select 0;

// TODO: This isn't super prominent being in the upper right.
// Maybe use a caption or something that is center of view so you know?
hint "Used a Medikit! Better get outta here...";
sleep 10;
hintSilent "";
_player setVariable ["RevByMedikit", false, true];
