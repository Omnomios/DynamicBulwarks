["Spawning reveal", "LOOT"] call shared_fnc_log;
private _droneRoom = call loot_fnc_getRandomLootRoom;
if (!isNil "_droneRoom") then {
	private _droneSupport = createVehicle ["Box_C_UAV_06_Swifd_F", _droneRoom, [], 0, "CAN_COLLIDE"];
	hideObjectGlobal _droneSupport;
	_droneSupport enableSimulationGlobal false;
	[_droneSupport, ["<t color='#ff00ff'>" + "Reveal loot", "removeAllActions (_this select 0); [ [],'supports\lootDrone.sqf'] remoteExec ['execVM',0];","",1,true,false,"true","true",2.5]] remoteExec ["addAction", 0, true];
	mainZeus addCuratorEditableObjects [[_droneSupport], true];
	_droneSupport;
} else {
	nil;
};

