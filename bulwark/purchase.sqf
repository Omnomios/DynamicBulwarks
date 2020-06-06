/**
*  bulwark/purchase
*
*  Actor for the "Purchase building" dialog button
*
*  Domain: Client
**/

_index = lbCurSel 1500;
private _shopVehic = objNull;
private _buildItem = (BULWARK_BUILDITEMS select _index);

_shopPrice = (BULWARK_BUILDITEMS select _index) select 0;
_shopName  = (BULWARK_BUILDITEMS select _index) select 1;
_shopClass = (BULWARK_BUILDITEMS select _index) select 2;

// Script was passed an invalid number
if(_shopClass == "") exitWith {};

private _killPoints = [player] call killPoints_fnc_get;
if(_killPoints >= _shopPrice && !(player call build_fnc_isHoldingObject)) then {
    [player, _shopPrice] remoteExec ["killPoints_fnc_spend", 2];
    [player, _buildItem] remoteExec ["build_fnc_doCreate", 2];
    objPurchase = true;
} else {
    if(_killPoints < _shopPrice) then {
        [format ["<t size='0.6' color='#ff3300'>Not enough points for %1!</t>", _shopName], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;
        objPurchase = false;
    }else{
        [format ["<t size='0.6' color='#ff3300'>You're already carrying an object!</t>", _shopName], -0, -0.02, 2, 0.1] call BIS_fnc_dynamicText;
        objPurchase = false;
    };
};

sleep 0.1;

if (objPurchase) then {
    closeDialog 0;
};
