// Delete
if (BODY_CLEANUP_WAVE >= 0) then {
    private _final = waveUnits select BODY_CLEANUP_WAVE;
    {deleteVehicle _x} foreach _final;
};

// Shuffle
waveUnits set [2, waveUnits select 1];
waveUnits set [1, waveUnits select 0];
waveUnits set [0, []];