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

waitUntil {!isNil "bulwarkCity"};

//Make player immune to fall damage and immune to all damage while incapacitated
player removeAllEventHandlers 'HandleDamage';
player addEventHandler ["HandleDamage", {
  _beingRevived = player getVariable "RevByMedikit";
  if ((_this select 4) == "" || lifeState player == "INCAPACITATED" || _beingRevived) then {0} else {_this call bis_fnc_reviveEhHandleDamage;};
}];
