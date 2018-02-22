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
_shopName = (BULWARK_BUILDITEMS select _index) select 0;
_shopClass = (BULWARK_BUILDITEMS select _index) select 2;

// Script was passed an invalid number
if(_shopClass == "") exitWith {};

if(player getVariable "killPoints" >= _shopPrice) then {
    [player, _shopPrice] remoteExec ["killPoints_fnc_spend", 2];
    shopVehic = _shopClass createVehicle [0,0,0];
    objPurchase = true;
} else {
    [format ["<t size='0.6' color='#ff3300'>Not enough points for %1!</t>", _shopName], -0, -0.02, 0.2] call BIS_fnc_dynamicText;
    objPurchase = false;
};

sleep 0.1;
if (objPurchase) then {
  closeDialog 0;
  shopVehic attachTo [ShopCaller, [0,2,0.02], "Pelvis"];
  {[shopVehic, _x] remoteExec ["disableCollisionWith", 0];} forEach playableUnits;
  dropActID = ShopCaller addAction ["Place Object",
    "detach shopVehic;
    {[shopVehic, _x] remoteExec ['enableCollisionWith', 0];} forEach playableUnits;
    ShopCaller removeAction dropActID;
    shopVehic setVehiclePosition [shopVehic, [], 0, 'CAN_COLLIDE'],[shopVehic, ['Remove', 'deleteVehicle (_this select 0)']] remoteExec ['addAction', 0];"];
};
