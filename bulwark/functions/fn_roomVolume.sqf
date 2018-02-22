_probeResult = _this call bulwark_fnc_probeBox;

if(!(_probeResult select 0)) exitWith {
	[false, 0];
};

_w = _probeResult select 5;
_h = _probeResult select 6;

[true, (_w * _h)];
