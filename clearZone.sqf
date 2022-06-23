/**
*  clears Zone from items that laying around
*
*  Actor for the bulwark "clear Zone" action menu item
*
*  Domain: Client
**/

_start = diag_tickTime;
{ deleteVehicle _x; } forEach allDead;
{ deleteVehicle _x; } forEach nearestObjects [getpos player,["WeaponHolder","GroundWeaponHolder"],2000];
//{ deleteVehicle _x; } forEach nearestObjects [getpos player,["WeaponHolder","GroundWeaponHolder"],BULWARK_RADIUS*2];

hint format ["Server cleanup took %1 seconds",diag_tickTime - _start];