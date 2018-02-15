_hPos = 0.70;
_lPos = 0.25;
_weaponList = [
    ["srifle_EBR_F",            "20Rnd_762x51_Mag"],
    ["hgun_ACPC2_F",            "9Rnd_45ACP_Mag"],
    ["LMG_Zafir_ARCO_F",        "150Rnd_762x54_Box"],
    ["arifle_MX_Holo_pointer_F","30Rnd_65x39_caseless_mag"],
    ["srifle_LRR_tna_LRPS_F",   "7Rnd_408_Mag"],
    ["arifle_SPAR_01_GL_snd_F", "30Rnd_556x45_Stanag"],
    ["arifle_MXC_ACO_F",        "30Rnd_65x39_caseless_mag"]
];

private ["_lootBox"];
_lootBox = _this select 0;

if(isNil {_this select 0}) then {
    throw "Lootbox is not being referenced in VM call";
};

if(isNil {_this select 1}) then {
    //
    // Randomly switch weapons until it settles
    //

    // Create weapon holder and position on loot box
    lootWeapon = createVehicle ["GroundWeaponHolder_Scripted", getPos _lootBox, [], 0, "can_collide"];
    lootWeapon setposATL [getPosATL _lootBox select 0, getPosATL _lootBox select 1, ((getPosATL _lootBox select 2) + _lPos) ];
    lootWeapon attachTo [_lootBox];

    // Trigger sound effect
    playSound3D [MISSION_ROOT + "sound\boxspin.wav", lootWeapon, false, getPosASL lootWeapon, 1, 1, 0];

    // Start raising the weapon out of the box
    _coRoutine = [_lootBox, 1] execVM "lootspin.sqf";

    // Start cycling weapons
    spinDelay = 0.01;
    while {spinDelay < 0.5} do {
        lootWeapon addWeaponCargo [selectRandom _weaponList select 0, 1];
        sleep spinDelay;
        clearWeaponCargo lootWeapon;
        spinDelay = spinDelay + 0.02;
    };

    // For safety, stop the weapon from moving.
    terminate _coRoutine;

    // Spin complete, present winning weapon with ammo
    finalWeapon = selectRandom _weaponList;
    lootWeapon addMagazineCargoGlobal [finalWeapon select 1, 1];
    lootWeapon addWeaponCargoGlobal [finalWeapon select 0, 1];
    detach lootWeapon;

    // Hold weapon for 3 seconds
    sleep 3;

    // Start to drop the weapon
    _coRoutine = [_lootBox, 2] execVM "lootspin.sqf";
    sleep 6;
    terminate _coRoutine;

    // Clean up for the next spin
    clearWeaponCargoGlobal lootWeapon;
    deleteVehicle lootWeapon;
} else {
    //
    // Animate the weapon raising and lowering.
    //
    if(_this select 1 == 1) then {
        liftDelay = 0;
        while {liftDelay < 1} do {
            _pos = [_lPos, _hPos, liftDelay, 0.1] call BIS_fnc_lerp;
            lootWeapon setpos [(getpos _lootBox select 0), (getpos _lootBox select 1), _pos];
            sleep 0.03;
            liftDelay = liftDelay + 0.01;
        };
    };

    if(_this select 1 == 2) then {
        liftDelay = 1;
        while {liftDelay > 0} do {
            _pos = [_lPos, _hPos, liftDelay, 0.1] call BIS_fnc_lerp;
            lootWeapon setpos [(getpos _lootBox select 0), (getpos _lootBox select 1), _pos];
            sleep 0.03;
            liftDelay = liftDelay - 0.005;
        };
    };
};
