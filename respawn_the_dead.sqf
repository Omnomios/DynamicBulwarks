		{if (!alive _x) then {
			forceRespawn _x;
			};
		} foreach allPlayers;
		