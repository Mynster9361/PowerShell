Connect-MsolService 
     
$users = Get-MsolUser -all | Where-Object {($_.licenses).AccountSkuId -match "SPE_E3"}

if ($users) {
    $Session = Connect-ExchangeOnline
$output = foreach ($user in $users) {
        $mailbox = get-mailbox $user.userprincipalname
if ($mailbox.ProhibitSendReceiveQuota -match "50 GB") {
            Write-Host "$($mailbox.displayname) is only 50 GB, resizing..." -ForegroundColor Yellow
             Set-Mailbox $mailbox.PrimarySmtpAddress -ProhibitSendReceiveQuota 100GB -ProhibitSendQuota 99GB -IssueWarningQuota 98GB
            $mailboxCheck = get-mailbox $mailbox.PrimarySmtpAddress
            Write-Host "New mailbox maximum size is $($mailboxcheck.ProhibitSendReceiveQuota)" -ForegroundColor Green
            
        }
        $output | export-csv users_mailbox_size.csv -NoTypeInformation -Encoding UTF8
    }
    
}
    
