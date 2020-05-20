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
  _type = getText (configFile >> "CfgWeapons" >> _pWeap >> "cursor");
  switch (_type) do {
    case "srifle": {_amount = magSNIPER select 1;};
    case "arifle": {_amount = magASSAULT select 1;};
    case "smg": {_amount = magSMG select 1;};
    case "sgun": {_amount = magSMG select 1;};
    case "mg": {_amount = magMG select 1;};
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
  _ammoPlayer addMagazines [_ammoToAdd, magLAUNCHER select 1];
};

_hWeap = handgunWeapon _ammoPlayer;
if (_hWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _hWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  _ammoPlayer addMagazines [_ammoToAdd, magHANDGUN select 1];
};
