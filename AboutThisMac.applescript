# About This Mac - Revision 2 - Author: Harry Xie

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
set wfStdrd to do shell script "system_profiler SPAirPortDataType | awk '/PHY Mode:/ { print $3 ; exit }'"
set battHealthCdt to do shell script "system_profiler SPPowerDataType | grep \"Condition\" | awk -F': ' '{print $2}'"
set battHealthPct to do shell script "system_profiler SPPowerDataType | awk '/Maximum Capacity:/ {print $3}' | sed 's/%//'"
set battCycles to do shell script "system_profiler SPPowerDataType | grep \"Cycle Count\" | awk '{print $3}'"
set chgWatts to (do shell script "watt=$(system_profiler SPPowerDataType | grep \"Wattage (W):\" | awk '{print $3}'); if [ -z \"$watt\" ]; then echo \"NOT CHARGING\"; else echo \"$watt\"; fi")
set chgInfo to do shell script "system_profiler SPPowerDataType | awk '/AC Charger Information:/,/  ChgInf:/ { if ($1 ~ /Manufacturer:/) mfg=$2; if ($1 ~ /Name:/) name=$2\" \"$3\" \"$4\" \"$5\" \"$6\" \"$7\" \"$8; } END { if (mfg && name) print mfg\", \"name; else print \"CANNOT READ CHARGER INFO OR NOT CHARGING\"; }'"
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
	"Attached GPUs: " & gpus & return & �
	"Wi-Fi Adapter's IEEE Standard: " & wfStdrd & return & return & �
	"--- BATTERY & POWER (for Mac notebook computers) ---" & return & �
	"Battery Health Condition: " & battHealthCdt & return & �
	"Battery Health Percentage: " & battHealthPct & return & �
	"Battery Charge Cycles: " & battCycles & return & �
	"Charging Wattage: " & chgWatts & return & �
	"Connected Charger Info: " & chgInfo & return & return & �
	"--- PROFILES & LOCKS ---" & return & �
	"DEP/MDM Enrollment Status: " & devmngStatus & return & �
	"Number of Installed Profiles: " & pfCount