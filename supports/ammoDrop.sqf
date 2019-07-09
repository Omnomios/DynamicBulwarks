/**
*  ammoDrop
*
*  Actor for "FILL AMMO" action menu item
*
*  Domain: Client
**/

_ammoBox = _this select 0;
ammoPlayer = _this select 1;

[_ammoBox] remoteExec ['removeAllActions', 0];

deleteVehicle _ammoBox;

pWeap = primaryWeapon ammoPlayer;
if (pWeap != "") then {
    _ammoArray = getArray (configFile >> "CfgWeapons" >> pWeap >> "magazines");
    _roundCount = 0;
    _maxRounds = 10000;
    _currentRounds = 0;
    while {_currentRounds < _maxRounds} do {
        _ammoToAdd = selectRandom _ammoArray;
        _roundCount = getNumber (configFile >> "CfgMagazines" >> _ammoToAdd >> "Count");
        if (_roundCount <= 4) then {
            _maxRounds = 15;
        };
        if (_roundCount >= 5 && _roundCount <= 10) then {
            _maxRounds = 25;
        };
        if (_roundCount > 10 && _roundCount <= 40) then {
            _maxRounds = 90;
        };
        if (_roundCount > 40 && _roundCount <= 70) then {
            _maxRounds = 150;
        };
        if (_roundCount > 70 && _roundCount <= 100) then {
            _maxRounds = 200;
        };
        if (_roundCount > 100 && _roundCount <= 150) then {
            _maxRounds = 300;
        };
        if (_roundCount > 150) then {
            _maxRounds = 400;
        };
        ammoPlayer addMagazines [_ammoToAdd, 1];
        _currentRounds = _currentRounds + _roundCount;
    };
    _pWeapCfgEntries = [ configFile >> "CfgWeapons" >> pWeap, 10] call BIS_fnc_returnChildren;
    _loop = 0;
    {
        if (configName (_x >> "magazines") isEqualTo "magazines") then {
            _secAmmo = getArray (_x >> "magazines");
            _ammoToAdd = selectRandom _secAmmo;
            ammoPlayer addMagazines [_ammoToAdd, 2];
        };
        _loop = _loop + 1;
    }forEach _pWeapCfgEntries
};

_sWeap = secondaryWeapon ammoPlayer;
if (_sWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _sWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  ammoPlayer addMagazines [_ammoToAdd, 3];
};

_hWeap = handgunWeapon ammoPlayer;
if (_hWeap != "") then {
  _ammoArray = getArray (configFile >> "CfgWeapons" >> _hWeap >> "magazines");
  _ammoToAdd = selectRandom _ammoArray;
  ammoPlayer addMagazines [_ammoToAdd, 3];
};
