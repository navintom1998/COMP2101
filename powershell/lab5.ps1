param ([switch]$System,[switch]$Disks,[switch]$Networks)

if ($System)
{

get-sys_desc
get-os_info
get-cpu_info
get-memory_info
get-video_info
}
elseif ($Disks)
{
get-disk_info
}
elseif($Networks)
{
get-network_info
}
else
{
get-sys_desc 
get-os_info
get-cpu_info
get-memory_info
get-disk_info
get-network_info
get-video_info
}
