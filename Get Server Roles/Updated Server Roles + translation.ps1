$ErrorActionPreference = "SilentlyContinue"

### Creates Scripts directory if it does not already exist

$testpath = Test-Path -Path C:\Scripts
If ($testpathvalue = 'False') {
    new-Item -ItemType Directory -Force -Path C:\Scripts
}

### Retrieving all Servers by Name

$servers = (Get-ADComputer -Properties operatingsystem -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"')
 
### Collection Point
 
$result = @()
 
### Ping all Servers and if ping is successful run Get-WindowsFeature
 
foreach ($server in $servers.name) {
 
    $ping = Test-Connection $server -Count 1
    $IP = $ping.IPV4Address.IPAddressToString
    $OS = Get-ADComputer $server -Properties operatingsystem
    

    If ($ping.Status -eq 'Success' -or $ping.StatusCode -eq '0') {
        $SQLServer = Get-Service MSSQLServer -ComputerName $server | select Name
        $roles = Get-WindowsFeature -ComputerName $server | Where Installed

        Set-Content -Path C:\scripts\test.txt.out -Value $file
        $SQL = $SQLServer.Name
        $rolenames = $roles.Name

        $hashtable = @{
            'AD-Certificate'          = 'AD-CS'
            'AD-Domain-Services'      = 'DC'
            'ADFS-Federation'         = 'AD-FS'
            'ADLDS'                   = 'AD-LDS'
            'ADRMS'                   = 'AD-RMS'
            'DHCP'                    = 'DHCP'
            'DNS'                     = 'DNS'
            'Fax'                     = 'Fax'
            'FileAndStorage-Services' = 'FileServer'
            'HostGuardianServiceRole' = 'HostGuardianServiceRole'
            'Hyper-V'                 = 'Hyper-V'
            'Print-Services'          = 'Print server'
            'RemoteAccess'            = 'RemoteAccess'
            'Remote-Desktop-Services' = 'RDS'
            'VolumeActivation'        = 'KMS'
            'WDS'                     = 'WDS'
            'Web-Server'              = 'IIS'
            'UpdateServices'          = 'WSUS'
            'DirectAccess-VPN'        = 'VPN'
            'Web-Ftp-Server'          = 'FTP'
            'FS-DFS-Namespace'        = 'DFS-N'
            'FS-DFS-Replication'      = 'DFS-R'
            'NPAS'                    = 'NPAS'
            'RDS-Connection-Broker'   = 'RDS-CB'
            'RDS-Gateway'             = 'RDS-GW'
            'RDS-RD-Server'           = 'RDS-Host'
            'BitLocker'               = 'BitLocker'
            'Failover-Clustering'     = 'Failover-Clustering'
            'Windows-Server-Backup'   = 'Backup'
            'MSSQLSERVER'             = 'SQL'
        }
        foreach ($key in $hashtable.Keys) {
            $rolenames = $rolenames.replace($key, $hashtable.$key)
            $SQL = $SQL.replace($key, $hashtable.$key)
        }
        $result += New-Object -TypeName PSObject -Property ([ordered]@{

                'Server' = $server
                'IP'     = $IP
                'OS'     = $OS.OperatingSystem
                'Roles'  = $rolenames + $SQL -join "`r`n" -replace "`n" -replace '\s', ", "
 
            }
        )
    }
}

#Export and open file
$result | Export-CSv "C:\Scripts\ServerRoles.csv" -NoTypeInformation
Start-Process C:\Scripts\"ServerRoles.csv"