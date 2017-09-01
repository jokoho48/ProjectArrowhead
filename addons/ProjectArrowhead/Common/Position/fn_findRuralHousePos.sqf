#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    get a Random House Pos from a Center Pos

    Parameter(s):
    0: Center Position <Position>
    1: Range for Searching <Number>

    Returns:
    0: Return <Type>
*/
params ["_center", "_range"];
private _return = [objNull,[0,0,0]];
for "_s" from 0 to 200 do {
    scopeName "HousePosLoop";
    private _startPos = [_center, 0, _range] call FUNC(selectRandomPos);
    if (!(_startPos call FUNC(nearBase))) then {
        {
            if (_startPos distance _x < 700) exitWith {breakTo "HousePosLoop";};
        } count GVAR(locations);
        private _houseArray = [_startPos,500] call FUNC(findHousePos);
        if (isNull (_houseArray select 0)) exitWith {};
        _return = _houseArray;
    };
};

_return
