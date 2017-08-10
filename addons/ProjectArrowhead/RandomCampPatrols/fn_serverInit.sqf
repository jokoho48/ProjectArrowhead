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


GVAR(randomCampCount) = 3;    // TODO: make settings
GVAR(randomPatrolCount) = 5;    // TODO: make settings
GVAR(ObjComp) = [["oneRandomCampName", 15]];    // TODO: make settings
for "_i" from 1 to GVAR(randomCampCount) do {
    private _randomType = selectRandom GVAR(ObjComp);
    _randomType params ["_class", "_size"];
    private _pos = [MGVAR(centerPos), MGVAR(worldSize), _size] call MFUNC(findRuralFlatPos);
    private _mrk = createMarker [format[QGVAR(CampPos_%1), _pos], _pos];
    _mrk setMarkerType "mil_triangle";
    _mrk setMarkerText "Random Camp Pos";
    _mrk setMarkerColor "ColorEAST";

    // TODO: Create test Camp with SOF
    // [_class, _pos, random 360] call CFUNC(createSimpleObjectComp);
    private _aiPos = [_pos, 100, 5] call MFUNC(findRuralFlatPos);

    private _grp = [_aiPos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [[_grp, _aiPos], (random [1000, 1500, 2000])] call MFUNC(taskPatrol);
};

for "_i" from 1 to GVAR(randomPatrolCount) do {
    private _aiPos = [MGVAR(centerPos), MGVAR(worldSize), 5] call MFUNC(findRuralFlatPos);

    private _grp = [_aiPos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [[_grp, _aiPos], (random [1000, 1500, 2000])] call MFUNC(taskPatrol);
};
