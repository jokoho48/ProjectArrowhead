#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Finds a Random Flat Position

    Parameter(s):
    0: Position <Position>
    1: Range for Searching <Number>
    2: Clearence Distance <Number>
    3: Minimal Range for Searching <Number> (default: 0)

    Returns:
    0: Return <Type>
*/

params ["_center", "_range", "_dist", ["_minRange", 0]];

private _pos = [0,0,0];

for "_s" from 0 to 200 do {
    _pos = [_center, _minRange, _range] call FUNC(selectRandomPos);
    if (!(_pos call FUNC(nearBase))) then {
        if (count (_pos isFlatEmpty [1, 0, 0.3, 30, 0, false, objNull]) != 0 && {count (_pos isFlatEmpty [1, 0, 0.12, _dist min 300, 0, false, objNull]) != 0}) then {
            if ((nearestObjects [_pos, ["house"], _dist]) isEqualTo []) then {
                private _dummypad = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
                _dummypad setPos _pos;
                if !(
                    surfaceIsWater (_dummypad modelToWorld [0,-100,0])
                     || {surfaceIsWater (_dummypad modelToWorld [0,100,0])}
                     || {surfaceIsWater (_dummypad modelToWorld [100,0,0])}
                     || {surfaceIsWater (_dummypad modelToWorld [-100,0,0])}
                     || {surfaceIsWater (_dummypad modelToWorld [0,0,0])}
                ) then {
                    deleteVehicle _dummypad;
                    breakTo SCRIPTSCOPENAME;
                };

                deleteVehicle _dummypad;
            };
        };
    };
};

if (_pos isEqualTo [0,0,0]) then {LOG("No Position Found");};


_pos
