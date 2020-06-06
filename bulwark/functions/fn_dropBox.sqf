/**
*  dropBox
*
*  Actor for the bulwark "Drop" action menu item
*
*  Domain: Client
**/

params ["_target", "_caller", "_dropAction", "_emptyCrate"];

player setVariable ["buildItemHeld", false, true];

detach _emptyCrate;
{[_emptyCrate, _x] remoteExec ["enableCollisionWith", 0];} forEach playableUnits;
_caller removeAction _dropAction;
[_emptyCrate, ["<t color='#00ffff'>" + "Pickup", { _this call bulwark_fnc_moveBox; },"",1,false,false,"true","true",2.5]] remoteExec ["addAction", 0];
["bulwarkBox"] remoteExec ["publicVariable", 2];

player call build_fnc_unregisterHeldObject;
