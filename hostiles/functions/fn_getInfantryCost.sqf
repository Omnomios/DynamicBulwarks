/* 
* Gives cost value to infantry, based on infantry effectiveness.*
* Expects: Array of infantry classes 
* returns: Number (cost value)
*/

params ["_infantryClasses"];


{
	private _config = configfile >> "CfgVehicles" >>_x;
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
    //debug:
	[format ["%1 | Role:%2 | Armor:%3",
        [str _displayName, 38] call shared_fnc_padString,
		[str _role, 20] call shared_fnc_padString,
        _armor],
        "INFDEBUG"] call shared_fnc_log;
} forEach _infantryClasses;