#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Find Multible Positions (near Roads or on Flat Pos)

    Parameter(s):
    0: Center Position <Position>
    1: Range for Searching <Number>
    2: Minimal Distance <Number>
    3: Amount of Positions <Number>
    4: Use Road Positions <Boolean>
    5: Positon Buffer <Number>
    Returns:
    0: Return <Type>
*/

params [["_center", [], [[]]],["_range", 100, [0]],["_minDist", 0, [0]],["_count", 1, [0]],["_ifRoad", false],["_posBuffer", 5, [0]]];

private _posArray = [];

if (_minDist >= _range) then {_minDist = ((_range*0.25)/(_count*2))};

for "_s" from 0 to 200 do {
    private _usePos = true;
    private "_pos";
    if (_ifRoad) then {
        _range = _range min 1000;
        private _roads = _center nearRoads _range;
        _pos = getPosATL (selectRandom _roads);
        if (_pos call FUNC(nearBase)) exitWith { _usePos = false; };
        if (count _posArray >= 1) then {
            {
                if (_x distance _pos < _minDist ) exitWith {
                    _usePos = false;
                };
                nil
            } count _posArray;
        };
    } else {
        _pos = [_center,0,_range] call FUNC(selectRandomPos);
        private _isEmpty = _pos isFlatEmpty [_posBuffer, 0, 1, _posBuffer, 0, false, objNull];
        if !(count _isEmpty isEqualTo 0) then {
            if !(count (_pos nearRoads 12) isEqualTo 0) exitWith { _usePos = false; };
            if (_pos call FUNC(nearBase)) exitWith { _usePos = false; };
            if (count _posArray >= 1) then {
                {
                     if (_x distance _pos < _minDist) exitWith { _usePos = false; };
                     nil
                } count _posArray;
            };
        } else {
            _usePos = false;
        };
    };

    if (_usePos) then {_posArray pushBack _pos};
    if (count _posArray isEqualTo _count) exitWith {};
};
if (_posArray isEqualTo []) then {LOG("no Postions found")};
_posArray
