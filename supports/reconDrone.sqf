/**
*  reconDrone
*
*  Actor for recon drone pickup
*
*  Domain: Client
**/

_droneBox = _this select 0;
hosMrks = [];
_curWave = attkWave;

deleteVehicle _droneBox;

["IntelAdded",["Hostiles added to MAP"]] remoteExec ["BIS_fnc_showNotification", 0];

while {_curWave == attkWave} do {
	{if ((side _x) == east) then
		{
		_mrkrName = format ["hos%1", _x];
		_hosMkr = createMarker [_mrkrName, getPos _x];
		_mrkrName setMarkerType "hd_dot";
		_mrkrName setMarkerColor "ColorRed";
		hosMrks pushback _mrkrName;
		};
	} forEach allUnits;
	//hint str hosMrks;
	sleep 2;
	{deleteMarker _x} forEach hosMrks;
}
