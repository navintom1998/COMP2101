function get-mydisks{
    Get-PhysicalDisk | format-list Manufacturer, Model, SerialNumber, FirmwareVersion, Size
}
get-mydisks
