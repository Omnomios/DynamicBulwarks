/**
*  dropBox
*
*  train player as maintainer
*
*  Domain: Client
**/
_bulwarkContents = itemCargo bulwarkBox;
_countToolKit = {_x == "ToolKit"} count _bulwarkContents;


if ( _countToolKit >= 1 ) then {
	_bulwarkContents = _bulwarkContents - ["ToolKit"];
	clearItemCargoGlobal  bulwarkBox;
	
	_Remaining_ToolKit = _countToolKit - 1 ;
	bulwarkBox addItemCargoGlobal ["ToolKit", _Remaining_ToolKit];
	
	player setUnitTrait ["Engineer", True];
	
	{
		bulwarkBox addItemCargoGlobal [_x, 1];
	} forEach _bulwarkContents;
	hint "Player trained as Maintainer";
};

call killPoints_fnc_updateHud;
