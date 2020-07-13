// Executed LOCALLY when player respawns in a multiplayer mission. 
// This event script will also fire at the beginning of a mission if respawnOnStart is 0 or 1, oldUnit will be objNull in this instance. This script will not fire at mission start if respawnOnStart equals -1. 

waitUntil {sleep 0.2; !(isNil "bulwarkBox")};
["Terminate"] call BIS_fnc_EGSpectator;
player setVariable ["buildItemHeld", false];

"onPlayerRespawn invoked" call shared_fnc_log;

//delete empty continers
// REVIEW: Is this related to the weapons-going-missing bug?
[player, ['Take', {
  params ['_unit', '_container', '_item'];
  [_container] remoteExecCall ["loot_fnc_deleteIfEmpty", 2];
}]] remoteExec ['addEventHandler', 0, true];

//remove and add gear
removeHeadgear player;
removeGoggles player;
removeVest player;
removeBackpack player;
removeAllWeapons player;
removeAllAssignedItems player;
player setPosASL ([bulwarkBox] call bulwark_fnc_findPlaceAround);

if(PLAYER_STARTWEAPON) then {
    _weap = selectRandom LOOT_POOL_HANDGUN;
		_ammo = selectRandom getArray (configFile >> "CfgWeapons" >> _weap >> "magazines");
		for "_i" from 1 to 3 do {player addMagazine _ammo;};
		player addWeapon _weap;
};

if(PLAYER_STARTMAP) then {
    player addItem "ItemMap";
    player assignItem "ItemMap";
    player linkItem "ItemMap";
};

if(PLAYER_STARTNVG) then {
    player addItem "Integrated_NVG_F";
    player assignItem "Integrated_NVG_F";
    player linkItem "Integrated_NVG_F";
};

if (isClass (configfile >> "CfgVehicles" >> "tf_anarc164")) then {
  player addItem "tf_anprc152";
};

waituntil {alive player};

call player_fnc_addStandardActions;

[] remoteExec ["killPoints_fnc_updateHud", 0];