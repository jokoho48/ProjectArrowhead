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
GVAR(locations) = [];
{
    private _locName = text _x;
    private _locPos = getPos _x;
    _locPos set [2,0];
    if !(_locPos call FUNC(nearBase) || (_locName in GVAR(blackListLocations))) then {
        GVAR(locations) pushBack _x;
    };
    nil
} count (nearestLocations [GVAR(centerPos), ["NameCityCapital","NameCity","NameVillage"], worldSize]);
