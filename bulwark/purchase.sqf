/**
*  bulwark/purchase
*
*  Actor for the "Purchase building" dialog button
*
*  Domain: Client
**/

_index = lbCurSel 1500;
shopVehic = objNull;

_shopPrice = (BULWARK_BUILDITEMS select _index) select 0;
_shopName  = (BULWARK_BUILDITEMS select _index) select 1;
_shopClass = (BULWARK_BUILDITEMS select _index) select 2;
_shopDir   = (BULWARK_BUILDITEMS select _index) select 3;
_VecRadius = (BULWARK_BUILDITEMS select _index) select 4;
_vechAi    = (BULWARK_BUILDITEMS select _index) select 5;

// Script was passed an invalid number
if(_shopClass == "") exitWith {};

if(player getVariable "killPoints" >= _shopPrice && !(player getVariable "buildItemHeld")) then {
    [player, _shopPrice] remoteExec ["killPoints_fnc_spend", 2];
    if (_vechAi) then {
        _vechWithAi = [[0,0,300], 0, _shopClass, west] call BIS_fnc_spawnVehicle;
        shopVehic = _vechWithAi select 0;
    }else{
        shopVehic = _shopClass createVehicle [0,0,0];
    };
    shopVehic setVariable ["shopPrice", _shopPrice, true];
    shopVehic setVariable ["Radius", _VecRadius, true];
    objPurchase = true;
} else {
    if(player getVariable "killPoints" < _shopPrice) then {
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

    // If it's a container, make sure it's empty
    clearItemCargoGlobal shopVehic;
    clearWeaponCargoGlobal shopVehic;
    clearMagazineCargoGlobal shopVehic;
    clearBackpackCargoGlobal shopVehic;

	[shopVehic, ShopCaller, [0,_VecRadius + 1.5,0.02], _shopDir] call build_fnc_pickup;
};
