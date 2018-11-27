params ["_player", "_killer"];

if(!isNull _player) then {
    ["Initialize", [_player, [west], false, true, true, false, true, true, true, true]] call BIS_fnc_EGSpectator;
};

if (!isNil "bulwarkCity" && side _killer == civilian) then {
  _unitLoadOut = getUnitLoadout _player;
  _playerPos = getPos _player;
    sleep 3;
  _dropped = nearestObjects [_player, ["WeaponHolderSimulated", "WeaponHolderSimulated_Scripted"], 3, true];
  _droppedWeapons = [];
  {
    _droppedWeaponsHolderCargo = getWeaponCargo _x;
    _droppedWep = _droppedWeaponsHolderCargo select 0;
    {
      _droppedWeapons pushBack _x;
    }forEach _droppedWep;
    deleteVehicle _x;
  } foreach _dropped;
  [[_unitLoadOut, _playerPos, _droppedWeapons], "hostiles\deadPlayerZombie.sqf"] remoteExec ["execVM", 2];
  _player setPos [0,0,0];
};
