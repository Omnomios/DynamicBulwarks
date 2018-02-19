_caller = _this select 1;
hint str _caller;
sleep 1;
call {openMap true};
onMapSingleClick "hint str _pos; [_pos] execVM 'supports\artilleryTarget.sqf'; onMapSingleClick '';openMap false; true";