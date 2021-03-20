// This function is called once when the game starts (after the lobby)

"Player waiting for game start" call shared_fnc_log;
waitUntil {!isNil "gameStarted"};

player setDamage 0;

startLoadingScreen ["Entering defense perimeter..."];

"Initializing player" call shared_fnc_log;

private _isCurator = getAssignedCuratorLogic player;
if (!isNull _isCurator) then {
    private _curatorUnit = (createGrouP sideLogic) createUnit ["modulecurator_f",[0,0,0],[],0,"CAN_COLLIDE"];
    {_curatorUnit setCuratorCoef [_x,0];} forEach ["place","edit","delete","destroy","group","synchronize"];
    player setVariable ["curatorUnit", _curatorUnit];
    format ["Player %1 is Zeus", player] call shared_fnc_log;
    player addEventHandler ["Respawn", {
    	params ["_unit", "_corpse"];
        player call player_fnc_reassignCurator;
    }];
};

// Damage handling:
// * Make player immune to fall damage
// * Make player immune to all damage while incapacitated
// * Make player immune if they've used the instant-revive with a medikit
// * Make player drop any held items if they are incapacitated
player removeAllEventHandlers "HandleDamage";
player addEventHandler ["HandleDamage", {
    params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
    format ["Dmg: %1 From: %2 At: %3 Part: %4 Projectile: %5", _damage, _source, _selection, _hitIndex, _projectile] call shared_fnc_log;
    TEAM_DAMAGE = missionNamespace getVariable "TEAM_DAMAGE";
    private _beingRevived = player getVariable "RevByMedikit";
    private _players = allPlayers;
    private _soakDamage = false;
    if (_projectile == "" || 
        lifeState player == "INCAPACITATED" || 
        _beingRevived || 
        (_source in _players && !TEAM_DAMAGE && !(_source isEqualTo player))) then {
        // "Invulnerable by status" call shared_fnc_log;
        _soakDamage = true;
    } else {
        if (_damage + damage player >= 1) then {
            
            // Drop any held objects
            // REVIEW: This doesn't *always* mean the player is going to go down
            // I don't think.  
            player call build_fnc_dropHeldObject;

            // See if we can instant-revive
            private _medikit = call CWS_GetMedikitEquivalent;
            if (!isNil "_medikit") then {
                format ["Instant revive by medikit for player %1", player] call shared_fnc_log;
                player removeItem _medikit;
                player setVariable ["RevByMedikit", true, true];
                player playActionNow "agonyStart";
                player playAction "agonyStop";
                player setDamage 0;
                [player] remoteExec ["bulwark_fnc_revivePlayer", 2];
                _soakDamage = true;
            };
        };
    };
    if(!_soakDamage) then {
        //"Normal damage handling" call shared_fnc_log;
        _this call bis_fnc_reviveEhHandleDamage;
    } else {
        0
    };
}];

private _newLoc = [bulwarkBox] call bulwark_fnc_findPlaceAround;
player setPosASL _newLoc;

endLoadingScreen;
[1, "BLACK", 2, 1] call BIS_fnc_fadeEffect;

player setVariable ["RevByMedikit", false, true];
player setVariable ["buildItemHeld", false];

/*
// Delete all map markers on clients
{
    _currMarker = toArray _x;
    if(count _currMarker >= 4) then {
        _currMarker resize 8; _currMarker = toString _currMarker;
        if(_currMarker == "bulwark_") then{ deleteMarker _x; };
    };
} foreach allMapMarkers;
*/
hitMarkers = [];

//Show the Bulwark label on screen
onEachFrame {
    if(!isNil "bulwarkBox") then {
        _textPos = getPosATL bulwarkBox vectorAdd [0, 0, 1.5];
        drawIcon3D ["", [1,1,1,0.5], _textPos, 1, 1, 0, "Bulwark", 0, 0.04, "RobotoCondensed", "center", true];
    };

    if (HITMARKERPARAM == 1) then {
    {
        _pos    = _x select 0;
        _label  = _x select 1;
        _unit   = _x select 2;
        _age    = _x select 3;
        _active = _x select 4;
        _colour = _x select 5;

        if(_active) then {
            _x set [3, _age + 1];

            _alpha = 1;
            _scale = 0;
            if(_age > 0 && _age <= 10) then {
                _scale = 0.035 * _age / 10;
            };
            if(_age > 10) then {
                _scale = 0.035;
            };
            if(_age > 30 && _age <= 40) then {
                _alpha = 1 - ((_age - 40) / 10);
            };
            _textPos = _pos vectorAdd [0, 0, 1 +_age / 100];

            if(_age > 40) then {_x set [4, false];};
            drawIcon3D ["", [_colour select 0, _colour select 1, _colour select 2, _alpha], _textPos, 1, 1, 0, format ["%1", _label], 0, _scale, "RobotoCondensed", "center", false];
        };
    } foreach hitMarkers;
    };
};

player createDiarySubject ["DynamicBulwarks","Dynamic Bulwarks","preview.paa"];

player createDiaryRecord ["DynamicBulwarks", ["Looting", "
<br />
Loot such as weapons, ammo, clothing and equipement can be found in buildings. Almost every item in the game (and any mods you have loaded) should be possible to find.
<br />
<br />
There are also some special loot items that can be found:
<br />
<br />
<font color='#FFCC00'>Loot Drone</font> - Find the purple drone box to reveal all the loot on the map
<br />
<br />
<font color='#FFCC00'>Cash Money</font> - Finding the pile of cash gives you points based on the kill points multiplier (default 5000).
<br />
<br />
<font color='#FFCC00'>Spin Box</font> - An innocuous wooden box that's definitely not a ripoff from a popular Zombie game... If you find the box you can spin it for random weapons, for a price of course. Be warned, eventually the box will steal your money and move to a new location.
<br />
<br />
<font color='#FFCC00'>Satellite Dish</font> - Unlocks the Support Menu at the Bulwark Box and rewards you with Points! One will spawn each wave until found. (Needs to be enabled in mission paramters)
"]];


player createDiaryRecord ["DynamicBulwarks", ["Supports", "<br />Supports can be purchased at the Bulwark Box. To use a Support bring up the Support menu <font color='#FFCC00'>(Default keys '0' then '8')</font>.
<br />
<br />
<br />
<font color='#FFCC00'>Recon UAV</font> - Shows All hostiles on the map until shot down
<br />
<br />
<font color='#FFCC00'>Paratroopers</font> - AI Reinforcements paradrop wherever you are looking or on a selected location on the map
<br />
<br />
<font color='#FFCC00'>Predator Drone</font> - Take control of a UAV armed with 6 Skalpel Missiles (Drone self destructs when out of ammo)
<br />
<br />
<font color='#FFCC00'>Missile CAS</font> - Calls in an airstrike wherever you are looking or on a selected location on the map
<br />
<br />
<font color='#FFCC00'>Mine Cluster Shell</font> - Call in a Mine Cluster Shell to create an instant mine field wherever you are looking or on a selected location on the map
<br />
<br />
<font color='#FFCC00'>Rage Stimpack</font> - No need to reload, unlimited ammo, invicibility and increased speed for a short time.
<br />
<br />
<font color='#FFCC00'>ARMAKART TM</font> - 1 minute in an invincible Go-Kart with an automatically targeting HMG
<br />
<br />
<font color='#FFCC00'>Emergency Teleport</font> - Teleports you back to the Bulwark Box but it's unstable and will create an explosion at your original position
<br />
<br />
<font color='#FFCC00'>Mind Control Gas</font> - Deploy a gas canister wherever you are looking or on a selected location on the map. Units that enter the gas will join your team! That's good! But the gas is fatal and the units die at the end of the wave.... That's bad.
<br />
<br />
<br />
Some Supports can be targeted by just looking at the target when you call the Support. Alternatively, you can use your map to target the support by openning your map and bring up the support menu. Have the support highlighted and then middle click your mouse on the map to have the support target that location."]];

player createDiaryRecord ["DynamicBulwarks", ["How to Play", "<img image='preview.paa' height=175 width=350/>
<br />
<br />
<font color='#FFCC00'>You are unarmed and there are hostile untis moving towards you. Survive for as many waves as possible.</font>
<br />
<br />
Search buildings for weapons, equipment and supplies. Build a Bulwark and defend it for as long as you can!
<br />
<br />
Kill enemies to earn points to spend at the Bulwark Box Shop (in the action menu on the Bulwark Box). Points can be used to purchase Building Supplies and Supports. Purchased Supports can be used via the Supports menu (0 - 8 on keyboard).
<br />
<br />
Allies will make regular ammo drops! Initially marked with blue smoke, find these wooden crates to get much needed ammo for your weapon.
<br />
<br />
If you are knocked unconscious but you have a Medikit in your inventory you will be automatically resurected within 10 seconds. 15 FAKs can be converted into a Medikit at the Bulwark Box.
<br />
<br />
<font color='#FFCC00'>You won't survive this fight but take as many of the bastards with you as you can!</font>"]];

//Make player immune to fall damage and immune to all damage while incapacitated
// waitUntil {!isNil "TEAM_DAMAGE"};
// player removeAllEventHandlers 'HandleDamage';
// player addEventHandler ["HandleDamage", {
//   _beingRevived = player getVariable "RevByMedikit";
//   _players = allPlayers;
//   if ((_this select 4) == "" || lifeState player == "INCAPACITATED" || _beingRevived || ((_this select 3) in _players && !TEAM_DAMAGE && !((_this select 3) isEqualTo player))) then {0} else {_this call bis_fnc_reviveEhHandleDamage;};
// }];


//
// FAK to Medikit conversion
//
player addEventHandler ["Put", {
    params ["_unit", "_container", "_item"];
    format ["Checking %1 against FAKs", _item] call shared_fnc_log;
    if (_container == bulwarkBox) then {
        private _fakEquivalents = ["FirstAidKit", (call bulwark_fnc_getFAKClass)];
        if (_item in _fakEquivalents) then {
            private _cargoItems = getItemCargo bulwarkBox;
            private _itemsToRemove = [];
            private _fakCount = 0;
            {
                if (_x in _fakEquivalents) then {
                    private _storedCount = (_cargoItems select 1) select _forEachIndex;
                    format ["Found %1 %2 in bulwark", _storedCount, _x] call shared_fnc_log;
                    private _countToRemove = _storedCount min (15 - _fakCount);
                    _fakCount = _fakCount + _countToRemove;
                    if (_countToRemove > 0) then {
                        _itemsToRemove pushBack [_x, _countToRemove];
                    };
                };
            } forEach (_cargoItems select 0);

            if (_fakCount == 15) then {
                "Converting FAKs to Medikit" call shared_fnc_log;
                {
                    [bulwarkBox, _x select 0, _x select 1, false] call CBA_fnc_removeItemCargo;
                } forEach _itemsToRemove;
                bulwarkBox addItemCargoGlobal [call bulwark_fnc_getMedikitClass, 1];
            };
        };
    };
}];

call player_fnc_addStandardActions;
call player_fnc_addMagRepack;

// kill player if they disconnected and rejoined during a wave
_buildPhase = bulwarkBox getVariable ["buildPhase", true];
waitUntil {alive player && !isnil "playersInWave" && !isnil "attkWave"};

if (getPlayerUID player in playersInWave && attkWave > 0 && !_buildPhase) then {
    player setDamage 1;
};



