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

    // If it's a container, make sure it's empty
    clearItemCargoGlobal shopVehic;
    clearWeaponCargoGlobal shopVehic;
    clearMagazineCargoGlobal shopVehic;
    clearBackpackCargoGlobal shopVehic;


    shopVehic attachTo [ShopCaller, [0,2,0.02], "Pelvis"];
    {[shopVehic, _x] remoteExec ["disableCollisionWith", 0];} forEach playableUnits;
    dropActID = ShopCaller addAction [ //adds actions to move up, move down and delete the purchased object after it's been placed
      "<t color='#00ffff'>" + "Place Object",
      "detach shopVehic;
      {[shopVehic, _x] remoteExec ['enableCollisionWith', 0];} forEach playableUnits;
      ShopCaller removeAction dropActID;
      shopVehic setVehiclePosition [shopVehic, [], 0, 'CAN_COLLIDE'],
      [shopVehic, ['<t color=''#ff0000''>' + 'Remove Object', 'deleteVehicle (_this select 0)','',1,false,false,'true','true',5]] remoteExec ['addAction', 0];
      [shopVehic, ['<t color=''#00ff00''>' + 'Move Down', '
        _shopVehicPos = getPos (_this select 0);
        _thisShopVehic = _this select 0;
        _thisShopVehic setPos [_shopVehicPos select 0, _shopVehicPos select 1, (_shopVehicPos select 2) - 0.5];
      ','',2,false,false,'true','true',5]] remoteExec ['addAction', 0];
      [shopVehic, ['<t color=''#0000ff''>' + 'Move Up', '
        _shopVehicPos = getPos (_this select 0);
        _thisShopVehic = _this select 0;
        _thisShopVehic setPos [_shopVehicPos select 0, _shopVehicPos select 1, (_shopVehicPos select 2) + 0.5];
      ','',2,false,false,'true','true',5]] remoteExec ['addAction', 0];
      "
    ];
    if (typeOf shopVehic == "Land_Cargo_Patrol_V3_F") then {
      _shopVehicPos = getPos shopVehic;
      shopVehic setPos [_shopVehicPos select 0, _shopVehicPos select 1, (_shopVehicPos select 2) - 0.5];
    };
};
