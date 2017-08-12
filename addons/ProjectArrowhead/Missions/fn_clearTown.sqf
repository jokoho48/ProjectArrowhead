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

private _location = selectRandom MGVAR(locations);
private _size = 0;
private _count = {
    _size = _size + _x;
    true
} count (size _location);
_size = _size / _count;
_size = _size * ([CFGPRAW(MainAOSize), 2] call CFUNC(getSetting));
MGVAR(mainAOSize) = _size;
publicVariable QMGVAR(mainAOSize);
MGVAR(mainAOPos) = getPos _location;
publicVariable QMGVAR(mainAOPos);
QGVAR(spawnClearTownUnits) call CFUNC(localEvent);
