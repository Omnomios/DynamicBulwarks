/*
// Gets all facions and relevant information
// - expects: nothing
// - returns: Array of faction configNames
*/

/*
* Gets factions from config
*/

_allFactions = call BIS_fnc_getFactions;
//filter out real factions
_allRealFactions = [];
_index = -1;
{
	private _side = [configfile >> "CfgFactionClasses" >> _x,"side"] call BIS_fnc_returnConfigEntry;
	if (_side <= 3) then {
		private _displayName = [configfile >> "CfgFactionClasses" >> _x,"displayName"] call BIS_fnc_returnConfigEntry;
		[_x] call factions_fnc_getAllFactionHostiles params ["_allInfantry","_filteredVehicles"];
		//filter out factions that don't have anything
		if (count _allInfantry + count _filteredVehicles > 0) then {
			private _displayName = format ["%1 [I:%2 V:%3]",_displayName,count _allInfantry,count _filteredVehicles];
			_index = _index + 1;
			_allRealFactions pushBack [_index,_displayName,_x];
		};
	};
} forEach _allFactions;
//[format ["Factions list generated: %1", _allRealFactions], "PARAM"] call shared_fnc_log;

_allRealFactions; //return