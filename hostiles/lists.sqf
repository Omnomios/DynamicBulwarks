/**
*  hostiles/lists
*
*  Populates global arrays with various unit types
*
*  Domain: Server
**/
LIST_HOSTILE_LEVEL_1 = [] + HOSTILE_LEVEL_1_WHITELIST;
LIST_HOSTILE_LEVEL_2 = [] + HOSTILE_LEVEL_2_WHITELIST;
LIST_HOSTILE_LEVEL_3 = [] + HOSTILE_LEVEL_3_WHITELIST;
LIST_HOSTILE_LEVEL_4 = [] + HOSTILE_LEVEL_4_WHITELIST;
LIST_DEFECTOR_CLASS = [] + DEFECTOR_CLASS_WHITELIST;
LIST_PARATROOP_CLASS = [] + PARATROOP_CLASS_WHITELIST;

HOSTILE_ARMOUR = [HOSTILE_ARMOUR_WHITELIST + HOSTILE_ARMED_CARS_WHITELIST, HOSTILE_VEHICLE_BLACKLIST] call hostiles_fnc_getAllowedVehicleClasses;
HOSTILE_ARMOUR_COSTS = [HOSTILE_ARMOUR] call hostiles_fnc_getVehicleCosts;

_allHostiles = HOSTILE_LEVEL_1 + HOSTILE_LEVEL_2 + HOSTILE_LEVEL_3 + DEFECTOR_CLASS + PARATROOP_CLASS;
private _allSides = (configFile >> "CfgGroups") call BIS_fnc_getCfgSubClasses;
{
	private _side = _x;
	private _factions = (configFile >> "CfgGroups" >> _side) call BIS_fnc_getCfgSubClasses;
	{
		private _faction = _x;
		private _groupTypes = (configFile >> "CfgGroups" >> _side >> _faction) call BIS_fnc_getCfgSubClasses;
		{
			private _groupType = _x;
			private _groups = (configFile >> "CfgGroups" >> _side >> _faction >> _groupType) call BIS_fnc_getCfgSubClasses;
			{
				private _group = _x;
				if (_group in _allHostiles) then {
					private _units = (configFile >> "CfgGroups" >> _side >> _faction >> _groupType >> _group) call BIS_fnc_getCfgSubClasses;
					{
						private _unit = _x;
						private _unitClass = getText (configFile >> "CfgGroups" >> _side >> _faction >> _groupType >> _group >> _x >> "vehicle");
						if (_group in HOSTILE_LEVEL_1) then {LIST_HOSTILE_LEVEL_1 append [_unitClass];};
						if (_group in HOSTILE_LEVEL_2) then {LIST_HOSTILE_LEVEL_2 append [_unitClass];};
						if (_group in HOSTILE_LEVEL_3) then {LIST_HOSTILE_LEVEL_3 append [_unitClass];};
            if (_group in HOSTILE_LEVEL_4) then {LIST_HOSTILE_LEVEL_4 append [_unitClass];};
            if (_group in DEFECTOR_CLASS) then {LIST_DEFECTOR_CLASS append [_unitClass];};
            if (_group in PARATROOP_CLASS) then {LIST_PARATROOP_CLASS append [_unitClass];};
					} forEach _units;
				};
			} forEach _groups;
		} forEach _groupTypes;
	} forEach _factions;
} forEach _allSides;
