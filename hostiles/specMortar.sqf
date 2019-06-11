_distFromBulwark = "BULWARK_RADIUS" call BIS_fnc_getParamValue;

_mortarPos = [bulwarkRoomPos, _distFromBulwark - 15, _distFromBulwark - 5, 3, 0, 10, 0] call BIS_fnc_findSafePos;
specMortar = [_mortarPos, 0, "O_Mortar_01_F", EAST] call bis_fnc_spawnvehicle;
mortarGunner = specMortar select 1 select 0;
mainZeus addCuratorEditableObjects [[specMortar select 0], true];

sleep 3;

{
  _x reveal [mortarGunner, 4];
}forEach allPlayers;

sleep 20;

while {alive mortarGunner} do {
  _bulwarkArtPos = getPos bulwarkBox;
  specMortar doArtilleryFire [[(_bulwarkArtPos select 0) + (random [-45, 0, 45]), (_bulwarkArtPos select 1) + (random [-45, 0, 45]), _bulwarkArtPos select 2], "8Rnd_82mm_Mo_shells", 1];
  sleep 30;
};
