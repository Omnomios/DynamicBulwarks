_index = lbCurSel 1500;
shopVehic = objNull;
//["Short Sandbag Wall","Tall Concrete Wall","Land_HBarrier_3_F","Land_HBarrierWall4_F","Land_SandbagBarricade_01_hole_F","Land_Cargo_Patrol_V3_F"];

switch (_index) do
{
    case 0:
    {
      if(player getVariable "killPoints" >= 100) then {
        [player, 100] call killPoints_fnc_spend;
        shopVehic = "Land_SandbagBarricade_01_half_F" createVehicle [0,0,0];
        objPurchase = true
      } else {
        [format ["<t size='0.6' color='#ff3300'>NOT ENOGH POINTS!</t>"], -0, -0.02, 0.2] call BIS_fnc_dynamicText;
        objPurchase = false
      };
    };

    case 2:
    {
      if(player getVariable "killPoints" >= 250) then {
        [player, 100] call killPoints_fnc_spend;
        shopVehic = "Land_Mil_WallBig_4m_F" createVehicle [0,0,0];
        objPurchase = true
      } else {
        [format ["<t size='0.6' color='#ff3300'>NOT ENOGH POINTS!</t>"], -0, -0.02, 0.2] call BIS_fnc_dynamicText;
        objPurchase = false
      };
    };

    case 3:
    {
      if(player getVariable "killPoints" >= 500) then {
        [player, 100] call killPoints_fnc_spend;
        shopVehic = "Land_HBarrier_3_F" createVehicle [0,0,0];
        objPurchase = true
      } else {
        [format ["<t size='0.6' color='#ff3300'>NOT ENOGH POINTS!</t>"], -0, -0.02, 0.2] call BIS_fnc_dynamicText;
        objPurchase = false
      };
    };
    case 4:
    {
      if(player getVariable "killPoints" >= 1000) then {
        [player, 100] call killPoints_fnc_spend;
        shopVehic = "Land_HBarrierWall4_F" createVehicle [0,0,0];
        objPurchase = true
      } else {
        [format ["<t size='0.6' color='#ff3300'>NOT ENOGH POINTS!</t>"], -0, -0.02, 0.2] call BIS_fnc_dynamicText;
        objPurchase = false
      };
    };
    case 1:
    {
      if(player getVariable "killPoints" >= 150) then {
        [player, 100] call killPoints_fnc_spend;
        shopVehic = "Land_SandbagBarricade_01_hole_F" createVehicle [0,0,0];
        objPurchase = true
      } else {
        [format ["<t size='0.6' color='#ff3300'>NOT ENOGH POINTS!</t>"], -0, -0.02, 0.2] call BIS_fnc_dynamicText;
        objPurchase = false
      };
    };
    case 5:
    {
      if(player getVariable "killPoints" >= 5000) then {
        [player, 100] call killPoints_fnc_spend;
        shopVehic = "Land_Cargo_Patrol_V3_F" createVehicle [0,0,0];
        objPurchase = true
      } else {
        [format ["<t size='0.6' color='#ff3300'>NOT ENOGH POINTS!</t>"], -0, -0.02, 0.2] call BIS_fnc_dynamicText;
        objPurchase = false
      };
    };
};
sleep 0.1;
if (objPurchase) then {
  closeDialog 0;
  shopVehic attachTo [ShopCaller, [0,2,0.02], "Pelvis"];
  dropActID = ShopCaller addAction ["drop", "detach shopVehic; ShopCaller removeAction dropActID; _shopVehicPos = getPos shopVehic; shopVehic setPos [_shopVehicPos select 0, _shopVehicPos select 1, 0]"];
};
