/*
// Gets all facions and relevant information
// - expects: nothing
// - returns: Array of faction configNames
*/

/*
* Gets factions from config
*/

["Start faction list generation", "FactionsParam"] call shared_fnc_log;

_allFactions = ((call BIS_fnc_getFactions) select {
	private _side = [configfile >> "CfgFactionClasses" >> _x,"side"] call shared_fnc_getConfigEntryAsNumber;
	if (!isNil "_side") then {
		//[format ["Faction: %1 Side: %2", _x, _side], "PARAM"] call shared_fnc_log;
		_side <= 3
	} else {
		false
	};
}); 

_displayNames = (_allFactions apply { [configfile >> "CfgFactionClasses" >> _x,"displayName"] call BIS_fnc_returnConfigEntry }) call BIS_fnc_sortAlphabetically; 

_allFactionsByDisplayName = [_allFactions, [], { 
	 _displayNames find ([configfile >> "CfgFactionClasses" >> _x,"displayName"] call BIS_fnc_returnConfigEntry)
}] call BIS_fnc_sortBy;

_allFactionsBySide = [_allFactionsByDisplayName, [], {
	[configfile >> "CfgFactionClasses" >> _x,"side"] call BIS_fnc_returnConfigEntry
}] call BIS_fnc_sortBy;

_sideNames = ["OPFOR", "BLUE", "IND", "CIV"];

_allRealFactions = [];
_allFactionsWithLoot = [];
_index = -1;
{
	[format ["Getting faction data for: %1",_x],"FactionsParam"] call shared_fnc_log;
	private _side = [configfile >> "CfgFactionClasses" >> _x,"side"] call shared_fnc_getConfigEntryAsNumber;
	private _displayName = [configfile >> "CfgFactionClasses" >> _x,"displayName"] call BIS_fnc_returnConfigEntry;
	[_x] call factions_fnc_getAllFactionHostiles params ["_allInfantry","_filteredVehicles"];
	//pushback any faction that has men for restricting loot per faction - civilian factions are missing?
	if (count _allInfantry > 0) then {
		private _displayName = format ["%1 %2",_sideNames select _side,_displayName];
		_allFactionsWithLoot pushback [_x,_displayName,_x];
	};
	//filter out factions that don't have anything
	if (count _allInfantry + count _filteredVehicles > 0) then {
		private _displayName = format ["%1 %2 [I:%3 V:%4]",_sideNames select _side, _displayName,count _allInfantry,count _filteredVehicles];
		_allRealFactions pushBack [_x,_displayName,_x];
	};
} forEach _allFactionsBySide;
//[format ["Factions list generated: %1", _allRealFactions], "PARAM"] call shared_fnc_log;
["End faction list generation", "FactionsParam"] call shared_fnc_log;
[_allRealFactions,_allFactionsWithLoot] //return