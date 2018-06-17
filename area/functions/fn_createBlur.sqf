/**
*  fn_createBlur
*
*  Creates DynamicBlur effect.
*
*  Domain: Client
**/

params ["_name", "_priority", "_effect", "_handle"];
while {
    _handle = ppEffectCreate [_name, _priority];
    _handle < 0
} do {
    _priority = _priority + 1;
};
_handle ppEffectEnable true;
_handle ppEffectAdjust _effect;
_handle ppEffectCommit 0;
waitUntil {ppEffectCommitted _handle};
_handle ppEffectAdjust [0];
_handle ppEffectCommit 1;
waitUntil {ppEffectCommitted _handle};
_handle ppEffectEnable false;
ppEffectDestroy _handle;
