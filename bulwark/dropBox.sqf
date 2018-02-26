/**
*  dropBox
*
*  Actor for the bulwark "Drop" action menu item
*
*  Domain: Client
**/

_emptyCrate = _this select 3;
_dropAction = _this select 2;
_playerAction = _this select 1;

detach _emptyCrate;
{[_emptyCrate, _x] remoteExec ["enableCollisionWith", 0];} forEach playableUnits;
_playerAction removeAction _dropAction;
[_emptyCrate, ["<t color='#00ffff'>" + "Pickup", "bulwark\moveBox.sqf","",1,false,false,"true","true",2.5]] remoteExec ["addAction", 0];
["bulwarkBox"] remoteExec ["publicVariable", 2];
