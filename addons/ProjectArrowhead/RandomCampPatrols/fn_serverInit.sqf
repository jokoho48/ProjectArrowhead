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


GVAR(randomCampCount) = 10;    // TODO: make settings
GVAR(randomPatrolCount) = 15;    // TODO: make settings
GVAR(ObjCompArray) = [["smallTestCamp", 15, false]];    // TODO: make settings
for "_i" from 1 to GVAR(randomCampCount) do {
    private _randomType = selectRandom GVAR(ObjCompArray);
    _randomType params ["_class", "_size", "_isSOF"];
    private _pos = [MGVAR(centerPos), MGVAR(worldSize), _size] call MFUNC(findRuralFlatPos);
    private _dir = [(random 2) - 1, (random 2) - 1, 0];
    _pos set [2,-(getTerrainHeightASL _pos)];
    if (_isSOF) then {
        [_class, _pos, _dir] call CFUNC(createSimpleObjectComp);
    } else {
        [_class, _pos, _dir] call MFUNC(createObjectComp);
    };
    private _aiPos = [_pos, 100, 5] call MFUNC(findRuralFlatPos);

    private _grp = [_aiPos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [[_grp, _aiPos], (random [1000, 1500, 2000])] call MFUNC(taskPatrol);

    private _mrk = createMarker [format[QGVAR(CampPos_%1), _pos], _pos];
    _mrk setMarkerType "mil_triangle";
    _mrk setMarkerText "Random Camp Pos";
    _mrk setMarkerColor "ColorEAST";
};

for "_i" from 1 to GVAR(randomPatrolCount) do {
    private _aiPos = [MGVAR(centerPos), MGVAR(worldSize), 5] call MFUNC(findRuralFlatPos);

    private _grp = [_aiPos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [[_grp, _aiPos], (random [1000, 1500, 2000])] call MFUNC(taskPatrol);
};
