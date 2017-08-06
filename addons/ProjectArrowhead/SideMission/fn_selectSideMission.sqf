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
private _sideMission = selectRandom GVAR(sideMissions);
_sideMission params ["_name", "_function", "_origin"];
private _code = missionNamespace getVariable _function;
if (isNil "_code") then {
    _code = compile _function;
};
[_name, _origin] call _code;
