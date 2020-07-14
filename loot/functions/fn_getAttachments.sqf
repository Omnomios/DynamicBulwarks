/*
* - Expects array of weapon classnames
* - Returns array of weapon attachment classnames - or empty array if none found
*/
params ["_weapons"];
_return = [];
{
	[configfile >> "CfgWeapons" >> _x >> "LinkedItems",0] call BIS_fnc_returnChildren apply {
		private _item = [_x,"item",""] call BIS_fnc_returnConfigEntry;
		if (_item != "") then {
			_return pushBackUnique _item;
		};
	};
} forEach _weapons;
_return
