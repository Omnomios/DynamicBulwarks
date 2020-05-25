params ["_title", "_error"];
_title hintC _error;
hintC_EH = findDisplay 72 displayAddEventHandler ["unload", {
    0 = _this spawn {
        _this select 0 displayRemoveEventHandler ["unload", hintC_EH];
        hintSilent "";
    };
}];