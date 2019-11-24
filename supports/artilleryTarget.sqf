_pos = _this select 0;
_randomOutboundSleep = random [15, 25, 45];
sleep _randomOutboundSleep;
_scriptedCharge = "Bo_GBU12_LGB" createVehicle [[[_pos, 50]],[]] call BIS_fnc_randomPos;
_scriptedCharge setDamage 1;
sleep random 3;
_scriptedCharge = "Bo_GBU12_LGB" createVehicle [[[_pos, 50]],[]] call BIS_fnc_randomPos;
_scriptedCharge setDamage 1;
sleep random 3;
_scriptedCharge = "Bo_GBU12_LGB" createVehicle [[[_pos, 50]],[]] call BIS_fnc_randomPos;;
_scriptedCharge setDamage 1;


