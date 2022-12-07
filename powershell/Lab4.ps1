function get-sys_desc {
    Write-Output "Hardware Description"
     Write-Output "------------------------"
    Get-WmiObject -class win32_computersystem | foreach {
            New-Object -TypeName psobject -Property @{
                'Description' = if( $_.Description  -ne $null ) {$_.Description} Else {"data unavailable"}
            }
    } | format-list
}

function get-cpu_info {
    Write-Output "Processor Information:"
     Write-Output "------------------------"
    Get-WmiObject win32_processor | foreach {
            New-Object -TypeName psobject -Property @{
                'Description' = if( $_.Description  -ne $null ) {$_.Description} Else {"data unavailable"}
                'MaxClockSpeed' = if( $_.MaxClockSpeed  -ne $null ) {$_.MaxClockSpeed} Else {"data unavailable"}
                'NumberOfCores' = if( $_.NumberOfCores  -ne $null ) {$_.NumberOfCores} Else {"data unavailable"}
                'L3CacheSize' = if( $_.L3CacheSize  -ne $null ) {$_.L3CacheSize} Else {"data unavailable"}
                'L2CacheSize' = if( $_.L2CacheSize  -ne $null ) {$_.L2CacheSize} Else {"data unavailable"}
                'L1CacheSize' = if( $_.L1CacheSize  -ne $null ) {$_.L1CacheSize} Else {"data unavailable"}
            }
    } | format-list
}

function get-os_info {
    Write-Output "Operating System Information"
     Write-Output "------------------------"
    Get-WmiObject win32_operatingsystem | foreach {
            New-Object -TypeName psobject -Property @{
                'Name' = if( $_.name  -ne $null ) {$_.name} Else {"data unavailable"}
                'Version' = if( $_.version  -ne $null ) {$_.version} Else {"data unavailable"}
            }
    } | format-list
}

function get-memory_info{
    Write-Output "System Memory Information"
     Write-Output "------------------------"
    $total = 0
    Get-WmiObject -class win32_physicalmemory | foreach {
                New-Object -TypeName psobject -Property @{
                    Vendor = if( $_.manufacturer  -ne $null ) {$_.manufacturer} Else {"data unavailable"}
                    Description =  if( $_.Description  -ne $null ) {$_.Description} Else {"data unavailable"}
                    "Size(GB)" = if( $_.capacity  -ne $null ) {$_.capacity/1gb} Else {"data unavailable"}
                    Bank =  if( $_.Banklabel  -ne $null ) {$_.Banklabel} Else {"data unavailable"}
                    Slot = if( $_.devicelocator  -ne $null ) {$_.devicelocator} Else {"data unavailable"}
            }
        $total += $_.capacity/1mb } | format-list 
    "Total RAM: ${total}MB"
}

function get-disk_info{
    Write-Output "Disk Information"
     Write-Output "------------------------"
    get-WmiObject -classname Win32_DiskDrive | where-object DeviceID -ne $NULL | Foreach-Object {
                $drive = $_
                $drive.GetRelated("Win32_DiskPartition") |
                foreach {
                    $logicaldisk =$_.GetRelated("win32_LogicalDisk");
                    if($logicaldisk.size) {
                        New-Object -TypeName PSobject -Property @{
                            Manufacturer = if( $drive.Manufacturer  -ne $null ) {$drive.Manufacturer} Else {"data unavailable"}
                            DriveLetter = if( $logicaldisk.DeviceID  -ne $null ) {$logicaldisk.DeviceID} Else {"data unavailable"}
                            Model =  if( $drive.model  -ne $null ) {$drive.model} Else {"data unavailable"}
                            Size = if( $logicaldisk.size  -ne $null ) {[String]($logicaldisk.size/1gb -as [int])+"GB"} Else {"data unavailable"}
                            Free =  if( $logicaldisk.freespace  -ne $null ) {[string]((($logicaldisk.freespace / $logicaldisk.size) * 100) -as [int])+ "%"} Else {"data unavailable"}
                            FreeSpace =  if( $logicaldisk.freespace   -ne $null ) {[string]($logicaldisk.freespace / 1gb -as [int]) +"GB"} Else {"data unavailable"}
                            } | format-table -AutoSize Manufacturer, Model, size, Free, FreeSpace }
                    }
                }
}

function get-network_info {
    Write-Output "Network Information"
     Write-Output "------------------------"
    get-ciminstance win32_networkadapterconfiguration | where IPEnabled -eq "True" | foreach {
            New-Object -TypeName psobject -Property @{
                'Description' = if( $_.Description  -ne $null ) {$_.Description} Else {"data unavailable"}
                'Index' = if( $_.Index  -ne $null ) {$_.Index} Else {"data unavailable"}
                'IPAddress' = if( $_.IPAddress  -ne $null ) {$_.IPAddress} Else {"data unavailable"}
                'IPSubnet' = if( $_.IPSubnet  -ne $null ) {$_.IPSubnet} Else {"data unavailable"}
                'DNSDomain' = if( $_.DNSDomain  -ne $null ) {$_.DNSDomain} Else {"data unavailable"}
                'DNSServerSearchOrder' = if( $_.DNSServerSearchOrder  -ne $null ) {$_.DNSServerSearchOrder} Else {"data unavailable"}
            }
    } | format-table
}

function get-video_info {
    Write-Output "Video Card Information"
    Write-Output "------------------------"
    Get-WmiObject win32_videocontroller | foreach {
            New-Object -TypeName psobject -Property @{
                'Description' = if( $_.Description  -ne $null ) {$_.Description} Else {"data unavailable"}
                'Vendor' = if( $_.Vendor  -ne $null ) {$_.Vendor} Else {"data unavailable"}
                'Screen Resolution' = if( $_.CurrentHorizontalResolution  -ne $null ) {'' + $_.CurrentHorizontalResolution +' X '+ $_.CurrentVerticalResolution} Else {"data unavailable"}}
    } | format-list
}

get-sys_desc 
get-os_info
get-cpu_info
get-memory_info
get-disk_info
get-network_info
get-video_info
