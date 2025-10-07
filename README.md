# About This Mac

A simple AppleScript that provides a convenient way to view key details about the current Mac with just a click, offering an instant overview and saving time looking through scattered information in Mac OS. No other software installations are needed, just using the (Apple)Script Editor that's built-in to Mac OS.

## What This AppleScript Can Get

As for Revision 5, this AppleScript can get the following information about the Mac:

|Information|Minimum Software/Hardware Requirement*|
|-|-|
|Mac's model identifier (e.g. "iMac10,1", not "iMac (27-inch, Late 2009)")||
|Mac's model number (e.g. MNWD3LL/A)|ARM Macs only|
|Mac's serial number||
|Mac's processor model in detail (e.g. "Intel(R) Core(TM) i5-5287U @ 2.9 GHz", not just "2.9GHz dual-core Intel Core i5")||
|Processor's cores/threads||
|Installed memory size||
|Each memory slot's size||
|Memory manufacturer(s)||
|Internal storage capacity|Mac OS 10.13 or higher|
|Attached GPUs||
|Total number of GPU cores|ARM Macs only|
|Connected power source|Mac OS 10.9 or higher|
|Battery's health condition (text representation, e.g. "Normal" "Service Recommended")||
|Battery's health percentage|ARM Macs only|
|Battery charge cycles|Mac OS 10.9 or higher|
|Battery's designed/current capacity|Current capacity requires Mac OS 10.15 or higher. For older Mac OS, replace `AppleRawMaxCapacity` to `CurrentCapacity` in the line that defines `battCurrCap`.|
|Current charging wattage||
|Connected charger's manufacturer & name||
|Current connected network's type||
|Connected Wi-Fi's channel||
|Connected Wi-Fi's country code||
|iCloud activation lock status|Mac OS 10.15 or higher|
|DEP/MDM enrollment status|Mac OS 10.13 or higher|
|Number of installed profiles||

**unless otherwise specified, assume that the minimum software/hardware requirement is "Mac OS 10.6 or higher, X86 Macs or newer" by default.*

## How To Use

1. Download `AboutThisMac.applescript` and open it in (Apple)Script Editor;

	- if it's opened in other editors, manually open it in (Apple)Script Editor.

2. Run the script to get the current Mac's information that are specified above.