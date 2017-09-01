#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Init for Common Module

    Parameter(s):
    None

    Returns:
    None
*/
private _return = [];
{
    if (_x isEqualType []) then {
        _x params ["_class", "_count"];
        for "_i" from 1 to _count do {
            _return pushBack _class;
        };
    } else {
        _return pushBack _x;
    };
    nil
} count _this;
_return
