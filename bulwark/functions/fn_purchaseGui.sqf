disableSerialization;

_buildItems = [
    "50 - Junk Barricade",
    "100 - Short Sandbag Wall",
    "150 - Sandbag Barricade",
    "250 - Tall Concrete Wall",
    "500 - H Barrier",
    "1000 - Double H Barrier",
    "5000 - Guard Tower"
];

_listFormat = "%1 - %2";
_supportItems = [
    format [_listFormat, SCORE_RECONUAV, "Recon Drone"],
    format [_listFormat, SCORE_PARATROOP, "Parratroopers"],
    format [_listFormat, SCORE_AIRSTRIKE, "Missle CAS"],
    format [_listFormat, SCORE_RAGEPACK, "Rage Stimpack"]
];

createDialog "startBox_Dialog";
waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;
{
    _ctrl lbAdd _x;
} forEach _buildItems;

_ctrl = (findDisplay 9999) displayCtrl 1501;
{
    _ctrl lbAdd _x;
} forEach _supportItems;
