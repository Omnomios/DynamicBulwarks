/**
*  fn_purchaseGui
*
*  Displays GUI for purchases from the bullwark box.
*
*  Domain: Client
**/

disableSerialization;

_listFormat = "%1 - %2";

createDialog "startBox_Dialog";
waitUntil {!isNull (findDisplay 9999);};

_ctrl = (findDisplay 9999) displayCtrl 1500;
{
    _ctrl lbAdd format [_listFormat, _x select 0, _x select 1],;
} forEach BULWARK_BUILDITEMS;

_ctrl = (findDisplay 9999) displayCtrl 1501;
if (SUPPORTMENU) then {
  {
      _ctrl lbAdd format [_listFormat, _x select 0, _x select 1],;
  } forEach BULWARK_SUPPORTITEMS;
}else{
  _ctrl lbAdd " ";
  _ctrl lbAdd "";
  _ctrl lbAdd "         A Satellite Dish must be found";
  _ctrl lbAdd "             to unlock Support Menu";
};
