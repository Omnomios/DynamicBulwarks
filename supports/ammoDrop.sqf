/**
*  ammoDrop
*
*  Actor for "FILL AMMO" action menu item
*
*  Domain: Client
**/

_ammoBox = _this select 0;
_ammoPlayer = _this select 1;

deleteVehicle _ammoBox;

_pWeap = primaryWeapon _ammoPlayer;
if (_pWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _pWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _ammoPlayer addMagazines [_ammoToAdd, 3];
};

_sWeap = secondaryWeapon _ammoPlayer;
if (_sWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _sWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _ammoPlayer addMagazines [_ammoToAdd, 3];
};

_hWeap = handgunWeapon _ammoPlayer;
if (_hWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _hWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _ammoPlayer addMagazines [_ammoToAdd, 3];
};
