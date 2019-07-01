/**
*  fn_ragePack
*
*  Applies post processing to screen and gives player godmode, infinite ammo, and faster run speed
*
*  Domain: Client
**/

// Screen effects
0 = ["ColorInversion", 2500, [0.5, 0.5, 0.5]] spawn { params ["_name", "_priority", "_effect", "_handle"];
    while {
        _handle = ppEffectCreate [_name, _priority];
        _handle < 0
    } do {
        _priority = _priority + 1;
    };
    _handle ppEffectEnable true;
    _handle ppEffectAdjust _effect;
    _handle ppEffectCommit 5;
    waitUntil {ppEffectCommitted _handle};
    uiSleep 24;
    comment "admire effect for a sec";
    _handle ppEffectEnable false;
    ppEffectDestroy _handle;
};
0 = ["ChromAberration", 200, [0.05, 0.05, true]] spawn { params ["_name", "_priority", "_effect", "_handle"];

    while {
        _handle = ppEffectCreate [_name, _priority];
        _handle < 0
    } do {
        _priority = _priority + 1;
    };
    _handle ppEffectEnable true;
    _handle ppEffectAdjust _effect;
    _handle ppEffectCommit 5;
    waitUntil {ppEffectCommitted _handle};
    uiSleep 24;
    comment "admire effect for a sec";
    _handle ppEffectEnable false;
    ppEffectDestroy _handle;
};

// Player modifier

[player, "rageSoundExternal"] remoteExec ["sound_fnc_say3DGlobal", 0];
playSound ["rageSoundInternal", false];
[] spawn {
    // Turn on RAGE mode
    player setVariable ["RevByMedikit", true, true];
    _unlimitedAmmo = player addeventhandler ["fired", {player setAmmo [currentWeapon player, 999]}];
    player setAnimSpeedCoef 2;
    enableCamShake true;
    addCamShake [4, 30, 15];

    Sleep 29;

    // Turn off RAGE mode
    player setAnimSpeedCoef 1;
    player removeEventHandler ["fired", _unlimitedAmmo];
    player setAmmo [currentWeapon player, 0];
    player setVariable ["RevByMedikit", false, true];
    player setDamage 0.4;

    titleText ["", "BLACK IN", 1];
};
