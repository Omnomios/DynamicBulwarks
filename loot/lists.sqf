/**
*  loot/lists
*
*  Populates global arrays with spawnable loot classes
*
*  Domain: Server
**/
//check if item has modTag
/*Exclude DLC content or limit to mod*/
_dlcParameter = "FILTER_DLC" call BIS_fnc_getParamValue;
//"enoch","Contact"
switch (_dlcParameter) do {
	case 0: {dlcCheck = [];};
	case 1: {dlcCheck = ["enoch","Contact"];};
};
DBW_filter = {
	params ["_item"];
	_filter = false;
	if (count modTag != 0) then {
		{
		_className = configName (_item);
		if ((toUpper _x) in (toUpper _className splitString "_")) then {_filter = true;};
		} forEach modTag;
	}
	else
	{
		_filter = true;
	};
	if (count dlcCheck != 0) then {
		{
		if (gettext (_item >> "DLC") == _x) then {_filter = false;};
		} forEach dlcCheck;
	};
	_filter //return bool
};

_hats = [];
_uniforms = [];
_vests = [];
_primaries = [];
_secondaries = [];
_launchers = [];
_optics = [];
_railAttach = [];
_items = [];
_mines = [];
_backpacks = [];
_glasses = [];
_faces = [];
_grenades = [];
_charges = [];
if (LOOT_WHITELIST_MODE != 1) then {
	_count =  count (configFile >> "CfgWeapons");
	for "_x" from 0 to (_count-1) do {
		_weap = ((configFile >> "CfgWeapons") select _x);
		if (isClass _weap) then {
			if (getnumber (_weap >> "scope") == 2) then {
				_filter = [_weap] call DBW_filter;
				if (_filter) then {
					if (isClass (_weap >> "ItemInfo")) then {
						_infoType = (getnumber (_weap >> "ItemInfo" >> "Type"));
						switch (_infoType) do {
							case 605: {_hats = _hats + [configName _weap];};
							case 801: {_uniforms = _uniforms + [configName _weap];};
							case 701: {_vests = _vests + [configName _weap];};
							case 201: {_optics = _optics + [configName _weap];};
							case 301: {_railAttach = _railAttach + [configName _weap];};
							case 601: {_items = _items + [configName _weap];};
							case 620: {_items = _items + [configName _weap];}; // Toolkit
							case 619: {_items = _items + [configName _weap];}; // Medikit
							case 621: {_items = _items + [configName _weap];}; // UAV terminal
							case 616: {_items = _items + [configName _weap];}; // NVG
							case 401: {_items = _items + [configName _weap];}; // First Aid Kit
						};
					};
					if (!isClass (_weap >> "LinkedItems")) then {
						if (count(getarray (_weap >> "magazines")) !=0 ) then {
							_type = getnumber (_weap >> "type");
							switch (_type) do {
								case 1: {_primaries = _primaries + [configName _weap];};
								case 2: {_secondaries = _secondaries + [configName _weap];};
								case 4: {_launchers = _launchers + [configName _weap];};
							};
						};
					};
					if ( isClass(_weap >> "LinkedItems" >> "LinkedItemsUnder") && !isClass(_weap >> "LinkedItems" >> "LinkedItemsAcc") && !isClass(_weap >> "LinkedItems" >> "LinkedItemsMuzzle") && !isClass(_weap >> "LinkedItems" >> "LinkedItemsOptic")) then {
						if (count(getarray (_weap >> "magazines")) !=0 ) then {
							_primaries = _primaries + [configName _weap];
						};
					};
				};
			};
		};
	};

	_count =  count (configFile >> "CfgVehicles");
	for "_x" from 0 to (_count-1) do {
		_item=((configFile >> "CfgVehicles") select _x);
		if (isClass _item) then {
			if (getnumber (_item >> "scope") == 2) then {
				_filter = [_item] call DBW_filter;
				if (_filter) then {
					if (gettext (_item >> "vehicleClass") == "Backpacks") then {
						_backpacks = _backpacks + [configname _item];
					};
				};
			};
		};
	};

	_count =  count (configFile >> "CfgGlasses");
	for "_x" from 0 to (_count-1) do {
		_item=((configFile >> "CfgGlasses") select _x);
		if (isClass _item) then {
			if (getnumber (_item >> "scope") == 2) then {
				_filter = [_item] call DBW_filter;
				if (_filter) then {
					_glasses = _glasses + [configName _item];
				};
			};
		};
	};
	_count =  count (configFile >> "CfgFaces" >> "Man_A3");
	for "_x" from 0 to (_count-1) do {
		_item=((configFile >> "CfgFaces" >> "Man_A3") select _x);
		_filter = [_item] call DBW_filter;
		if (_filter) then {
			if (isClass _item) then {_faces = _faces + [configName _item];};
		};
	};

	_count =  count (configFile >> "CfgMagazines");
	for "_x" from 0 to (_count-1) do {
		_item=((configFile >> "CfgMagazines") select _x);
		if (isClass _item) then {
			if(getNumber (_item >> "value") == 5) then {
				_filter = [_item] call DBW_filter;
				if (_filter) then {
					if(["mine", getText (_item >> "displayName")] call BIS_fnc_inString) then {
						_mines = _mines + [configName _item];
					};
				};
			};
		};
	};

	_count =  count (configFile >> "CfgMagazines");
	_chargeType = getText (configfile >> "CfgMagazines" >> "DemoCharge_Remote_Mag" >> "type");
	for "_x" from 0 to (_count-1) do {
	_item=((configFile >> "CfgMagazines") select _x);
		if (isClass _item) then {
			_filter = [_item] call DBW_filter;
			if (_filter) then {
				if (gettext (_item >> "type") == _chargeType && ["remote", configName _item] call BIS_fnc_inString) then {
					_charges = _charges + [configName _item];
				};
			};
		};
	};

	_count =  count (configFile >> "CfgMagazines");
	for "_x" from 0 to (_count-1) do {
		_item=((configFile >> "CfgMagazines") select _x);
		if (isClass _item) then {
			if(getNumber (_item >> "type") == 16 || getNumber (_item >> "type") == 256) then {
				_filter = [_item] call DBW_filter;
				if (_filter) then {
					if(["grenade", getText (_item >> "displayName")] call BIS_fnc_inString && !(["smoke", getText (_item >> "displayName")] call BIS_fnc_inString)) then {
						_grenades = _grenades + [configName _item];
					};
				};
			};
		};
	};
};
List_Hats = [] + _hats;
List_Uniforms = [] + _uniforms;
List_Vests = [] + _vests;
List_Backpacks = [] + _backpacks;
List_Primaries = [] + _primaries;
List_Secondaries = [] + _secondaries;
List_Launchers = [] + _launchers;
List_Optics = [] + _optics + _railAttach;
List_Items = [] + _items + ['ItemGPS','ItemCompass','ItemMap', 'ItemWatch', 'ItemRadio'];
List_Mines = [] + _mines;
List_Glasses = [] + _glasses;
List_Faces = [] + _faces;
List_Grenades = [] + _grenades;
List_Charges = [] + _charges;

List_AllWeapons = List_Primaries + List_Secondaries + List_Launchers;
List_AllClothes = List_Hats + List_Uniforms + List_Glasses;
List_Sniper = [];
List_Assault = [];
List_SMG = [];
List_MG = [];

{
 	_type = getText (configFile >> "CfgWeapons" >> _x >> "cursor");
	switch (_type) do {
		case "srifle": {List_Sniper append [_x];};
		case "arifle": {List_Assault append [_x];};
		case "smg": {List_SMG append [_x];};
		case "sgun": {List_SMG append [_x];};	//shotguns included in SMG array since there aren't that many
		case "mg": {List_MG append [_x];};
	};
} forEach List_AllWeapons;
/* Loot Spawn */
if (LOOT_WHITELIST_MODE != 1) then {
    LOOT_WEAPON_POOL    = List_AllWeapons - LOOT_BLACKLIST;
    LOOT_APPAREL_POOL   = List_AllClothes + List_Vests - LOOT_BLACKLIST;
    LOOT_ITEM_POOL      = List_Optics + List_Items - LOOT_BLACKLIST;
    LOOT_EXPLOSIVE_POOL = List_Mines + List_Grenades + List_Charges - LOOT_BLACKLIST;
    LOOT_STORAGE_POOL   = List_Backpacks - LOOT_BLACKLIST;
    LOOT_WEAPON_MG_POOL = List_MG - LOOT_BLACKLIST;
    LOOT_WEAPON_HANDGUN_POOL = List_Secondaries - LOOT_BLACKLIST;
    LOOT_WEAPON_SNIPER_POOL = List_Sniper - LOOT_BLACKLIST;
    LOOT_WEAPON_SMG_POOL = List_SMG - LOOT_BLACKLIST;
    LOOT_WEAPON_ASSAULT_POOL = List_Assault - LOOT_BLACKLIST;
    LOOT_WEAPON_LAUNCHER_POOL = List_Launchers - LOOT_BLACKLIST;
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