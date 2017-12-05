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
params ["_input", "_pos", "_dir", ["_ignoreObj1", objNull], ["_ignoreObj2", objNull]];

private _inputData = GVAR(objComp) getVariable _input;

if (isNil "_inputData" || {_input isEqualTo []}) exitWith {
    LOG("ERROR ObjectComp Dont exist: " + _input);
    []
};

_inputData params ["_alignOnSurface", "_objects"];

private _intersections = lineIntersectsSurfaces [
    AGLToASL _pos,
    AGLToASL _pos vectorAdd [0, 0, -1000],
    _ignoreObj1,
    _ignoreObj2
];

private _normalVector = (_intersections select 0) select 1;
private _posVectorASL = (_intersections select 0) select 0;

private _originObj = "Land_HelipadEmpty_F" createVehicleLocal [0, 0, 0];
_originObj setPosASL _posVectorASL;

private _xVector = _dir vectorCrossProduct _normalVector;
_dir = _normalVector vectorCrossProduct _xVector;
private _ovUp = [[0, 0, 1], _normalVector] select _alignOnSurface;

_originObj setVectorDirAndUp [_dir, _ovUp];

private _originPosAGL = _originObj modelToWorld [0, 0, 0];
private _originPosASL = AGLToASL _originPosAGL;

private _return = [];
{
    _x params ["_class", "_posOffset", "_dirOffset", "_upOffset", "_sim", "_snap"];

    private _obj = createVehicle [_class, [0, 0, 0], [], 0, "CAN_COLLIDE"];
    if !(_sim) then {
        _obj enableSimulationGlobal false;
    } else {
        _obj enableDynamicSimulation true;
    };
    private _pos = _originObj modelToWorld _posOffset;
    if (_snap) then {
        _pos set [2, 0];
    };
    _obj setPos _pos;
    _obj setVectorDirAndUp [AGLToASL (_originObj modelToWorld _dirOffset) vectorDiff _originPosASL, AGLToASL (_originObj modelToWorld _upOffset) vectorDiff _originPosASL];
    _return pushBack _obj;
    nil
} count _objects;

deleteVehicle _originObj;
{
    ["addCuratorEditableObjects", [_x, [_return, true]]] call CFUNC(serverEvent);
    nil
} count allCurators;
_return;
