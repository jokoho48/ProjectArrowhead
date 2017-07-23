#include "\tc\CLib\addons\CLib\ModuleMacros.hpp"

class CfgCLibModules {
    class ProjectArrowhead {
        path = "\bso\BSOPublic\addons\BSOPublic"; // TODO add Simplifyed Macro for this
        dependency[] = {"CLib", "BSO/RBU", "BSO/Common", "BSO/BFT"};

        MODULE(BaseProtection) {
            FNC(clientInit);
            FNC(serverInit);
        };

        MODULE(Common) {
            MODULE(Misc) {
                FNC(getClosePlayers);
                FNC(getEnemyStrength);
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
                FNC(spawnSniper);
                FNC(spawnTower);
            };

            MODULE(UnitMovment) {
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
            FNC(serverInit);
        };

        MODULE(SideMission) {
            FNC(serverInit);
        };
    };
};
