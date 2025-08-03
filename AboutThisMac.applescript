# About This Mac - Revision 3 - Author: Harry Xie

set modelID to do shell script "sysctl -n hw.model"
set sn to do shell script "ioreg -l | awk '/IOPlatformSerialNumber/ {print $4}' | tr -d '\"'"
set cpuModel to do shell script "sysctl -n machdep.cpu.brand_string"
set phyCores to do shell script "sysctl -n hw.physicalcpu"
set logCores to do shell script "sysctl -n hw.logicalcpu"
set mem to do shell script "system_profiler SPHardwareDataType | grep \" Memory:\" | awk '{print $2}'"
set eachMemSize to do shell script "system_profiler SPMemoryDataType | awk '/Size:/ {sizes = (sizes == \"\" ? \"\" : sizes \", \") $2$3} END {print sizes}'"
set memMfg to do shell script "system_profiler SPMemoryDataType | grep \"Manufacturer:\" | awk '{print $2}' | xargs | sed 's/ /, /g'"
set storage to do shell script "diskutil info disk0 | grep \"Disk Size\" | awk '{print $3$4}'"
set gpus to do shell script "system_profiler SPDisplaysDataType | grep \"Chipset Model\" | awk -F': ' '{ if (NR == 1) {chipsets = $2} else {chipsets = chipsets \", \" $2} } END {print chipsets}'"
set battHealthCdt to do shell script "system_profiler SPPowerDataType | grep \"Condition\" | awk -F': ' '{print $2}'"
set battCycles to do shell script "system_profiler SPPowerDataType | grep \"Cycle Count\" | awk '{print $3}'"
set battDesCap to do shell script "ioreg -l | awk -F' = ' '/(DesignCapacity)/ {gsub(\"\\\"\",\"\"); print $2}' | tail -n 1"
set battCurrCap to do shell script "ioreg -l | awk -F' = ' '/(AppleRawCurrentCapacity)/ {gsub(\"\\\"\",\"\"); print $2}'"
set battHealthPct to ((((battCurrCap / battDesCap) * 100) * 100) div 1) / 100
set chgWatts to (do shell script "watt=$(system_profiler SPPowerDataType | grep \"Wattage (W):\" | awk '{print $3}'); if [ -z \"$watt\" ]; then echo \"NOT CHARGING\"; else echo \"$watt\"; fi")
set chgInfo to do shell script "system_profiler SPPowerDataType | awk '/AC Charger Information:/,/  ChgInf:/ { if ($1 ~ /Manufacturer:/) { mfg=$0; gsub(/^[ 	]*Manufacturer: /, \"\", mfg); } if ($1 ~ /Name:/) name=$2\" \"$3\" \"$4\" \"$5\" \"$6\" \"$7\" \"$8; } END { if (mfg && name) print mfg\", \"name; else print \"CANNOT READ OR NOT CHARGING\"; }'"
set ctType to do shell script "networksetup -listallhardwareports | grep -C 1 $(route get default | grep interface | awk '{print $2}') | awk -F: '/Hardware Port/{print $2}' | sed 's/^[[:space:]]*//'"
set wifiCh to do shell script "system_profiler SPAirPortDataType | grep \"Channel:\" | awk -F: '{print $2}' | sed 's/^[[:space:]]*//' | head -n 1"
set wifiCt to do shell script "system_profiler SPAirPortDataType | grep \"Country Code:\" | awk -F: '{print $2}' | sed 's/^[[:space:]]*//' | head -n 1"
set devmngStatus to do shell script "profiles status -type enrollment | grep -oE 'Yes|No' | paste -s -d '/' -"
set pfCount to do shell script "sudo profiles -L | grep \"profileIdentifier:\" | wc -l | tr -d ' '"

display dialog "This is: " & modelID & return & �
	"Serial Number: " & sn & return & return & �
	"--- GENERAL INFORMATION ---" & return & �
	"Processor: " & cpuModel & return & �
	"Number of Physical/Logical Cores: " & phyCores & "/" & logCores & return & �
	"Total Installed Memory: " & mem & "GB" & return & �
	"Each Memory Slot's Size: " & eachMemSize & return & �
	"Memory Manufacturer(s): " & memMfg & return & �
	"Storage (internal HD): " & storage & return & �
	"Attached GPUs: " & gpus & return & return & �
	"--- BATTERY & POWER (for Mac notebook computers) ---" & return & �
	"Health Condition: " & battHealthCdt & return & �
	"Health Percentage: " & battHealthPct & "%" & return & �
	"Charge Cycles: " & battCycles & return & �
	"Designed/Current Capacity: " & battDesCap & "/" & battCurrCap & return & �
	"Charging Wattage: " & chgWatts & return & �
	"Charger Info: " & chgInfo & return & return & �
	"--- NETWORK & INTERNET ---" & return & �
	"Connection Type: " & ctType & return & �
	"Connected Channel (Wi-Fi): " & wifiCh & return & �
	"Country Code: " & wifiCt & return & return & �
	"--- PROFILES & LOCKS ---" & return & �
	"DEP/MDM Enrollment Status: " & devmngStatus & return & �
	"Number of Installed Profiles: " & pfCount