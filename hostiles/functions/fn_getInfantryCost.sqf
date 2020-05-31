/* 
* Gives cost value to infantry, based on infantry effectiveness.*
* Expects: Array of infantry classes 
* returns: Number (cost value)
*/

params ["_infantryClasses"];

CWS_getCostFactor = {
    params ["_cfg"];
    _cost = [_cfg,"cost"] call BIS_fnc_returnConfigEntry;
    log _cost;
};

CWS_getRoleFactor = {
    params ["_cfg"];
    _roleCosts = [
        ["MachineGunner", 10],
        ["Grenadier", 9],
        ["Marksman", 8],
        ["MissileSpecialist", 7],
        ["Sapper", 6],
        ["CombatLifeSaver", 5],
        ["Rifleman", 1],
        ["SpecialOperative", 1],
        ["Assistant", 1],
        ["RadioOperator", 1]
    ];

    private _role = [_cfg,"role"] call BIS_fnc_returnConfigEntry;
    _index = _roleCosts findIf { (_x select 0) == _role };
    (_roleCosts select _index) select 1;
};

CWS_getArmorFactor = {
    params ["_cfg"];
    private _linkedItemsArr = [_cfg,"respawnLinkedItems"] call BIS_fnc_returnConfigEntry;
    //if item has armor values extract that info as well and combine to single armor rating value for the unit
    private _armor = 0;
	{
        private _config = configfile >> "CfgWeapons" >> _x;
        private _hitpointProtection = [_config >> "ItemInfo" >> "HitpointsProtectionInfo",0] call BIS_fnc_returnChildren;
        if (count _hitpointProtection != 0) then {
            {
                private _armorValue = [_x,"armor",0] call BIS_fnc_returnConfigEntry;
                _armor = _armor + _armorValue;
            } forEach _hitpointProtection;
        };
    } forEach _linkedItemsArr;
    if(_armor == 0) then {
        1;
    } else {
        ln _armor;
    };
};

CWS_getWaveCost = {
    params ["_cfg"];

    private _costFactor = _cfg call CWS_getCostFactor;
    private _roleFactor = _cfg call CWS_getRoleFactor;
    private _armorFactor = _cfg call CWS_getArmorFactor;
    //private _waveCost = log (_threatFactor * (_costFactor + _armorFactor));
    private _waveCost = _roleFactor * _costFactor * _armorFactor;
    _waveCost;
};


_uniqueRoles = [];

_infantryByCost = [];

{
    private _config = configfile >> "CfgVehicles" >> _x;
    _waveCost = _config call CWS_getWaveCost;
    _infantryByCost pushBack [_config, _waveCost];
}
foreach _infantryClasses;

_sortedInfantry = [+_infantryByCost, [], { _x select 1 }, "DESCEND"] call BIS_fnc_sortBy;

{
	private _config = _x select 0;
	private _displayName = [_config,"displayName"] call BIS_fnc_returnConfigEntry;
	private _role = [_config,"role"] call BIS_fnc_returnConfigEntry;
	private _cost = [_config,"cost"] call BIS_fnc_returnConfigEntry;
	[_config,"threat"] call BIS_fnc_returnConfigEntry params ["_threatSoft","_threatArmor","_threatAir"];
	private _linkedItemsArr = [_config,"respawnLinkedItems"] call BIS_fnc_returnConfigEntry;
    //if item has armor values extract that info as well and combine to single armor rating value for the unit
    private _armor = 0;
	{
        private _config = configfile >> "CfgWeapons" >> _x;
        private _hitpointProtection = [_config >> "ItemInfo" >> "HitpointsProtectionInfo",0] call BIS_fnc_returnChildren;
        if (count _hitpointProtection != 0) then {
            {
                private _armorValue = [_x,"armor",0] call BIS_fnc_returnConfigEntry;
                _armor = _armor + _armorValue;
            } forEach _hitpointProtection;
        };
    } forEach _linkedItemsArr;

    _uniqueRoles pushBackUnique _role;

    _waveCost = 0;
    _costFactor = _config call CWS_getCostFactor;
    _armorFactor = _config call CWS_getArmorFactor;
    _roleFactor = _config call CWS_getRoleFactor;
    _waveCost = _config call CWS_getWaveCost;

    _infantryByCost pushBack [_config, _waveCost];
    //debug:
	[format ["%1 | Role: %2 | Cost: %3 | Armor: %4 | RF: %5 | CF: %6 | AF: %7 | Wave: %8",
        [str _displayName, 38] call shared_fnc_padString,
		[str _role, 20] call shared_fnc_padString,
        [str _cost, 5] call shared_fnc_padString,
        [str _armor, 4] call shared_fnc_padString,
		[str _roleFactor, 6] call shared_fnc_padString,
        [str _costFactor, 7] call shared_fnc_padString,
        [str _armorFactor, 6] call shared_fnc_padString,
        [str _waveCost, 6] call shared_fnc_padString
        ],
        "INFDEBUG"] call shared_fnc_log;
} forEach _sortedInfantry;

{
    [format ["Role: %1", 
        [_x, 20] call shared_fnc_padString], "INFDEBUG"] call shared_fnc_log;
}
foreach _uniqueRoles;

