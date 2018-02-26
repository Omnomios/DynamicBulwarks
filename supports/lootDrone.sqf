/**
*  reconDrone
*
*  Actor for loot drone pickup
*
*  Domain: Client
**/

_droneBox = _this select 0;
lootMrks = [];
_curWave = attkWave;

deleteVehicle _droneBox;

["IntelAdded",["Loot locations added to map"]] remoteExec ["BIS_fnc_showNotification", 0];

{
	_mrkrName = format ["loot%1", _x];
	_hosMkr = createMarker [_mrkrName, getPos _x];
	_mrkrName setMarkerType "hd_dot";
	_mrkrName setMarkerColor "ColorGreen";
	_mrkrName setMarkerText (str (((weaponsItemsCargo _x) select 0) select 0));
	_mrkrName setMarkerText (str (((getItemCargo _x) select 0) select 0));
	_mrkrName setMarkerText (str ((magazineCargo _x) select 0));
	_mrkrName setMarkerText (str ((backpackCargo _x) select 0));
	lootMrks pushback _mrkrName;
} forEach activeLoot;

waitUntil {_curWave != attkWave};
{deleteMarker _x} forEach lootMrks;
