#include "macros.hpp"
/*
    Project Arrowhead

    Author: joko // Jonas

    Description:
    Settings for Units and other Stuff requried in missions

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
GVAR(unitPoolFriendly) = GVAR(unitPoolFriendly) call FUNC(flattenArray);
GVAR(unitPoolFriendly) = GVAR(unitPoolFriendly) call CFUNC(shuffleArray);

GVAR(vehiclePoolFriendly) = [CFGPRAW2(Units,vehiclePoolFriendly), VPF] call CFUNC(getSetting);
GVAR(vehiclePoolFriendly) = GVAR(vehiclePoolFriendly) call FUNC(flattenArray);
GVAR(vehiclePoolFriendly) = GVAR(vehiclePoolFriendly) call CFUNC(shuffleArray);

GVAR(airPoolFriendly) = [CFGPRAW2(Units,airPoolFriendly), APF] call CFUNC(getSetting);
GVAR(airPoolFriendly) = GVAR(airPoolFriendly) call FUNC(flattenArray);
GVAR(airPoolFriendly) = GVAR(airPoolFriendly) call CFUNC(shuffleArray);


GVAR(unitPoolEnemy) = [CFGPRAW2(Units,unitPoolEnemy), UPE] call CFUNC(getSetting);
GVAR(unitPoolEnemy) = GVAR(unitPoolEnemy) call FUNC(flattenArray);
GVAR(unitPoolEnemy) = GVAR(unitPoolEnemy) call CFUNC(shuffleArray);

GVAR(vehicleMRAPPoolEnemy) = [CFGPRAW2(Units,vehicleMRAPPoolEnemy), VMPE] call CFUNC(getSetting);
GVAR(vehicleMRAPPoolEnemy) = GVAR(vehicleMRAPPoolEnemy) call FUNC(flattenArray);
GVAR(vehicleMRAPPoolEnemy) = GVAR(vehicleMRAPPoolEnemy) call CFUNC(shuffleArray);

GVAR(vehicleLightPoolEnemy) = [CFGPRAW2(Units,vehicleLightPoolEnemy), VLPE] call CFUNC(getSetting);
GVAR(vehicleLightPoolEnemy) = GVAR(vehicleLightPoolEnemy) call FUNC(flattenArray);
GVAR(vehicleLightPoolEnemy) = GVAR(vehicleLightPoolEnemy) call CFUNC(shuffleArray);

GVAR(vehicleAAPoolEnemy) = [CFGPRAW2(Units,vehicleAAPoolEnemy), VAPE] call CFUNC(getSetting);
GVAR(vehicleAAPoolEnemy) = GVAR(vehicleAAPoolEnemy) call FUNC(flattenArray);
GVAR(vehicleAAPoolEnemy) = GVAR(vehicleAAPoolEnemy) call CFUNC(shuffleArray);

GVAR(vehicleHeavyPoolEnemy) = [CFGPRAW2(Units,vehicleHeavyPoolEnemy), VHPE] call CFUNC(getSetting);
GVAR(vehicleHeavyPoolEnemy) = GVAR(vehicleHeavyPoolEnemy) call FUNC(flattenArray);
GVAR(vehicleHeavyPoolEnemy) = GVAR(vehicleHeavyPoolEnemy) call CFUNC(shuffleArray);


GVAR(airSlowPoolEnemy) = [CFGPRAW2(Units,airSlowPoolEnemy), ASPE] call CFUNC(getSetting);
GVAR(airSlowPoolEnemy) = GVAR(airSlowPoolEnemy) call FUNC(flattenArray);
GVAR(airSlowPoolEnemy) = GVAR(airSlowPoolEnemy) call CFUNC(shuffleArray);

GVAR(airFastPoolEnemy) = [CFGPRAW2(Units,airFastPoolEnemy), AFPE] call CFUNC(getSetting);
GVAR(airFastPoolEnemy) = GVAR(airFastPoolEnemy) call FUNC(flattenArray);
GVAR(airFastPoolEnemy) = GVAR(airFastPoolEnemy) call CFUNC(shuffleArray);

GVAR(airAttackPoolEnemy) = [CFGPRAW2(Units,airAttackPoolEnemy), AAPE] call CFUNC(getSetting);
GVAR(airAttackPoolEnemy) = GVAR(airAttackPoolEnemy) call FUNC(flattenArray);
GVAR(airAttackPoolEnemy) = GVAR(airAttackPoolEnemy) call CFUNC(shuffleArray);


GVAR(sniperPoolEnemy) = [CFGPRAW2(Units,sniperPoolEnemy), SPE] call CFUNC(getSetting);
GVAR(sniperPoolEnemy) = GVAR(sniperPoolEnemy) call FUNC(flattenArray);
GVAR(sniperPoolEnemy) = GVAR(sniperPoolEnemy) call CFUNC(shuffleArray);


GVAR(staticPoolEnemy) = [CFGPRAW2(Units,staticPoolEnemy), STPE] call CFUNC(getSetting);
GVAR(staticPoolEnemy) = GVAR(staticPoolEnemy) call FUNC(flattenArray);
GVAR(staticPoolEnemy) = GVAR(staticPoolEnemy) call CFUNC(shuffleArray);

GVAR(staticHighPoolEnemy) = [CFGPRAW2(Units,staticHighPoolEnemy), STHPE] call CFUNC(getSetting);
GVAR(staticHighPoolEnemy) = GVAR(staticHighPoolEnemy) call FUNC(flattenArray);
GVAR(staticHighPoolEnemy) = GVAR(staticHighPoolEnemy) call CFUNC(shuffleArray);

GVAR(staticMortarEnemy) = [CFGPRAW2(Units,staticMortarEnemy), STMPE] call CFUNC(getSetting);
GVAR(staticMortarEnemy) = GVAR(staticMortarEnemy) call FUNC(flattenArray);
GVAR(staticMortarEnemy) = GVAR(staticMortarEnemy) call CFUNC(shuffleArray);

GVAR(unitPoolRebels) = [CFGPRAW2(Units,unitPoolRebels), UPR] call CFUNC(getSetting);
GVAR(unitPoolRebels) = GVAR(unitPoolRebels) call FUNC(flattenArray);
GVAR(unitPoolRebels) = GVAR(unitPoolRebels) call CFUNC(shuffleArray);

GVAR(vehiclePoolRebels) = [CFGPRAW2(Units,vehiclePoolRebels), VPR] call CFUNC(getSetting);
GVAR(vehiclePoolRebels) = GVAR(vehiclePoolRebels) call FUNC(flattenArray);
GVAR(vehiclePoolRebels) = GVAR(vehiclePoolRebels) call CFUNC(shuffleArray);


GVAR(unitPoolCiv) = [CFGPRAW2(Units,unitPoolCiv), UPC] call CFUNC(getSetting);
GVAR(unitPoolCiv) = GVAR(unitPoolCiv) call FUNC(flattenArray);
GVAR(unitPoolCiv) = GVAR(unitPoolCiv) call CFUNC(shuffleArray);

GVAR(vehiclePoolCiv) = [CFGPRAW2(Units,vehiclePoolCiv), VUC] call CFUNC(getSetting);
GVAR(vehiclePoolCiv) = GVAR(vehiclePoolCiv) call FUNC(flattenArray);
GVAR(vehiclePoolCiv) = GVAR(vehiclePoolCiv) call CFUNC(shuffleArray);


GVAR(enemySide) = East;

GVAR(ignoredBuildingTypes) = [CFGPRAW(ignoredBuildingTypes), ["Piers_base_F"]] call CFUNC(getSetting);
GVAR(ignoredBuildingTypes) pushBackUnique "Piers_base_F";
