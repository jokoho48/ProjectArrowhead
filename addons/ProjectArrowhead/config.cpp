#include "macros.hpp"
class CfgPatches {
    class ProjectArrowhead {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.72;
        author = "joko // Jonas & ShadowFox";
        authors[] = {"joko // Jonas", "ShadowFox"};
        authorUrl = "";
        version = VERSION;
        versionStr = QUOTE(VERSION);
        versionAr[] = {VERSION_AR};
        requiredAddons[] = {"CLib"};
    };
};

#include "CfgCLibModules.hpp"
class CfgObjectComp {
    class smallTestCamp {
        alignOnSurface = 0;
        class item0 {
            classname = "Land_TentA_F";
            offset[] = {-1.89258, 2.54102, 0};
            dirVector[] = {-0.579043, 0.815297, 0};
            upVector[] = {0, 0, 1};
        };
        class item1 {
            classname = "Land_TentA_F";
            offset[] = {-1.20703, -3.02344, 0};
            dirVector[] = {-0.338339, -0.941024, 0};
            upVector[] = {0, 0, 1};
        };
        class item2 {
            classname = "Land_TentA_F";
            offset[] = {3.07031, 0.328125, 0};
            dirVector[] = {0.996812, 0.0797868, 0};
            upVector[] = {0, 0, 1};
        };
        class item3 {
            classname = "Land_FirePlace_F";
            offset[] = {0.03125, 0.158203, 0};
            dirVector[] = {0, 1, 0};
            upVector[] = {0, 0, 1};
        };
    };
};
