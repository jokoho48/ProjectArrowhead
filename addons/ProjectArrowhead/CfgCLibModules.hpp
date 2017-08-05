#include "\tc\CLib\addons\CLib\ModuleMacros.hpp"

class CfgCLibModules {
    class ProjectArrowhead {
        path = "\paw\ProjectArrowhead\addons\ProjectArrowhead"; // TODO add Simplifyed Macro for this
        dependency[] = {"CLib"};

        MODULE(BaseProtection) {
            FNC(clientInit);
            FNC(serverInit);
        };

        MODULE(Common) {
            MODULE(Misc) {
                FNC(getClassName);
                FNC(getClosePlayers);
                FNC(getEnemyStrength);
                FNC(setUnitSurrender);
                FNC(setUnitHostage);
            };

            MODULE(Position) {
                FNC(findHousePos);
                FNC(findPosArray);
                FNC(findRuralFlatPos);
                FNC(findRutalHousePos);
                FNC(findTriPos);
                FNC(inArea);
                FNC(selectRandomPos);
            };

            MODULE(Spawn) {
                FNC(spawnGroup);
                FNC(spawnSniper);
                FNC(spawnTower);
            };

            MODULE(UnitMovment) {
                FNC(occupyBuilding);
                FNC(serverInit);
                FNC(setPatrolInf);
                FNC(setPatrolVeh);
                FNC(taskPatrol);
            };

            FNC(init);
        };

        MODULE(IED) {
            FNC(serverInit);
        };

        MODULE(MainAO) {
            FNC(selectMainMission);
            FNC(serverInit);
        };

        MODULE(Missions) {
            FNC(clearTown);
        };

        MODULE(SideMission) {
            FNC(selectSideMission);
            FNC(serverInit);
        };
    };
};
