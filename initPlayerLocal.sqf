Player setPos (getMarkerPos "respawn_west");
player setCustomAimCoef 0;
player enableStamina FALSE;
player addEventHandler ['Respawn',{player enableStamina FALSE;}];
player setUnitRecoilCoefficient 0.5;

_killPoints = player getVariable "killPoints";
if(isNil "_killPoints") then {
    _killPoints = 0;
};
player setVariable ["killPoints", _killPoints, true];
