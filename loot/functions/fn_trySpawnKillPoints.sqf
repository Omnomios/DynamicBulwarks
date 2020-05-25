["Spawning points", "LOOT"] call shared_fnc_log;
private _pointsLootRoom = call loot_fnc_getRandomLootRoom;
if (!isNil "_pointsLootRoom") then {
	private _pointsLoot = createVehicle ["Land_Money_F", _pointsLootRoom, [], 0, "CAN_COLLIDE"];
	hideObjectGlobal _pointsLoot;
	_pointsLoot enableSimulationGlobal false;
	[_pointsLoot, ["<t color='#00ff00'>" + "Collect Points", "[_this select 0, _this select 1] execVM 'loot\lootPoints.sqf'; [_this select 0] remoteExec ['removeAllActions', 0];","",1,true,false,"true","true",2.5]] remoteExec ["addAction", 0, true];
	_pointsLoot;
} else {
	nil;
};
