/**
* Populates global arrays with spawnable loot classes
* Domain: Server
* Todo: 
* - To get all glasses for a faction and not just a few, might need to get identities and find which glasses in CfgGlasses they can spawn with
* - CBA has a system for randomized glasses might need to be accounted for as well since configs are different
* - Make sure all headgear is there due to randomized headgear being configured differently some might be missing
* - autonomous MG array is empty for some reason
**/

#include "..\..\shared\bulwark.hpp"

_factions = BULWARK_PARAM_LOOT_FACTIONS call shared_fnc_getCurrentParamValue; //BULWARK_PARAM_FACTIONS call shared_fnc_getCurrentParamValue;
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
				case "Uniform": {_List_Uniforms pushback _x};
				case "Backpack": {_List_Backpacks pushback _x};
				default {};
			};
		};
		default {};
	};
} forEach _allItems;
//get weapon attachments
_LIST_ATTACHMENT = [_List_MG + _List_Sniper + _List_SMG + _List_Shotgun + _List_Handgun + _List_Launcher + _List_Assault] call loot_fnc_getAttachments;
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

//put results into global variables, use whitelist instead if it has entries in it.
if (count LOOT_WHITELIST_UNIFORMS > 0)          then {LOOT_POOL_UNIFORMS            = LOOT_WHITELIST_UNIFORMS}          else {LOOT_POOL_UNIFORMS        = _List_Uniforms                   - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_VESTS > 0)             then {LOOT_POOL_VESTS               = LOOT_WHITELIST_VESTS}             else {LOOT_POOL_VESTS           = _List_Vests                      - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_HEADGEAR > 0)          then {LOOT_POOL_HEADGEAR            = LOOT_WHITELIST_HEADGEAR}          else {LOOT_POOL_HEADGEAR        = _List_Hats                       - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_BACKPACKS > 0)         then {LOOT_POOL_BACKPACKS           = LOOT_WHITELIST_BACKPACKS}         else {LOOT_POOL_BACKPACKS       = _List_Backpacks                  - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_STATICGUNS > 0)        then {LOOT_POOL_STATICGUNS          = LOOT_WHITELIST_STATICGUNS}        else {LOOT_POOL_STATICGUNS      = _List_DisassembledStaticGuns     - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_AUTOSTATICGUNS > 0)    then {LOOT_POOL_AUTOSTATICGUNS      = LOOT_WHITELIST_AUTOSTATICGUNS}    else {LOOT_POOL_AUTOSTATICGUNS  = _List_DisassembledAutonomousGuns - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_STATICSUPPORTS > 0)    then {LOOT_POOL_STATICSUPPORTS      = LOOT_WHITELIST_STATICSUPPORTS}    else {LOOT_POOL_STATICSUPPORTS  = _List_DisassembledSupports       - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_DRONES > 0)            then {LOOT_POOL_DRONES              = LOOT_WHITELIST_DRONES}            else {LOOT_POOL_DRONES          = _List_DisassembledDrones         - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_GLASSES > 0)           then {LOOT_POOL_GLASSES             = LOOT_WHITELIST_GLASSES}           else {LOOT_POOL_GLASSES         = _List_Glasses                    - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_ATTACHMENT > 0)        then {LOOT_POOL_ATTACHMENT          = LOOT_WHITELIST_ASSAULT}           else {LOOT_POOL_ATTACHMENT      = _LIST_ATTACHMENT                 - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_ITEMS > 0)             then {LOOT_POOL_ITEMS               = LOOT_WHITELIST_ITEMS}             else {LOOT_POOL_ITEMS           = _list_Items                      - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_GRENADES > 0)          then {LOOT_POOL_GRENADES            = LOOT_WHITELIST_GRENADES}          else {LOOT_POOL_GRENADES        = _List_Grenades                   - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_EXPLOSIVES > 0)        then {LOOT_POOL_EXPLOSIVES          = LOOT_WHITELIST_EXPLOSIVES}        else {LOOT_POOL_EXPLOSIVES      = _List_Explosives                 - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_MG > 0)                then {LOOT_POOL_MG                  = LOOT_WHITELIST_MG}                else {LOOT_POOL_MG              = _List_MG                         - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_SMG > 0)               then {LOOT_POOL_SMG                 = LOOT_WHITELIST_SMG}               else {LOOT_POOL_SMG             = _List_SMG                        - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_SNIPER > 0)            then {LOOT_POOL_SNIPER              = LOOT_WHITELIST_SNIPER}            else {LOOT_POOL_SNIPER          = _List_Sniper                     - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_SHOTGUN > 0)           then {LOOT_POOL_SHOTGUN             = LOOT_WHITELIST_SHOTGUN}           else {LOOT_POOL_SHOTGUN         = _List_Shotgun                    - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_HANDGUN > 0)           then {LOOT_POOL_HANDGUN             = LOOT_WHITELIST_HANDGUN}           else {LOOT_POOL_HANDGUN         = _List_Handgun                    - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_LAUNCHER > 0)          then {LOOT_POOL_LAUNCHER            = LOOT_WHITELIST_LAUNCHER}          else {LOOT_POOL_LAUNCHER        = _List_Launcher                   - LOOT_BLACKLIST};
if (count LOOT_WHITELIST_ASSAULT > 0)           then {LOOT_POOL_ASSAULT             = LOOT_WHITELIST_ASSAULT}           else {LOOT_POOL_ASSAULT         = _List_Assault                    - LOOT_BLACKLIST};
LOOT_POOL_ALLWEAPONS = LOOT_POOL_MG + LOOT_POOL_SMG + LOOT_POOL_SNIPER + LOOT_POOL_SHOTGUN + LOOT_POOL_HANDGUN + LOOT_POOL_LAUNCHER + LOOT_POOL_ASSAULT;