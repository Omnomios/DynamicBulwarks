private _knownMagRepackAddons = ["outlw_magrepack"];

if (count (_knownMagRepackAddons arrayIntersect activatedAddons) == 0) then {
    // Mag Repack
    MY_KEYDOWN_FNC = {
        _handled = false;
        params ["_ctrl", "_dikCode", "_shift", "_ctrlKey", "_alt"];
        if (_dikCode == 19 && _ctrlKey) then { // using if instead of switch since it's faster when evaluating only one condition
            [player] execVM "bulwark\magRepack.sqf";
            _handled = true;
        };
        _handled
    };

    toggled = 0;

    waituntil {!(isNull (findDisplay 46))};
    (findDisplay 46) displayAddEventHandler ["KeyDown",{_this call MY_KEYDOWN_FNC}];
};
