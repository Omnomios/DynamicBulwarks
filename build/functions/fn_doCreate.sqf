params [ "_player", "_buildItem"];

private _shopPrice  = _buildItem select 0;
private _shopName   = _buildItem select 1;
private _shopClass  = _buildItem select 2;
private _shopDir    = _buildItem select 3;
private _VecRadius  = _buildItem select 4;
private _explosive  = _buildItem select 5;
private _invincible = _buildItem select 6;
private _vechAi     = _buildItem select 7;

private _shopVehicle = objnull;

if (_vechAi) then {
    _vechWithAi = [[0,0,300], 0, _shopClass, west] call BIS_fnc_spawnVehicle;
    _shopVehicle = _vechWithAi select 0;
}else{
    _shopVehicle = _shopClass createVehicle [0,0,0];
};

_shopVehicle setVariable ["shopPrice", _shopPrice, true];
_shopVehicle setVariable ["Radius", _VecRadius, true];

//Check if Explosive	
if (_explosive == 1) then {
    _shopVehicle setDamage 0.9;
    _shopVehicle addEventHandler ["Killed", killPoints_fnc_hitBoom];	
};
    //check if invincible
if (_invincible == 1) then {
    _shopVehicle allowDamage false;
};

// If it's a container, make sure it's empty
clearItemCargoGlobal _shopVehicle;
clearWeaponCargoGlobal _shopVehicle;
clearMagazineCargoGlobal _shopVehicle;
clearBackpackCargoGlobal _shopVehicle;

[_player, _shopVehicle, [0,_VecRadius + 1.5,0.02], _shopDir] call build_fnc_doPickup;
