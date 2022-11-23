function get-cpuinfo{
                     get-ciminstance cim_processor | format-list Manufacturer, Name, CurrentClockSpeed, MaxClockSpeed, NumberOfCores
}
get-cpuinfo
