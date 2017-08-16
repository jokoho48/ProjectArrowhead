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
private _target = objNull;
{
    if (_x call MFUNC(isAwake) && !([getPos _x] call MFUNC(nearBase))) exitWith {_target = _x;};
    nil
} count (allPlayers call CFUNC(shuffleArray));

_target
