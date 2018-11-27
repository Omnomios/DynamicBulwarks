_unit = _this select 0;

_bodyPos = getPos _unit;
_gunHolder = 'WeaponHolderSimulated' createVehicle [_bodyPos select 0, _bodyPos select 1, (_bodyPos select 2) + 1];
mainZeus addCuratorEditableObjects [[_gunHolder], true];
_droppedWeapons = _unit getVariable 'weapons';
{
  _gunHolder addWeaponCargoGlobal [_x, 1];
} forEach _droppedWeapons;





/*
{
	if (count _x > 4 && {typeName (_x select 4) == typeName []}) then
	{
		private ["_weapon","_magazine"];
		_weapon = _x select 0;
		_magazine = _x select 4 select 0;
		if !(isnil "_magazine") then
		{
			switch _weapon do
			{
				case (primaryWeapon _unit): {_primaryWeaponMagazine = _magazine;};
				case (secondaryWeapon _unit): {_secondaryWeaponMagazine = _magazine;};
				case (handgunWeapon _unit): {_handgunMagazine = _magazine;};
			};
		};
	};
} forEach weaponsItems _droppedWeapons;
*/
