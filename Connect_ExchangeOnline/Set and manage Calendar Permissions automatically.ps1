Param(
    $User_Perm1 = "", # User@Contoso.com - Please type in the email of the user or group that needs permissions to all user calendars
    $Perm1 = "", # Author,Editor etc.. - Please specify which permission it should be
    $User_Perm2 = "", # User@Contoso.com - Please type in the email of the user or group that needs permissions to all user calendars
    $Perm2 = "" # Author,Editor etc.. - Please specify which permission it should be
)

# To have the script be automated you can configure sign in with certificate like descriped here:
# https://docs.microsoft.com/en-us/powershell/exchange/app-only-auth-powershell-v2?view=exchange-ps
# I would suggest and recommend to use "Connect using a certificate thumbprint:"
# Connect-ExchangeOnline -CertificateThumbPrint "" -AppID "" -Organization ""

Connect-ExchangeOnline


$Mailboxes = Get-Mailbox -Filter '(RecipientTypeDetails -eq "UserMailbox")'
$Mailboxes | ForEach-Object {
    # Defines the identity parameter to set calendar permissions. example:
    # intials@domain.xx:\calendar or intials@domain.xx:\kalender
    $CalendarPath = $_.UserPrincipalName + ":\" + (Get-MailboxFolderStatistics $_.Identity | Where-Object {
    $_.Foldertype -eq "Calendar" } | Select-Object -First 1).Name
    # Sets calendar permissions
    $Permissionscal_write = Get-MailboxFolderPermission -identity $CalendarPath -User $User_Perm1 -ErrorAction SilentlyContinue
    $PermissionsCalendarEditor = Get-MailboxFolderPermission -identity $CalendarPath -User CalendarEditor@godskegroup.onmicrosoft.com -ErrorAction SilentlyContinue

    if ($Permissionscal_write.AccessRights -ne $Perm1) {
        add-MailboxFolderPermission -Identity $CalendarPath -User $User_Perm1 -AccessRights $Perm1
    } else {
        Set-MailboxFolderPermission -Identity $CalendarPath -User $User_Perm1 -AccessRights $Perm1
    }

    if ($PermissionsCalendarEditor.AccessRights -ne $Perm2) {
        add-MailboxFolderPermission -Identity $CalendarPath -User $User_Perm2 -AccessRights $Perm2
    } else {
        Set-MailboxFolderPermission -Identity $CalendarPath -User $User_Perm2 -AccessRights $Perm2
    }
}