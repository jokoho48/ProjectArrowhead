enableSaving [false, false];
enableEnvironment [false, true];
enableSentences false;
{_x setmarkeralpha 0} forEach (allmapmarkers select {(getmarkertype _x) find "respawn" > -1});
call CLib_fnc_loadModules;

if (hasInterface) then {
	null = [] execVM "diary.sqf";					//Diary
    addMissionEventHandler ["PreloadFinished", {
        player setVehiclePosition [(getMarkerPos "baseSpawn"), [], 0];
        player setDir (markerDir "baseSpawn");
        player action ["WeaponOnBack", player];
    }];
};