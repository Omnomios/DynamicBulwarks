/**
*  spin/main
*
*  Actor for the "Spin the box" action menu item
*
*  Domain: Client
**/
_hPos = 0.70;
_lPos = 0.35;

_weaponList = List_AllWeapons;


if(isNil {_this select 0}) then {
    throw "Unkown lootbox position";
};
if(isNil {_this select 1}) then {
    throw "Unkown lootbox position ATL";
};

_boxPos    = _this select 0;
_boxPosATL = _this select 1;

// Create weapon holder and position on loot box
_weapon = createVehicle ["GroundWeaponHolder_Scripted", _boxPos, [], 0, "can_collide"];
_weapon setPosATL [_boxPosATL select 0, _boxPosATL select 1, ((_boxPosATL select 2) + _lPos) ];
_weapon enableSimulationGlobal false;

// Trigger sound effect
playSound3D ["boxSpin", _weapon, false, getPosASL _weapon, 1, 1, 0];

// Start raising the weapon out of the box
_coRoutine = [1, _boxPosATL, _lPos, _hPos, _weapon] execVM "loot\spin\animateWeapon.sqf";

// Start cycling weapons
_spinDelay = 0.01;
while {_spinDelay < 0.33} do {
    _weapon addWeaponCargo [selectRandom _weaponList, 1];
    sleep _spinDelay;
    clearWeaponCargo _weapon;
    _spinDelay = _spinDelay + 0.01;
};

// For safety, stop the weapon from moving.
terminate _coRoutine;

// Spin complete, present winning weapon with ammo
_weapon enableSimulationGlobal true;
_finalWeapon = selectRandom _weaponList;

_ammoArray = getArray (configFile >> "CfgWeapons" >> _finalWeapon >> "magazines");
_weapon addMagazineCargoGlobal [selectRandom _ammoArray, 2];
_weapon addWeaponCargoGlobal [_finalWeapon, 1];

// Hold weapon for 3 seconds
sleep 3;

// Start to drop the weapon
_coRoutine = [2, _boxPosATL, _lPos, _hPos, _weapon] execVM "loot\spin\animateWeapon.sqf";
sleep 6;
terminate _coRoutine;

// Clean up for the next spin
clearWeaponCargoGlobal _weapon;
deleteVehicle _weapon;
