/**
*  ammoDrop
*
*  Actor for "FILL AMMO" action menu item
*
*  Domain: Client
**/
#include "..\shared\bulwark.hpp"
_ammoBox = _this select 0;
_ammoPlayer = _this select 1;

[_ammoBox] remoteExec ['removeAllActions', 0];

deleteVehicle _ammoBox;

_pWeap = primaryWeapon _ammoPlayer;
if (_pWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _pWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _amount = 1;
  _type = getText (configFile >> "CfgWeapons" >> _pWeap >> "cursor");
  switch (_type) do {
    case "srifle": {_amount = BULWARK_PARAM_AMMO_SNIPERMAX call shared_fnc_getCurrentParamValue};
    case "arifle": {_amount = BULWARK_PARAM_AMMO_ASSAULTMAX call shared_fnc_getCurrentParamValue};
    case "smg": {_amount = BULWARK_PARAM_AMMO_SMGMAX call shared_fnc_getCurrentParamValue};
    case "sgun": {_amount = BULWARK_PARAM_AMMO_SHOTGUNMAX call shared_fnc_getCurrentParamValue};
    case "mg": {_amount = BULWARK_PARAM_AMMO_MGMAX call shared_fnc_getCurrentParamValue};
  };
  _ammoPlayer addMagazines [_ammoToAdd, _amount];
  _muzzles = getArray (configfile >> "CfgWeapons" >> _pWeap >> "muzzles");
  _gl = _muzzles select 1;
  if !(isnil "_gl" || {_gl == "SAFE"}) then {
    _glMag = getArray (configFile >> "CfgWeapons" >> _pWeap >> _gl >> "magazines");
    _glToAdd = _glMag select 0;
    _ammoPlayer addMagazines [_glToAdd, 5];
  };
};

_sWeap = secondaryWeapon _ammoPlayer;
if (_sWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _sWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _ammoPlayer addMagazines [_ammoToAdd, BULWARK_PARAM_AMMO_LAUNCHERMAX call shared_fnc_getCurrentParamValue];
};

_hWeap = handgunWeapon _ammoPlayer;
if (_hWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _hWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _ammoPlayer addMagazines [_ammoToAdd, BULWARK_PARAM_AMMO_HANDGUNMAX call shared_fnc_getCurrentParamValue];
};
