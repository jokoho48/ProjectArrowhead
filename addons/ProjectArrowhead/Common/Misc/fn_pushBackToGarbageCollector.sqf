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
params ["_obj"];
switch (typeName _obj) do {
    case ("ARRAY"): {
        {
            GARBAGE(_x);
            nil
        } count _obj
    };
    case ("OBJECT"): {
        _obj call CLib_GarbageCollector_fnc_pushbackInQueue;
    };
    case ("GROUP"): {
        {
            if (vehicle _x != _x) then {
                _x call CLib_GarbageCollector_fnc_pushbackInQueue;
            };
            _x call CLib_GarbageCollector_fnc_pushbackInQueue;
            nil
        } count (units _obj)
    };
};
