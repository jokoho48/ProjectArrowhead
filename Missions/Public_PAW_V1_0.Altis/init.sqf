enableSaving [false, false];
enableEnvironment [false, true];
enableSentences false;
call CLib_fnc_loadModules;
if !(isServer) then {
	null = [] execVM "diary.sqf";					//Diary
};
