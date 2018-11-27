_obj = _this select 0;
_objRadius = _this select 1;

_caughtAI = [];

while {!(isNull _obj)} do {
  _nearAI = _obj nearEntities (_objRadius + 1.5);
  {
    if (side _x == EAST) then {
      if (!(_x in _caughtAI)) then {
        _x disableAI "MOVE";
        _caughtAI pushback _x;
      };
    };
  } forEach  _nearAI;
};

{
  if (!isPlayer _x) then {
    _x enableAI "MOVE";
    _aiUnit = _x;
    {
      _aiUnit reveal [_x, 4];
    } forEach allPlayers;
  };
} forEach _caughtAI;

_caughtAI = [];
