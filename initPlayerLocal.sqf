Player setPos (getMarkerPos "respawn_west");
player setCustomAimCoef 0;
player enableStamina FALSE;
player addEventHandler ['Respawn',{player enableStamina FALSE;}];
player setUnitRecoilCoefficient 0.5;

_supportTroops = [player,"paraDrop"] call BIS_fnc_addCommMenuItem;
_supportUAV = [player,"reconUAV"] call BIS_fnc_addCommMenuItem;
