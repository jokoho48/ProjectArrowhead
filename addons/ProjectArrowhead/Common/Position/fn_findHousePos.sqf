#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Find a Position in a Building around a Center Pos

    Parameter(s):
    0: Center Position <Position>
    1: Range <Number>

    Returns:
    0: Hose object <Object>
    1: Building Position <Position>
*/
params [["_center", [0,0,0]], ["_range", 100, [0]]];

private _houseArray = (_center nearObjects ["House",_range]) select {!([_x, GVAR(ignoredBuildingTypes)] call MFUNC(isKindOf))};
if !(_houseArray isEqualTo []) then {
    private _house = selectRandom _houseArray;
    private _housePosArray = _house buildingPos -1;

    if !(_housePosArray isEqualTo []) then {
        {
            private _dummypad = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
            _dummypad setPos _x;
            private _lis = lineIntersectsSurfaces [(getPosASL _dummypad), (getPosASL _dummypad) vectorAdd [0, 0, 20]];
            if !(_lis isEqualTo []) exitWith {
                deleteVehicle _dummypad;
                [_house, _x] breakOut SCRIPTSCOPENAME;
            };
            deleteVehicle _dummypad;
            nil
        } count _housePosArray;
    };
};
[objNull,[[0,0,0]]] // Default Return when no pos was found
