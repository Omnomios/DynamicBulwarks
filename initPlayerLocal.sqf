player setCustomAimCoef 0.2;
player setUnitRecoilCoefficient 0.5;
player enableStamina FALSE;
"START_KILLPOINTS" call BIS_fnc_getParamValue;
player setVariable ["RevByMedikit", false, true];
player setVariable ["buildItemHeld", false];

// Lower recoil, lower sway, remove stamina on respawn
player addEventHandler ['Respawn',{
    player setCustomAimCoef 0.2;
    player setUnitRecoilCoefficient 0.5;
    player enableStamina FALSE;
}];

//setup Kill Points
_killPoints = player getVariable "killPoints";
if(isNil "_killPoints") then {
    _killPoints = 0;
};
_killPoints = _killPoints + ("START_KILLPOINTS" call BIS_fnc_getParamValue);
player setVariable ["killPoints", _killPoints, true];
[] call killPoints_fnc_updateHud;

// Delete all map markers on clients
{
    _currMarker = toArray _x;
    if(count _currMarker >= 4) then {
        _currMarker resize 8; _currMarker = toString _currMarker;
        if(_currMarker == "bulwark_") then{ deleteMarker _x; };
    };
} foreach allMapMarkers;

//Show the Bulwark label on screen
onEachFrame {
    if(!isNil "bulwarkBox") then {
        _textPos = getPosATL bulwarkBox vectorAdd [0, 0, 1.5];
        drawIcon3D ["", [1,1,1,0.5], _textPos, 1, 1, 0, "Bulwark", 0, 0.04, "RobotoCondensed", "center", true];
    }
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
player removeAllEventHandlers 'HandleDamage';
player addEventHandler ["HandleDamage", {
  _beingRevived = player getVariable "RevByMedikit";
  if ((_this select 4) == "" || lifeState player == "INCAPACITATED" || _beingRevived) then {0} else {_this call bis_fnc_reviveEhHandleDamage;};
}];

waitUntil {!isNil "bulwarkCity"};

[player, ['Take', {
  params ['_unit', '_container', '_item'];
  [_container] remoteExecCall ["loot_fnc_deleteIfEmpty", 2];
}]] remoteExec ['addEventHandler', 0, true];

// kill player if they disconnected and rejoined during a wave
waitUntil {!isnil "playersInWave"};
waitUntil {alive player};

if (getPlayerUID player in playersInWave) then {
    player setDamage 1;
};
