#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Get a Location on Map
    also Offsets Pos when a CityCenter is existing
    Parameter(s):
    None

    Returns:
    0: Location Position <Position>
    1: Location Name <String>
    2: Location Size <Number>
    3: Location <Location>
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
if ((getPos _nearestCenter) distance _pos <= (_size select 0)) then {
    _location = _nearestCenter;
};
[getPos _location, _name, _size select 0, _location]
