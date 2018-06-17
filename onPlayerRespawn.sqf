waitUntil {!isNil "bulwarkBox"};
["Terminate"] call BIS_fnc_EGSpectator;

_player = _this select 0;
removeHeadgear _player:
removeGoggles _player;
removeVest _player;
removeBackpack _player;
removeAllWeapons _player:
removeAllAssignedItems _player;
_player setPosASL ([bulwarkBox] call bulwark_fnc_findPlaceAround);

if (PLAYER_STARTEQUIPMENT > 0) then {
	_player addItem "ItemMap";
    _player assignItem "ItemMap";
};
if (PLAYER_STARTEQUIPMENT > 1) then {
	_player addItem "ItemWatch";
	_player addItem "ItemCompass";
    _player assignItem "ItemWatch";
    _player assignItem "ItemCompass";
};
if (PLAYER_STARTEQUIPMENT > 2) then {
	_player addItem "ItemRadio";
    _player assignItem "ItemRadio";
};
if (PLAYER_STARTEQUIPMENT > 3) then {
	_player addItem "ItemGPS";
    _player assignItem "ItemGPS";
};

switch (PLAYER_STARTVISION) do {
    case 1: { _player addWeapon "Binocular"; };
    case 2: { _player addWeapon "Rangefinder"; };
	case 3: { _player addWeapon "Laserdesignator"; };
};

if(PLAYER_STARTWEAPON) then {
    _player addMagazine "16Rnd_9x21_Mag";
    _player addMagazine "16Rnd_9x21_Mag";
    _player addWeapon "hgun_P07_F";
};

if(PLAYER_STARTNVG) then {
    _player addItem "Integrated_NVG_F";
    _player assignItem "Integrated_NVG_F";
};
