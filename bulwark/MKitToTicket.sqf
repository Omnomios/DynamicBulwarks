/**
*  dropBox
*
*  converts Medikits into tickets
*
*  Domain: Client
**/
call killPoints_fnc_updateHud;
systemChat "Version3";
_Medikit_per_Ticket = ("Medikit_per_Ticket" call BIS_fnc_getParamValue);
systemChat (format ["%1",_Medikit_per_Ticket]);

_bulwarkContents = itemCargo bulwarkBox;

_countMediKits = {_x == "Medikit"} count _bulwarkContents;
systemChat (format ["%1",_countMediKits]);

if (_countMediKits >= _Medikit_per_Ticket ) then {
	_bulwarkContents = _bulwarkContents - ["Medikit"];
	clearItemCargoGlobal  bulwarkBox;
	
	_Remaining_Medikits = _countMediKits - _Medikit_per_Ticket ;
	systemChat (format ["%1",_Remaining_Medikits]);
	bulwarkBox addItemCargoGlobal ["Medikit", _Remaining_Medikits];
	
	[west, 5] call BIS_fnc_respawnTickets;
	
	{
		bulwarkBox addItemCargoGlobal [_x, 1];
	} forEach _bulwarkContents;
	hint "Medikits traded for Tickets";
};

call killPoints_fnc_updateHud;



