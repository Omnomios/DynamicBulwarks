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

    shopVehic attachTo [ShopCaller, [0,3,0.02], "Pelvis"];
    /*
   sleep (1);
   _VecCurrentDir = getDir player;
   _VecCurrentDir = _VecCurrentDir + _shopDir;
   if (_VecCurrentDir > 360) then {
       _VecCurrentDir = _VecCurrentDir - 360;
   };
   if (_VecCurrentDir < 0) then {
       _VecCurrentDir = _VecCurrentDir + 360;
   };
   shopVehic setDir _VecCurrentDir;
   */
    {[shopVehic, _x] remoteExec ["disableCollisionWith", 0];} forEach playableUnits;
    dropActID = ShopCaller addAction ["<t color='#00ffff'>" + "Place Object", "build\heldBuildObject.sqf"]; // Action not attached to objset but attached to player
};
