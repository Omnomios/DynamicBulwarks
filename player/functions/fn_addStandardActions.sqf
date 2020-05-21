//Disarm mines and explosives
_disarm =
{
    _explosive = nearestObject [player, "TimeBombCore"];
	deleteVehicle _explosive;
    _explosiveClass = typeOf _explosive;
    _count =  count (configFile >> "CfgMagazines");
    for "_x" from 0 to (_count-1) do {
        _item=((configFile >> "CfgMagazines") select _x);
		if (getText (_item >> "ammo") isEqualTo _explosiveClass) then {
			player addMagazine configName _item;
		};
    };
	player playAction "PutDown";
};
player addAction ["Disarm Explosive",_disarm,nil,2,false,true,"","(player distance2D nearestObject [player, 'TimeBombCore']) <= 1.6"];

_disarmMine =
{
    _explosive = nearestObject [player, "mineBase"];
	deleteVehicle _explosive;
    player playAction "PutDown";
};
player addAction ["Disarm Mine",_disarmMine,nil,2,false,true,"","(player distance2D nearestObject [player, 'mineBase']) <= 1.6"];
