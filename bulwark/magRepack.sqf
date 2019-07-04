_player = _this select 0;

_playerFullMags = magazinesAmmo _player;

_fullAmmoCountArr = [];
_foundMags = [];
{
    _magName = (_x select 0);

    if ((_foundMags find _magName) == -1) then {
        _fullAmmoCountArr pushback [_magName, 0];
        _foundMags pushback _magName;
    };
}forEach _playerFullMags;

{
    _aMagArray = _x;
    _magClassName = (_aMagArray select 0);
    {
        if (_magClassName isEqualTo (_x select 0)) then {
            _currentRoundCount = _x select 1; // get rounds currently in array
            _roundsinCurrentMag = _aMagArray select 1; // get rounds in current mag
            _totalRounds = _currentRoundCount + _roundsinCurrentMag; //add them
            (_fullAmmoCountArr select _forEachIndex) set [1, _totalRounds]; //delete current entry in array
        };
    }forEach _fullAmmoCountArr;
}forEach _playerFullMags;
_fullAmmoCountArr = _fullAmmoCountArr - [["test",0]];

{
    _magClassName = (_x select 0);
    _roundCount = (_x select 1);
    _magCapacity = getNumber (configFile >> "CfgMagazines" >> _magClassName >> "Count");
    _roundsDivByMagCap = (_roundCount / _magCapacity);
    if (_roundsDivByMagCap > 1) then { // more than one mag
        _player removeMagazines _magClassName;
        for "_magToAddIter" from 1 to (floor _roundsDivByMagCap) do {
            _player addMagazine _magClassName;
        };
        _remainingRounds = _roundCount - (floor _roundsDivByMagCap * _magCapacity);
        if (_remainingRounds != 0) then {
            _player addMagazine [_magClassName, _remainingRounds];
        };
    };
}forEach _fullAmmoCountArr;

if (!(_foundMags isEqualTo [])) then {
    _player playMove "AinvPknlMstpSnonWnonDr_medic2";
};
