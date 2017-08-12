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
["DisplayHint", {
    (_this select 0) params ["_headerText", "_mainText", ["_color", "#ff0000"]];
    [
        format [
            "<t size='1' color='%3'>%1</t><br/><t size='0.6'>%2</t>",
            _headerText,
            _mainText,
            _color
        ]
    ] spawn BIS_fnc_dynamicText;
}] call CFUNC(addEventhandler);
