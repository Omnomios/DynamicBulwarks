waitUntil {!isNil "bulwarkBox"};
["Terminate"] call BIS_fnc_EGSpectator;
player setVariable ["buildItemHeld", false];

//Make player immune to fall damage and immune to all damage while incapacitated
player removeAllEventHandlers 'HandleDamage';
player addEventHandler ["HandleDamage", {
  _beingRevived = player getVariable "RevByMedikit";
  if ((_this select 4) == "" || lifeState player == "INCAPACITATED" || _beingRevived) then {0} else {_this call bis_fnc_reviveEhHandleDamage;};
}];

//delete empty continers
[player, ['Take', {
  params ['_unit', '_container', '_item'];
  [_container] remoteExecCall ["loot_fnc_deleteIfEmpty", 2];
}]] remoteExec ['addEventHandler', 0, true];

_player = _this select 0;
removeHeadgear _player;
removeGoggles _player;
removeVest _player;
removeBackpack _player;
removeAllWeapons _player;
removeAllAssignedItems _player;
_player setPosASL ([bulwarkBox] call bulwark_fnc_findPlaceAround);

if(PLAYER_STARTWEAPON) then {
    _player addMagazine "16Rnd_9x21_Mag";
    _player addMagazine "16Rnd_9x21_Mag";
    _player addWeapon "hgun_P07_F";
};

if(PLAYER_STARTMAP) then {
    _player addItem "ItemMap";
    _player assignItem "ItemMap";
    _player linkItem "ItemMap";
};

if(PLAYER_STARTNVG) then {
    _player addItem "Integrated_NVG_F";
    _player assignItem "Integrated_NVG_F";
    _player linkItem "Integrated_NVG_F";
};

if (isClass (configfile >> "CfgVehicles" >> "tf_anarc164")) then {
  _player addItem "tf_anprc152";
};

waituntil {alive _player};

[] remoteExec ["killPoints_fnc_updateHud", 0];
