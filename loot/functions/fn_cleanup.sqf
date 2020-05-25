/**
*  fn_cleanup
*
*  Removes all loot from Zone
*
*  Domain: Server
**/

//{deleteVehicle _x} foreach activeLoot;

["BEGIN Loot cleanup", "LOOT"] call shared_fnc_log;

_loot = [] call loot_fnc_get;

{ 
	deleteVehicle _x;
} forEach _loot;

lootObjects = [];

["END Loot cleanup", "LOOT"] call shared_fnc_log;
