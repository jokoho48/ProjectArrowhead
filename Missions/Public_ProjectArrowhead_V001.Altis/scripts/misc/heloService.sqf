/*
* Author: alganthe
* Handler for the vehicle service pad (Helos)
*
* Arguments:
* 0: Vehicle to be serviced <OBJECT>
*
* Return Value:
* Nothing
*/
params ["_vehicle"];

if (_vehicle isKindOf "Helicopter") then {


    _vehicle vehicleChat "Servicing started, we should be finished in 40s";
    _vehicle setFuel 0;


    //---------- REPAIRING
    sleep 30;
    _vehicle vehicleChat "*crew is working*";



    //---------- FINISHED
    sleep 10;

    _vehicle setDamage 0;
    _vehicle setFuel 0.1;
    _vehicle vehicleChat "We've repaired her and put some fuel in to get you going.";



    sleep 2;
    _vehicle vehicleChat "Good luck out there soldier!";

} else {
    _vehicle vehicleChat "Sorry, we're only equipped for rotary crafts.";

};
