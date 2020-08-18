# NPC System

## Table of Contents

#### Release
- [1.1.3](https://github.com/Vex87/NPC-System/blob/master/README.md#113)
- [1.1.2](https://github.com/Vex87/NPC-System/blob/master/README.md#112)
- [1.1.1](https://github.com/Vex87/NPC-System/blob/master/README.md#111)
- [1.1.0](https://github.com/Vex87/NPC-System/blob/master/README.md#110)
- [1.0.8](https://github.com/Vex87/NPC-System/blob/master/README.md#108)
- [1.0.7](https://github.com/Vex87/NPC-System/blob/master/README.md#107)
- [1.0.6](https://github.com/Vex87/NPC-System/blob/master/README.md#106)

#### Initialize
- [0.1.0](https://github.com/Vex87/NPC-System/blob/master/README.md#010)
- [0.0.0](https://github.com/Vex87/NPC-System/blob/master/README.md#000)

## 1.1.3
#### Changes
- Moved all commits to a new repository because of the massive amount of useless commits. Attempting to use a more organized method of this software.
- Made a few edits to the read me.

## 1.1.2
#### Additions
- Added in the CheckFront function to allow spacing between the NPCs' front and back.
- Made the NPC clone itself when it dies (temporarily)
#### Changes
- Changed the Mag function.

## 1.1.1
#### Changes
- Formatted for Rojo use, no files were changed.

## 1.1.0
#### Changes
- Changed UpdateDelay from 0.5 to 0.1 sec.
#### Fixes
- Fixed some typos.
#### Removals
- Removed custom animation script because when NPC's run into each other, they clog each other's animations. Roblox's legacy script allows the NPC's to smoothly animate, even when cogged

## 1.0.8
#### Additions
- Added in TargetLineOFSightDist in settings & removed AttackDist.
#### Changes
- Instead of two same functions for two different events, I combined the two functions for less lines of code.
- If the remote function did not return in the Stats UI, the stats text would be displayed as "N/A."
#### Removals
- Removed the round function from the helper module as it was only used in one script. Readded it to the NPC handler. Therefore making that module a function for a new thread..
- Removed some useless code in some scripts as well as reorganized.

## 1.0.7
#### Additions
- Added an optional distance argument to the check sight function.  Added a line of sight distance setting. Changed detection distance and attack delay settings.
- Made the NPC face the non-humanoid target if near it.
- Added in update delay and color settings in the stats UI as well as variables for the remotes. Added in other threads and parts stats as well as renamed count to NPC.
#### Changes
- Disconnected events that were no longer in use so they won't cause performance issues and clug up the memory.
- Combined the new thread and round function into a module.
- Changed the touched event for the attack listener to the hands instead of just the root.
#### Fixes
- Fixed the non-humanoid defeat music to not immediately stop after playing.
#### Removals
- Removed the pistol

## 1.0.6
#### Additions
- Added in a defeat sound if the non-humanoid target is destroyed.
- Made NPC move directly to the target if it is in its direct line of sight. 
#### Changes
- Changed update delay to 0.5 sec. 

## 0.1.0
#### Additions
- Added in points near the non-humanoid target. NPC's wil now run to a point with the least amount of NPC's at it instead of running to the non-humanoid target. This allows less grouping, but the grouping issue has not been fully resolved yet.

## 0.0.0
#### Additions
- Upload