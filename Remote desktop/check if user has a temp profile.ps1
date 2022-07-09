Param(
    $Servers = @('Server1,Server2'),
    $TypeUsernameHere = "Username"
)


try {
    $userid = get-aduser -identity $TypeUsernameHere | select SID
    Write-Host "User $TypeUsernameHere Found"
}
catch {
    Write-Host "Cannot find user $TypeUsernameHere"
    Break
}

$global:objectsid = $userid.SID.Value

foreach ($computer in $Servers) {
    Invoke-Command -ComputerName $computer -ScriptBlock {
        & { 
            $test = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$Using:objectsid"
            $test1 = Test-Path "HKLM:\SOFTWARE\FSLogix\Profiles\Sessions\$Using:objectsid"
            $test2 = Get-ChildItem "\\$computer\C$\Users"
            if ($test -or $test1) {
                Write-Output "Session found on $($env:computername)"
            }
            else {
                Write-Output "Session was not found in $($env:computername)"
            }
            if ($test2.attributes -eq "Directory") {
                if ($test2.Name -match $TypeUsernameHere) {
                    $chapter_name = $folder_child
                    Write-Output $chapter_name | Select-Object Name, LastWriteTime, FullName
                }
            }
        }
    }
}

Write-Host "Would you like to run clean up of temp profile? Y/N"
$answer1 = Read-Host
if ($answer1 -eq "Y") {
    Write-Host "Please make sure that you have logged the user off before you continue"
    Write-Host "Ready to continue? Y/N"
    $answer2 = Read-Host
    if ($answer2 -eq "Y") {
        foreach ($folder_child in $path) {
            if ($folder_child.attributes -eq "Directory") {
                if ($folder_child.Name -match $TypeUsernameHere) {
                    $chapter_name = $folder_child
                    $copytopath = '\\BCFILE-P01\D$\$computer\'
                    Write-Host "copying files"
                    Copy-Item -Path $chapter_name.FullName -Destination $copytopath -Recurse -Verbose -wait
                    Write-Host "Copy complete"
                    Write-Host "Deleting files"
                    Get-ChildItem -Path $chapter_name.FullName -Include *.* -Recurse | Remove-Item -Force
                }
            }
        }
        foreach ($computer in $Servers) {
            Invoke-Command -ComputerName $computer -ScriptBlock {
                & { 
                    $test = Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$objectsid"
                    $test1 = Test-Path "HKLM:\SOFTWARE\FSLogix\Profiles\Sessions\$objectsid"
                    if ($test) {
                        Write-Host "removing Regedit ProfileList item $objectsid"
                        Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$objectsid" -Recurse
                    }
                    else {
                        Write-Host "No existing item in ProfileList for $objectsid"
                    }
                    if ($test1) {
                        Write-Host "removing Regedit Profile Session item $objectsid"
                        Remove-Item -Path "HKLM:\SOFTWARE\FSLogix\Profiles\Sessions\$objectsid" -Recurse
                    }
                    else {
                        Write-Host "No existing item in ProfileList for $objectsid"
                    }
                }
            }
        }
    }
}