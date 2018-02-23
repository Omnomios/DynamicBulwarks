player setCustomAimCoef 0;
player enableStamina FALSE;
player addEventHandler ['Respawn',{
    player enableStamina FALSE;
    player addAction ['Break Medikit', {
	    player removeItem "Medikit";
	    for ("_i") from 1 to 4 do { player addItem "firstAidKit"; };
	}, nil, 1.5, true, true, '', "'Medikit' in items _this"];
}];
player setUnitRecoilCoefficient 0.5;

player addAction ['Break Medikit', {
    player removeItem "Medikit";
    for ("_i") from 1 to 4 do { player addItem "firstAidKit"; };
}, nil, 1.5, true, true, '', "'Medikit' in items _this"];

_killPoints = player getVariable "killPoints";
if(isNil "_killPoints") then {
    _killPoints = 0;
};
player setVariable ["killPoints", _killPoints, true];
