params ["_string", "_len"];

private _result = _string;
for "_x" from 0 to (_len - count _string) do {
    _result = _result + " ";
};
_result;