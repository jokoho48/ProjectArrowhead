#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Description

    Parameter(s):
    0: Argument <Type>

    Returns:
    0: Return <Type>
*/
GVAR(mainMissions) = [];
GVAR(isFirstCallDone) = false;
GVAR(missionCounter) = 0;

GVAR(missionAmount) = [CFGPRAW(missionAmount), 10] call CFUNC(getSetting);    // TODO: make settings
{
    private _configPath = ["Mission", "Server"] select _forEachIndex;
    {
        if (isText _x) then {
            GVAR(mainMissions) pushBack [configName _x, getText _x, _configPath, configNull];
        } else {
            GVAR(mainMissions) pushBack [configName _x, getText (_x >> "function"), _configPath, _x];
        };
        nil
    } count configProperties [_x >> "ProjectArrowhead" >> "mainMissions" , "isClass _x || isText _x", true];
    nil
} forEach [missionConfigFile, configFile];
["missionStarted", {
    call FUNC(selectMainMission);
}] call CFUNC(addEventhandler);
