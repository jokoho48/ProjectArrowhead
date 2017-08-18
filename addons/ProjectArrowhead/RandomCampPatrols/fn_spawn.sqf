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

private _aoPos = MGVAR(centerPos);
private _posArray = [_aoPos, MGVAR(worldSize)*3, MGVAR(mainAOSize)*4, GVAR(randomCampCount), false, 10] call MFUNC(findPosArray);

{
    private _pos = _x;
    private _randomType = selectRandom GVAR(ObjCompArray);
    _randomType params ["_class", "_size", "_isSOF"];

    private _dir = [(random 2) - 1, (random 2) - 1, 0];
    _pos set [2,-(getTerrainHeightASL _pos)];

    if (_isSOF) then {
        [_class, _pos, _dir] call CFUNC(createSimpleObjectComp);
    } else {
        private _objs = [_class, _pos, _dir] call MFUNC(createObjectComp);
        {
            private _pos = getPosASL _x;
            private _ils = (lineIntersectsSurfaces [_pos vectorAdd [0,0,10], _pos vectorAdd [0,0,-100], _x, objNull]) select 0;
            _x setVectorUp (_ils select 1);
            _x setPosASL (_ils select 0);
            nil
        } count _objs;
    };

    private _grp = [_pos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [[_grp, _pos], (random [300, 500, 700])] call MFUNC(taskPatrol);

    #ifdef ISDEV
    [_pos, "mil_triangle", "ColorEAST", 0, "Random Camp Pos"] call MFUNC(createMarker);
    #endif
    nil
} count _posArray;

for "_i" from 1 to GVAR(randomCampCount) do {

};

for "_i" from 1 to GVAR(randomPatrolCount) do {
    private _pos = [_aoPos, MGVAR(worldSize)*4, 5, MGVAR(mainAOSize)*4] call MFUNC(findRuralFlatPos);
    while {surfaceIsWater _pos} do {
        _pos = [_aoPos, MGVAR(worldSize)*4, 5, MGVAR(mainAOSize)*4] call MFUNC(findRuralFlatPos);
    };
    private _grp = [_pos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
    [[_grp, _pos], (random [500, 700, 1000])] call MFUNC(taskPatrol);

    #ifdef ISDEV
    [_pos, "mil_triangle", "ColorEAST", 0, "Random Inf Patrol"] call MFUNC(createMarker);
    #endif
};

// Spawn Vehicles
for "_i" from 1 to GVAR(randomPatrolVehCount) do {
    private _pos = [_aoPos, MGVAR(worldSize)*4, 5, MGVAR(mainAOSize)*4] call MFUNC(findRuralFlatPos);
    while {surfaceIsWater _pos} do {
        _pos = [_aoPos, MGVAR(worldSize)*4, 5, MGVAR(mainAOSize)*4] call MFUNC(findRuralFlatPos);
    };
    private _vehicles = [_pos, [1, round (random 2)], 1, east] call MFUNC(spawnGroup);
    {
        [_x, (random [1500, 2000, 2500]), false] call MFUNC(setPatrolVeh);
        nil
    } count _vehicles;

    #ifdef ISDEV
    [_pos, "mil_triangle", "ColorEAST", 0, "Random Veh Patrol"] call MFUNC(createMarker);
    #endif
};
