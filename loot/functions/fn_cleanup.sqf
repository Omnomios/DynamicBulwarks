/**
*  fn_cleanup
*
*  Removes all loot from Zone
*
*  Domain: Server
**/

//{deleteVehicle _x} foreach activeLoot;

_loot = [] call loot_fnc_get;

{ 
	deleteVehicle _x;
} forEach _loot

