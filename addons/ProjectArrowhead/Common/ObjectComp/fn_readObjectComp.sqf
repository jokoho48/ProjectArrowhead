#include "macros.hpp"
/*
    Community Lib - CLib

    Author: joko // Jonas

    Description:


    Parameter(s):
    0: Config Path <Config>
    1: Name <String> (Default: ConfigName of the ConfigPath)

    Remarks:
    this function only work properly on the Server on Mod Config

    Returns:
    ObjectStructure <Array>
*/
params [["_config", configNull, [configNull]], "_name"];
if (isNil "_name" || {_name isEqualTo ""}) then {
    _name = configName _config;
};

private _fnc_readObjectClass = {
    params ["_config"];

    private _path = getText (_config >> "classname");
    private _offset = getArray (_config >> "offset");
    private _dir = getArray (_config >> "dirVector");
    private _up = getArray (_config >> "upVector");
    private _sim = ((getNumber (_config >> "Simulate")) == 1);
    if (_up isEqualTo []) then {
        _up = [0, 0, 0];
    };
    if (_dir isEqualTo []) then {
        _dir = [0, 0, 0];
    };
    if (_offset isEqualTo []) then {
        _offset = [0, 0, 0];
    };

    [_path, _offset, _dir, _up, _sim]
};

private _return = [];
private _childs = configProperties [_config, "isClass _x", true];
private _alignOnSurface = getNumber (_config >> "alignOnSurface");

if (_childs isEqualTo []) then {
    _return pushBack (_config call _fnc_readObjectClass);
} else {
    {
        _return pushBack (_x call _fnc_readObjectClass);
        nil
    } count _childs;
};
_return = [_alignOnSurface, _return];

GVAR(objComp) setVariable [_name, _return, true];
_return;

/* return
[
    [
        "PATH",
        [offset],
        [dir],
        [up],
        [ // this array can be replace with a Simple FALSE what mean that this gets ignored
            ["hideSelectionName1", true],
            ["hideSelectionName2", fase]
        ],
        [ // this array can be replace with a Simple FALSE what mean that this gets ignored
            [
                ["AnimName", phase, speed]
            ]
        ],
        [ // this array can be replace with a Simple FALSE what mean that this gets ignored
            [id, Texture]
        ]
    ]
]
*/
