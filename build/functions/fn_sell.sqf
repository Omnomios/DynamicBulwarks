_object = _this select 0;
_player = _this select 1;

_shopPrice = _object getVariable ["shopPrice", 0];

//hint "sold for " + _shopPrice;

//[_player, _shopPrice] call killPoints_fnc_add;

deleteVehicle (_object);