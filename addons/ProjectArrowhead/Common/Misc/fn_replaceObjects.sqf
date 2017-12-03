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
params ["_objType", "_objTypeR", "_objArray"];
private _return = [];
{
    if (_x isKindOf _objType) then {
        private _pos = getPos _x;
        private _dir = getDir _x;
        private _obj = createVehicle [_objTypeR, _pos, [], 0, "CAN_COLLIDE"];
        _obj attachTo [_x, [0,0,0]];
        ["hideObject", [_x, true]] call CFUNC(serverEvent);
        _obj setDir _dir;
        _return pushBack _obj;
    };
    nil
} count _objArray;
_return
