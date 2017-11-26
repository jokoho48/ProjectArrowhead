#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    get a Player Target that is not in base and is awake

    Parameter(s):
    None

    Returns:
    Target Player <Object>
*/
private _target = objNull;
{
    if (_x call MFUNC(isAwake) && !(getPos _x call MFUNC(nearBase)) && !(player getVariable [QGVAR(isHCClient), false])) exitWith {_target = _x;};
    nil
} count (allPlayers call CFUNC(shuffleArray));

_target
