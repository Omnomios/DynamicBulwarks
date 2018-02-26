/**
*  moveBox
*
*  Actor for the bulwark "Pickup" action menu item
*
*  Domain: Client
**/

_emptyCrate = _this select 0;
_caller = _this select 1;
_pickupAction = _this select 2;

{[_emptyCrate, _x] remoteExec ["disableCollisionWith", 0];} forEach playableUnits;
//{_caller disableCollisionWith _x;} forEach playableUnits;

_emptyCrate attachTo [_caller, [0,2,0.05], "Pelvis"];
[_emptyCrate, _pickupAction] remoteExec ["removeAction", 0];
[_caller, ["<t color='#00ffff'>" + "Drop", "bulwark\dropBox.sqf", _emptyCrate]] remoteExec ["addAction", 0];
