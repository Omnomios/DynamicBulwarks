/**
*  spin/main
*
*  Actor for the "Spin the box" action menu item
*
*  Domain: Client
**/
_hPos = 1; //0.70
_lPos = 0.35;

_weaponList = List_AllWeapons;


if(isNil {_this select 0}) then {
    throw "Unkown lootbox position";
};
if(isNil {_this select 1}) then {
    throw "Unkown lootbox position ATL";
};

_boxPos    = _this select 0;
_boxPosATL = _this select 1;
_boxDir    = _this select 2;


if (floor random 15 == 1) then {
  deleteVehicle lootBox;
  _player = player;
  [_player, "SmallExplosion"] remoteExec ["sound_fnc_say3DGlobal", 0];
  _lootBoxRoom = while {true} do {
  	_lootBulding = selectRandom lootHouses;
  	_lootRooms = _lootBulding buildingPos -1;
  	_lootRoom = selectRandom _lootRooms;
  	if(!isNil "_lootRoom") exitWith {_lootRoom};
  };
  lootBox = createVehicle ["Land_WoodenBox_F", _lootBoxRoom, [], 4];
  publicVariable "lootBox";
  [lootBox, ["<t color='#00ffff'>" + "Pickup", "bulwark\moveSpinBox.sqf"]] remoteExec ["addAction", 0, true];
  [lootBox, [
  	"<t color='#FF0000'>Spin the box!</t>", "
  		lootBoxPos    = getPos lootBox;
  		lootBoxPosATL = getPosATL lootBox;
  		lootBoxDir    = getDir lootBox;
  		_player = _this select 1;
  		_points = _player getVariable 'killPoints';
  		if(_points >= SCORE_RANDOMBOX) then {
  			[_player, SCORE_RANDOMBOX] remoteExec ['killPoints_fnc_spend', 2];
  			[[lootBoxPos, lootBoxPosATL, lootBoxDir], 'loot\spin\main.sqf'] remoteExec ['execVM', 2];
  		};
  	"
  ]] remoteExec ["addAction", 0, true];
  //lootBox enableSimulationGlobal false;
}else{
  // Create weapon holder and position on loot box
  _weapon = createVehicle ["WeaponHolderSimulated_Scripted", _boxPos, [], 0, "can_collide"];
  _weapon setDir _boxDir;
  _weapon setPosATL [_boxPosATL select 0, _boxPosATL select 1, ((_boxPosATL select 2) + _lPos) ];
  _weapon enableSimulationGlobal false;

  // Trigger sound effects
  [_weapon, "boxSpin"] remoteExec ["sound_fnc_say3DGlobal", 0];

  // Start raising the weapon out of the box
  _coRoutine = [1, _boxPosATL, _lPos, _hPos, _weapon] execVM "loot\spin\animateWeapon.sqf";

  // Start cycling weapons
  _spinDelay = 0.01;
  while {_spinDelay < 0.33} do {
      _weapon addWeaponCargoGlobal [selectRandom _weaponList, 1];
      sleep _spinDelay;
      clearWeaponCargoGlobal _weapon;
      _spinDelay = _spinDelay + 0.01;
  };

  // For safety, stop the weapon from moving.
  terminate _coRoutine;

  // Spin complete, present winning weapon with ammo
  _weapon enableSimulationGlobal true;
  _finalWeapon = selectRandom _weaponList;

  _ammoArray = getArray (configFile >> "CfgWeapons" >> _finalWeapon >> "magazines");
  _weapon addMagazineCargoGlobal [selectRandom _ammoArray, 1];
  _weapon addWeaponCargoGlobal [_finalWeapon, 1];

  // Hold weapon for 5 seconds

  [_weapon, lootBox] call BIS_fnc_attachToRelative;
  sleep 5;
  detach _weapon;

  // Start to drop the weapon
  _coRoutine = [2, _boxPosATL, _lPos, _hPos, _weapon] execVM "loot\spin\animateWeapon.sqf";
  sleep 6;
  terminate _coRoutine;

  // Clean up for the next spin
  clearWeaponCargoGlobal _weapon;
  deleteVehicle _weapon;
};
