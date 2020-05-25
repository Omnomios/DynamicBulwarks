if (lootRoomsConsumed >= count lootRoomIndices) then {
    nil;
} else {
    lootRoomsConsumed = lootRoomsConsumed + 1;
    possibleLootRooms select (lootRoomIndices select lootRoomsConsumed - 1);
};
