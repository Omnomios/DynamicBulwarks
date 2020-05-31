/**
*  hostiles/lists
*
*  Populates global arrays with various unit types
*
*  Domain: Server
**/


#define SCOPE_PRIVATE 0
#define SCOPE_PROTECTED 1
#define SCOPE_PUBLIC 2
#include "..\shared\bulwark.hpp"

private _factionParams = [BULWARK_PARAM_FILTER_FACTIONS] call shared_fnc_getCurrentParamValue;
_allInfantry = [];
_allVehicles = [];
{
	[_x] call factions_fnc_getAllFactionHostiles params ["_infantry","_vehicles"];
	_allInfantry append _infantry;
	_allVehicles append _vehicles;
} forEach _factionParams;

//use whitelists instead if they are being used
if (count HOSTILE_VEHICLE_WHITELIST > 0) then {
	_allVehicles = HOSTILE_VEHICLE_WHITELIST;
};
if (count HOSTILE_INFANTRY_WHITELIST > 0) then {
	_allInfantry = HOSTILE_INFANTRY_WHITELIST;
};
//set global arrays
HOSTILE_ARMOUR = _allVehicles;
HOSTILE_ARMOUR_COSTS = [HOSTILE_ARMOUR] call hostiles_fnc_getVehicleCosts;

LIST_HOSTILE_LEVEL_1 = _allInfantry;
LIST_HOSTILE_LEVEL_2 = _allInfantry;
LIST_HOSTILE_LEVEL_3 = _allInfantry;
LIST_HOSTILE_LEVEL_4 = _allInfantry;
HOSTILE_INFANTRY_COSTS = [_allInfantry] call hostiles_fnc_getInfantryCost;

if (count HOSTILE_INFANTRY_WHITELIST > 0) then {
	LIST_DEFECTOR_CLASS = DEFECTOR_CLASS_WHITELIST;
}
else
{
	LIST_DEFECTOR_CLASS =  _allInfantry;
};
if (count HOSTILE_INFANTRY_WHITELIST > 0) then {
	LIST_PARATROOP_CLASS = PARATROOP_CLASS_WHITELIST;
}
else
{
	LIST_PARATROOP_CLASS = _allInfantry;
};

