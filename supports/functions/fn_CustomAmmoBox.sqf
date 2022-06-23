_wPos = screenToWorld [0.5,0.5];
_ammobox = "ACRE_RadioSupplyCrate" createVehicle _wPos;

sleep 120;

deleteVehicle _ammobox;


//_ammobox addAction ["Munition Auffüllen","ammoDrop.sqf"];