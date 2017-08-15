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

DFUNC(rebelAttack) = {
    QGVAR(rebelAttackSpawn) call CFUNC(serverEvent); // TODO: Make HC Compatible
};

DFUNC(airAttack) = {
    QGVAR(airAttackSpawn) call CFUNC(serverEvent); // TODO: Make HC Compatible
};

DFUNC(earthQuake) = {
    QGVAR(earthQuake) call CFUNC(globalEvent);
};

{
    private _configPath = ["Mission", "Server"] select _forEachIndex;
    {
        if (isText _x) then {
            GVAR(randomEvents) pushBack [configName _x, getText _x, _configPath, configNull];
        } else {
            GVAR(randomEvents) pushBack [configName _x, getText (_x >> "function"), _configPath, _x];
        };
        nil
    } count configProperties [_x >> "ProjectArrowhead" >> "randomEvents" , "isClass _x || isText _x", true];
    nil
} forEach [missionConfigFile, configFile];

call FUNC(selectRandomEvent);
