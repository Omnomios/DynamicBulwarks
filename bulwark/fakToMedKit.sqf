/**
*  dropBox
*
*  converts fak's into Medkits
*
*  Domain: Client
**/

_fakArr = ["FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit","FirstAidKit"];

while {true} do{
  _bulwarkContents = itemCargo bulwarkBox;
  _countFaks = {_x == "FirstAidKit"} count _bulwarkContents;
  if (_countFaks >= 15) then {
    _bulwarkContents = _bulwarkContents - _fakArr;
    clearItemCargoGlobal  bulwarkBox;
    bulwarkBox addItemCargoGlobal ["Medikit", 1];
    {
        bulwarkBox addItemCargoGlobal [_x, 1];
    } forEach _bulwarkContents;
    hint "true";
  };
};
