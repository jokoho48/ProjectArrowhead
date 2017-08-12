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
params [["_pos", [0,0,0], [[]]], ["_range", 100, [0]], ["_count", 1, [0]], ["_type", -1, [0]], ["_side", GVAR(enemySide)]];

private _gunnerArray = [];
private _posArray = [];

private _random = _type isEqualTo -1;
private _roads = _pos nearRoads _range;

for "_s" from 0 to 100 do {
    if (_random) then {_type = floor random 2};
    call {

        if (_type isEqualTo 0) exitWith { // open static
            if (count _roads < 1) exitWith {};
            private _road = selectRandom _roads;
            private _roadConnectedTo = (roadsConnectedTo _road) select 0;
            if (isNil "_roadConnectedTo") exitWith {};
            private _dir = _road getDir _roadConnectedTo;
            private _staticPos = [getPosATL _road, getPosATL _roadConnectedTo] call FUNC(findTriPos);
            private _check = _staticPos isFlatEmpty [2, 0, 0.4, 2, 0, false, objNull];

            {
                if (_x distance _staticPos < 20) exitWith {_check = []};
                nil
            } count _posArray;
            if (_check isEqualTo [] || {isOnRoad _staticPos}) exitWith {};

            _posArray pushBack _staticPos;
            private _static = GETCLASS(_side,"static") createVehicle [0,0,0];
            _static setPos _staticPos;
            _static setVectorUp surfaceNormal getPos _static;
            private _lis = lineIntersectsSurfaces [(getPosASL _static) vectorAdd [0,0,0.5], ATLToASL(_static modelToWorld [0,30,0.5]), _static];
            if !(_lis isEqualTo []) exitWith {deleteVehicle _static;};

            private _grp = createGroup _side;
            private _gunner = _grp createUnit [GETCLASS(_side,"inf"), [0,0,0], [], 0, "NONE"];
            _gunner moveInGunner _static;
            _gunner setBehaviour "COMBAT";
            _gunner setFormDir (_dir + 180);
            _gunner setDir (_dir + 180);
            _gunnerArray pushBack _gunner;
        };
        if (_type isEqualTo 1) exitWith { // bunkered static
            if (count _roads < 1) exitWith {};
            private _road = selectRandom _roads;
            private _roadConnectedTo = (roadsConnectedTo _road) select 0;
            if (isNil "_roadConnectedTo") exitWith {};
            private _dir = _road getDir _roadConnectedTo;
            private _staticPos = [getPosATL _road, getPosATL _roadConnectedTo] call FUNC(findTriPos);
            private _check = _staticPos isFlatEmpty [2, 0, 0.4, 3, 0, false, objNull];

            if (count _posArray > 0) then {
                {
                    if (_x distance _staticPos < 20) exitWith {
                        _check = []
                    };
                    nil
                } count _posArray;
            };
            if (_check isEqualTo [] || isOnRoad _staticPos) exitWith {};

            _staticPos set [2,-0.02];
            _posArray pushBack _staticPos;
            private _bunker = "Land_BagBunker_Small_F" createVehicle _staticPos;
            _bunker setDir _dir + 180;
            _bunker setVectorUp surfaceNormal (getPos _bunker);

            private _lis = lineIntersectsSurfaces [getPosASL _bunker vectorAdd [0,0,1], ATLToASL(_bunker modelToWorld [0,30,1]), _bunker];
            if !(_lis isEqualTo []) exitWith {deleteVehicle _bunker;};
            private _static = createVehicle [GETCLASS(_side, "statichigh"), [0,0,0], [], 0, "CAN COLLIDE"];
            _static setPosATL (_bunker modelToWorld [0,0,-0.8]);

            private _grp = createGroup _side;
            private _gunner = _grp createUnit [GETCLASS(_side, "inf"), [0,0,0], [], 0, "NONE"];
            _gunner moveInGunner _static;
            _gunner setBehaviour "COMBAT";
            _gunner doWatch (_bunker modelToWorld [0,-40,1]);
            //_gunner disableAI "MOVE";
            _gunnerArray pushBack _gunner;
        };
         // mortar
        private _staticPos = [_pos, 0, _range] call FUNC(selectRandomPos);
        private _check = _staticPos isFlatEmpty [3, 0, 0.55, 3, 0, false, objNull];

        if (count _posArray > 0) then {
            {
                if (_x distance _staticPos < 20) exitWith {
                    _check = [];
                };
            } forEach _posArray;
        };
        if (_check isEqualTo [] || isOnRoad _staticPos) exitWith {};

        _posArray pushBack _staticPos;
        private _static = GETCLASS(_side, "staticmortar") createVehicle _staticPos;


        {
            private _fort = "Land_BagFence_Round_F" createVehicle [0,0,0];
            private _fortPos = _static modelToWorld _x;
            _fortPos set [2,0];
            _fort setPosATL _fortPos;
            _fort setDir (_fort getDir _static);
            _fort setVectorUp (surfaceNormal (getPos _fort));
            nil
        } count [
            [0,2.3,0],
            [0,-2.3,0],
            [-2.3,0,0],
            [2.3,0,0]
        ];
        private _grp = createGroup _side;
        private _gunner = _grp createUnit [GETCLASS(_side, "inf"), [0,0,0], [], 0, "NONE"];
        _gunner moveInGunner _static;
        _gunner setBehaviour "COMBAT";
        //_gunner disableAI "MOVE";
        _gunnerArray pushBack _gunner;
    };

    if (count _gunnerArray isEqualTo _count) exitWith {};
};

#ifdef ISDEV
{
    [getPos _x, "mil_triangle", "ColorEAST", (getDir _x), "STATIC"] call FUNC(createMarker);
    nil
} count _gunnerArray;
#endif


_gunnerArray
