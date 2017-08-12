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
params ["_driver", "_maxRange", "_isAir", ["_height", 160]];

private _pos1 = if (_driver isEqualType []) then {
    private _temp = _driver select 1;
    _driver = _driver select 0;
    _temp
} else {
    getPosATL _driver;
};

_maxRange = _maxRange min 1000;
_driver setBehaviour "SAFE";
private _veh = vehicle _driver;
if (isNil "_isAir") then {
    _isAir = _veh isKindOf "Air";
};
private _grp = group _driver;
private _wpindex = 0;
private _waypointsrange = 5;
private _posArray = [];
private _minDist = _maxRange * 0.30;

if !(_isAir) then {
    private _roads = _veh nearRoads _maxRange;
    _veh forceSpeed (_veh getSpeed "SLOW");

    if (_roads isEqualTo []) then {


        for "_i" from 1 to 100 do {
            private _dir = random 360;
            private _range = (ceil random _maxRange);
            private _pos2 = [(_pos1 select 0) + (sin _dir) * _range, (_pos1 select 1) + (cos _dir) * _range, 0];
            if !(surfaceIsWater _pos2) then {
                if ({(_pos2 distance _x) < _minDist} count _posArray isEqualTo 0) then {
                    if (_pos2 call FUNC(nearBase)) exitWith {};
                    _posArray pushBack _pos2;
                    _wpindex = _wpindex + 1;
                    private _wp = _grp addWaypoint [_pos2, 0];
                    _wp setWaypointType (selectRandom ["MOVE", "LOITER"]);
                    [_grp, _wpindex] setWaypointBehaviour "SAFE";
                    [_grp, _wpindex] setWaypointCombatMode "RED";
                    [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
                    [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
                    [_grp, _wpindex] setWaypointTimeout [2,20,6];
                    [_grp, _wpindex] setWaypointStatements ["true", DFUNC(exitPatrol)];
                };
            };
            if (count _posArray isEqualTo 5) then {
                [_grp, _wpindex] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];" + DFUNC(exitPatrol)];
                breakOut SCRIPTSCOPENAME;
            };
        };
    } else {
        for "_i" from 1 to 100 do {
            private _road = selectRandom _roads;
            if (({(_road distance _x) < _minDist} count _posArray) isEqualTo 0) then {
                if ((getPos _road) call FUNC(nearBase)) exitWith {};
                _posArray pushBack (getPosATL _road);
                _wpindex = _wpindex + 1;
                private _wp = _grp addWaypoint [(getPosATL _road), 0];
                _wp setWaypointType (selectRandom ["MOVE", "LOITER"]);
                [_grp, _wpindex] setWaypointBehaviour "SAFE";
                [_grp, _wpindex] setWaypointCombatMode "RED";
                [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
                [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
                [_grp, _wpindex] setWaypointTimeout [2,20,6];
                [_grp, _wpindex] setWaypointStatements ["true", DFUNC(exitPatrol)];
            };

            if (count _posArray isEqualTo 5) then {
                [_grp, _wpindex] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];" + DFUNC(exitPatrol)];
                breakOut SCRIPTSCOPENAME;
            };
        };
    };
} else {
    _veh flyInHeight _height;

    for "_i" from 1 to 100 do {
        private _dir = random 360;
        private _range = (ceil random _maxRange);
        private _pos2 = [(_pos1 select 0) + (sin _dir) * _range, (_pos1 select 1) + (cos _dir) * _range, _height];
           if ({(_pos2 distance _x) < _minDist} count _posArray isEqualTo 0) then {
             _posArray pushBack _pos2;
             _wpindex = _wpindex + 1;
             private _wp = _grp addWaypoint [_pos2, 0];
             _wp setWaypointType "MOVE";
             [_grp, _wpindex] setWaypointBehaviour "SAFE";
             [_grp, _wpindex] setWaypointCombatMode "RED";
             [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
             [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
             [_grp, _wpindex] setWaypointStatements ["true", DFUNC(exitPatrol)];
         };

        if (count _posArray isEqualTo 5) then {
            [_grp, _wpindex] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];" + DFUNC(exitPatrol)];
            breakTo SCRIPTSCOPENAME;
        };
    };
};
