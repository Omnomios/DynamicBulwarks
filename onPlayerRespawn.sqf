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
    _weap = selectRandom LOOT_WEAPON_HANDGUN_POOL;
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

//Disarm mines and explosives
_disarm =
{
    _explosive = nearestObject [player, "TimeBombCore"];
	deleteVehicle _explosive;
    _explosiveClass = typeOf _explosive;
    _count =  count (configFile >> "CfgMagazines");
    for "_x" from 0 to (_count-1) do {
        _item=((configFile >> "CfgMagazines") select _x);
		if (getText (_item >> "ammo") isEqualTo _explosiveClass) then {
			player addMagazine configName _item;
		};
    };
	player playAction "PutDown";
};
player addAction ["Disarm Explosive",_disarm,nil,2,false,true,"","(player distance2D nearestObject [player, 'TimeBombCore']) <= 1.6"];
_disarmMine =
{
    _explosive = nearestObject [player, "mineBase"];
	deleteVehicle _explosive;
    player playAction "PutDown";
};
player addAction ["Disarm Mine",_disarmMine,nil,2,false,true,"","(player distance2D nearestObject [player, 'mineBase']) <= 1.6"];

[] remoteExec ["killPoints_fnc_updateHud", 0];