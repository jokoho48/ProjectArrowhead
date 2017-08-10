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
params [["_center", [0,0,0]], ["_range", 100, [0]]];
private _pos = [0,0,0];
private _return = [objNull,[[0,0,0]]];

private _houseArray = _center nearObjects ["House",_range];
if !(_houseArray isEqualTo []) then {
    private _house = selectRandom _houseArray;
    private _housePosArray = _house buildingPos -1;

    if !(_housePosArray isEqualTo []) then {
        {
            private _dummypad = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
            _dummypad setPos _x;
            if !((lineIntersectsObjs [(getPosASL _dummypad), [(getPosASL _dummypad select 0),(getPosASL _dummypad select 1),((getPosASL _dummypad select 2) + 20)]]) isEqualTo []) exitWith { // TODO: replace with ILS
                deleteVehicle _dummypad;
                [_house, _x] breakOut SCRIPTSCOPENAME;
            };
            deleteVehicle _dummypad;
            nil
        } count _housePosArray;
    };
};
_return
