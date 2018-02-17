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


if(isNil {_this select 0}) then {
    throw "Unkown lootbox position";
};
if(isNil {_this select 1}) then {
    throw "Unkown lootbox position ATL";
};

_boxPos    = _this select 0;
_boxPosATL = _this select 1;

systemChat format ["%1, %2", _boxPos, _boxPosATL];

// Create weapon holder and position on loot box
_weapon = createVehicle ["GroundWeaponHolder_Scripted", _boxPos, [], 0, "can_collide"];
_weapon setposATL [_boxPosATL select 0, _boxPosATL select 1, ((_boxPosATL select 2) + _lPos) ];
//_weapon attachTo [_lootBox];

// Trigger sound effect
playSound3D [MISSION_ROOT + "sound\boxspin.wav", _weapon, false, getPosASL _weapon, 1, 1, 0];

// Start raising the weapon out of the box
_coRoutine = [1] execVM "animateWeapon.sqf";

// Start cycling weapons
_spinDelay = 0.01;
while {_spinDelay < 0.5} do {
    _weapon addWeaponCargo [selectRandom _weaponList select 0, 1];
    sleep _spinDelay;
    clearWeaponCargo _weapon;
    _spinDelay = _spinDelay + 0.02;
};

// For safety, stop the weapon from moving.
terminate _coRoutine;

// Spin complete, present winning weapon with ammo
_finalWeapon = selectRandom _weaponList;
_weapon addMagazineCargoGlobal [_finalWeapon select 1, 1];
_weapon addWeaponCargoGlobal [_finalWeapon select 0, 1];

// Hold weapon for 3 seconds
sleep 3;

// Start to drop the weapon
_coRoutine = [2] execVM "animateWeapon.sqf";
sleep 6;
terminate _coRoutine;

// Clean up for the next spin
clearWeaponCargoGlobal _weapon;
deleteVehicle _weapon;
