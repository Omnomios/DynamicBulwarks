/*
* Filters out DLC configs excluded in DLC parameter
* Expects config array
* Returns config array
*/
params [["_configArr",[]]];
private _return = [];
if (count excludedDLC != 0) then {
	_return = _configArr select {
		private _dlc = [_x,"DLC"] call shared_fnc_getConfigEntryAsString;
		if (isNil "_dlc" || {!(toUpper _dlc in excludedDLC)}) then {
			true
		};
	};
}
else
{
	_return = _configArr;
};
_return