/*
* Common config filter, filters by scope and DLC filter
* Expects array of config entries, returns array of config entries that passed the filter
* Example: [config] call loot_fnc_filter;
*/
#include "..\..\shared\bulwark.hpp"
params [["_configArr",[]]];
//get DLC filter parameter
_dlcParameter = BULWARK_PARAM_FILTER_DLC call shared_fnc_getCurrentParamValue;
switch (_dlcParameter) do {
	case 0: {dlcCheck = [];};
	case 1: {dlcCheck = ["enoch","Contact"];};
};
_filteredConfigs = [];
{	//filter out scoped out configs - make sure scope is number
	private _scope = [_x,'scope',0] call BIS_fnc_returnConfigEntry;
	if (typeName _scope != "SCALAR") then {
		_scope = 0;
	};
	private _config = _x;
	if (_scope == 2) then {
		//dlc filter
		if (count dlcCheck != 0) then {
			{
				if ([_config,"DLC"] call BIS_fnc_returnConfigEntry  == _x) then {
					_filteredConfigs pushback _config;
				};
			} forEach dlcCheck;
		}
		else
		{
			_filteredConfigs pushback _config;
		};
	};
} forEach _configArr;
_filteredConfigs //return