$adgroups = Get-ADObject -Filter 'ObjectClass -eq "group"' -Properties name, whencreated, member, Description | Select-Object name, whencreated, member, Description
$result = @()

foreach ($adgroup in $adgroups) {
    $members = Get-ADGroupMember $adgroup.name
    Write-Host $adgroup.name -ForegroundColor Green
    Write-Host $members.name -ForegroundColor White
    $result += New-Object -TypeName PSObject -Property ([ordered]@{
        'ADGroup' = $adgroup.name
        'Creation Date' = $adgroup.whencreated
        'Description' = $adgroup.Description
        'Members' = ""
        'objectClass' = ""
    })
    foreach ($member in $members) {
        $memberName = $member.name
        $memberObject = $member.objectClass
        $result += New-Object -TypeName PSObject -Property ([ordered]@{
            'ADGroup' = ""
            'Creation Date' = ""
            'Description' = ""
            'Members' = $memberName
            'objectClass' = $memberObject
        })
    }
}

$result | Export-CSv "C:\Scripts\ADGroups_Members.csv" -NoTypeInformation -Encoding UTF8