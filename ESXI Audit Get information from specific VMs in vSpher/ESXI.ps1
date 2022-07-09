param(
    $vmsh = @"
    Server1.domain.local,Server2.domain.local,ServerX.domain.local
"@ # Type in the list of servers/vms separeted by a comma ","

)

# Requires this module:
# Install-Module VMware.PowerCLI
# Connect with the following command:
# Connect-VIServer -Server xx


# Get UUID from all Hosts and calculate install date from UUID
# Original format: echo -n "ESXi install date: " ; date -d @$(printf "%d" 0x$(esxcli system uuid get | cut -d \- -f1 ))

$ESXihosts = Get-VMHost | Select-Object Name,@{N='ESXi System UUid';E={(Get-Esxcli -VMHost $_).system.uuid.get()}}  
$result =@()

foreach ($ESXihost in $ESXihosts) {
    $SysUUID = $ESXihost.'ESXi System UUid'.Split("-")
    $hexdate = "0x" + $SysUUID[0]
    $unixdate = [uint32]$hexdate

    [datetime]$origin = '1970-01-01 00:00:00'
    $ESXihost.Name, $origin.AddSeconds($unixdate)
    $Global:result += New-Object -TypeName PSObject -Property ([ordered]@{
        "ESXI_HOST" = $ESXihost.Name
        "Origen" = $origin.AddSeconds($unixdate)
    })
}
$result | export-csv "C:\temp\hostsForVCenter_Name.csv" -NoTypeInformation


$result2 =@()

$vms = $vmsh.split(",`n`r")
foreach ($vm in $vms){
write-output $vm
    $vm_info = get-vm $vm
    if ($null -eq $vm_info) {
        write-output "Unable to run get-vm on $vm"
        $Name = $vm
        $PowerState = "Server has been decommissioned"
        $State = ""
        $Host_name = ""
        $Cluster = ""
        $CPU_S = ""
        $Cores = ""
        $MEM_GB = ""
        $OS = ""
        $Used_Space = ""
        $Space_Capacity = ""
    } else {
        $Name = $vm_info.Name
        $PowerState = $vm_info.PowerState
        $State = $vm_info.Guest.State
        $Host_name = $vm_info.VMHost.name
        $Cluster = $vm_info.VMHost.Parent
        $CPU_S = $vm_info.NumCpu
        $Cores = $vm_info.CoresPerSocket
        $MEM_GB = $vm_info.MemoryGB
        $OS = $vm_info.Guest.OSFullName
        foreach ($disk in $vm_info.Guest.Disks){
            if ($disk.Path -eq "C:\"){
                $Space_Capacity = [math]::Round($disk.CapacityGB,2)
            }
        }
        write-output $Space_Capacity
        $Used_Space = [math]::Round($vm_info.UsedSpaceGB,2)
    }
    $Global:result2 += New-Object -TypeName PSObject -Property ([ordered]@{
        "Name" = $Name
        "State" = $PowerState
        "Status" = $State
        "Host" = $Host_name
        "Cluster" = $Cluster
        "Provisioned Space" = $Space_Capacity
        "Used Space" = $Used_Space
        "Number of CPU's" = $CPU_S
        "Number of Corespersocket" = $Cores
        "Host Mem GB" = $MEM_GB
        "Guest OS" = $OS
    })
}

$result2 | export-csv "C:\temp\vmsForVCenter.csv" -NoTypeInformation -Delimiter ";"