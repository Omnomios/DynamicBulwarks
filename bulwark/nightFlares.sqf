_centre = bulwarkCity; 
 _centerGrp = createCenter west;
  _group = createGroup _centerGrp;
while {true} do
{
	
	while {daytime < 6 || daytime > 18.5} do {
		_pos = [[[bulwarkCity , (BULWARK_RADIUS+50)]],[]] call BIS_fnc_randomPos; 
		//_pos = ATLToASL _pos;
		_pos = [ _pos select 0,_pos select 1,(_pos select 2) + 250];
		_flrObj = (selectRandom ["uns_vecflare_r"]) createvehicle _pos; //,"uns_vecflare_w"
		_flrObj setVelocity [0,0,-5]; 
		// _group createUnit [selectRandom[ 'ModuleFlareWhite_F', 	 
		// 'ModuleFlareYellow_F',
		// 'ModuleFlareGreen_F'
		// ], 
		// _pos, [], 0, "FORM"];
		sleep (90 + (random 90));
	};
	waitUntil{sleep 90; daytime < 6 || daytime > 18.5};
};


//"uns_vecflare_r" createvehicle ((player) ModelToWorld [0,0,50]); flrObj setVelocity [0,0,-10];
//flrObj = "F_40mm_white" createvehicle ((player) ModelToWorld [0,0,10]); flrObj setVelocity [0,0,-2]; 