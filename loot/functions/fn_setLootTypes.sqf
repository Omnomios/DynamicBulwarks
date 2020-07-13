/*
* Sets loot types and chances
*/

#include "..\..\shared\bulwark.hpp"

randItemTypes = [];
randItemChances = [];
if (count LOOT_POOL_UNIFORMS > 0) then {
	randItemTypes pushback "UNIFORMS";
	randItemChances pushback (BULWARK_PARAM_LOOT_UNIFORMS call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_VESTS > 0) then {
	randItemTypes pushback "VESTS";
	randItemChances pushback (BULWARK_PARAM_LOOT_VESTS call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_HEADGEAR > 0) then {
	randItemTypes pushback "HEADGEAR";
	randItemChances pushback (BULWARK_PARAM_LOOT_HEADGEAR call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_BACKPACKS > 0) then {
	randItemTypes pushback "BACKPACKS";
	randItemChances pushback (BULWARK_PARAM_LOOT_BACKPACKS call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_STATICGUNS > 0) then {
	randItemTypes pushback "STATICGUNS";
	randItemChances pushback (BULWARK_PARAM_LOOT_STATICGUN call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_AUTOSTATICGUNS > 0) then {
	randItemTypes pushback "AUTOSTATICGUNS";
	randItemChances pushback (BULWARK_PARAM_LOOT_AUTOGUN call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_DRONES > 0) then {
	randItemTypes pushback "DRONES";
	randItemChances pushback (BULWARK_PARAM_LOOT_DRONE call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_GLASSES > 0) then {
	randItemTypes pushback "GLASSES";
	randItemChances pushback (BULWARK_PARAM_LOOT_GLASSES call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_ITEMS > 0) then {
	randItemTypes pushback "ITEMS";
	randItemChances pushback (BULWARK_PARAM_LOOT_ITEMS call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_GRENADES > 0) then {
	randItemTypes pushback "GREANDES";
	randItemChances pushback (BULWARK_PARAM_LOOT_GRENADES call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_EXPLOSIVES > 0) then {
	randItemTypes pushback "EXPLOSIVES";
	randItemChances pushback (BULWARK_PARAM_LOOT_EXPLOSIVE call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_MG > 0) then {
	randItemTypes pushback "MG";
	randItemChances pushback (BULWARK_PARAM_LOOT_MG call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_SMG > 0) then {
	randItemTypes pushback "SMG";
	randItemChances pushback (BULWARK_PARAM_LOOT_SMG call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_SNIPER > 0) then {
	randItemTypes pushback "SNIPER";
	randItemChances pushback (BULWARK_PARAM_LOOT_SNIPER call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_SHOTGUN > 0) then {
	randItemTypes pushback "SHOTGUN";
	randItemChances pushback (BULWARK_PARAM_LOOT_SHOTGUN call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_HANDGUN > 0) then {
	randItemTypes pushback "HANDGUN";
	randItemChances pushback (BULWARK_PARAM_LOOT_HANDGUN call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_LAUNCHER > 0) then {
	randItemTypes pushback "LAUCNHER";
	randItemChances pushback (BULWARK_PARAM_LOOT_LAUNCHER call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_ATTACHMENT > 0) then {
	randItemTypes pushback "ATTACHMENT";
	randItemChances pushback (BULWARK_PARAM_LOOT_ATTACHMENT call shared_fnc_getCurrentParamValue);
};
if (count LOOT_POOL_ASSAULT > 0) then {
	randItemTypes pushback "ASSAULT";
	randItemChances pushback (BULWARK_PARAM_LOOT_ASSAULT call shared_fnc_getCurrentParamValue);
};
//Give supports for static guns equal chance of spawning as static gun and autogun bags
if (count LOOT_POOL_STATICSUPPORTS > 0) then {
	_autoGunsCount = count LOOT_POOL_AUTOSTATICGUNS;
	_staticGunsCount = count LOOT_POOL_STATICGUNS;
	_combinedGunbagChance = 0;
	if (_staticGunsCount > 0) then {
		_combinedGunbagChance = _combinedGunbagChance + (BULWARK_PARAM_LOOT_STATICGUN call shared_fnc_getCurrentParamValue);
	};
	if (_autoGunsCount > 0) then {
		_combinedGunbagChance = _combinedGunbagChance + (BULWARK_PARAM_LOOT_AUTOGUN call shared_fnc_getCurrentParamValue);
	};
	if (_autoGunsCount + _staticGunsCount > 0) then {
		randItemTypes pushBack "STATICSUPPORTS";
		randItemChances pushBack _combinedGunbagChance;
	};
};
