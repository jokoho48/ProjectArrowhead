/*
| Author:
|
|	Quiksilver.
|
| Modified last by: Pfc. Christiansen
|
|_____
|
| Description:
|
|	Created: 14/2/2015. Altered: 16/2/2015
|	Coded for AhoyWorld EU 3 to replace Patrol Ops with a perpetual mission with few scripts.
|	You may use and edit the code.
|	You may not remove any entries from Credits without first removing the relevant author's contributions,
|	or asking permission from the mission authors/contributors.
|	You may not remove the Credits tab, without consent of Ahoy World.
| 	Feel free to re-format or make it look better.
|_____
|
| Usage:
|
|	Search below for the diary entries you would like to edit.
|	DiarySubjects appear in descending order when player map is open.
|	DiaryRecords appear in ascending order when selected.
|_____
|
| Credit:
|
|	This Mission was created by Pfc.Christiansen and BACONMOP
|
|	Please be respectful and do not remove credit.
|______________________________________________________________*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Rules"];
player createDiarySubject ["Platoon Roster", "Platoon Roster"];
player createDiarySubject ["faq", "FAQ"];
player createDiarySubject ["changelog", "Change Log"];
player createDiarySubject ["credits", "Credits"];

//-------------------------------------------------- Rules


player createDiaryRecord ["rules",
[
"General",
"
<br />1. Do not teamkill. This one shouldn’t even be here… ANY type of on purpose teamkilling will not be accepted. IE: Revenge killing, executions, dicking around…
<br />2. Do not dare/antagonize someone to teamkill, and/or create a situation where teamkilling is very likely to happen. (capturing an enemy vehicle and failing to properly notifying your team)
<br />3. Listen to the Chain of Command.
<br />4. Do not type over side chat.(Unless in an emergency).
<br />5. Do not discharge any of your weapons in base on purpose! This includes launchers with their back blast.
<br />6. Pilots should not get into jets/helicopters unless told to by Command elements.
<br />7. Do not use 2 seater aircraft when alone.
<br />8. CAS  pilots(Helicopter/Jet) should be on standby in a safe orbit over AO unless instructed otherwise by command element(Not Squad Leaders). CAS standby and not fire unless told to by command.
<br />9. Firing 20mm or 30mm cannon can cause server lag issues, so please use them with discretion.
<br />10. If you select a role, please play that role. We don’t expect a medic to be running around with a AT launcher + LMG. Just play your role.
<br />11. The first medic on a scene decides how to treat a patient. Do not run up to a patient and start doing medical stuff without asking the on scene medic first.
<br />12. Radios are not for chit-chat. Please keep radio chatter to a minimum. If you have to talk do it LOCALLY.
<br />13. The motor pool and spawn area is not for helicopters or jets. Do not land them there. Use the helipads instead. When no helipad is available, land outside base in a safe area.
<br />
<br />If you see a player in violation of the above, contact a moderator or admin (teamspeak).
"
]];

//-------------------------------------------------- Platoon Roster

player createDiaryRecord ["Platoon Roster",
[
"Charlie Squad",
"
<br /> SL and TL Talk on 152 Channel 3 (Charlie Net).
<br /> Bravo Fireteams are allowed to use channels 7-9 on the 343.
<br /> SL is free to split up over these channels however he desires.

"
]];

player createDiaryRecord ["Platoon Roster",
[
"Bravo Squad",
"
<br /> SL and TL Talk on 152 Channel 2 (Bravo Net).
<br /> Bravo Fireteams are allowed to use channels 4-6 on the 343.
<br /> SL is free to split up over these channels however he desires.

"
]];



player createDiaryRecord ["Platoon Roster",
[
"Alpha Squad",
"
<br /> SL and TL Talk on 152 Channel 1 (Alpha Net).
<br /> Alpha Fireteams are allowed to use channels 1-3 on the 343.
<br /> SL is free to split up over these channels however he desires.

"
]];


player createDiaryRecord ["Platoon Roster",
[
"HQ Setup",
"
<br /> SL use their 152 to get in to touch with HQ on Channel 5 (Platoon Net).
<br /> FAC and air communicate on 117/152 Channel 6 (Air Net).
<br /> Armor and HQ/armor comander communicate on 117/152 Channel 7 (Armor Net).

"
]];
//-------------------------------------------------- FAQ

player createDiaryRecord ["faq",
[
"Shots left in magazine",
"
<br /><font size='16'>Q:</font> How do I check the amount of rounds left in my magazine?<br />
<br /><font size='16'>A:</font>
<br /> 1. Press CTRL and press R.
<br /> 2. This will give you an indication of how heavy the magazine is and thus how many rounds are left.
<br /> Green = full or near full, Yellow = around half empty, Red = almost empty if you can reload now if your about to move onto the enemy
<br />
"
]];

player createDiaryRecord ["faq",
[
"ACE3 Keys",
"
<br /><font size='16'>Q:</font> Which keys to I use to interact with myself or others?<br />
<br /><font size='16'>A:</font>
<br /> 1. Press Left Control+ Left Windows key to interact with yourself.
<br /> 2. Press Left Windows key to interact with other players/vehicles.
<br /> 3. Your SELF-INTERACTION key is used to interact with your gear, from putting earplugs in, attaching items to you, self-healing, repacking your magazines.
<br /> 4. Your INTERACTION key is used to interact with other players, vehicles. You can heal other players, use Team Management to join their squad, cable-tie units (do not use on friendly players).
<br />
"
]];

player createDiaryRecord ["faq",
[
"ACE3 Vector",
"
<br /><font size='16'>Q:</font> How do I properly use ACE3 Vector and which keys to use?<br />
<br /><font size='16'>A:</font>
<br /> 1. Use Vector as any other binoculars, press B to pull it out.
<br /> 2. Always point the middle cross towards and on the target.
<br /> 3. To measure DISTANCE to the target, aim at it, press and hold R until a red square appears then release the key. A distance to your target should appear in the right section of your vector. Distance is measured in meters.
<br /> 4. To measure BEARING to the target, aim at it, press and hold Tab until a red square appears then release the key. A bearing to your target should appear in the left section of your vector. Bearing is measured in degrees.
<br />
"
]];

player createDiaryRecord ["faq",
[
"ACE3 Weapon Safety",
"
<br /><font size='16'>Q:</font> How do I put my weapon on safe?<br />
<br /><font size='16'>A:</font>
<br /> 1. Press Left Control + ~ (tilde key - next to 1).
<br /> 2. A weapon and text should appear in top right corner saying: Put on Safety and your fire mode has no bar.
<br /> 3. Remove the safety by pressing same buttons again or by switching firing mode of your weapon. A text should say Remove safety and your fire mode should be visible.
<br />
"
]];

player createDiaryRecord ["faq",
[
"343 and 152 Radio",
"
<br /><font size='16'>Q:</font> How do i use my 343 radio?<br />
<br /><font size='16'>A:</font>
<br /> 1. Press CAPSLOCK to transmit (please change default arma ptt keybind if you use CAPSLOCK).
<br /> 2. 343 radio's are used for comms inside of a team and have a max range of about 700 meters.
<br /> 3. 152 radio's are used for comms between lead elements such as SL,TL,PL and FAC and have a range of 5-7 kilometers.
<br /> 4. If your TL or SL dies please do pickup their radio as to ensure the continuation of Comms with HQ.
<br />
"
]];

player createDiaryRecord ["faq",
[
"117 Radio",
"
<br /><font size='16'>Q:</font> How do i use my 117 radio?<br />
<br /><font size='16'>A:</font>
<br /> 1. CAPSLOCK to transmit.
<br /> 2. 117 Is a powerful 20 kilometer range radio that is primariliy used by HQ elemnts such as the platoon commander and the FAC.
<br /> 3. This is basically a bigger/heavier version of the 152 radio.
<br />
"
]];

//-------------------------------------------------- Change Log

player createDiaryRecord ["changelog",
[
"V 0.1",
"

<br />[ADDED] RHS Units and Vehicles.
<br />[CHANGED] No more Revive or Anti-instadeath.
<br />[ADDED] Respawn timer and spectator cam of 60 seconds.


"
]];
//-------------------------------------------------- Credits

player createDiaryRecord ["credits",
[
"BSO mission Files",
"
<br />Mission authors:<br /><br />

		- <font size='16'>ShadowFox<br /><br />
		- <font size='16'>Joko</font><br />

<br />Other:<br /><br />
		All BSO Scripts<br />
		- Joko<br />
"
]];
