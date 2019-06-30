/**
*  reconDrone
*
*  Actor for loot drone pickup
*
*  Domain: Client
**/

//_droneBox = _this select 0;
lootMrks = [];
_curWave = attkWave;

//deleteVehicle _droneBox;

["IntelAdded",["Loot locations added to map"]] call BIS_fnc_showNotification;

_loot = [] call loot_fnc_get;

{
	_displayName = "";
	_mrkrName = format ["loot%1", _x];
	_hosMkr = createMarker [_mrkrName, getPos _x];
	_mrkrName setMarkerType "hd_dot";
	_mrkrName setMarkerColor "ColorGreen";
	if (!isNil {((magazineCargo _x) select 0)}) then {
		_displayName = getText(configFile >> "CfgMagazines" >> ((magazineCargo _x) select 0) >> "displayName");
		_mrkrName setMarkerColor "ColorBlue";
		_mrkrName setMarkerText _displayName;
	};
	if (!isNil {((weaponsItemsCargo _x) select 0) select 0}) then {
		_displayName = getText(configFile >> "CfgWeapons" >> ((weaponsItemsCargo _x) select 0) select 0 >> "displayName");
		_mrkrName setMarkerColor "ColorPink";
		_mrkrName setMarkerText _displayName;
	};
	if (!isNil {((getItemCargo _x) select 0) select 0}) then {
		_displayName = getText(configFile >> "CfgWeapons" >> ((getItemCargo _x) select 0) select 0 >> "displayName");
		_mrkrName setMarkerColor "ColorGreen";
		_mrkrName setMarkerText _displayName;
	};
	if (!isNil {((getBackpackCargo _x) select 0) select 0}) then {
		_displayName = getText(configFile >> "CfgVehicles" >> (((getBackpackCargo _x) select 0) select 0) >> "displayName");
		_mrkrName setMarkerColor "ColorYellow";
		_mrkrName setMarkerText str _displayName;
	};
	if (_displayName == "") then {
		_mrkrName setMarkerText (str (((weaponsItemsCargo _x) select 0) select 0));
		_mrkrName setMarkerText (str (((getItemCargo _x) select 0) select 0));
		_mrkrName setMarkerText (str ((magazineCargo _x) select 0));
		_mrkrName setMarkerText (str ((backpackCargo _x) select 0));
	};
	lootMrks pushback _mrkrName;
} forEach _loot;

waitUntil {attkWave >= 2};
waitUntil {_curWave != attkWave};
{deleteMarker _x} forEach lootMrks;
