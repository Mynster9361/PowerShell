# Hent alle ad grupper inklusiv alle properties på grupperne
$adgroups = Get-adobject -filter 'ObjectClass -eq "group"' -Properties *

# Opret array/collection af data
$result = @()

# forhver adgruppe i alle adgrupper
foreach($adgroup in $adgroups){

    # Skaf medlemmer i den enkelte adgruppe
    $adgroup_members = Get-ADGroupMember $adgroup | select name

    # Tilføj resultatet af adgruppe og oprettelse dato og lig det ind in dit array/collection

    $result += New-Object -TypeName PSObject -Property ([ordered]@{
        'ADGroup' = $adgroup.Name
        'Creation date' = $adgroup.whenCreated
        'Medlemmer' = ""
    })
    
    # forhvert medlem i den givne adgruppe
    foreach($adgroup_member in $adgroup_members) {
        # tilføj det enkelte medlem på hver linje
        $result += New-Object -TypeName PSObject -Property ([ordered]@{
            'ADGroup' = ""
            'Creation date' = ""
            'Medlemmer' = $adgroup_member.name
        })
    }

}

# eksporter resultat til en csv fil uden "type information" og med encoding UTF8 for at supportere øæå
$result | export-csv .\Desktop\test.csv -NoTypeInformation -Encoding UTF8