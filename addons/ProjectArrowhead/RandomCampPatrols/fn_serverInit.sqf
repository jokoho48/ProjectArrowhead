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

[{

    GVAR(ObjCompArray) = [];

    {
        GVAR(ObjCompArray) pushBack [
            [configName _x, getText (_x >> "className")] select isText (_x >> "className"),
            getNumber(_x >> "size"),
            getNumber(_x >> "useSOF") isEqualTo 1
        ];
        nil
    } count configProperties [MISSIONCLASS >> "RandomCampCompositions", "isClass _x", true];
    GVAR(randomCampCount) = [CFGPRAW2(RandomCampPatrols,randomCampCount), 5] call CFUNC(getSetting);
    GVAR(randomPatrolCount) = [CFGPRAW2(RandomCampPatrols,randomPatrolCount), 5] call CFUNC(getSetting);
    GVAR(randomPatrolVehCount) = [CFGPRAW2(RandomCampPatrols,randomPatrolVehCount), 2] call CFUNC(getSetting);
    for "_i" from 1 to GVAR(randomCampCount) do {
        private _randomType = selectRandom GVAR(ObjCompArray);
        _randomType params ["_class", "_size", "_isSOF"];
        private _pos = [MGVAR(centerPos), MGVAR(worldSize), _size] call MFUNC(findRuralFlatPos);
        private _dir = [(random 2) - 1, (random 2) - 1, 0];
        _pos set [2,-(getTerrainHeightASL _pos)];
        if (_isSOF) then {
            [_class, _pos, _dir] call CFUNC(createSimpleObjectComp);
        } else {
            private _objs = [_class, _pos, _dir] call MFUNC(createObjectComp);
            {
                private _pos = getPos _x;
                _pos set [2,0];
                _x setPos _pos;
                _x setVectorUp (surfaceNormal _pos);
            } count _objs;
        };
        private _pos = [_pos, 100, 5] call MFUNC(findRuralFlatPos);

        private _grp = [_pos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
        [[_grp, _pos], (random [1000, 1500, 2000])] call MFUNC(taskPatrol);

        #ifdef ISDEV
        private _mrk = createMarker [format[QGVAR(CampPos_%1), _pos], _pos];
        _mrk setMarkerType "mil_triangle";
        _mrk setMarkerText "Random Camp Pos";
        _mrk setMarkerColor "ColorEAST";
        #endif
    };

    for "_i" from 1 to GVAR(randomPatrolCount) do {
        private _pos = [MGVAR(centerPos), MGVAR(worldSize), 5] call MFUNC(findRuralFlatPos);

        private _grp = [_pos, 0, floor (random [2, 4, 6]), east] call MFUNC(spawnGroup);
        [[_grp, _pos], (random [1000, 1500, 2000])] call MFUNC(taskPatrol);

        #ifdef ISDEV
        private _mrk = createMarker [format[QGVAR(RInfPatrolStart_%1), _pos], _pos];
        _mrk setMarkerType "mil_triangle";
        _mrk setMarkerText "Random Inf Patrol";
        _mrk setMarkerColor "ColorEAST";
        #endif
    };

    // Spawn Vehicles
    private _posArray = [MGVAR(centerPos), MGVAR(worldSize), 0, GVAR(randomPatrolVehCount), true, 10] call MFUNC(findPosArray);
    {
        private _pos = [_x, 1000, 5] call MFUNC(findRuralFlatPos);
        private _vehicles = [_pos, 1, 1, east] call MFUNC(spawnGroup);
        {
            [_x, (random [1000, 1500, 2000]), false] call MFUNC(setPatrolVeh);
            nil
        } count _vehicles;

        #ifdef ISDEV
        private _mrk = createMarker [format[QGVAR(RInfPatrolStart_%1), _pos], _pos];
        _mrk setMarkerType "mil_triangle";
        _mrk setMarkerText "Random Veh Patrol";
        _mrk setMarkerColor "ColorEAST";
        #endif
        nil
    } count _posArray;
}, 120] call CFUNC(wait);
