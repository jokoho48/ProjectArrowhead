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
[{
    private _randomEvent = selectRandom GVAR(sideMissions);
    _randomEvent params ["_name", "_function", "_origin", "_cfg"];
    private _code = missionNamespace getVariable _function;
    if (isNil "_code") then {
        _code = compile _function;
    };
    LOG("load Random Event: """ + _name + """ from: " + _origin);
    [_name, _origin, _cfg] call _code;
    call FUNC(selectRandomEvent);
}, random GVAR(EventTimings)] call CFUNC(wait);
