_index = lbCurSel 1500;
shopVehic = objNull;
//["Short Sandbag Wall","Tall Concrete Wall","Land_HBarrier_3_F","Land_HBarrierWall4_F","Land_SandbagBarricade_01_hole_F","Land_Cargo_Patrol_V3_F"];

_shopClass = "";
_shopPrice = 0;

switch (_index) do {
    case 0: {
        _shopClass = "Land_SandbagBarricade_01_half_F"; _shopPrice = 100;
    };
    case 1: {
        _shopClass = "Land_SandbagBarricade_01_hole_F"; _shopPrice = 150;
    };
    case 2: {
        _shopClass = "Land_Mil_WallBig_4m_F"; _shopPrice = 250;
    };
    case 3:{
        _shopClass = "Land_HBarrier_3_F"; _shopPrice = 500;
    };
    case 4: {
        _shopClass = "Land_HBarrierWall4_F"; _shopPrice = 1000;
    };
    case 5: {
        _shopClass = "Land_Cargo_Patrol_V3_F"; _shopPrice = 5000;
    };
};

// Script was passed an invalid number
if(_shopClass == "") exitWith {};

if(player getVariable "killPoints" >= _shopPrice) then {
    [player, _shopPrice] remoteExec ["killPoints_fnc_spend", 2];
    shopVehic = _shopClass createVehicle [0,0,0];
    objPurchase = true
} else {
    [format ["<t size='0.6' color='#ff3300'>NOT ENOUGH POINTS!</t>"], -0, -0.02, 0.2] call BIS_fnc_dynamicText;
    objPurchase = false
};

sleep 0.1;
if (objPurchase) then {
    closeDialog 0;
    shopVehic attachTo [ShopCaller, [0,2,0.02], "Pelvis"];
    dropActID = ShopCaller addAction ["drop", "detach shopVehic; ShopCaller removeAction dropActID; _shopVehicPos = getPos shopVehic; shopVehic setPos [_shopVehicPos select 0, _shopVehicPos select 1, 0]"];
};
