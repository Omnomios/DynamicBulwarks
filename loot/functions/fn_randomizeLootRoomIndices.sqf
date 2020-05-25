// Randomize the indices for this spawn
for "_x" from 0 to count lootRoomIndices - 1 do {
	private _temp = lootRoomIndices select _x;
	private _swapWithIndex = lootRoomIndices call BIS_fnc_randomIndex;
	lootRoomIndices set [_x, lootRoomIndices select _swapWithIndex];
	lootRoomIndices set [_swapWithIndex, _temp];
};

lootRoomsConsumed = 0;

