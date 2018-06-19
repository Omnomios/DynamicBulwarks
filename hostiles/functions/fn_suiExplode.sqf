_thisAI = _this select 0;

_randExplosion = ["DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted","ClaymoreDirectionalMine_Remote_Ammo_Scripted"];
_scriptedCharge = (selectRandom _randExplosion) createVehicle (getPos _thisAI);
_scriptedCharge setDamage 1;
