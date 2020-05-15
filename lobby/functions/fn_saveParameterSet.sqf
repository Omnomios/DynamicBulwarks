disableSerialization;

private _dialog = findDisplay 9999;
private _setList = _dialog displayCtrl 100;

private _selectedIndex = lbCurSel _setList;
private _selectedSet = _setList lbText _selectedIndex;

_selectedSet call lobby_fnc_doSave;