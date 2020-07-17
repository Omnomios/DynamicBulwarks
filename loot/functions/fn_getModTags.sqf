/*
* Gets all mod tags to be used for mod filters
* Getting info from CfgPatches instead of CfgWeapons and CfgVehicles, because it has a lot less entries in it, therefore less loading time. Also every mod has CfgPatches entries
*/
["Start of mod list generation","MODLIST"] call shared_fnc_log;
_typeTags = ["U","H","B","I","O","V"]; //tags used to descripe types of gear - if these show up the modTag will be in different place
_modTags = [];
modTagOptions = [];
{
	_blacklist = ["A3"] + _modTags; //vanilla arma content or other stuff that needs to be excluded - also exclude entries that would contain already added tags
	private _splitString = configName _x splitString "_";
	//if its without tag its probably not from a mod
	if !(count _splitString < 2 || (_splitString select 0) in _blacklist) then {
		//find out if the cfgPatches entry contains any items
		private _weapons = [_x,"weapons",[]] call BIS_fnc_returnConfigEntry;
		private _backpacks = [];
		[_x,"units",[]] call BIS_fnc_returnConfigEntry apply {
			if ([configFile >> "CfgVehicles" >> _x,"vehicleClass",""] call BIS_fnc_returnConfigEntry == "Backpacks") then {		
				_backpacks pushBack _x;
			};
		};
		//find at least one valid item in backpacks
		private _validBackpackIndex = _backpacks findIf {
			private _scope = [configFile >> "CfgWeapons" >> _x,"scope",0] call BIS_fnc_returnConfigEntry;
			if (typeName _scope != "SCALAR") then {
				_scope = 0;
			};
			if (_scope == 2) then {
				true
			};
		};
		//if it can't find any in backpacks search in weapons (more expensive) - need make sure its an actual valid loot item
		private _validItemIndex = -1;
		if (_validBackpackIndex == -1) then {
			_validItemIndex = _weapons findIf {
				private _scope = [configFile >> "CfgWeapons" >> _x,"scope",0] call BIS_fnc_returnConfigEntry;
				if (typeName _scope != "SCALAR") then {
					_scope = 0;
				};
				if (_scope == 2) then {
					_x call BIS_fnc_itemType params ["_cat","_type"];
					switch (_cat) do {
						case "Item";
						case "Equipment";
						case "Magazine";
						case "Mine";
						case "Weapon": {true}; //this includes a few vehicle weapons, hopefully doesn't matter
						default {false};
					};
				};
			};
		};
		//Proceed if CfgPatches entry contains any real items
		if (_validItemIndex != -1 || _validBackpackIndex != -1) then {
			//grab the actual modTag directly from the item
			private _possibleModTag = "";
			private _item = "";
			if (_validBackpackIndex != -1) then {_item = _backpacks select _validBackpackIndex} else {_item = _weapons select _validItemIndex};
			private _splitStringItem = _item splitString "_";
			if (count _splitStringItem > 1) then {
				if (_splitStringItem select 0 in _typeTags) then {
					_possibleModTag = _splitStringItem select 1;
				}
				else
				{
					_possibleModTag = _splitStringItem select 0;
				};
				if (_possibleModTag != "muzzle") then { //Exclude vanilla muzzles, since we don't use mod filter for any vanilla items anyway.
				_modtag = toUpper _possibleModTag;
				modTagOptions pushBackUnique [_modtag,_modtag,_modtag];
				};
			};
		};
	};
} forEach ("true" configClasses (configFile >> "CfgPatches"));
publicVariable "modTagOptions";
["End of mod list generation","MODLIST"] call shared_fnc_log;