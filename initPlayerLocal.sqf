Player setPos (getMarkerPos "respawn_west");

player setCustomAimCoef 0;
player enableStamina FALSE;
player addEventHandler ['Respawn',{player enableStamina FALSE;}];
player setUnitRecoilCoefficient 0.5;