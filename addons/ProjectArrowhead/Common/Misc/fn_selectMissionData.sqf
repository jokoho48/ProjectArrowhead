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
private _mission = selectRandom _this;
_mission params ["", "", "", "", "_requireCollectIntel"];

if (_requireCollectIntel != 0) exitWith {
    if (_requireCollectIntel == 1) then {
        _mission call EFUNC(Missions,collectIntel);
    } else {
        if (floor (random 2) == 1) then {
            _mission call EFUNC(Missions,collectIntel);
        } else {
            _mission call FUNC(callMissionData);
        };
    };
};

_mission call FUNC(callMissionData);
