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
params [["_center", [], [[]]],["_min", 0, [0]],["_max", 100, [0]],["_dirArray", [], [[]]]];

private _dir = if (count _dirArray isEqualTo 0) then {
    random 360
} else {
    _dirArray params ["_dMin", "_dMax"];
    (_dMin + random _dMax) min _dMax;
};
private _range = (ceil (random _max)) max _min;
[(_center select 0) + (sin _dir) * _range, (_center select 1) + (cos _dir) * _range, 0];
