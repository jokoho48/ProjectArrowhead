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
GVAR(randomEvents) = [];
GVAR(EventTimings) = [600,1000,1200]; // TODO: Setting
{
    private _origin = ["Mission", "Server"] select _forEachIndex;
    {
        if (isText _x) then {
            GVAR(randomEvents) pushBack [configName _x, getText _x, _origin, configNull];
        } else {
            GVAR(randomEvents) pushBack [configName _x, getText (_x >> "function"), _origin, _x];
        };
        nil
    } count configProperties [_x >> "ProjectArrowhead" >> "randomEvents" , "isClass _x || isText _x", true];
    nil
} forEach [missionConfigFile, configFile];

call FUNC(selectRandomEvent);
