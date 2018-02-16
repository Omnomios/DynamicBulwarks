_ammoBox = _this select 0;
_ammoPlayer = _this select 1;

deleteVehicle _ammoBox;

_pWeap = primaryWeapon _ammoPlayer;

_ammoArray = getArray (configFile >> "CfgWeapons" >> _pWeap >> "magazines");

_ammoToAdd = selectRandom _ammoArray;

_ammoPlayer addMagazines [_ammoToAdd, 4];