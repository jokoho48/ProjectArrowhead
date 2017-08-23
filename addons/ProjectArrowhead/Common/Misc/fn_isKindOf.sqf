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
params [["_obj", objNull, [objNull, ""]], ["_typeArray", [], [[]]], ["_targetConfig", configNull, [configNull]]];
if (isNull _targetConfig) then {
    {
        if (_obj isKindOf _x) then {
            true breakOut SCRIPTSCOPENAME;
        };
    } count _typeArray;
} else {
    {
        if (_obj isKindOf [_x, _targetConfig]) then {
            true breakOut SCRIPTSCOPENAME;
        };
    } count _typeArray;
};
false
