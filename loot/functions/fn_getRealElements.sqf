/*
* Function to filter out empty strings
* - expects string or array of strings
* - outputs array of passed strings
* example: elements call loot_fnc_getRealElements;
*/
params [["_input",[]]];
_output = [];
if (_input isEqualType []) then {
	_input apply {
		if !(_x == "" || isNil "_x") then {
		_output pushBack _x;
		};
	};
}
else
{
	if !(_input == "") then {
		_output pushBack _input;
	};
};
_output