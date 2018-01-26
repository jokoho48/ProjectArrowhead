#include "macros.hpp"
class CfgPatches {
    class ProjectArrowhead {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.72;
        author = "joko // Jonas & ShadowFox";
        authors[] = {"joko // Jonas", "ShadowFox"};
        authorUrl = "https://twitter.com/joko48Ger";
        version = VERSION;
        versionStr = QUOTE(VERSION);
        versionAr[] = {VERSION_AR};
        requiredAddons[] = {"CLib"};
    };
};

class CfgCLibSettings {
    ProjectArrowhead[] = {"ProjectArrowhead"};
};

#include "CfgCLibModules.hpp"
#include "CfgObjectComp.hpp"
#include "CfgSettings.hpp"
