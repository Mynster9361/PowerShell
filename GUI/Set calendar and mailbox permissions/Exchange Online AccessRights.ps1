function installedmodule {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
    $installedmodule = Get-InstalledModule -Name 'ExchangeOnlineManagement'
    #Uninstall-Module -name ExchangeOnlineManagement
    if ($installedmodule.name -contains 'ExchangeOnlineManagement' -and $installedmodule.Version -gt "2.0.4") {
        Write-Output "Exchange Online Module already installed. Connecting"
        Connect-ExchangeOnline 
    } 
    if ($installedmodule.name -contains 'ExchangeOnlineManagement' -and  $installedmodule.Version -le "2.0.4") {
        write-output "updating Exchange Online Package"
        Uninstall-Module -name ExchangeOnlineManagement
        Install-Module -Name ExchangeOnlineManagement -force
        Connect-ExchangeOnline
    } else {
        write-output "installing Exchange Online Package"
        install-packageprovider -name NuGet -MinimumVersion 2.8.5.201 -force
        Register-PSRepository -Default -InstallationPolicy Trusted
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
        Install-Module -Name ExchangeOnlineManagement
        Connect-ExchangeOnline
    } 
}
installedmodule
Add-Type -Name Window -Namespace Console -MemberDefinition '[DllImport("Kernel32.dll")] public static extern IntPtr GetConsoleWindow(); [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'
function Hide-Console {
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}
Hide-Console
$connect = "Connect-ExchangeOnline"
$testpath = Test-Path -Path C:\temp
If ($testpath -eq $false){
    new-Item -ItemType Directory -Force -Path C:\temp
}
$global:date = Get-Date -Format " dd/MM/yyyy"
$global:filename = "C:\temp\AccessRights" + $date + ".txt"
function Making ($text, $loc1, $loc2, $width, $height, $autoSize, $object) {
    $location                 = New-Object System.Drawing.Point($loc1, $loc2)
    $obj                      = New-Object $object
    $obj.text                 = $text
    $obj.width                = $width
    $obj.height               = $height
    $obj.location             = $location
    $obj.AutoSize             = $autoSize
    if($obj -match 'System.Windows.Forms.TextBox') {
        $obj.multiline        = $false
    } 
    if($obj -match 'System.Windows.Forms.ComboBox') {
        $obj.DropDownStyle    = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    } 
    if($obj -match 'System.Windows.Forms.LinkLabel') {
        $obj.LinkColor        = "Blue"
        $obj.ActiveLinkColor  = "Red"
    } 
    $obj.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    $obj
}
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(575,360)
$Form.text                       = "Exchange Online Access Control"
$Form.TopMost                    = $false
$FullAccess                      = Making "Full Access" 300 50 125 20 $false System.Windows.Forms.CheckBox
$SendAs                          = Making "Send As" 300 85 125 20 $false System.Windows.Forms.CheckBox
$SendOnBehalf                    = Making "Send On Behalf" 300 120 125 20 $false System.Windows.Forms.CheckBox
$CalendarAccess                  = Making "Only check this box if you need to change calendar permissions" 20 175 600 20 $false System.Windows.Forms.CheckBox
$Label1                          = Making "Mailbox" 20 25 25 10 $true System.Windows.Forms.Label
$Label2                          = Making "Person you would like to give access to" 20 100 25 10 $true System.Windows.Forms.Label
$Label3                          = Making "Choose which access you would like to give" 20 200 25 10 $true System.Windows.Forms.Label
$user                            = Making "" 20 50 250 25 $false System.Windows.Forms.TextBox
$userthatneedsaccess             = Making "" 20 125 250 25 $false System.Windows.Forms.TextBox
$CheckAccess                     = Making "Check Access" 460 50 100 40 $false System.Windows.Forms.Button
$Remove_Access                   = Making "Remove Access" 350 300 100 40 $false System.Windows.Forms.Button
$GiveAccess                      = Making "Give Access" 240 300 100 40 $false System.Windows.Forms.Button
$Exit                            = Making "Exit" 460 300 100 40 $false System.Windows.Forms.Button
$AccessRights                    = Making "" 20 250 250 20 $false System.Windows.Forms.ComboBox
$Label4                          = Making "Read about permissions here" 20 225 25 10 $true System.Windows.Forms.LinkLabel
$Form.controls.AddRange(@($FullAccess,$SendAs,$SendOnBehalf,$Label1,$Label2,$user,$userthatneedsaccess,$CheckAccess,$Remove_Access,$GiveAccess,$Exit,$AccessRights,$CalendarAccess,$Label3,$Label4))
$CheckAccess.Add_Click({ CheckAccess })
$GiveAccess.Add_Click({ GiveAccess })
$Remove_Access.Add_Click({ Remove_Access })
$Exit.Add_Click({ Exit_Button })
$AccessRights.Add_DropDown({ AccessRights })
$Label4.Add_Click({ [System.Diagnostics.Process]::Start("https://docs.microsoft.com/en-us/powershell/module/exchange/add-mailboxfolderpermission?view=exchange-ps#parameters") })
function Exit_Button {
    Get-PSSession | Remove-PSSession
    [void]$Form.Close()
}
function Mail {
    $mailuser = $user.Text -replace '(^\s+|\s+$)','' -replace '\s+',' '
    $mail = Get-EXOMailboxPermission -identity $mailuser
    $mail
}
function Recipient {
    $mailuser = $user.Text -replace '(^\s+|\s+$)','' -replace '\s+',' '
    $recipient = Get-EXORecipientPermission -Identity $mailuser
    $recipient
}
function Calendar {
    $mailuser = $user.Text -replace '(^\s+|\s+$)','' -replace '\s+',' '
    $calendarFolder = Get-EXOMailboxFolderStatistics -Identity $mailuser -FolderScope Calendar | Where-Object { $_.FolderType -eq 'Calendar'} | Select-Object Name, FolderId
    $calendar = $mailuser + ':\' + $calendarFolder.name
    $calendar
}
function AccessRights { 
    $AccessRights.Items.Clear()
    @('Reviewer','Editor','Owner','AvailabilityOnly','Author','Contributor','None','NonEditingAuthor','PublishingEditor','PublishingAuthor') | ForEach-Object {[void] $AccessRights.Items.Add($_)}
}
function addcontent($filename, $text, $perm) {
    if ($perm) {
    Add-content $filename $text
    $perm | Out-File -Append $filename
    }
}
function cmd($filename, $cmd) {
    $cmd | Out-File -Append $filename
    "">>$filename
}
function before($filename, $added_removed) {
    "Before you $added_removed the access it looked like this:">>$filename
    "">>$filename
}
function Chapter($filename) {
    "">>$filename
    "--------------------------------------------------------------">>$filename
    "-############################################################-">>$filename
    "--------------------------------------------------------------">>$filename
    "">>$filename
}
function textconnect($filename, $connect) {
    "The following commands has been used to perform your changes">>$filename
    "">>$filename
    "$connect">>$filename
    "">>$filename
}
function textcheckaccess($filename, $cmdMailboxPermission, $cmdMailboxSendOnBehalf, $cmdSendAs, $cmdCalendar) {
    $cmdMailboxPermission | Out-File -Append $filename
    "">>$filename
    $cmdMailboxSendOnBehalf | Out-File -Append $filename
    "">>$filename
    $cmdSendAs | Out-File -Append $filename
    "">>$filename
    $cmdCalendar | Out-File -Append $filename
}
function textonceyouclose($filename) {
    "!!!Once you close this file it will be deleted!!!">>$filename
    "You need to close this file before you can continue with the program">>$filename
    "">>$filename
}
function textpermissions($filename) {
    "Permissions now looks like shown here:">>$filename
    "">>$filename
}
function Remove_Access { 
    $mailuser = $user.Text -replace '(^\s+|\s+$)','' -replace '\s+',' '
    $removemailuserthatneedsaccess = $userthatneedsaccess.text -replace '(^\s+|\s+$)','' -replace '\s+',' '
    $calendar = Calendar
    textonceyouclose $filename
    textpermissions $filename
    if($FullAccess.Checked -eq $true){
        $2_FullAccess = Get-MailboxPermission -Identity $mailuser | select User,AccessRights
        Remove-MailboxPermission -Identity $mailuser -user $removemailuserthatneedsaccess -AccessRights FullAccess -InheritanceType All -confirm:$false
        $3_FullAccess = "Remove-MailboxPermission -Identity $mailuser -user $removemailuserthatneedsaccess -AccessRights FullAccess -InheritanceType All -confirm:$false"
        $permafter_fullaccess = Get-MailboxPermission -Identity $mailuser | select User,AccessRights
        addcontent $filename "Current Mailbox Permissions:" $permafter_fullaccess
    }
    if($SendAs.Checked -eq $true){
        $2_SendAs = Get-RecipientPermission -Identity $mailuser | select Trustee,AccessRights
        Remove-RecipientPermission -identity $mailuser -AccessRights SendAs -Trustee $removemailuserthatneedsaccess -confirm:$false
        $3_SendAs = "Remove-RecipientPermission -identity $mailuser -AccessRights SendAs -Trustee $removemailuserthatneedsaccess -confirm:$false"
        $permafter_sendas = Get-RecipientPermission -Identity $mailuser | select Trustee,AccessRights
        addcontent $filename "Current Send As Permissions:" $permafter_sendas
    }
    if($SendOnBehalf.Checked -eq $true){
        $2_SendOnBehalf = Get-Mailbox $mailuser | select Name
        Set-Mailbox -Identity $mailuser -GrantSendOnBehalfTo @{remove=$removemailuserthatneedsaccess}
        $3_SendOnBehalf = "Set-Mailbox -Identity $mailuser -GrantSendOnBehalfTo @{remove=$removemailuserthatneedsaccess}"
        $permafter_sendonbehalf = Get-Mailbox $mailuser
        addcontent $filename "Current Send On Behalf Permissions:" $permafter_sendonbehalf.GrantSendOnBehalfTo
    }
    if($CalendarAccess.Checked -eq $true) {
        $2_Calendar = $permbefore_calendar = Get-EXOMailboxFolderPermission -Identity $calendar | select User,AccessRights
        Remove-MailboxFolderPermission -Identity $calendar -User $removemailuserthatneedsaccess -confirm:$false
        $3_Calendar = "Remove-MailboxFolderPermission -Identity $calendar -User $removemailuserthatneedsaccess -confirm:$false"
        $permafter_calendar = Get-EXOMailboxFolderPermission -Identity $calendar | select User,AccessRights
        addcontent $filename "Current Calendar Permissions:" $permafter_calendar
    }
    Chapter $filename
    before $filename "removed"
    addcontent $filename "Mailbox Permissions:" $2_FullAccess
    addcontent $filename "Send As Permissions:" $2_SendAs
    addcontent $filename "Send On Behalf Permissions:" $2_SendOnBehalf
    addcontent $filename "Calendar Permissions:" $2_Calendar
    Chapter $filename
    textconnect $filename $connect
    cmd $filename $3_FullAccess
    cmd $filename $3_SendAs
    cmd $filename $3_SendOnBehalf
    cmd $filename $3_Calendar
    Start-Process $filename -Wait
    Remove-Item $filename
}
function GiveAccess { 
    $mailuser = $user.Text -replace '(^\s+|\s+$)','' -replace '\s+',' '
    $givemailuserthatneedsaccess = $userthatneedsaccess.text -replace '(^\s+|\s+$)','' -replace '\s+',' '
    $calendar = Calendar
    $cal = Get-EXOMailboxFolderPermission -identity $calendar
    $calID = $cal | Select-Object User
    $giveMail = Get-EXOMailboxPermission -identity $mailuser
    $userthatneeds = get-EXOmailbox $givemailuserthatneedsaccess
    $recipient = Get-EXORecipientPermission -Identity $mailuser
    $giveAccessRights = $AccessRights.SelectedItem
    textonceyouclose $filename
    textpermissions $filename
    if($FullAccess.Checked -eq $true){
        "Mailbox Permissions:">>$filename
        $2_FullAccess = Get-MailboxPermission -Identity $mailuser | select User,AccessRights
        if ($giveMail.User -notcontains $givemailuserthatneedsaccess) {
            Add-MailboxPermission -Identity $mailuser -User $givemailuserthatneedsaccess -AccessRights FullAccess -InheritanceType All -AutoMapping $true
            $3_FullAccess = "Add-MailboxPermission -Identity $mailuser -User $givemailuserthatneedsaccess -AccessRights FullAccess -InheritanceType All -AutoMapping $true"
            Get-MailboxPermission -Identity $mailuser | select User,AccessRights | Out-File -Append $filename
        }
    }
    if($SendAs.Checked -eq $true){
        Add-content $filename "Send As Permissions:"
        $2_SendAs = Get-RecipientPermission -Identity $mailuser | select Trustee,AccessRights 
        Add-RecipientPermission -Identity $mailuser -Trustee $givemailuserthatneedsaccess -AccessRights SendAs -confirm:$false
        $3_SendAs = "Add-RecipientPermission -Identity $mailuser -Trustee $givemailuserthatneedsaccess -AccessRights SendAs -confirm:$false"
        Get-RecipientPermission -Identity $mailuser | select Trustee,AccessRights | Out-File -Append $filename
    }
    if($SendOnBehalf.Checked -eq $true){
        Add-content $filename "Send On Behalf Permissions:"
        $2_SendOnBehalf = Get-Mailbox $mailuser | select Name
        Set-Mailbox -Identity $mailuser -GrantSendOnBehalfTo $givemailuserthatneedsaccess
        $3_SendOnBehalf = "Set-Mailbox -Identity $mailuser -GrantSendOnBehalfTo $givemailuserthatneedsaccess"
        Get-Mailbox $mailuser | select Name | Out-File -Append $filename
        "">>$filename
    }
    if($CalendarAccess.checked -eq $true){
        Add-content $filename "Calendar Permissions:"
        $2_Calendar = Get-EXOMailboxFolderPermission -Identity $calendar | select User,AccessRights
            $permission = Get-EXOMailboxFolderPermission -identity $calendar -User $givemailuserthatneedsaccess -ErrorAction SilentlyContinue
            if($permission -eq $null){
                Add-MailboxFolderPermission �identity $calendar �user $givemailuserthatneedsaccess  �Accessrights $AccessRights.SelectedItem
                $3_Calendar = "Add-MailboxFolderPermission -Identity $calendar -User $givemailuserthatneedsaccess -AccessRights $giveAccessRights"
            }else{
                Set-MailboxFolderPermission �identity $calendar �user $givemailuserthatneedsaccess �Accessrights $AccessRights.SelectedItem
                $3_Calendar = "Set-MailboxFolderPermission -Identity $calendar -User $givemailuserthatneedsaccess -AccessRights $giveAccessRights"
            }
            Get-EXOMailboxFolderPermission -Identity $calendar | select User,AccessRights | Out-File -Append $filename
    }
    Chapter $filename
    before $filename "added"
    addcontent $filename "Mailbox Permissions:" $2_FullAccess
    addcontent $filename "Send As Permissions:" $2_SendAs
    addcontent $filename "Send On Behalf Permissions:" $2_SendOnBehalf
    addcontent $filename "Calendar Permissions:" $2_Calendar
    Chapter $filename
    textconnect $filename $connect
    cmd $filename $3_FullAccess
    cmd $filename $3_SendAs
    cmd $filename $3_SendOnBehalf
    cmd $filename $3_Calendar
    Start-Process $filename -Wait
    Remove-Item $filename
}
function CheckAccess {   
    $mailuser = $user.Text -replace '(^\s+|\s+$)','' -replace '\s+',' ' 
    $calendar = Calendar
    $perm1 = Get-EXOMailboxPermission -Identity $mailuser | select User,AccessRights
    $cmdMailboxPermission = "Get-MailboxPermission -Identity $mailuser | select User,AccessRights"
    $perm2 = Get-EXOMailbox $mailuser | Select GrantSendOnBehalfTo
    $cmdMailboxSendOnBehalf = "Get-Mailbox $mailuser | Select GrantSendOnBehalfTo"
    $perm3 = Get-RecipientPermission -Identity $mailuser | select Trustee,AccessRights 
    $cmdSendAs = "Get-RecipientPermission -Identity $mailuser | select Trustee,AccessRights "
    $perm4 = Get-MailboxFolderPermission -Identity $calendar | select User,AccessRights
    $cmdCalendar = "Get-MailboxFolderPermission -Identity $calendar | select User,AccessRights"
    textonceyouclose $filename
    addcontent $filename "Mailbox Permissions:" $perm1
    addcontent $filename "Send On Behalf:" $perm2
    addcontent $filename "Send As Permissions:" $perm3
    addcontent $filename "Calendar Permissions:" $perm4
    Chapter $filename
    textconnect $filename $connect
    textcheckaccess $filename $cmdMailboxPermission $cmdMailboxSendOnBehalf $cmdSendAs $cmdCalendar
    Start-Process $filename -Wait
    Remove-Item $filename
}
[void]$Form.ShowDialog()