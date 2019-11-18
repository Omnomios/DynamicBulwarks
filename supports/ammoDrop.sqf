/**
*  ammoDrop
*
*  Actor for "FILL AMMO" action menu item
*
*  Domain: Client
**/

_ammoBox = _this select 0;
_ammoPlayer = _this select 1;

[_ammoBox] remoteExec ['removeAllActions', 0];

deleteVehicle _ammoBox;

_pWeap = primaryWeapon _ammoPlayer;
if (_pWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _pWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _amount = 1;
  if (_pWeap in LOOT_WEAPON_MG_POOL) then {_amount = magMG select 1;};
  if (_pWeap in LOOT_WEAPON_SNIPER_POOL) then {_amount = magSNIPER select 1;};
  if (_pWeap in LOOT_WEAPON_SMG_POOL) then {_amount = magSMG select 1;};
  if (_pWeap in LOOT_WEAPON_ASSAULT_POOL) then {_amount = magASSAULT select 1;};
  _ammoPlayer addMagazines [_ammoToAdd, _amount];
  _muzzles = getArray (configfile >> "CfgWeapons" >> _pWeap >> "muzzles");
  _gl = _muzzles select 1;
  if (!isnil "_gl") then {
    _glMag = getArray (configFile >> "CfgWeapons" >> _pWeap >> _gl >> "magazines");
    _glToAdd = _glMag select 0;
    _ammoPlayer addMagazines [_glToAdd, 5];
  };
};

_sWeap = secondaryWeapon _ammoPlayer;
if (_sWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _sWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _ammoPlayer addMagazines [_ammoToAdd, magLAUNCHER select 1];
};

_hWeap = handgunWeapon _ammoPlayer;
if (_hWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _hWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _ammoPlayer addMagazines [_ammoToAdd, magHANDGUN select 1];
};