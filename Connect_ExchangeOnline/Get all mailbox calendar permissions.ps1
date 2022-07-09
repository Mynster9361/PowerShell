$Result=@()
$allMailboxes = Get-Mailbox -ResultSize Unlimited | Select-Object -Property Displayname,PrimarySMTPAddress
$totalMailboxes = $allMailboxes.Count
$i = 1 
$allMailboxes | ForEach-Object {
$mailbox = $_
$calendarFolder = Get-EXOMailboxFolderStatistics -Identity $($_.PrimarySMTPAddress) -FolderScope Calendar | Where-Object { $_.FolderType -eq 'Calendar'} | Select-Object Name, FolderId
Write-Progress -activity "Processing $($_.Displayname)" -status "$i out of $totalMailboxes completed"
$cal = $calendarFolder.name
$folderPerms = Get-MailboxFolderPermission -Identity "$($_.PrimarySMTPAddress):\$cal"
$folderPerms | ForEach-Object {
$Result += New-Object PSObject -property @{ 
MailboxName = $mailbox.DisplayName
User = $_.User
Permissions = $_.AccessRights
}}
$i++
}
$Result | Select MailboxName, User, Permissions |
Export-CSV "C:\temp\CalendarPermissions.CSV" -NoTypeInformation -Encoding UTF8