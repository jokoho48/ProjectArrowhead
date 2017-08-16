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
params ["_pos", "_range"];
private _players = [];

{
    if (((_x distance _pos) <= _range) && _x call MFUNC(isAwake)) then {
        _players pushBack _x
    };
    nil
} count allPlayers;

_players
