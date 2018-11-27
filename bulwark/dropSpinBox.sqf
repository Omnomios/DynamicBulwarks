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

[_emptyCrate] remoteExec ['detach', 0];
_boxPos = getPos _emptyCrate;
_emptyCrate setPos [_boxPos select 0, _boxPos select 1, _boxPos select 2 - 1.5];
_playerAction removeAction _dropAction;
[_emptyCrate, ["<t color='#00ffff'>" + "Pickup", "bulwark\moveSpinBox.sqf","",1,false,false,"true","true",2.5]] remoteExec ["addAction", 0, true];
