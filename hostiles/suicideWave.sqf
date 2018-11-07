_wave = attkWave;

_allHCs = entities "HeadlessClient_F";
_allHPs = allPlayers - _allHCs;

//Kill Hostile AI if they get too close to player. Event for explosion assigned to AI in spawnSquad.sqf
while {_wave == attkWave} do {
  {
    if (side _x == east) then {
      _thisAI = _x;
      {
        if (((_thisAI distance2D _x) < 10) && (alive _thisAI)) then {
          _thisAI setDamage 1;
        }
      } forEach _allHPs;
    };
  } foreach allUnits;
};
