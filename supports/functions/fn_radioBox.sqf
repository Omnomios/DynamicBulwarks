_player = _this select 0;

_vehiclePos = [_player, 1, 15, 5, 0, 30, 0] call BIS_fnc_findSafePos;

// TFAR Box
if (isClass (configfile >> "CfgVehicles" >> "tf_anarc164")) then {
radioStorage = createVehicle ["Box_NATO_Equip_F", _vehiclePos, [], 0, "CAN_COLLIDE"];
clearItemCargo radioStorage;
radioStorage addItemCargo ["TFAR_anprc148jem", 15];
radioStorage addItemCargo ["TFAR_anprc152", 15];
radioStorage addItemCargo ["TFAR_anprc154", 15];
radioStorage addItemCargo ["TFAR_fadak", 15];
radioStorage addItemCargo ["TFAR_pnr1000a", 15];
radioStorage addItemCargo ["TFAR_rf7800str", 15];
};

// ACRE Box
if (!isNil "acre_main") then {
radioStorage = createVehicle ["ACRE_RadioSupplyCrate", _vehiclePos, [], 0, "CAN_COLLIDE"];
};

sleep 120;
deleteVehicle radioStorage;