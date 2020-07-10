/**
*  loot/lists
*
*  Populates global arrays with spawnable loot classes
*
*  Domain: Server
**/

#include "..\..\shared\bulwark.hpp"

_factions = "BLU_F"; //BULWARK_PARAM_FACTIONS call shared_fnc_getCurrentParamValue;
//filter out infantry and by faction
_unitConfigs = 	"
	[_x,'simulation'] call BIS_fnc_returnConfigEntry == 'soldier' &&
	[_x,'faction'] call BIS_fnc_returnConfigEntry in _factions
" configClasses (configFile >> "CfgVehicles");
_filteredUnitConfigs = [_unitConfigs] call loot_fnc_filter;

//grab all gear from the infantry configs
_allItems = [];
{
	[[_x,"Items",""] call BIS_fnc_returnConfigEntry] call loot_fnc_getRealElements apply {_allItems pushBackUnique _x};
	[[_x,"linkedItems",""] call BIS_fnc_returnConfigEntry] call loot_fnc_getRealElements apply {_allItems pushBackUnique _x};
	[[_x,"magazines",""] call BIS_fnc_returnConfigEntry] call loot_fnc_getRealElements apply {_allItems pushBackUnique _x};
	[[_x,"uniformClass",""] call BIS_fnc_returnConfigEntry] call loot_fnc_getRealElements apply {_allItems pushBackUnique _x};
	[[_x,"weapons",""] call BIS_fnc_returnConfigEntry] call loot_fnc_getRealElements apply {_allItems pushBackUnique _x};
	[[_x,"backpack",""] call BIS_fnc_returnConfigEntry] call loot_fnc_getRealElements apply {_allItems pushBackUnique _x};
} forEach _filteredUnitConfigs;

//sort items
/*https://community.bistudio.com/wiki/BIS_fnc_itemType*/
_List_MG = [];
_List_Sniper = [];
_List_SMG = [];
_List_Shotgun = [];
_List_Handgun = [];
_List_Launcher = [];
_List_Assault = [];
_List_Grenades = [];
_List_Explosives = [];
_List_Uniforms = [];
_List_Glasses = [];
_List_Hats = [];
_List_Vests = [];
_list_Items = [];
//backpacks,statics and so on
_List_Backpacks = [];
{
	_x call BIS_fnc_itemType params ["_cat","_type"];
	switch (_cat) do {
		case "Weapon": {
			switch (_type) do {
				case "MachineGun": {_List_MG pushBack _x};
				case "SniperRifle": {_List_Sniper pushBack _x};
				case "SubmachineGun": {_List_SMG pushBack _x};
				case "Shotgun": {_List_Shotgun pushBack _x};
				case "Handgun": {_List_Handgun pushBack _x};
				case "RocketLauncher";
				case "MissileLauncher": {_List_Launcher pushBack _x};
				case "Rifle";
				case "AssaultRifle": {_List_Assault pushBack _x};
				default {};
			};
		};
		//magazines are spawned with rifles and from rifle config, only need grenades
		case "Magazine": {
			if (_type == "Grenade") then {
				_List_Grenades pushBack _x;
			};
		};
		case "Mine": {
			_List_Explosives pushBack _x;
		};
		case "Item": {
			_list_Items pushBack _x;
		};
		case "Equipment": {
			switch (_type) do {
				case "Glasses": {_List_Glasses pushback _x};
				case "Headgear": {_List_Hats pushback _x};
				case "Vest": {_List_Vests pushback _x};
				case "Unform": {_List_Uniforms pushback _x};
				case "Backpack": {_List_Backpacks pushback _x};
				default {};
			};
		};
		default {};
	};
} forEach _allItems;
//deal anything that might have gear in it or attachments on it
_List_Backpacks = [_List_Backpacks] call loot_fnc_getEmptyBackpacks;
_List_MG = [_List_MG] call loot_fnc_getBaseWeapons;
_List_Sniper = [_List_Sniper] call loot_fnc_getBaseWeapons;
_List_SMG = [_List_SMG] call loot_fnc_getBaseWeapons;
_List_Shotgun = [_List_Shotgun] call loot_fnc_getBaseWeapons;
_List_Handgun = [_List_Handgun] call loot_fnc_getBaseWeapons;
_List_Launcher = [_List_Launcher] call loot_fnc_getBaseWeapons;
_List_Assault = [_List_Assault] call loot_fnc_getBaseWeapons;
//filter out backpack types
[_List_Backpacks] call loot_fnc_sortBackpackTypes params ["_List_Backpacks","_List_DisassembledStaticGuns","_List_DisassembledAutonomousGuns","_List_DisassembledDrones","_List_DisassembledSupports"];
//placeholder:
/* Loot Spawn */
if (LOOT_WHITELIST_MODE != 1) then {
    LOOT_APPAREL_POOL = [];
    LOOT_ITEM_POOL = [];
    LOOT_EXPLOSIVE_POOL = [];
    LOOT_STORAGE_POOL = [];
    LOOT_WEAPON_MG_POOL = [];
    LOOT_WEAPON_HANDGUN_POOL = [];
    LOOT_WEAPON_SNIPER_POOL = [];
    LOOT_WEAPON_SMG_POOL = [];
    LOOT_WEAPON_ASSAULT_POOL = [];
    LOOT_WEAPON_LAUNCHER_POOL = [];

    if (LOOT_CATEGORY_HATS in (BULWARK_PARAM_LOOT_WORN call shared_fnc_getCurrentParamValue)) then {
        LOOT_APPAREL_POOL append _List_Hats; 
    };
    if (LOOT_CATEGORY_UNIFORMS in (BULWARK_PARAM_LOOT_WORN call shared_fnc_getCurrentParamValue)) then {
        LOOT_APPAREL_POOL append _List_Uniforms; 
    };
    if (LOOT_CATEGORY_VESTS in (BULWARK_PARAM_LOOT_WORN call shared_fnc_getCurrentParamValue)) then {
        LOOT_APPAREL_POOL append _List_Vests;
    };
    if (LOOT_CATEGORY_BACKPACKS in (BULWARK_PARAM_LOOT_WORN call shared_fnc_getCurrentParamValue)) then {
        LOOT_STORAGE_POOL append _List_Backpacks;
    };
    if (LOOT_CATEGORY_GLASSES in (BULWARK_PARAM_LOOT_WORN call shared_fnc_getCurrentParamValue)) then {
        LOOT_APPAREL_POOL append _List_Glasses;
    };
	if (LOOT_CATEGORY_SNIPER in (BULWARK_PARAM_LOOT_WEAPONS call shared_fnc_getCurrentParamValue)) then {
        LOOT_WEAPON_SNIPER_POOL append _List_Sniper;
    };
	if (LOOT_CATEGORY_ASSAULT in (BULWARK_PARAM_LOOT_WEAPONS call shared_fnc_getCurrentParamValue)) then {
        LOOT_WEAPON_ASSAULT_POOL append _List_Assault;
    };
	if (LOOT_CATEGORY_SMG in (BULWARK_PARAM_LOOT_WEAPONS call shared_fnc_getCurrentParamValue)) then {
        LOOT_WEAPON_SMG_POOL append _List_SMG;
    };
	if (LOOT_CATEGORY_MG in (BULWARK_PARAM_LOOT_WEAPONS call shared_fnc_getCurrentParamValue)) then {
        LOOT_WEAPON_MG_POOL append _List_MG;
    };
	//don't forget adding shotguns later
	if (LOOT_CATEGORY_LAUNCHERS in (BULWARK_PARAM_LOOT_WEAPONS call shared_fnc_getCurrentParamValue)) then {
        LOOT_WEAPON_LAUNCHER_POOL append _List_Launcher;
    };
	if (LOOT_CATEGORY_HANDGUNS in (BULWARK_PARAM_LOOT_WEAPONS call shared_fnc_getCurrentParamValue)) then {
        LOOT_WEAPON_HANDGUN_POOL append _List_Handgun;
    };
    if (LOOT_CATEGORY_MINES in (BULWARK_PARAM_LOOT_EXPLOSIVES call shared_fnc_getCurrentParamValue)) then {
        LOOT_EXPLOSIVE_POOL append _List_Explosives;
    };
    if (LOOT_CATEGORY_GRENADES in (BULWARK_PARAM_LOOT_EXPLOSIVES call shared_fnc_getCurrentParamValue)) then {
        LOOT_EXPLOSIVE_POOL append _List_Grenades;
    };
    //LOOT_APPAREL_POOL   = List_AllClothes + _List_Vests - LOOT_BLACKLIST;
    //LOOT_ITEM_POOL      = List_Optics + List_Items - LOOT_BLACKLIST;
    //LOOT_EXPLOSIVE_POOL = List_Mines + _List_Grenades + List_Charges - LOOT_BLACKLIST;
    //LOOT_STORAGE_POOL   = _List_Backpacks - LOOT_BLACKLIST;
    //LOOT_WEAPON_MG_POOL = _list_Items + LOOT_WHITELIST_WEAPON_MG - LOOT_BLACKLIST;
    //LOOT_WEAPON_HANDGUN_POOL = List_Secondaries + LOOT_WHITELIST_WEAPON_HANDGUN - LOOT_BLACKLIST;
    //LOOT_WEAPON_SNIPER_POOL = _List_Sniper + LOOT_WHITELIST_WEAPON_SNIPER - LOOT_BLACKLIST;
    //LOOT_WEAPON_SMG_POOL = _List_SMG + LOOT_WHITELIST_WEAPON_SMG - LOOT_BLACKLIST;
    //LOOT_WEAPON_ASSAULT_POOL = _List_Assault + LOOT_WHITELIST_WEAPON_ASSAULT - LOOT_BLACKLIST;
    //LOOT_WEAPON_LAUNCHER_POOL = _List_Launchers + LOOT_WHITELIST_WEAPON_LAUNCHER - LOOT_BLACKLIST;
	LOOT_WEAPON_POOL = LOOT_WEAPON_MG_POOL + LOOT_WEAPON_HANDGUN_POOL + LOOT_WEAPON_SNIPER_POOL + LOOT_WEAPON_SMG_POOL + LOOT_WEAPON_ASSAULT_POOL + LOOT_WEAPON_LAUNCHER_POOL;
}
else
{
    LOOT_WEAPON_POOL    = LOOT_WHITELIST_WEAPON_MG + LOOT_WHITELIST_WEAPON_SNIPER + LOOT_WHITELIST_WEAPON_SMG + LOOT_WHITELIST_WEAPON_ASSAULT + LOOT_WHITELIST_WEAPON_LAUNCHER + LOOT_WHITELIST_WEAPON_HANDGUN;
    LOOT_APPAREL_POOL   = LOOT_WHITELIST_APPAREL;
    LOOT_ITEM_POOL      = LOOT_WHITELIST_ITEM;
    LOOT_EXPLOSIVE_POOL = LOOT_WHITELIST_EXPLOSIVE;
    LOOT_STORAGE_POOL   = LOOT_WHITELIST_STORAGE;
    LOOT_WEAPON_MG_POOL = LOOT_WHITELIST_WEAPON_MG;
    LOOT_WEAPON_HANDGUN_POOL = LOOT_WHITELIST_WEAPON_HANDGUN;
    LOOT_WEAPON_SNIPER_POOL = LOOT_WHITELIST_WEAPON_SNIPER;
    LOOT_WEAPON_SMG_POOL = LOOT_WHITELIST_WEAPON_SMG;
    LOOT_WEAPON_ASSAULT_POOL = LOOT_WHITELIST_WEAPON_ASSAULT;
    LOOT_WEAPON_LAUNCHER_POOL = LOOT_WHITELIST_WEAPON_LAUNCHER;
};
