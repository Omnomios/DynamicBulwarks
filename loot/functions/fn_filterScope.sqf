/*
* Common config filter, filters by scope and DLC filter
* Expects array of config entries, returns array of config entries that passed the filter
* Example: [configArr] call loot_cnf_filterScope;
*/
params [["_configArr",[]]];
private _return = _configArr select {
	if ([_x,"scope"] call shared_fnc_getConfigEntryAsNumber == 2) then {
		true
	}
};
_return