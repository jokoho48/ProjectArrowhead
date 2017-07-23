#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:
    Description

    Parameter(s):
    0: Argument <Type>

    Returns:
    0: Return <Type>
*/
params ["_pos", "_range"];
private _players = [];

{
    if (isPlayer _x && ((_x distance _pos) <= _range) && alive _x) then {
        _players pushBack _x
    };
    nil
} count allUnits;

_players
