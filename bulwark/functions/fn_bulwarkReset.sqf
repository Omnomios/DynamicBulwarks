//resets bulwarkbox position when it falls into the floor
While {true} do {
if !(isTouchingGround bulwarkBox) then {
	_nearObj = nearestObjects [getPos bulwarkBox,[],25,false];
	if (count _nearObj == 2) then
		{
			bulwarkRoomPos params ["_posX","_posY","_posZ"];
			vectorUp bulwarkBox;
			bulwarkBox setPos [_posX,_posY,_posZ + 3];
		};
	};
	sleep 60;
};
