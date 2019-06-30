_curWave = attkWave;

waitUntil {waveSpawned};

while {_curWave == attkWave} do {
  _drone = leader selectRandom droneSquad;
  if (alive _drone) then {
    _drone fireAtTarget [bulwarkBox];
    sleep 30;
  }else{
    sleep 0.5;
  };
};
