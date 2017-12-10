#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    DONT CALL THAT SCRIPT
    creates the Real Patrol use MFUNC(taskPatrol)

    Parameter(s):
    DONT CALL THAT SCRIPT

    Returns:
    DONT CALL THAT SCRIPT
*/
RUNTIMESTART;
params ["_grp", "_maxRange", "_houseArray", ["_waypointCount", 5]];
private _minDist = _maxRange * 0.30;
private _waypointsrange = 5;
private _posArray = [];
private _pos1 = if (_grp isEqualType []) then {
    private _temp = _grp select 1;
    _grp = _grp select 0;
    _temp
} else {
    getPosATL (leader _grp);
};
private _wpindex = 0;
private _usesHouses = !(_houseArray isEqualTo []);

for "_i" from 1 to 100 do {
    if (_usesHouses && {RND(45)}) then {
        private _house = selectRandom _houseArray;
        private _housePosArray = _house buildingPos -1;
        _houseArray deleteAt (_houseArray find _house);
        if !(_housePosArray isEqualTo []) then {
            private _pos2 = getPos _house;
            if (_pos2 call FUNC(nearBase)) exitWith {};
            _posArray pushBack _pos2;
            _wpindex = _wpindex + 1;
            private _wp = _grp addWaypoint [_pos2, 0];
            _wp setWaypointType (selectRandom ["MOVE", "LOITER"]);
            _wp waypointAttachObject _house;
            [_grp, _wpindex] setWaypointHousePosition floor(random(count _housePosArray));
            [_grp, _wpindex] setWaypointBehaviour "SAFE";
            [_grp, _wpindex] setWaypointCombatMode "RED";
            [_grp, _wpindex] setWaypointCompletionRadius _waypointsrange;
            [_grp, _wpindex] setWaypointLoiterRadius _waypointsrange;
            [_grp, _wpindex] setWaypointTimeout [2,20,6];
            [_grp, _wpindex] setWaypointStatements ["true", DFUNC(exitPatrol)];
        };
    } else {
        private _dir = random 360;

        private _range = (ceil random _maxRange);
        private _pos2 = [(_pos1 select 0) + (sin _dir) * _range, (_pos1 select 1) + (cos _dir) * _range, 0];
        if !(surfaceIsWater _pos2) then {
            if !([_pos2, _minDist, _posArray] call FUNC(nearPositions)) then {
                if (_pos2 call FUNC(nearBase) || !(_pos2 call FUNC(isOnMap))) exitWith {};
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
    };
    if (count _posArray isEqualTo _waypointCount) then {
        [_grp, _wpindex] setWaypointStatements ["true", "(group this) setCurrentWaypoint [group this, 1];" + DFUNC(exitPatrol)];
        breakTo SCRIPTSCOPENAME;
    };
};
_grp setCurrentWaypoint [_grp, 1];
RUNTIME("InfPatrol");
