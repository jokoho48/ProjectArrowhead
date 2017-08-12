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
while {
    (getPos _location call FUNC(nearBase))
     || !(([getPos _location, 2000] call FUNC(getClosePlayers)) isEqualTo [])
} do {
    _location = selectRandom MGVAR(locations);
};
MGVAR(locations) deleteAt (MGVAR(locations) find _location);
if (MGVAR(locations) isEqualTo []) then {
    call MFUNC(fillLocations);
};

private _name = text _location;
private _pos = getPos _location;
private _size = size _location;
private _nearestCenter = nearestLocation [getPos _location, "CityCenter"];
if ((getPos _nearestCenter) inArea _location) then {
    _location = _nearestCenter;
};
[getPos _location, _name, _size select 0, _location]
