_playerLoadout = _this select 0;
_playerPos = _this select 1;
_droppedWeapons = _this select 2;

//add all items, gear and mags to new unit
_deadPlayerGroup = createGroup [EAST, true];
_deadPlayerUnit = _deadPlayerGroup createUnit ["RyanZombieC_man_1slowOpfor", [0,0,0], [], 1, "FORM"];
[_deadPlayerUnit] join _deadPlayerGroup;
_deadPlayerUnit addEventHandler ["Hit", killPoints_fnc_hit];
_deadPlayerUnit addEventHandler ["Killed", killPoints_fnc_killed];
_deadPlayerUnit setVariable ["nearObject", 0];
mainZeus addCuratorEditableObjects [[_deadPlayerUnit], true];
{
  if (_x in (weapons _deadPlayerUnit)) then {
    _droppedWeapons deleteAt (_droppedWeapons find _x);
  };
} forEach _droppedWeapons;

sleep 3;

_deadPlayerUnit setUnitLoadout _playerLoadout;
_deadPlayerUnit setPos _playerPos;
Survivors reveal _deadPlayerUnit;
//_droppedWeapons = _droppedWeapons + (weapons _deadPlayerUnit);
_deadPlayerUnit setVariable ["weapons", _droppedWeapons];
{
  _deadPlayerUnit removeWeaponGlobal _x;
}forEach _droppedWeapons;
_deadPlayerUnit addEventHandler ["Killed", CreateHostiles_fnc_zombPlayerWeapons];
