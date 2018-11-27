/**
*  fn_telePlode
*
*  teleports player back to Bulwark Box and creates an explosion where they were
*
*  Domain: Server
**/

_player = _this select 0;
_explosionPos = position _player;

_player setPosASL ([bulwarkBox] call bulwark_fnc_findPlaceAround);
["teleport"] remoteExec ["playSound", _player];
sleep 0.5;
_scriptedCharge = "DemoCharge_Remote_Ammo_Scripted" createVehicle _explosionPos;
_scriptedCharge setDamage 1;
