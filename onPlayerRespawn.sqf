waitUntil {!isNil "bulwarkBox"};
["Terminate"] call BIS_fnc_EGSpectator;
player setVariable ["buildItemHeld", false];

//Make player immune to fall damage and immune to all damage while incapacitated
waitUntil {!isNil "TEAM_DAMAGE"};
player removeAllEventHandlers 'HandleDamage';
player addEventHandler ["HandleDamage", {
    _beingRevived = player getVariable "RevByMedikit";
    TEAM_DAMAGE = missionNamespace getVariable "TEAM_DAMAGE";
    _incDamage = _this select 2;
    _hitpoint = _this select 5;
    _currentPointDamage = player getHitIndex _hitpoint;
    _totalDamage = _incDamage + _currentPointDamage;
    _playerItems = items player;
    _players = allPlayers;
    if ((_this select 4) == "" || lifeState player == "INCAPACITATED" || _beingRevived || ((_this select 3) in _players && !TEAM_DAMAGE && !((_this select 3) isEqualTo player))) then {
        0
    } else {
        if (_totalDamage >= 0.89) then {
        _playerItems = items player;
            if ("Medikit" in _playerItems) then {
            player removeItem "Medikit";
            player setVariable ["RevByMedikit", true, true];
            player playActionNow "agonyStart";
            player playAction "agonyStop";
            player setDamage 0;
            [player] remoteExec ["bulwark_fnc_revivePlayer", 2];
            0;
            }else{
                _this call bis_fnc_reviveEhHandleDamage;
            };
        } else {
            _this call bis_fnc_reviveEhHandleDamage;
        };
    };
}];

//delete empty continers
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
    player addMagazine "16Rnd_9x21_Mag";
    player addMagazine "16Rnd_9x21_Mag";
    player addWeapon "hgun_P07_F";
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
