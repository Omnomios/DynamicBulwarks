/* 
* Gives cost value to infantry, based on infantry effectiveness.*
* Expects: Array of infantry classes 
* returns: Number (cost value)
*/

params ["_infantryClasses"];

CWS_getCostFactor = {
    params ["_cfg"];
    private _cost = [_cfg,"cost"] call BIS_fnc_returnConfigEntry;
    //log _cost;
    1;
};

CWS_getRoleFactor = {
    params ["_cfg"];
    private _role = [_cfg,"role"] call BIS_fnc_returnConfigEntry;
    private _roleCost = 0;
    switch (_role) do {
        case "MachineGunner": {_roleCost = 17};
        case "Grenadier": {_roleCost = 16};
        case "Marksman": {_roleCost = 16};
        case "MissileSpecialist": {_roleCost = 15};
        case "Sapper": {_roleCost = 15};
        case "CombatLifeSaver": {_roleCost = 15};
        case "Rifleman": {_roleCost = 15};
        case "SpecialOperative": {_roleCost = 15};
        case "Assistant": {_roleCost = 13};
        case "RadioOperator": {_roleCost = 13};
        default {_roleCost = 15};
    };
    _roleCost / 20;
};

CWS_GetCombinedArmor = {
    params ["_cfg"];
    private _linkedItemsArr = [_cfg,"respawnLinkedItems"] call BIS_fnc_returnConfigEntry;
   // [str _cfg,"INFCOSTUNIT"] call shared_fnc_log;
   //[str _linkedItemsArr,"INFCOSTITEMS"] call shared_fnc_log;
    //if item has armor values extract that info as well and combine to single armor rating value for the unit
    private _armor = 0;
	{
        //[str _x,"INFCOSTITEM"] call shared_fnc_log;
        private _config = configfile >> "CfgWeapons" >> _x;
        private _hitpointProtection = [_config >> "ItemInfo" >> "HitpointsProtectionInfo",0] call BIS_fnc_returnChildren;
        if (count _hitpointProtection != 0) then {
            {
                private _armorValue = [_x,"armor",0] call BIS_fnc_returnConfigEntry;
                if (typeName _armorValue == "SCALAR") then {
                //[str _armorValue,"INFCOSTARMOR"] call shared_fnc_log;
                _armor = _armor + _armorValue;
                };
            } forEach _hitpointProtection;
        };
    } forEach _linkedItemsArr;

    private _unitLinkedUniformClass = getText (_cfg >> "uniformClass");
    private _unitUniformClass = getText (configFile >> "CfgWeapons" >> _unitLinkedUniformClass >> "ItemInfo" >> "uniformClass");
    //[format ["UniformClass: %1  UnitUniformClass: %2", _unitLinkedUniformClass, _unitUniformClass], "INFDEBUG"] call shared_fnc_log;
    
    if(_unitUniformClass != "") then {
        private _unitHitpoints = configFile >> "CfgVehicles" >> _unitUniformClass >> "HitPoints";
        private _allHitpointLocations = _unitHitpoints call BIS_fnc_returnChildren;
        {
            private _armorValue = getNumber (_x >> "armor");
            //[format ["Adding %1 hp from uniform %2", _armorValue, _unitLinkedUniformClass], "INFDEBUG"] call shared_fnc_log;
            if (! isNil "_armorValue") then {
                if (_armorValue < 1000) then {
                    _armor = _armor + _armorValue;
                };
            };
        } forEach _allHitpointLocations;
    };
    _armor;
};

CWS_getArmorFactor = {
    params ["_cfg"];
    private _armor = _cfg call CWS_GetCombinedArmor;
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
private _highestCost = 0;
private _lowestCost = 99999;

{
    private _config = configfile >> "CfgVehicles" >> _x;
    _waveCost = _config call CWS_getWaveCost;
    _infantryByCost pushBack [_config, _waveCost];
    _highestCost = _highestCost max _waveCost;
    _lowestCost = _lowestCost min _waveCost;
}
foreach _infantryClasses;

{
    private _rawWaveCost = _x select 1;
    private _normalizationOffset = if (_highestCost == _lowestCost) then {
        // If all vehicles cost the same amount, there is no offset
        0;
    } else {
        // Otherwise, normalize them.
        (_rawWaveCost - _lowestCost) / (_highestCost -_lowestCost) * (INFANTRY_COST_CAP - 1);
    };
    private _normalizedWaveCost = 1 + _normalizationOffset;

    _x set [1, _normalizedWaveCost];
} forEach _infantryByCost;


_sortedInfantry = [+_infantryByCost, [], { _x select 1 }, "DESCEND"] call BIS_fnc_sortBy;

{
	private _config = _x select 0;
	private _displayName = [_config,"displayName"] call BIS_fnc_returnConfigEntry;
	private _role = [_config,"role"] call BIS_fnc_returnConfigEntry;
	private _cost = [_config,"cost"] call BIS_fnc_returnConfigEntry;
	[_config,"threat"] call BIS_fnc_returnConfigEntry params ["_threatSoft","_threatArmor","_threatAir"];
    //if item has armor values extract that info as well and combine to single armor rating value for the unit
    private _armor = _config call CWS_GetCombinedArmor;

    _uniqueRoles pushBackUnique _role;

    _waveCost = 0;
    _costFactor = _config call CWS_getCostFactor;
    _armorFactor = _config call CWS_getArmorFactor;
    _roleFactor = _config call CWS_getRoleFactor;
    _waveCost = _x select 1;
    private _weapons = [_config, "weapons"] call BIS_fnc_returnConfigEntry;

	[format ["%1 | Role: %2 | Cost: %3 | Armor: %4 | RF: %5 | CF: %6 | AF: %7 | Wave: %8 | Weapons: %9",
        [str _displayName, 38] call shared_fnc_padString,
		[str _role, 20] call shared_fnc_padString,
        [str _cost, 5] call shared_fnc_padString,
        [str _armor, 4] call shared_fnc_padString,
		[str _roleFactor, 6] call shared_fnc_padString,
        [str _costFactor, 7] call shared_fnc_padString,
        [str _armorFactor, 6] call shared_fnc_padString,
        [str _waveCost, 6] call shared_fnc_padString,
        _weapons
        ],
        "INFDEBUG"] call shared_fnc_log;
} forEach _sortedInfantry;

{
    [format ["Role: %1", 
        [_x, 20] call shared_fnc_padString], "INFDEBUG"] call shared_fnc_log;
}
foreach _uniqueRoles;

for "_x" from 1 to 30 do {
    private _waveBudget1 = [_x, 1] call hostiles_fnc_getInfantryBudgetForWave;
    private _waveBudget2 = [_x, 2] call hostiles_fnc_getInfantryBudgetForWave;
    private _waveWindow = [1, INFANTRY_COST_CAP, INFANTRY_COST_WAVE_CAP, INFANTRY_COST_WINDOW_SIZE, _x] call hostiles_fnc_getCostWindowForWave;
    [format ["Wave: %1  1 Player: %2  2 Players: %3  MinCost: %4 MaxCost: %5", 
        [str _x, 3] call shared_fnc_padString,
        [str _waveBudget1, 3] call shared_fnc_padString,
        [str _waveBudget2, 3] call shared_fnc_padString,
        [str (_waveWindow select 0), 3] call shared_fnc_padString,
        [str (_waveWindow select 1), 3] call shared_fnc_padString],
        "INFDEBUG"] call shared_fnc_log;
};

_infantryClassesByCost = [];

{
    _infantryClassesByCost pushBack [configName (_x select 0), _x select 1];
}
foreach _sortedInfantry;

_infantryClassesByCost;
