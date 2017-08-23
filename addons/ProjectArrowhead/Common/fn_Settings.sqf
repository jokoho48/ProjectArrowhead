#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Init for Common Module

    Parameter(s):
    None

    Returns:
    None
*/

#define blackListLoc ["Nifi", "Kalithea", "Agia Triada", "Telos", "Gravia", "Koroni", "Ifestiona", "Agios Petros", "Ekali"]

#define UPF []
#define VPF []
#define APF []

#define UPE ["O_soldierU_A_F"]
#define SPE ["O_sniper_F"]

#define ASPE ["O_Heli_Light_02_F"]
#define AFPE ["O_Plane_CAS_02_F"]
#define AAPE ["O_Heli_Attack_02_F"]

#define VMPE ["O_MRAP_02_gmg_F"]
#define VLPE ["O_APC_Tracked_02_cannon_F"]
#define VAPE ["O_APC_Tracked_02_AA_F"]
#define VHPE ["O_MBT_02_cannon_F"]

#define STPE ["O_GMG_01_F"]
#define STHPE ["O_GMG_01_high_F"]
#define STMPE ["O_Mortar_01_F"]

#define UPR ["I_G_Soldier_F"]
#define VPR []

#define UPC ["C_Nikos_aged"]
#define VUC []
GVAR(baseMarker) = [CFGPRAW(BaseMarker), "Base"] call CFUNC(getSetting);
GVAR(blackListLocations) = [CFGPRAW(BlackListLocations), blackListLoc] call CFUNC(getSetting);

GVAR(unitPoolFriendly) = [CFGPRAW2(Units,unitPoolFriendly), UPF] call CFUNC(getSetting);
GVAR(vehiclePoolFriendly) = [CFGPRAW2(Units,vehiclePoolFriendly), VPF] call CFUNC(getSetting);
GVAR(airPoolFriendly) = [CFGPRAW2(Units,airPoolFriendly), APF] call CFUNC(getSetting);

GVAR(unitPoolEnemy) = [CFGPRAW2(Units,unitPoolEnemy), UPE] call CFUNC(getSetting);

GVAR(vehicleMRAPPoolEnemy) = [CFGPRAW2(Units,vehicleMRAPPoolEnemy), VMPE] call CFUNC(getSetting);
GVAR(vehicleLightPoolEnemy) = [CFGPRAW2(Units,vehicleLightPoolEnemy), VLPE] call CFUNC(getSetting);
GVAR(vehicleAAPoolEnemy) = [CFGPRAW2(Units,vehicleAAPoolEnemy), VAPE] call CFUNC(getSetting);
GVAR(vehicleHeavyPoolEnemy) = [CFGPRAW2(Units,vehicleHeavyPoolEnemy), VHPE] call CFUNC(getSetting);

GVAR(airSlowPoolEnemy) = [CFGPRAW2(Units,airSlowPoolEnemy), ASPE] call CFUNC(getSetting);
GVAR(airFastPoolEnemy) = [CFGPRAW2(Units,airFastPoolEnemy), AFPE] call CFUNC(getSetting);
GVAR(airAttackPoolEnemy) = [CFGPRAW2(Units,airAttackPoolEnemy), AAPE] call CFUNC(getSetting);

GVAR(sniperPoolEnemy) = [CFGPRAW2(Units,sniperPoolEnemy), SPE] call CFUNC(getSetting);

GVAR(staticPoolEnemy) = [CFGPRAW2(Units,staticPoolEnemy), STPE] call CFUNC(getSetting);
GVAR(staticHighPoolEnemy) = [CFGPRAW2(Units,staticHighPoolEnemy), STHPE] call CFUNC(getSetting);
GVAR(staticMortarEnemy) = [CFGPRAW2(Units,staticMortarEnemy), STMPE] call CFUNC(getSetting);

GVAR(unitPoolRebels) = [CFGPRAW2(Units,unitPoolRebels), UPR] call CFUNC(getSetting);
GVAR(vehiclePoolRebels) = [CFGPRAW2(Units,vehiclePoolRebels), VPR] call CFUNC(getSetting);

GVAR(unitPoolCiv) = [CFGPRAW2(Units,unitPoolCiv), UPC] call CFUNC(getSetting);
GVAR(vehiclePoolCiv) = [CFGPRAW2(Units,vehiclePoolCiv), VUC] call CFUNC(getSetting);

GVAR(enemySide) = East;

GVAR(ignoredBuildingTypes) = [CFGPRAW(ignoredBuildingTypes), ["Piers_base_F"]] call CFUNC(getSetting);
GVAR(ignoredBuildingTypes) pushBackUnique "Piers_base_F";
