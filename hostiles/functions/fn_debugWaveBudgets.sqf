private _firstWave = 5; 
//private _waveScale = 0.1; 
private _waveScale = 1;
for "_x" from _firstWave to 50 do { 
//    private _waveBudget = exp((_x - _firstWave) * _waveScale);     
    private _waveBudget = (_x - _firstWave + exp(_waveScale)) / exp(1);
    [format ["Wave %1: %2", _x, _waveBudget], "WAVEBUDGET"] call shared_fnc_log; 
}; 

