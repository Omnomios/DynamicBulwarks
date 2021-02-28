/**
*  dropBox
*
*  converts Medikits into tickets
*
*  Domain: Client
**/
call killPoints_fnc_updateHud;
_Medikit_per_Ticket = ("Medikit_per_Ticket" call BIS_fnc_getParamValue);

_bulwarkContents = itemCargo bulwarkBox;

_countMediKits = {_x == "Medikit"} count _bulwarkContents;

if (_countMediKits >= _Medikit_per_Ticket ) then {
	_bulwarkContents = _bulwarkContents - ["Medikit"];
	clearItemCargoGlobal  bulwarkBox;
	
	_Remaining_Medikits = _countMediKits - _Medikit_per_Ticket ;
	bulwarkBox addItemCargoGlobal ["Medikit", _Remaining_Medikits];
	
	[west, 5] call BIS_fnc_respawnTickets;
	
	{
		bulwarkBox addItemCargoGlobal [_x, 1];
	} forEach _bulwarkContents;
	hint "Medikits traded for Tickets";
};

call killPoints_fnc_updateHud;



