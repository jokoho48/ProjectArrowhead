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

DFUNC(selectRandomEvent) = {
    [{
        private _randomEvent = selectRandom GVAR(sideMissions);
        _randomEvent params ["_name", "_function", "_origin", "_cfg"];
        private _code = missionNamespace getVariable _function;
        if (isNil "_code") then {
            _code = compile _function;
        };
        [_name, _origin, _cfg] call _code;
    }, random [600,1000,1200]] call CFUNC(wait);
};

call FUNC(selectRandomEvent);

DFUNC(earthQuake) = {
    QGVAR(earthQuake) call CFUNC(globalEvent);
};
[QGVAR(earthQuake), {
    (ceil (random 4)) spawn BIS_fnc_earthquake;
}] call CFUNC(addEventhandler);
