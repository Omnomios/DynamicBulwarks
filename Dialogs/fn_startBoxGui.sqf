disableSerialization;

_shopItems = ["50 - Junk Barricade","100 - Short Sandbag Wall","150 - Sandbag Barricade","250 - Tall Concrete Wall","500 - H Barrier","1000 - Double H Barrier","5000 - Guard Tower"];

createDialog "startBox_Dialog";

waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;

{
    _ctrl lbAdd _x;
} forEach _shopItems;
