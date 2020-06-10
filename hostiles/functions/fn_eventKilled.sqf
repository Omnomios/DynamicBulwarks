params ["_unit", "_killer", "_instigator"];

[_unit, _killer, _instigator] call killPoints_fnc_killed;

if (isServer) then {
    if (BODY_CLEANUP_WAVE == -1) then {
        _unit spawn {
            params ["_unit"];
            sleep 3;
            deleteVehicle _unit;
        };
    };
};
