$result = @()
foreach ($DS in $DSLIST.PrimarySmtpAddress){
    $Dist_group_member = Get-DistributionGroupMember -Identity $DS | select DisplayName, WindowsLiveID
    foreach ($member in $Dist_group_member){
        $result += New-Object -TypeName PSObject -Property ([ordered]@{
        'Distributions gruppe' = $DS
        'Navn' = $member.DisplayName
        'Email' = $member.WindowsLiveID
        })
    }
}

$filename = "C:\temp\Distributions-gruppe-medlemmer.csv"
$result | export-csv -NoTypeInformation -Encoding UTF8 $filename

