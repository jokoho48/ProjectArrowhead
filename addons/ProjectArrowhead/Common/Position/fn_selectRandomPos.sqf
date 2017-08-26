#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Find a Random Position

    Parameter(s):
    0: Center Position <Position>
    1: Minimal Distance <Number>
    2: Maximal Distance <Number>
    3: Limiting to a Direction Angle <Array<Number>> [Dont need to be defined.]
    4: Retry Counter <Number> (default: 5)

    Returns:
    0: Return <Type>
*/
params [["_center", [], [[]]],["_min", 0, [0]],["_max", 100, [0]],["_dirArray", [], [[]]], ["_counter", 5]];
private _dir = if (_dirArray isEqualTo []) then {
    random 360
} else {
    _dirArray params ["_dMin", "_dMax"];
    (_dMin + random _dMax) min _dMax;
};
private _range = (ceil (random _max)) max _min;
private _pos = [(_center select 0) + (sin _dir) * _range, (_center select 1) + (cos _dir) * _range, 0];
if (_pos call FUNC(nearBase) && _counter != 0) exitWith {
    [_center, _min, _max, _dirArray, _counter - 1] call (missionNamespace getVariable [_fnc_scriptName, {}]);
};
_pos
