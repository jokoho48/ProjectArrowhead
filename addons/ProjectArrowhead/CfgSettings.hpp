class ProjectArrowhead {
    MainAOSize = 2;
    sideMissionDelay = 250;
    RandomEventTimings[] = {600, 1000,1200};
    missionAmount = 10;

    class clearTown {
        mainAOGroupCount = 10;
        mainAOVehicleMRAPCount = 5;
        mainAOVehicleLightCount = 2;
        mainAOVehicleAACount = 1;
        mainAOVehicleHeavyCount = 1;
        mainAOAirCount = 1;
        mainAOTowerCount = 3;
        mainAOSniperCount = 2;
        mainAOStaticCount = 3;
    };

    class sideMissions {
        class locateHostage {
            function = "ProjectArrowhead_Missions_fnc_locateHostage";
        };
    };

    class mainMissions {
        class clearTown {
            function = "ProjectArrowhead_Missions_fnc_clearTown";
        };
    };

    class randomEvents {
        #ifdef ISDEV
        class earthQuake {
            function = "ProjectArrowhead_RandomEvents_fnc_earthQuake"; // FFS arma why you need that spawned
        };
        #endif
        class rebelAttack {
            function = "ProjectArrowhead_RandomEvents_fnc_rebelAttackTrigger";
        };
        class airAttack {
            function = "ProjectArrowhead_RandomEvents_fnc_airAttackTrigger";
        };
    };

    class RandomCampPatrols {
        randomCampCount = 10;
        randomPatrolCount = 10;
        randomPatrolVehCount = 4;
    };

    class Caching {
        Group = 2000;
        Vehicle = 2500;
        EmptyVehicle = 1000;
        Prop = 250;
        IsMoving = 2.2;
        useViewDistance = 0;
    };
};
