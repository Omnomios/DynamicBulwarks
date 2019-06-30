_player = _this select 0;

_kartPos = [_player, 1, 15, 5, 0, 30, 0] call BIS_fnc_findSafePos;
_crazyKart = createVehicle ["C_Kart_01_Vrana_F", _kartPos, [], 0, "CAN_COLLIDE"];
_crazyKartGun = [[0,0,100], 0, "B_HMG_01_A_F", west] call BIS_fnc_spawnVehicle;
[_crazyKartGun select 0,["HandleDamage", {0}]] remoteExec ["addEventHandler", 0];
[_crazyKart,["HandleDamage", {0}]] remoteExec ["addEventHandler", 0];
_player setVariable ["RevByMedikit", true, true]; //uses the medikit revive variable to make player invinvible

(_crazyKartGun select 0) attachTo [_crazyKart, [0,1,0.1]];
[_player, _crazyKart] remoteExec ["moveInDriver", 0];

[_player, "armakartMusic"] remoteExec ["sound_fnc_say3DGlobal", 0];

for "_i" from 1 to 60 do {
  //_player moveInDriver _crazyKart;
  [_player, _crazyKart] remoteExec ["moveInDriver", 2];
  sleep 1;
};

deleteVehicle _crazyKart;
deleteVehicle (_crazyKartGun select 0);
sleep 1;
_player setVariable ["RevByMedikit", false, true];
