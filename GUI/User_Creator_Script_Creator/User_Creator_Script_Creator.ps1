$testpathvalue = Test-Path -Path C:\Scripts
If ($testpathvalue -eq $False){
    #Creating a folder in the C:\ Drive called Scripts if it does not exist already
    new-Item -ItemType Directory -Force -Path C:\Scripts
}
$date = Get-Date -Format " dd-MM-yyyy"
$filename = "C:\Scripts\User_Creator" + $date + ".ps1"
$global:Required = New-Object Collections.Generic.List[String]
$global:requiredFields = "@("
function Making ($text, $checked, $enabled, $loc1, $loc2, $width, $height, $autoSize, $object) {
    #Used to make the Gui in the first form
    $location                               = New-Object System.Drawing.Point($loc1, $loc2)
    $obj                                    = New-Object $object
    $obj.text                               = $text
    $obj.width                              = $width
    $obj.height                             = $height
    $obj.location                           = $location
    $obj.AutoSize                           = $autoSize
    if($obj -match 'System.Windows.Forms.TextBox') {
        $obj.multiline                      = $false
    } 
    if($obj -match 'System.Windows.Forms.CheckBox') {
        $obj.Checked                        = $checked
        $obj.Enabled                        = $enabled
    }
    if($obj -match 'System.Windows.Forms.ComboBox') {
        $obj.DropDownStyle    = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    } 
    if($obj -match 'System.Windows.Forms.Label' -and $loc2 -eq 40) {
        $obj.Font                           = [System.Drawing.Font]::new("Microsoft Sans Serif", 11, [System.Drawing.FontStyle]::Bold)
    } elseif($obj -match 'System.Windows.Forms.Label' -and $loc2 -eq 15) {
        $obj.Font                           = [System.Drawing.Font]::new("Microsoft Sans Serif", 12, [System.Drawing.FontStyle]::Bold)
    } elseif($obj -match 'System.Windows.Forms.Label') {
        $obj.Font                           = [System.Drawing.Font]::new("Microsoft Sans Serif", 11)
    } else {
        $obj.Font                           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    }
    $obj
}
function Check_Next ($last_object_check, $text_check, $check_check, $enabled_check, $loc1_check, $loc2_check, $width_check, $height_checl, $autoSize_check, $object_check){
    #Used to only input an object in the next_form if the item was checked in the first form
    if($last_object_check.Checked -eq $true){
        $location_check                     = New-Object System.Drawing.Point($loc1_check, $loc2_check)
        $obj_check                          = New-Object $object_check
        $obj_check.text                     = $text_check
        $obj_check.width                    = $width_check
        $obj_check.height                   = $height_checl
        $obj_check.location                 = $location_check
        $obj_check.AutoSize                 = $autoSize_check
        if($obj_check -match 'System.Windows.Forms.CheckBox') {
            $obj_check.Checked              = $check_check
            $obj_check.Enabled              = $enabled_check
            $obj_check.Font                 = [System.Drawing.Font]::new("Microsoft Sans Serif", 10)
        }
        if($obj_check -match 'System.Windows.Forms.Label'){
            $obj_check.Font                 = [System.Drawing.Font]::new("Microsoft Sans Serif", 11)
        }
        $obj_check
        $NextForm.Controls.Add($obj_check)
    }
}

function R_Check ($Req, $ReqValue, $Field) {
    #Used to make/check if a value is required and is used to see if the Create user should be enabled or not
    if($Req.Checked){
        #Tjek op pÃ¥ bÃ¥de Required og requiredFields de tilfÃ¸jet ting 2 gange hvis man kÃ¸re scriptet 2 gange uden at lukke det
        [void]$Required.add($ReqValue)
        $global:requiredFields += $Field
    }
}
function export_check ($first_check, $second_check, $text, $copyfrom_check) {
    #Used only if $copy_from is checked in order to get information from the copied user
    if ($first_check.Checked -eq $true) {
        if($copyfrom_check -eq $true){
        Add-Content -Path $filename $text
        }
        if ($first_check.Checked -eq $true -and $second_check.Checked -eq $true) {
            Add-Content -Path $filename $text
        }
    }
}
function export_check_create_User ($first_check, $text) {
    #Used to check if a check box is checked if checked it will add content to the create user function in the exported script
    if ($first_check.Checked -eq $true) {
        Add-Content -path $filename $text
    }
}
function red_white_validate ($first_check, $text, $text1, $text4, $text5, $text6) {
    #Used to create labels, Textboxes, Combobox in exported script
    if ($first_check.Checked -eq $true) {
        Add-Content -path $filename $text
        Add-Content -path $filename $text1
        Add-Content -path $filename $text5
        Add-Content -path $filename $text6
        Add-Content -Path $filename $text4
    } 
}
function General_Copy_From_checkboxes ($check_copy_from_checkboxes) {
    #Used to check boxes when $General_Copy_From is checked
    if ($General_Copy_From.Checked -eq $true){
        $General_Web_page.Checked = $true
        $Address_City.Checked = $true
        $Address_State_Province.Checked = $true
        $Address_Zip_Postal_Code.Checked = $true
        $Address_Country_Region.Checked = $true
        $Organization_Department.Checked = $true
        $Organization_Company.Checked = $true
        $Organization_Manager.Checked = $true
    }
    if ($General_Copy_From.Checked -eq $false){
        $General_Web_page.Checked = $false
        $Address_City.Checked = $false
        $Address_State_Province.Checked = $false
        $Address_Zip_Postal_Code.Checked = $false
        $Address_Country_Region.Checked = $false
        $Organization_Department.Checked = $false
        $Organization_Company.Checked = $false
        $Organization_Manager.Checked = $false
    }
}
function checkoffice365 {
    if ($Office365.Checked) {
        $Exchange.Checked = $false
        $Exchange_Hybrid_O365.Checked = $false
        if ($Office365.Checked -eq $true -or $Exchange.Checked -eq $true -or $Exchange_Hybrid_O365.Checked -eq $true) {
            $Next.Enabled = $true
        }
    }
    if ($Office365.Checked -eq $false -and $Exchange.Checked -eq $false -and $Exchange_Hybrid_O365.Checked -eq $false) {
        $Next.Enabled = $false
    }
}
function checkexchange {
    if ($Exchange.Checked) {
        $Office365.Checked = $false
        $Exchange_Hybrid_O365.Checked = $false
        if ($Office365.Checked -eq $true -or $Exchange.Checked -eq $true -or $Exchange_Hybrid_O365.Checked -eq $true) {
            $Next.Enabled = $true
        }
    } 
    if ($Office365.Checked -eq $false -and $Exchange.Checked -eq $false -and $Exchange_Hybrid_O365.Checked -eq $false) {
        $Next.Enabled = $false
    }
}

function checkexchangehybrid {
    if ($Exchange_Hybrid_O365.Checked) {
        $Office365.Checked = $false
        $Exchange.Checked = $false
        if ($Office365.Checked -eq $true -or $Exchange.Checked -eq $true -or $Exchange_Hybrid_O365.Checked -eq $true) {
            $Next.Enabled = $true
        }
    }
    if ($Office365.Checked -eq $false -and $Exchange.Checked -eq $false -and $Exchange_Hybrid_O365.Checked -eq $false) {
        $Next.Enabled = $false
    }
}
######################################################################
#                          Start of Form                             #
######################################################################
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
$Form                                       = New-Object system.Windows.Forms.Form
$Form.ClientSize                            = New-Object System.Drawing.Point(700,360)
$Form.text                                  = "Script creator for User Creations"
$Form.TopMost                               = $false
$General                                    = Making "General" $false $false 20 40 95 20 $true System.Windows.Forms.Label
$General_Copy_From                          = Making "Copy groups" $false $true 20 60 125 20 $false System.Windows.Forms.CheckBox
$General_Initials                           = Making "Initials" $true $false 20 80 125 20 $false System.Windows.Forms.CheckBox
$General_Domain                             = Making "@Domain.xx" $true $false 20 100 125 20 $false System.Windows.Forms.CheckBox
$General_FirstName                          = Making "First name" $true $false 20 120 125 20 $false System.Windows.Forms.CheckBox
$General_LastName                           = Making "Last name" $true $false 20 140 125 20 $false System.Windows.Forms.CheckBox
$General_Password                           = Making "Password" $true $false 20 160 125 20 $false System.Windows.Forms.CheckBox
$General_Description                        = Making "Description" $false $true 20 180 125 20 $false System.Windows.Forms.CheckBox
$General_Telephone_Number                   = Making "Telephone" $false $true 20 200 125 20 $false System.Windows.Forms.CheckBox
$General_Web_page                           = Making "Web page" $false $true 20 220 125 20 $false System.Windows.Forms.CheckBox
$Address                                    = Making "Address" $false $false 150 40 95 20 $true System.Windows.Forms.Label
$Address_Street                             = Making "Address street" $false $true 150 60 125 20 $false System.Windows.Forms.CheckBox
$Address_City                               = Making "City" $false $true 150 80 125 20 $false System.Windows.Forms.CheckBox
$Address_State_Province                     = Making "State/Province" $false $true 150 100 125 20 $false System.Windows.Forms.CheckBox
$Address_Zip_Postal_Code                    = Making "ZIP/Postal Code" $false $true 150 120 125 20 $false System.Windows.Forms.CheckBox
$Address_Country_Region                     = Making "Country/Region" $false $true 150 140 125 20 $false System.Windows.Forms.CheckBox
$Profile_header                             = Making "Profile" $false $false 280 40 95 20 $true System.Windows.Forms.Label
$Profile_Profile_Path                       = Making "Profile path" $false $true 280 60 125 20 $false System.Windows.Forms.CheckBox
$Profile_Logon_Script                       = Making "Logon script" $false $true 280 80 125 20 $false System.Windows.Forms.CheckBox
$Profile_Local_Path                         = Making "Local path" $false $true 280 100 125 20 $false System.Windows.Forms.CheckBox
$Profile_Connect                            = Making "Connect x-path" $false $true 280 120 125 20 $false System.Windows.Forms.CheckBox
$Telephones                                 = Making "Telephones" $false $false 410 40 95 20 $true System.Windows.Forms.Label
$Telephones_Home                            = Making "Home" $false $true 410 60 125 20 $false System.Windows.Forms.CheckBox
$Telephones_Mobile                          = Making "Mobile" $false $true 410 80 125 20 $false System.Windows.Forms.CheckBox
$Telephones_Fax                             = Making "Fax" $false $true 410 100 125 20 $false System.Windows.Forms.CheckBox
$Organization                               = Making "Organization" $false $false 540 40 95 20 $true System.Windows.Forms.Label
$Organization_Job_Title                     = Making "Job Title" $false $true 540 60 125 20 $false System.Windows.Forms.CheckBox
$Organization_Department                    = Making "Department" $false $true 540 80 125 20 $false System.Windows.Forms.CheckBox
$Organization_Company                       = Making "Company" $false $true 540 100 125 20 $false System.Windows.Forms.CheckBox
$Organization_Manager                       = Making "Manager" $false $true 540 120 125 20 $false System.Windows.Forms.CheckBox
$Exit                                       = Making "Exit" $false $false 570 300 100 30 $false System.Windows.Forms.Button
$Next                                       = Making "Next" $false $false 450 300 100 30 $false System.Windows.Forms.Button
$Profile_Local_Path.Add_Click({ $Profile_Connect.checked = $false  })
$Profile_Connect.Add_Click({ $Profile_Local_Path.checked = $false  })
$General_Copy_From.Checked = $true

$General_Copy_From.Add_Click({ General_Copy_From_checkboxes })
$Exit                                       = Making "Exit" $false $false 570 300 100 30 $false System.Windows.Forms.Button
$Next                                       = Making "Next" $false $false 450 300 100 30 $false System.Windows.Forms.Button
$Next.Enabled = $false

$Mail_Solution                              = Making "Mail solution:" $false $false 448 200 95 20 $true System.Windows.Forms.Label
$Office365                                  = Making "Office 365" $false $true 450 220 125 20 $false System.Windows.Forms.CheckBox
$Exchange                                   = Making "Exchange" $false $true 450 240 125 20 $false System.Windows.Forms.CheckBox
$Exchange_Hybrid_O365                       = Making "Exchange Hybrid O365" $false $true 450 260 250 20 $false System.Windows.Forms.CheckBox

$Form.controls.AddRange(@($General,$General_Copy_from,$General_FirstName,$General_LastName,$General_Password,$General_Initials,$General_Domain,$General_Description,$General_Telephone_Number,$General_Web_page,$Address,$Address_Street,$Address_City,$Address_State_Province,$Address_Zip_Postal_Code,$Address_Country_Region,$Profile_header,$Profile_Profile_Path,$Profile_Logon_Script,$Profile_Local_Path,$Profile_Connect,$Telephones,$Telephones_Home,$Telephones_Mobile,$Telephones_Fax,$Organization,$Organization_Job_Title,$Organization_Department,$Organization_Company,$Organization_Manager,$Mail_Solution,$Office365,$Exchange,$Exchange_Hybrid_O365,$Exit,$Next))

$Exit.Add_Click({ Exit_Button })
$Next.Add_Click({ Next_Button })
$Office365.Add_CheckStateChanged({ checkoffice365 })
$Exchange.Add_CheckStateChanged({ checkexchange })
$Exchange_Hybrid_O365.Add_CheckStateChanged({ checkexchangehybrid })

######################################################################
#                        End of First Form                           #
######################################################################
function Exit_Button {
    [void]$Form.Close()
}
function Next_Button {
######################################################################
#                        Start of NextForm                           #
######################################################################
    $NextForm                               = New-Object system.Windows.Forms.Form
    $NextForm.ClientSize                    = New-Object System.Drawing.Point(900,550)
    $NextForm.text                          = "Script creator for User Creations"
    $NextForm.TopMost                       = $false
    $Text_Next                              = Making "Select the fields that should always have content" $false $false 275 15 150 20 $true System.Windows.Forms.Label
    $General_Next                           = Making "General" $false $false 20 40 95 20 $true System.Windows.Forms.Label
    $Next_General_Copy_From_Label           = Check_Next $General_Copy_From "Copy groups" $false $false 20 70 25 10 $true System.Windows.Forms.Label
    $Next_General_Copy_From                 = Check_Next $General_Copy_From "Required" $false $true 20 90 125 20 $false System.Windows.Forms.CheckBox
    $Next_General_FirstName_Label           = Check_Next $General_FirstName "First name" $false $false 20 120 25 10 $true System.Windows.Forms.Label
    $Next_General_FirstName                 = Check_Next $General_FirstName "Required" $true $false 20 140 125 20 $false System.Windows.Forms.CheckBox
    $Next_General_LastName_Label            = Check_Next $General_LastName "Last name" $false $false 20 170 25 10 $true System.Windows.Forms.Label
    $Next_General_LastName                  = Check_Next $General_LastName "Required" $true $false 20 190 125 20 $false System.Windows.Forms.CheckBox
    $Next_General_Initials_Label            = Check_Next $General_Initials "Initials" $false $false 20 220 25 10 $true System.Windows.Forms.Label
    $Next_General_Initials                  = Check_Next $General_Initials "Required" $true $false 20 240 125 20 $false System.Windows.Forms.CheckBox
    $Next_General_Domain_Label              = Check_Next $General_Domain "@Domain.xx" $false $false 20 270 25 10 $true System.Windows.Forms.Label
    $Next_General_Domain                    = Check_Next $General_Domain "Required" $true $false 20 290 125 20 $false System.Windows.Forms.CheckBox
    $Next_General_Password_Label            = Check_Next $General_FirstName "Password" $false $false 20 320 25 10 $true System.Windows.Forms.Label
    $Next_General_Password                  = Check_Next $General_FirstName "Required" $true $false 20 340 125 20 $false System.Windows.Forms.CheckBox
    $Next_General_Description_Label         = Check_Next $General_Description "Description" $false $false 20 370 25 10 $true System.Windows.Forms.Label
    $Next_General_Description               = Check_Next $General_Description "Required" $false $true 20 390 125 20 $false System.Windows.Forms.CheckBox
    $Next_General_Telephone_Number_Label    = Check_Next $General_Telephone_Number "Telephone" $false $false 20 420 25 10 $true System.Windows.Forms.Label
    $Next_General_Telephone_Number          = Check_Next $General_Telephone_Number "Required" $false $true 20 440 125 20 $false System.Windows.Forms.CheckBox
    $Next_General_Web_page_Label            = Check_Next $General_Web_page "Web page" $false $false 20 470 25 10 $true System.Windows.Forms.Label
    $Next_General_Web_page                  = Check_Next $General_Web_page "Required" $false $true 20 490 125 20 $false System.Windows.Forms.CheckBox
    $Address_Next                           = Making "Address" $false $false 200 40 95 20 $true System.Windows.Forms.Label
    $Next_Address_Street_Label              = Check_Next $Address_Street "Street" $false $false 200 70 25 10 $true System.Windows.Forms.Label
    $Next_Address_Street                    = Check_Next $Address_Street "Required" $false $true 200 90 125 20 $false System.Windows.Forms.CheckBox
    $Next_Address_City_Label                = Check_Next $Address_City "City" $false $false 200 120 25 10 $true System.Windows.Forms.Label
    $Next_Address_City                      = Check_Next $Address_City "Required" $false $true 200 140 125 20 $false System.Windows.Forms.CheckBox
    $Next_Address_State_Province_Label      = Check_Next $Address_State_Province "State/Province" $false $false 200 170 25 10 $true System.Windows.Forms.Label
    $Next_Address_State_Province            = Check_Next $Address_State_Province "Required" $false $true 200 190 125 20 $false System.Windows.Forms.CheckBox
    $Next_Address_Zip_Postal_Code_Label     = Check_Next $Address_Zip_Postal_Code "Zip/Postal Code" $false $false 200 220 25 10 $true System.Windows.Forms.Label
    $Next_Address_Zip_Postal_Code           = Check_Next $Address_Zip_Postal_Code "Required" $false $true 200 240 125 20 $false System.Windows.Forms.CheckBox
    $Next_Address_Country_Region_Label      = Check_Next $Address_Country_Region "Country" $false $false 200 270 25 10 $true System.Windows.Forms.Label
    $Next_Address_Country_Region            = Check_Next $Address_Country_Region "Required" $false $true 200 290 125 20 $false System.Windows.Forms.CheckBox
    $Profile_Next                           = Making "Profile" $false $false 380 40 95 20 $true System.Windows.Forms.Label
    $Next_Profile_Profile_Path_Label        = Check_Next $Profile_Profile_Path "Profile Path" $false $false 380 70 25 10 $true System.Windows.Forms.Label
    $Next_Profile_Profile_Path              = Check_Next $Profile_Profile_Path "Required" $false $true 380 90 125 20 $false System.Windows.Forms.CheckBox
    $Next_Profile_Logon_Script_Label        = Check_Next $Profile_Logon_Script "Logon Script" $false $false 380 120 25 10 $true System.Windows.Forms.Label
    $Next_Profile_Logon_Script              = Check_Next $Profile_Logon_Script "Required" $false $true 380 140 125 20 $false System.Windows.Forms.CheckBox
    $Next_Profile_Local_Path_Label          = Check_Next $Profile_Local_Path "Local Path" $false $false 380 170 25 10 $true System.Windows.Forms.Label
    $Next_Profile_Local_Path                = Check_Next $Profile_Local_Path "Required" $false $true 380 190 125 20 $false System.Windows.Forms.CheckBox
    $Next_Profile_Connect_Label             = Check_Next $Profile_Connect "Connect x-path" $false $false 380 220 25 10 $true System.Windows.Forms.Label
    $Next_Profile_Connect                   = Check_Next $Profile_Connect "Required" $false $true 380 240 125 20 $false System.Windows.Forms.CheckBox
    $Telephones_Next                        = Making "Telephones" $false $false 560 40 95 20 $true System.Windows.Forms.Label
    $Next_Telephones_Home_Label             = Check_Next $Telephones_Home "Home" $false $false 560 70 25 10 $true System.Windows.Forms.Label
    $Next_Telephones_Home                   = Check_Next $Telephones_Home "Required" $false $true 560 90 125 20 $false System.Windows.Forms.CheckBox
    $Next_Telephones_Mobile_Label           = Check_Next $Telephones_Mobile "Mobile" $false $false 560 120 25 10 $true System.Windows.Forms.Label
    $Next_Telephones_Mobile                 = Check_Next $Telephones_Mobile "Required" $false $true 560 140 125 20 $false System.Windows.Forms.CheckBox
    $Next_Telephones_Fax_Label              = Check_Next $Telephones_Fax "Fax" $false $false 560 170 25 10 $true System.Windows.Forms.Label
    $Next_Telephones_Fax                    = Check_Next $Telephones_Fax "Required" $false $true 560 190 125 20 $false System.Windows.Forms.CheckBox
    $Organization_Next                      = Making "Organization" $false $false 740 40 95 20 $true System.Windows.Forms.Label
    $Next_Organization_Job_Title_Label      = Check_Next $Organization_Job_Title "Job Title" $false $false 740 70 25 10 $true System.Windows.Forms.Label
    $Next_Organization_Job_Title            = Check_Next $Organization_Job_Title "Required" $false $true 740 90 125 20 $false System.Windows.Forms.CheckBox
    $Next_Organization_Department_Label     = Check_Next $Organization_Department "Department" $false $false 740 120 25 10 $true System.Windows.Forms.Label
    $Next_Organization_Department           = Check_Next $Organization_Department "Required" $false $true 740 140 125 20 $false System.Windows.Forms.CheckBox
    $Next_Organization_Company_Label        = Check_Next $Organization_Company "Company" $false $false 740 170 25 10 $true System.Windows.Forms.Label
    $Next_Organization_Company              = Check_Next $Organization_Company "Required" $false $true 740 190 125 20 $false System.Windows.Forms.CheckBox
    $Next_Organization_Manager_Label        = Check_Next $Organization_Manager "Manager" $false $false 740 220 25 10 $true System.Windows.Forms.Label
    $Next_Organization_Manager              = Check_Next $Organization_Manager "Required" $false $true 740 240 125 20 $false System.Windows.Forms.CheckBox
    $Filename_Label                         = Making "Customer:" $false $false 400 450 95 20 $true System.Windows.Forms.Label
    $Filename_Label.Forecolor               = 'red'
    $Filename_Text                          = Making "" $true $false 400 475 200 20 $true System.Windows.Forms.TextBox

    if ($Exchange.Checked -or $Exchange_Hybrid_O365.Checked) {
        $ExchangeServer_Label               = Making "FQDN Exchange server:" $false $false 400 400 95 20 $true System.Windows.Forms.Label
        $ExchangeServer_Label.Forecolor     = 'red'
        $ExchangeServer_Text                = Making "" $true $false 400 425 200 20 $true System.Windows.Forms.TextBox
        $NextForm.Controls.AddRange(@($ExchangeServer_Label,$ExchangeServer_Text))
    }
    if ($Office365.Checked -or $Exchange_Hybrid_O365.Checked) {
        $ADFS_Label                         = Making "ADFS server:" $false $false 400 350 95 20 $true System.Windows.Forms.Label
        $ADFS_Label.Forecolor               = 'red'
        $ADFS_Text                          = Making "" $true $false 400 375 200 20 $true System.Windows.Forms.TextBox
        $NextForm.Controls.AddRange(@($ADFS_Label,$ADFS_Text))
    }


    $global:filename_export = $Filename_Text.text
    $Export_Script                          = Making "Export Script" $false $false 775 500 100 30 $false System.Windows.Forms.Button
    $Back                                   = Making "Back" $false $false 650 500 100 30 $false System.Windows.Forms.Button
    $Next_SD_Agreement.Checked = $true
    $Next_SD_Agreement.Add_Click({ $Next_SD_Agreement_Blue_White.checked = $false  })
    $Next_SD_Agreement_Blue_White.Add_Click({ $Next_SD_Agreement.checked = $false  })
    $NextForm.Controls.AddRange(@($Text_Next, $General_Next, $Address_Next, $Profile_Next, $Telephones_Next, $Organization_Next, $Export_Script, $Back, $Filename_Text, $Filename_Label))
    $Export_Script.Add_Click({ Export_Script })
    $Back.Add_Click({ [void]$NextForm.Close() })
    [void]$NextForm.ShowDialog()
######################################################################
#                        End of NextForm                             #
######################################################################
}
function Export_Script {
    $global:filename_export = $Filename_Text.text
######################################################################
#                        Start of Export                             #
######################################################################
######################################################################
#                 Start of Export Failure window                     #
######################################################################
    $ExportForm_Failure                     = New-Object system.Windows.Forms.Form
    $ExportForm_Failure.ClientSize          = New-Object System.Drawing.Point(950,200)
    $ExportForm_Failure.text                = "Failure"
    $ExportForm_Failure.TopMost             = $false
    $Text_ExportForm_Failure                = Making "A file already exist called '$global:filename_export User Creator.ps1' in 'C:\Scripts\'" $false $false 20 15 150 20 $true System.Windows.Forms.Label
    $Text_ExportForm_Failure.ForeColor      = 'red'
    $Text_ExportForm_Failure1               = Making "Please move this file somewhere else or choose another name and try again" $false $false 20 50 150 20 $true System.Windows.Forms.Label
    $Try_Again                              = Making "Try again" $false $false 475 150 100 30 $false System.Windows.Forms.Button
    $ExportForm_Failure.Controls.AddRange(@($Text_ExportForm_Failure, $Text_ExportForm_Failure1, $Try_Again))
    $FailureTest = Test-Path -Path "C:\Scripts\$global:filename_export User Creator.ps1"
    If ($FailureTest -eq 'True'){
        $Try_Again.Add_Click({ [void]$ExportForm_Failure.Close()})
        [void]$ExportForm_Failure.ShowDialog()
        return
    }
######################################################################
#                  End of Export Failure window                      #
######################################################################
######################################################################
#                 Start of Export Success window                     #
######################################################################
    $ExportForm_Success                     = New-Object system.Windows.Forms.Form
    $ExportForm_Success.ClientSize          = New-Object System.Drawing.Point(600,200)
    $ExportForm_Success.text                = "Success"
    $ExportForm_Success.TopMost             = $false
    $Text_ExportForm_Success                = Making "The user creator script has now been created" $false $false 20 15 150 20 $true System.Windows.Forms.Label
    $Text_ExportForm_Success1               = Making "and can be located at 'C:\Scripts\' with the file name '$global:filename_export User Creator.ps1'" $false $false 20 50 150 20 $true System.Windows.Forms.Label
    $Text_ExportForm_Success2               = Making "Place your new script on the server it needs to run from in 'C:\Scripts' " $false $false 20 70 150 20 $true System.Windows.Forms.Label
    $Text_ExportForm_Success3               = Making "Place the shortcut anywhere you would like on the server" $false $false 20 90 150 20 $true System.Windows.Forms.Label
    $Done                                   = Making "Done" $false $false 475 150 100 30 $false System.Windows.Forms.Button
    $Create_Another_ExportForm              = Making "Create one more" $false $false 340 150 125 30 $false System.Windows.Forms.Button
    $Create_Another_ExportForm.Add_Click({ [void]$NextForm.Close() ; [void]$ExportForm_Success.Close() })
    $Done.Add_Click({ [void]$Form.Close() ; [void]$NextForm.Close() ; [void]$ExportForm_Success.Close() })
    $ExportForm_Success.Controls.AddRange(@($Text_ExportForm_Success, $Text_ExportForm_Success1, $Done, $Create_Another_ExportForm, $Text_ExportForm_Success2, $Text_ExportForm_Success3))
    [void]$ExportForm_Success.ShowDialog()
######################################################################
#                  End of Export Success window                      #
######################################################################
    $global:Required = New-Object Collections.Generic.List[String]
    $global:requiredFields = "@("
    R_Check $Next_General_Copy_From '$Copy_From_Initials.Text.Length' "'`$Copy_From_Initials',"
    R_Check $Next_General_Initials '$Initials.Text.Length' "'`$Initials',"
    R_Check $Next_General_FirstName '$First_name.Text.Length' "'`$First_name',"
    R_Check $Next_General_LastName '$Last_name.Text.Length' "'`$Last_name',"
    R_Check $Next_General_Description '$Description.Text.Length' "'`$Description',"
    R_Check $Next_General_Telephone_Number '$Phone.Text.Length' "'`$Phone',"
    R_Check $Next_General_Web_page '$Web_page.Text.Length' "'`$Web_page',"
    R_Check $Next_General_Domain '$Domain_UPN.Text.Length' "'`$Domain_UPN',"
    R_Check $Next_Address_Street '$Address_street.Text.Length' "'`$Address_street',"
    R_Check $Next_Address_City '$City.Text.Length' "'`$City',"
    R_Check $Next_Address_State_Province '$State_Province.Text.Length' "'`$State_Province',"
    R_Check $Next_Address_Zip_Postal_Code '$ZIP_Postal_Code.Text.Length' "'`$ZIP_Postal_Code',"
    R_Check $Next_Address_Country_Region '$Country.Text.Length' "'`$Country',"
    R_Check $Next_Profile_Profile_Path '$Profile_path.Text.Length' "'`$Profile_path',"
    R_Check $Next_Profile_Logon_Script '$Logon_script.Text.Length' "'`$Logon_script',"
    R_Check $Next_Profile_Local_Path '$Local_path.Text.Length' "'`$Local_path',"
    R_Check $Next_Profile_Connect '$Connect_x_path.Text.Length' "'`$Connect_x_path',"
    R_Check $Next_Profile_Connect '$Homedrive1.Text.Length' "'`$Homedrive1',"
    R_Check $Next_Telephones_Home '$Telephones_Home.Text.Length' "'`$Telephones_Home',"
    R_Check $Next_Telephones_Mobile '$Mobile.Text.Length' "'`$Mobile',"
    R_Check $Next_Telephones_Fax '$Fax.Text.Length' "'`$Fax',"
    R_Check $Next_Organization_Job_Title '$Job_Title.Text.Length' "'`$Job_Title',"
    R_Check $Next_Organization_Department '$Department.Text.Length' "'`$Department',"
    R_Check $Next_Organization_Company '$Company.Text.Length' "'`$Company',"
    R_Check $Next_Organization_Manager '$Manager.Text.Length' "'`$Manager',"
    R_Check $Next_General_Initials '$OU_Drop.Text.Length' "'`$OU_Drop',"
    $RequiredValue = $Required -join ' -and '
    $global:requiredFields = $global:requiredFields.Substring(0,($global:requiredFields.Length-1))
    $global:requiredFields += ')'
    if ($Next_Address_Country_Region.Checked -eq $true){
        $country_validation = '-and $Country.SelectedItem -ne "-- Please select one --"'
    }
    $ADFS = $ADFS_Text.Text
    $Install_module = @"
function installedmodule {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
    `$installedmodule1 = Get-InstalledModule -Name 'ExchangeOnlineManagement' -ErrorAction SilentlyContinue
    `$installedmodule2 = Get-InstalledModule -Name 'MSOnline' -ErrorAction SilentlyContinue
    if (`$installedmodule1.name -contains 'ExchangeOnlineManagement' -and `$installedmodule1.Version -gt "2.0.4") {
        Write-Output "Exchange Online module already installed. Connecting"
        Connect-ExchangeOnline 
    } elseif (`$installedmodule1.name -contains 'ExchangeOnlineManagement' -and  `$installedmodule1.Version -le "2.0.4") {
        write-output "updating Exchange Online Package"
        Uninstall-Module -name ExchangeOnlineManagement
        Install-Module -Name ExchangeOnlineManagement -force
        Connect-ExchangeOnline
    } else {
        write-output "installing Exchange Online Package"
        install-packageprovider -name NuGet -MinimumVersion 2.8.5.201 -force
        Register-PSRepository -Default -InstallationPolicy Trusted -ErrorAction SilentlyContinue
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted -ErrorAction SilentlyContinue
        Install-Module -Name ExchangeOnlineManagement
        Connect-ExchangeOnline
    } 
    if (`$installedmodule2.name -contains 'MSOnline') {
        Write-Output "MSOnline module already installed. Connecting"
        Connect-MsolService 
    } else {
        write-output "installing MSOnline Package"
        install-packageprovider -name NuGet -MinimumVersion 2.8.5.201 -force
        Register-PSRepository -Default -InstallationPolicy Trusted -ErrorAction SilentlyContinue
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted -ErrorAction SilentlyContinue
        Install-Module MSOnline
        Connect-MsolService
    }
}
`$Global:ADConnect = "$ADFS"
installedmodule
"@

$Exchange_FQDN = "http://" + $ExchangeServer_Text.Text + "/PowerShell/"
    $exchange_module = @"
    `$Global:ExchangeServer = "$Exchange_FQDN"
    `$Global:PSSExch = (New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri `$Global:ExchangeServer)
"@
    if ($Office365.Checked -or $Exchange_Hybrid_O365.Checked) {
        Add-Content -path $filename $Install_module
    } elseif ($Exchange.Checked) {
        Add-Content -path $filename $exchange_module
    }
    $Export_LicenseNames = @"
`$Global:Sku = @{
    'AAD_BASIC'='Azure Active Directory Basic';
    'AAD_BASIC_AAD_BASIC'='Azure AD Basic - Azure Active Directory Basic';
    'AAD_BASIC_EDU'='Azure Active Directory Basic for EDU';
    'AAD_EDU'='Azure Active Directory for Education';
    'AAD_PREMIUM'='Azure Active Directory Premium P1';
    'AAD_PREMIUM_AAD_PREMIUM'='Azure AD Premium P1 - Azure AD Premium P1';
    'AAD_PREMIUM_MFA_PREMIUM'='Azure AD Premium P1 - Azure Multi-Factor Authentication';
    'AAD_PREMIUM_P2'='Azure Active Directory Premium P2';
    'AAD_PREMIUM_P2_AAD_PREMIUM'='Azure AD Premium P2 - Azure AD Premium P1';
    'AAD_PREMIUM_P2_AAD_PREMIUM_P2'='Azure AD Premium P2 - Azure AD Premium P2';
    'AAD_PREMIUM_P2_ADALLOM_S_DISCOVERY'='Azure AD Premium P2 - Cloud App Security Discovery';
    'AAD_PREMIUM_P2_MFA_PREMIUM'='Azure AD Premium P2 - Azure Multi-Factor Authentication';
    'AAD_SMB'='Azure Active Directory';
    'ADALLOM_S_DISCOVERY'='Cloud App Security Discovery';
    'ADALLOM_S_O365'='Office 365 Advanced Security Management';
    'ADALLOM_S_STANDALONE'='Microsoft Cloud App Security';
    'ADALLOM_STANDALONE'='Microsoft Cloud App Security';
    'ADV_COMMS'='Advanced Communications add-on for Microsoft Teams';
    'ATA'='Azure Advanced Threat Protection';
    'ATP_ENTERPRISE'='Office 365 Advanced Threat Protection (Plan 1)';
    'ATP_ENTERPRISE_FACULTY'='Exchange Online Advanced Threat Protection';
    'AX_ENTERPRISE_USER'='Microsoft Dynamics AX Enterprise';
    'AX_SELF-SERVE_USER'='Microsoft Dynamics AX Self-Serve';
    'AX7_USER_TRIAL'='Microsoft Dynamics AX7 User Trial';
    'BI_AZURE_P0'='Power BI (free)';
    'BI_AZURE_P1'='Microsoft Power BI Reporting And Analytics Plan 1';
    'BI_AZURE_P2'='Power BI Pro';
    'BPOS_S_TODO_1'='To-do (Plan 1)';
    'BPOS_S_TODO_2'='To-do (Plan 2)';
    'BPOS_S_TODO_3'='To-do (Plan 3)';
    'BPOS_S_TODO_FIRSTLINE'='To-do (Firstline)';
    'CCIBOTS_PRIVPREV_VIRAL'='Power Virtual Agents Viral Trial';
    'CCIBOTS_PRIVPREV_VIRAL_CCIBOTS_PRIVPREV_VIRAL'='Dynamics Bots Trial';
    'CCIBOTS_PRIVPREV_VIRAL_DYN365_CDS_CCI_BOTS'='Dynamics Bots Trial - Common Data Service';
    'CCIBOTS_PRIVPREV_VIRAL_FLOW_CCI_BOTS'='Dynamics Bots Trial - Microsoft Flow';
    'CDS_DB_CAPACITY'='CDS DB Capacity';
    'COMMUNICATIONS_COMPLIANCE'='Microsoft Communications Compliance';
    'COMMUNICATIONS_DLP'='Microsoft Communications Dlp';
    'CRM_HYBRIDCONNECTOR'='CRM Hybrid Connector';
    'CRMENTERPRISE'='Microsoft Dynamics CRM Online Enterprise';
    'CRMIUR'='CRM for Partners';
    'CRMPLAN2'='Microsoft Dynamics CRM Online Basic';
    'CRMPLAN2_CRMPLAN2'='Microsoft Dynamics CRM Online Basic';
    'CRMPLAN2_FLOW_DYN_APPS'='MS Dynamics CRM Online Basic  - Flow for Dynamics 365';
    'CRMPLAN2_POWERAPPS_DYN_APPS'='MS Dynamics CRM Online Basic  - PowerApps for Office 365';
    'CRMSTANDARD'='Microsoft Dynamics CRM Online';
    'CRMSTANDARD_CRMSTANDARD'='Microsoft Dynamics CRM Online';
    'CRMSTANDARD_FLOW_DYN_APPS'='MS Dynamics CRM Online - Flow for Dynamics 365     ';
    'CRMSTANDARD_GCC'='Microsoft Dynamics CRM Online Government Professional';
    'CRMSTANDARD_MDM_SALES_COLLABORATION'='MS Dynamics CRM Online - MS Dynamics Marketing Sales Collaboration';
    'CRMSTANDARD_NBPROFESSIONALFORCRM'='MS Dynamics CRM Online - MS Social Engagement Professional';
    'CRMSTANDARD_POWERAPPS_DYN_APPS'='MS Dynamics CRM Online - PowerApps for Office 365';
    'CRMSTORAGE'='Microsoft Dynamics CRM Storage';
    'CRMTESTINSTANCE'='Microsoft Dynamics CRM Test Instance';
    'CUSTOMER_KEY'='Microsoft Customer Key';
    'DATA_INVESTIGATIONS'='Microsoft Data Investigations';
    'DDYN365_CDS_DYN_P2'='Common Data Service';
    'Deskless'='Microsoft Staffhub';
    'DESKLESSPACK'='Office 365 F3';
    'DESKLESSPACK_BPOS_S_TODO_FIRSTLINE'='O365 F1 - To-do (Firstline)';
    'DESKLESSPACK_DESKLESS'='O365 F1 - Microsoft StaffHub';
    'DESKLESSPACK_DYN365_CDS_O365_F1'='O365 F1 - Common Data Service';
    'DESKLESSPACK_EXCHANGE_S_DESKLESS'='O365 F1 - Exchange Online Kiosk';
    'DESKLESSPACK_FLOW_O365_S1'='O365 F1 - Flow for Office 365 K1';
    'DESKLESSPACK_FORMS_PLAN_K'='O365 F1 - Microsoft Forms (Plan F1)';
    'DESKLESSPACK_GOV'='Office 365 F1 for Government';
    'DESKLESSPACK_KAIZALA_O365_P1'='O365 F1 - Microsoft Kaizala Pro';
    'DESKLESSPACK_MCOIMP'='O365 F1 - Skype for Business Online (P1)';
    'DESKLESSPACK_OFFICEMOBILE_SUBSCRIPTION'='O365 F1 - Mobile Apps for Office 365';
    'DESKLESSPACK_POWERAPPS_O365_S1'='O365 F1 - Powerapps for Office 365 K1';
    'DESKLESSPACK_PROJECTWORKMANAGEMENT'='O365 F1 - Microsoft Planner';
    'DESKLESSPACK_SHAREPOINTDESKLESS'='O365 F1 - SharePoint Online Kiosk';
    'DESKLESSPACK_SHAREPOINTWAC'='O365 F1 - Office for web';
    'DESKLESSPACK_STREAM_O365_K'='O365 F1 - Microsoft Stream for O365 K SKU';
    'DESKLESSPACK_SWAY'='O365 F1 - Sway';
    'DESKLESSPACK_TEAMS1'='O365 F1 - Microsoft Teams';
    'DESKLESSPACK_WHITEBOARD_FIRSTLINE1'='O365 F1 - Whiteboard (Firstline)';
    'DESKLESSPACK_YAMMER'='Office 365 F1 with Yammer';
    'DESKLESSPACK_YAMMER_ENTERPRISE'='O365 F1 - Yammer Enterprise';
    'DESKLESSWOFFPACK'='Office 365 Kiosk P2';
    'DESKLESSWOFFPACK_GOV'='Office 365 Kiosk P2 for Government';
    'DEVELOPERPACK'='Office 365 E3 Developer';
    'DEVELOPERPACK_EXCHANGE_S_ENTERPRISE'='O365 E3 Developer - Exchange Online (P2)';
    'DEVELOPERPACK_FLOW_O365_P2'='O365 E3 Developer - Flow for Office 365';
    'DEVELOPERPACK_FORMS_PLAN_E5'='O365 E3 Developer - Microsft Forms (Plan E5)';
    'DEVELOPERPACK_GOV'='Office 365 Developer for Government';
    'DEVELOPERPACK_MCOSTANDARD'='O365 E3 Developer - Skype for Business Online (P2)';
    'DEVELOPERPACK_OFFICESUBSCRIPTION'='O365 E3 Developer - Office 365 ProPlus';
    'DEVELOPERPACK_POWERAPPS_O365_P2'='O365 E3 Developer - PowerApps for Office 365';
    'DEVELOPERPACK_PROJECTWORKMANAGEMENT'='O365 E3 Developer - Microsoft Planner';
    'DEVELOPERPACK_SHAREPOINT_S_DEVELOPER'='O365 E3 Developer - SharePoint (P2)';
    'DEVELOPERPACK_SHAREPOINTWAC_DEVELOPER'='O365 E3 Developer - Office for web';
    'DEVELOPERPACK_STREAM_O365_E5'='O365 E3 Developer - Stream for Office 365';
    'DEVELOPERPACK_SWAY'='O365 E3 Developer - Sway';
    'DEVELOPERPACK_TEAMS1'='O365 E3 Developer - Microsoft Teams';
    'DMENTERPRISE'='Microsoft Dynamics Marketing Online Enterprise';
    'DYN365_AI_SERVICE_INSIGHTS_DYN365_AI_SERVICE_INSIGHTS'='Dynamics 365 Customer Service Insights';
    'DYN365_BUSINESS_MARKETING'='Dynamics 365 for Marketing';
    'DYN365_CDS_DYN_APPS'='Common Data Service';
    'DYN365_CDS_PROJECT'='Common Data Service for Project';
    'DYN365_CDS_VIRAL'='Common Data Service';
    'DYN365_ENTERPRISE_CUSTOMER_SERVICE'='Dynamics 365 for Customer Service Enterprise Edition';
    'DYN365_ENTERPRISE_P1'='Dynamics 365 Customer Engagement Plan';
    'DYN365_ENTERPRISE_P1_IW'='Dynamics 365 P1 Trial for Information Workers';
    'DYN365_ENTERPRISE_P1_IW_DYN365_ENTERPRISE_P1_IW'='Dynamics 365 P1 Trial for Information Workers';
    'DYN365_ENTERPRISE_PLAN1'='Dynamics 365 Customer Engagement Plan Enterprise Edition';
    'DYN365_ENTERPRISE_PLAN1_DYN365_ENTERPRISE_P1'='D365 Customer Engagement Plan Ent Edition - Dynamics 365 Customer Engagement Plan';
    'DYN365_ENTERPRISE_PLAN1_FLOW_DYN_P2'='D365 Customer Engagement Plan Ent Edition - Flow for Dynamics 365';
    'DYN365_ENTERPRISE_PLAN1_NBENTERPRISE'='D365 Customer Engagement Plan Ent Edition - MS Social Engagement - Service Discontinuation';
    'DYN365_ENTERPRISE_PLAN1_POWERAPPS_DYN_P2'='D365 Customer Engagement Plan Ent Edition - Powerapps for Dynamics 365';
    'DYN365_ENTERPRISE_PLAN1_PROJECT_CLIENT_SUBSCRIPTION'='D365 Customer Engagement Plan Ent Edition - Project Online Desktop Client';
    'DYN365_ENTERPRISE_PLAN1_SHAREPOINT_PROJECT'='D365 Customer Engagement Plan Ent Edition - Project Online Service';
    'DYN365_ENTERPRISE_PLAN1_SHAREPOINTENTERPRISE'='D365 Customer Engagement Plan Ent Edition - SharePoint (P2)';
    'DYN365_ENTERPRISE_PLAN1_SHAREPOINTWAC'='D365 Customer Engagement Plan Ent Edition - Office for web';
    'DYN365_ENTERPRISE_SALES'='Dynamics 365 for Sales Enterprise Edition';
    'DYN365_ENTERPRISE_SALES_CUSTOMERSERVICE'='Dynamics 365 for Sales And Customer Service Enterprise Edition';
    'DYN365_ENTERPRISE_SALES_DYN365_ENTERPRISE_SALES'='D365 for Sales Enterprise Edition - Dynamics 365 for Sales Enterprise Edition';
    'DYN365_ENTERPRISE_SALES_FLOW_DYN_APPS'='D365 for Sales Enterprise Edition - Flow for Dynamics 365';
    'DYN365_ENTERPRISE_SALES_NBENTERPRISE'='D365 for Sales Enterprise Edition - MS Social Engagement - Service Discontinuation';
    'DYN365_ENTERPRISE_SALES_POWERAPPS_DYN_APPS'='D365 for Sales Enterprise Edition - PowerApps for Office 365';
    'DYN365_ENTERPRISE_SALES_PROJECT_ESSENTIALS'='D365 for Sales Enterprise Edition - Project Online Essential';
    'DYN365_ENTERPRISE_SALES_SHAREPOINTENTERPRISE'='D365 for Sales Enterprise Edition - SharePoint (P2)';
    'DYN365_ENTERPRISE_SALES_SHAREPOINTWAC'='D365 for Sales Enterprise Edition - Office for web';
    'DYN365_Enterprise_Talent_Attract_TeamMember'='Dynamics 365 for Talent - Attract Experience Team Member';
    'DYN365_Enterprise_Talent_Onboard_TeamMember'='Dynamics 365 for Talent - Onboard Experience';
    'DYN365_ENTERPRISE_TEAM_MEMBERS'='Dynamics 365 for Team Members Enterprise Edition';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_DYN365_ENTERPRISE_TALENT_ATTRACT_TEAMMEMBER'='D365 for Team Members Ent Edition - D365 for Talent - Attract Experience Team Member';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_DYN365_ENTERPRISE_TALENT_ONBOARD_TEAMMEMBER'='D365 for Team Members Ent Edition - D365 for Talent - Onboard Experience';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_DYN365_ENTERPRISE_TEAM_MEMBERS'='Dynamics 365 for Team Members Enterprise Edition';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_DYNAMICS_365_FOR_OPERATIONS_TEAM_MEMBERS'='D365 for Team Members Ent Edition - Dynamics 365 for Operations Member';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_DYNAMICS_365_FOR_RETAIL_TEAM_MEMBERS'='D365 for Team Members Ent Edition - Dynamics 365 for Retail Member';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_DYNAMICS_365_FOR_TALENT_TEAM_MEMBERS'='D365 for Team Members Ent Edition - Dynamics 365 for Talent Member';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_FLOW_DYN_TEAM'='D365 for Team Members Ent Edition - Flow for Office 365';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_POWERAPPS_DYN_TEAM'='D365 for Team Members Ent Edition - PowerApps for Office 365';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_PROJECT_ESSENTIALS'='D365 for Team Members Ent Edition - Project Online Essential';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_SHAREPOINTENTERPRISE'='D365 for Team Members Ent Edition - SharePoint (P2)';
    'DYN365_ENTERPRISE_TEAM_MEMBERS_SHAREPOINTWAC'='D365 for Team Members Ent Edition - Office for web';
    'DYN365_FINANCE'='Dynamics 365 Finance';
    'DYN365_FINANCIALS_BUSINESS'='Dynamics 365 for Financials';
    'DYN365_FINANCIALS_BUSINESS_SKU'='Dynamics 365 for Financials Business Edition';
    'DYN365_FINANCIALS_BUSINESS_SKU_DYN365_FINANCIALS_BUSINESS'='Dynamics 365 for Financials Business Edition';
    'DYN365_FINANCIALS_BUSINESS_SKU_FLOW_DYN_APPS'='D365 for Financials Business Edition - Flow for Dynamics 365';
    'DYN365_FINANCIALS_BUSINESS_SKU_POWERAPPS_DYN_APPS'='D365 for Financials Business Edition - PowerApps for Office 365';
    'DYN365_FINANCIALS_TEAM_MEMBERS_SKU'='Dynamics 365 for Team Members Business Edition';
    'DYN365_RETAIL_TRIAL'='Dynamics 365 for Retail Trial';
    'DYN365_SCM'='Dynamics 365 for Supply Chain Management';
    'DYN365_SCM_ATTACH'='Dynamics 365 Supply Chain Management Attach to Qualifying Dynamics 365 Base Offer';
    'DYN365_TALENT_ENTERPRISE'='Dynamics 365 for Talent';
    'DYN365_TEAM_MEMBERS'='Dynamics 365 Team Members';
    'Dyn365_Operations_Activity'='Dyn365 für Operations Activity Enterprise Edition';
    'Dynamics_365_for_Operations'='Dynamics 365 Unf Ops Plan Ent Edition';
    'Dynamics_365_for_Retail'='Dynamics 365 for Retail';
    'Dynamics_365_for_Retail_Team_members'='Dynamics 365 for Retail Team Members';
    'Dynamics_365_for_Talent_Team_members'='Dynamics 365 for Talent Team Members';
    'Dynamics_365_Onboarding_Free_PLAN'='Dynamics 365 for Talent: Onboard';
    'Dynamics_365_Onboarding_SKU'='Dynamics 365 for Talent: Onboard';
    'DYNAMICS_365_ONBOARDING_SKU_DYN365_CDS_DYN_APPS'='Dynamics 365 for Talent: Onboard - Common Data Service';
    'DYNAMICS_365_ONBOARDING_SKU_DYNAMICS_365_ONBOARDING_FREE_PLAN'='Dynamics 365 for Talent: Onboard';
    'DYNAMICS_365_ONBOARDING_SKU_DYNAMICS_365_TALENT_ONBOARD'='Dynamics 365 for Talent: Onboard - Dynamics 365 for Talent: Onboard';
    'Dynamics_365_for_Operations_Sandbox_Tier2_SKU'='Dynamics 365 Operations – Sandbox Tier 2:Standard Acceptance Testing';
    'ECAL_SERVICES'='ECAL Services (EOA, EOP, DLP)';
    'EducationAnalyticsP1'='Education Analytics';
    'EDUPACK_FACULTY'='Office 365 Education E3 for Faculty';
    'EDUPACK_STUDENT'='Office 365 Education for Students';
    'EMS'='Enterprise Mobility + Security E3';
    'EMS_AAD_PREMIUM'='Ent Mobility + Security E3 - Azure AD Premium P1';
    'EMS_ADALLOM_S_DISCOVERY'='Ent Mobility + Security E3 - Cloud App Security Discovery';
    'EMS_EDU_STUUSBNFT'='Enterprise Mobility + Security A3';
    'EMS_INTUNE_A'='Ent Mobility + Security E3 - Microsoft Intune';
    'EMS_MFA_PREMIUM'='Ent Mobility + Security E3 - Azure Multi-Factor Authentication';
    'EMS_RMS_S_ENTERPRISE'='Ent Mobility + Security E3 - Azure Rights Management';
    'EMS_RMS_S_PREMIUM'='Ent Mobility + Security E3 - Azure Information Protection P1';
    'EMSPREMIUM'='Enterprise Mobility + Security E5';
    'EMSPREMIUM_AAD_PREMIUM'='Ent Mobility + Security E5 - Azure AD Premium P1';
    'EMSPREMIUM_AAD_PREMIUM_P2'='Ent Mobility + Security E5 - Azure AD Premium P2';
    'EMSPREMIUM_ADALLOM_S_STANDALONE'='Ent Mobility + Security E5 - Microsoft Cloud App Security';
    'EMSPREMIUM_ATA'='Ent Mobility + Security E5 - Azure Advanced Threat Protection';
    'EMSPREMIUM_INTUNE_A'='Ent Mobility + Security E5 - Microsoft Intune';
    'EMSPREMIUM_MFA_PREMIUM'='Ent Mobility + Security E5 - Azure Multi-Factor Authentication';
    'EMSPREMIUM_RMS_S_ENTERPRISE'='Ent Mobility + Security E5 - Azure Rights Management';
    'EMSPREMIUM_RMS_S_PREMIUM'='Ent Mobility + Security E5 - Azure Information Protection P1';
    'EMSPREMIUM_RMS_S_PREMIUM2'='Ent Mobility + Security E5 - Azure Information Protection P2';
    'ENTERPRISEPACK'='Office 365 E3';
    'ENTERPRISEPACK_BPOS_S_TODO_2'='O365 E3 - To-do (P2)';
    'ENTERPRISEPACK_DESKLESS'='O365 E3 - Microsoft StaffHub';
    'ENTERPRISEPACK_EXCHANGE_S_ENTERPRISE'='O365 E3 - Exchange Online (P2)';
    'ENTERPRISEPACK_FACULTY'='Office 365 Education E3 for Faculty';
    'ENTERPRISEPACK_FLOW_O365_P2'='O365 E3 - Flow for Office 365';
    'ENTERPRISEPACK_FORMS_PLAN_E3'='O365 E3 - Microsft Forms (Plan E3)';
    'ENTERPRISEPACK_GOV'='Office 365 Enterprise E3 for Government';
    'ENTERPRISEPACK_KAIZALA_O365_P3'='O365 E3 - Microsoft Kaizala Pro';
    'ENTERPRISEPACK_MCOSTANDARD'='O365 E3 - Skype for Business Online (P2)';
    'ENTERPRISEPACK_MIP_S_CLP1'='O365 E3 - Information Protection for Office 365 - Standard';
    'ENTERPRISEPACK_MYANALYTICS_P2'='O365 E3 - Insights by MyAnalytics';
    'ENTERPRISEPACK_OFFICESUBSCRIPTION'='O365 E3 - Office 365 ProPlus';
    'ENTERPRISEPACK_POWERAPPS_O365_P2'='O365 E3 - PowerApps for Office 365';
    'ENTERPRISEPACK_PROJECTWORKMANAGEMENT'='O365 E3 - Microsoft Planner';
    'ENTERPRISEPACK_RMS_S_ENTERPRISE'='O365 E3 - Azure Rights Management';
    'ENTERPRISEPACK_SHAREPOINTENTERPRISE'='O365 E3 - SharePoint (P2)';
    'ENTERPRISEPACK_SHAREPOINTWAC'='O365 E3 - Office for web';
    'ENTERPRISEPACK_STREAM_O365_E3'='O365 E3 - Stream for Office 365';
    'ENTERPRISEPACK_STUDENT'='Office 365 Education E3 for Students';
    'ENTERPRISEPACK_SWAY'='O365 E3 - Sway';
    'ENTERPRISEPACK_TEAMS1'='O365 E3 - Microsoft Teams';
    'ENTERPRISEPACK_USGOV_DOD '='Office 365 E3 US GOV DoD';
    'ENTERPRISEPACK_USGOV_GCCHIGH '='Office 365 E3 US GOV GCC High';
    'ENTERPRISEPACK_WHITEBOARD_PLAN2'='O365 E3 - Whiteboard (P2)';
    'ENTERPRISEPACK_YAMMER_ENTERPRISE'='O365 E3 - Yammer Enterprise';
    'ENTERPRISEPACKLRG'='Office 365 (Plan E3)';
    'ENTERPRISEPACKPLUS_FACULTY'='Office 365 A3 for faculty';
    'ENTERPRISEPACKWITHOUTPROPLUS'='Office 365 Enterprise E3 without ProPlus Add-on';
    'ENTERPRISEPACKWSCAL'='Office 365 Enterprise E4';
    'ENTERPRISEPREMIUM'='Office 365 E5';
    'ENTERPRISEPREMIUM_ADALLOM_S_O365'='O365 E5 - Office 365 Advanced Security Management';
    'ENTERPRISEPREMIUM_ATP_ENTERPRISE'='O365 E5 - Office 365 Advanced Threat Protection (P1)';
    'ENTERPRISEPREMIUM_BI_AZURE_P2'='O365 E5 - Power BI Pro';
    'ENTERPRISEPREMIUM_BPOS_S_TODO_3'='O365 E5 - To-do (P3)';
    'ENTERPRISEPREMIUM_COMMUNICATIONS_COMPLIANCE'='O365 E5 - Microsoft Communications Compliance';
    'ENTERPRISEPREMIUM_COMMUNICATIONS_DLP'='O365 E5 - Microsoft Communications Dlp';
    'ENTERPRISEPREMIUM_CUSTOMER_KEY'='O365 E5 - Microsoft Customer Key';
    'ENTERPRISEPREMIUM_DATA_INVESTIGATIONS'='O365 E5 - Microsoft Data Investigations';
    'ENTERPRISEPREMIUM_DESKLESS'='O365 E5 - Microsoft StaffHub';
    'ENTERPRISEPREMIUM_DYN365_CDS_O365_P3'='O365 E5 - Common Data Service';
    'ENTERPRISEPREMIUM_EQUIVIO_ANALYTICS'='O365 E5 - Office 365 Advanced eDiscovery';
    'ENTERPRISEPREMIUM_EXCHANGE_ANALYTICS'='O365 E5 - Delve Analytics';
    'ENTERPRISEPREMIUM_EXCHANGE_S_ENTERPRISE'='O365 E5 - Exchange Online (P2)';
    'ENTERPRISEPREMIUM_FACULTY'='Office 365 A5 for Faculty';
    'ENTERPRISEPREMIUM_FLOW_O365_P3'='O365 E5 - Flow for Office 365';
    'ENTERPRISEPREMIUM_FORMS_PLAN_E5'='O365 E5 - Microsoft Forms (Plan E5)';
    'ENTERPRISEPREMIUM_INFO_GOVERNANCE'='O365 E5 - Microsoft Information Governance';
    'ENTERPRISEPREMIUM_INFORMATION_BARRIERS'='O365 E5 - Information Barriers';
    'ENTERPRISEPREMIUM_INTUNE_O365'='O365 E5 - Microsoft Intune';
    'ENTERPRISEPREMIUM_KAIZALA_STANDALONE'='O365 E5 - Microsoft Kaizala Pro';
    'ENTERPRISEPREMIUM_LOCKBOX_ENTERPRISE'='O365 E5 - Customer Lockbox';
    'ENTERPRISEPREMIUM_M365_ADVANCED_AUDITING'='O365 E5 - Microsoft 365 Advanced Auditing';
    'ENTERPRISEPREMIUM_MCOEV'='O365 E5 - Microsoft Phone System';
    'ENTERPRISEPREMIUM_MCOMEETADV'='O365 E5 - Audio Conferencing';
    'ENTERPRISEPREMIUM_MCOSTANDARD'='O365 E5 - Skype for Business Online (P2)';
    'ENTERPRISEPREMIUM_MICROSOFTBOOKINGS'='O365 E5 - Microsoft Bookings';
    'ENTERPRISEPREMIUM_MIP_S_CLP1'='O365 E5 - Information Protection for Office 365 - Standard';
    'ENTERPRISEPREMIUM_MIP_S_CLP2'='O365 E5 - Information Protection for Office 365 - Premium';
    'ENTERPRISEPREMIUM_MTP'='O365 E5 - Microsoft Threat Protection';
    'ENTERPRISEPREMIUM_MYANALYTICS_P2'='O365 E5 - Insights by MyAnalytics';
    'ENTERPRISEPREMIUM_NOPSTNCONF'='Office 365 E5 Without Audio Conferencing';
    'ENTERPRISEPREMIUM_NOPSTNCONF_ADALLOM_S_O365'='O365 E5 Without Audio Conferencing - Office 365 Advanced Security Management';
    'ENTERPRISEPREMIUM_NOPSTNCONF_BI_AZURE_P2'='O365 E5 Without Audio Conferencing - Power BI Pro';
    'ENTERPRISEPREMIUM_NOPSTNCONF_DESKLESS'='O365 E5 Without Audio Conferencing - Microsoft StaffHub';
    'ENTERPRISEPREMIUM_NOPSTNCONF_EQUIVIO_ANALYTICS'='O365 E5 Without Audio Conferencing - Office 365 Advanced eDiscovery';
    'ENTERPRISEPREMIUM_NOPSTNCONF_EXCHANGE_ANALYTICS'='O365 E5 Without Audio Conferencing - Delve Analytics';
    'ENTERPRISEPREMIUM_NOPSTNCONF_EXCHANGE_S_ENTERPRISE'='O365 E5 Without Audio Conferencing - Exchange Online (P2)';
    'ENTERPRISEPREMIUM_NOPSTNCONF_FLOW_O365_P3'='O365 E5 Without Audio Conferencing - Flow for Office 365';
    'ENTERPRISEPREMIUM_NOPSTNCONF_FORMS_PLAN_E5'='O365 E5 Without Audio Conferencing - Microsft Forms (Plan E5)';
    'ENTERPRISEPREMIUM_NOPSTNCONF_LOCKBOX_ENTERPRISE'='O365 E5 Without Audio Conferencing - Customer Lockbox';
    'ENTERPRISEPREMIUM_NOPSTNCONF_MCOEV'='O365 E5 Without Audio Conferencing - Microsoft Phone System';
    'ENTERPRISEPREMIUM_NOPSTNCONF_MCOSTANDARD'='O365 E5 Without Audio Conferencing - Skype for Business Online (P2)';
    'ENTERPRISEPREMIUM_NOPSTNCONF_OFFICESUBSCRIPTION'='O365 E5 Without Audio Conferencing - Office 365 ProPlus';
    'ENTERPRISEPREMIUM_NOPSTNCONF_POWERAPPS_O365_P3'='O365 E5 Without Audio Conferencing - PowerApps for Office 365';
    'ENTERPRISEPREMIUM_NOPSTNCONF_PROJECTWORKMANAGEMENT'='O365 E5 Without Audio Conferencing - Microsoft Planner';
    'ENTERPRISEPREMIUM_NOPSTNCONF_RMS_S_ENTERPRISE'='O365 E5 Without Audio Conferencing - Azure Rights Management';
    'ENTERPRISEPREMIUM_NOPSTNCONF_SHAREPOINTENTERPRISE'='O365 E5 Without Audio Conferencing - SharePoint (P2)';
    'ENTERPRISEPREMIUM_NOPSTNCONF_SHAREPOINTWAC'='O365 E5 Without Audio Conferencing - Office for web';
    'ENTERPRISEPREMIUM_NOPSTNCONF_STREAM_O365_E5'='O365 E5 Without Audio Conferencing - Stream for Office 365';
    'ENTERPRISEPREMIUM_NOPSTNCONF_SWAY'='O365 E5 Without Audio Conferencing - Sway';
    'ENTERPRISEPREMIUM_NOPSTNCONF_TEAMS1'='O365 E5 Without Audio Conferencing - Microsoft Teams';
    'ENTERPRISEPREMIUM_NOPSTNCONF_THREAT_INTELLIGENCE'='O365 E5 Without Audio Conferencing - Office 365 Threat Intelligence';
    'ENTERPRISEPREMIUM_NOPSTNCONF_YAMMER_ENTERPRISE'='O365 E5 Without Audio Conferencing - Yammer Enterprise';
    'ENTERPRISEPREMIUM_OFFICESUBSCRIPTION'='O365 E5 - Office 365 ProPlus';
    'ENTERPRISEPREMIUM_PAM_ENTERPRISE'='O365 E5 - Office 365 Privileged Access Management';
    'ENTERPRISEPREMIUM_POWERAPPS_O365_P3'='O365 E5 - PowerApps for Office 365';
    'ENTERPRISEPREMIUM_PREMIUM_ENCRYPTION'='O365 E5 - Premium Encryption in Office 365';
    'ENTERPRISEPREMIUM_PROJECTWORKMANAGEMENT'='O365 E5 - Microsoft Planner';
    'ENTERPRISEPREMIUM_RECORDS_MANAGEMENT'='O365 E5 - Microsoft Records Management';
    'ENTERPRISEPREMIUM_RMS_S_ENTERPRISE'='O365 E5 - Azure Rights Management';
    'ENTERPRISEPREMIUM_SHAREPOINTWAC'='O365 E5 - SharePoint (P2)';
    'ENTERPRISEPREMIUM_STREAM_O365_E5'='O365 E5 - Stream for Office 365';
    'ENTERPRISEPREMIUM_STUDENT'='Office 365 A5 for Students';
    'ENTERPRISEPREMIUM_SWAY'='O365 E5 - Sway';
    'ENTERPRISEPREMIUM_TEAMS1'='O365 E5 - Microsoft Teams';
    'ENTERPRISEPREMIUM_THREAT_INTELLIGENCE'='O365 E5 - Office 365 Threat Intelligence';
    'ENTERPRISEPREMIUM_WHITEBOARD_PLAN3'='O365 E5 - Whiteboard (P3)';
    'ENTERPRISEPREMIUM_YAMMER_ENTERPRISE'='O365 E5 - Yammer Enterprise';
    'ENTERPRISEWITHSCAL'='Office 365 E4';
    'ENTERPRISEWITHSCAL '='Office 365 Enterprise E4';
    'ENTERPRISEWITHSCAL_DESKLESS'='O365 E4 - Microsoft StaffHub';
    'ENTERPRISEWITHSCAL_EXCHANGE_S_ENTERPRISE'='O365 E4 - Exchange Online (P2)';
    'ENTERPRISEWITHSCAL_FACULTY'='Office 365 Education E4 for Faculty';
    'ENTERPRISEWITHSCAL_FLOW_O365_P2'='O365 E4 - Flow for Office 365';
    'ENTERPRISEWITHSCAL_FORMS_PLAN_E3'='O365 E4 - Microsft Forms (Plan E3)';
    'ENTERPRISEWITHSCAL_GOV'='Office 365 Enterprise E4 for Government';
    'ENTERPRISEWITHSCAL_MCOSTANDARD'='O365 E4 - Skype for Business Online (P2)';
    'ENTERPRISEWITHSCAL_MCOVOICECONF'='O365 E4 - Audio Conferencing';
    'ENTERPRISEWITHSCAL_OFFICESUBSCRIPTION'='O365 E4 - Office 365 ProPlus';
    'ENTERPRISEWITHSCAL_POWERAPPS_O365_P2'='O365 E4 - PowerApps for Office 365';
    'ENTERPRISEWITHSCAL_PROJECTWORKMANAGEMENT'='O365 E4 - Microsoft Planner';
    'ENTERPRISEWITHSCAL_RMS_S_ENTERPRISE'='O365 E4 - Azure Rights Management';
    'ENTERPRISEWITHSCAL_SHAREPOINTENTERPRISE'='O365 E4 - SharePoint (P2)';
    'ENTERPRISEWITHSCAL_SHAREPOINTWAC'='O365 E4 - Office for web';
    'ENTERPRISEWITHSCAL_STREAM_O365_E3'='O365 E4 - Stream for Office 365';
    'ENTERPRISEWITHSCAL_STUDENT'='Office 365 Education E4 for Students';
    'ENTERPRISEWITHSCAL_SWAY'='O365 E4 - Sway';
    'ENTERPRISEWITHSCAL_TEAMS1'='O365 E4 - Microsoft Teams';
    'ENTERPRISEWITHSCAL_YAMMER_ENTERPRISE'='O365 E4 - Yammer Enterprise';
    'EOP_ENTERPRISE'='Exchange Online Protection';
    'EOP_ENTERPRISE_FACULTY'='Exchange Online Protection for Faculty';
    'EOP_ENTERPRISE_GOV'='Exchange Protection for Government';
    'EOP_ENTERPRISE_PREMIUM'='Exchange Enterprise CAL Services (EOP, DLP)';
    'EOP_ENTERPRISE_STUDENT'='Exchange Protection for Student';
    'EQUIVIO_ANALYTICS'='Office 365 Advanced Compliance';
    'EQUIVIO_ANALYTICS_FACULTY'='Office 365 Advanced Compliance for Faculty';
    'EXCHANGE_ANALYTICS'='Microsoft Myanalytics (full)';
    'EXCHANGE_B_STANDARD'='Exchange Online Pop';
    'EXCHANGE_L_STANDARD'='Exchange Online (P1)';
    'EXCHANGE_ONLINE_WITH_ONEDRIVE_LITE'='Exchange with OneDrive for Business';
    'EXCHANGE_S_ARCHIVE'='Exchange Online Archiving for Exchange Server';
    'EXCHANGE_S_ARCHIVE_ADDON'='Exchange Online Archiving for Exchange Online';
    'EXCHANGE_S_ARCHIVE_ADDON_GOV'='Exchange Online Archiving';
    'EXCHANGE_S_DESKLESS'='Exchange Online Kiosk';
    'EXCHANGE_S_DESKLESS_GOV'='Exchange Online Kiosk for Government';
    'EXCHANGE_S_ENTERPRISE'='Exchange Online (Plan 2)';
    'EXCHANGE_S_ENTERPRISE_GOV'='Exchange Online P2 for Government';
    'EXCHANGE_S_ESSENTIALS'='Exchange Online Essentials';
    'EXCHANGE_S_ESSENTIALS_EXCHANGE_S_ESSENTIALS'='Exchange Online Essentials';
    'EXCHANGE_S_FOUNDATION'='Exchange Foundation';
    'EXCHANGE_S_STANDARD'='Exchange Online (Plan 1)';
    'EXCHANGE_S_STANDARD_MIDMARKET'='Exchange Online Plan 1';
    'EXCHANGE_STANDARD_ALUMNI'='Exchange Online (Plan 1) for alumni';
    'EXCHANGEARCHIVE'='Exchange Online Archiving for Exchange Server';
    'EXCHANGEARCHIVE_ADDON'='Exchange Online Archiving for Exchange Online';
    'EXCHANGEARCHIVE_ADDON_EXCHANGE_S_ARCHIVE_ADDON'='Exchange Online Archiving for Exchange Online';
    'EXCHANGEARCHIVE_EXCHANGE_S_ARCHIVE'='Exchange Online Archiving for Exchange Server';
    'EXCHANGEARCHIVE_FACULTY'='Exchange Archiving for Faculty';
    'EXCHANGEARCHIVE_GOV'='Exchange Archiving for Government';
    'EXCHANGEARCHIVE_STUDENT'='Exchange Archiving for Students';
    'EXCHANGEDESKLESS'='Exchange Online Kiosk';
    'EXCHANGEDESKLESS '='Exchange Online Kiosk';
    'EXCHANGEDESKLESS_EXCHANGE_S_DESKLESS'='Exchange Online Kiosk';
    'EXCHANGEDESKLESS_GOV'='Exchange Kiosk for Government';
    'EXCHANGEENTERPRISE'='Exchange Online (Plan 2)';
    'EXCHANGEENTERPRISE '='Exchange Online Plan 2';
    'EXCHANGEENTERPRISE_BPOS_S_TODO_1'='Exchange Online (P2) - To-do (P1)';
    'EXCHANGEENTERPRISE_EXCHANGE_S_ENTERPRISE'='Exchange Online (P2) - Exchange Online (P2)';
    'EXCHANGEENTERPRISE_FACULTY'='Exchange Online (Plan 2) for Faculty';
    'EXCHANGEENTERPRISE_GOV'='Exchange Online Plan 2 for Government';
    'EXCHANGEENTERPRISE_STUDENT'='Exchange Online (Plan 2) for Student';
    'EXCHANGEESSENTIALS'='Exchange Online Essentials';
    'EXCHANGEESSENTIALS_EXCHANGE_S_STANDARD'='Exchange Online Essentials';
    'EXCHANGESTANDARD'='Exchange Online (Plan 1)';
    'EXCHANGESTANDARD_EXCHANGE_S_STANDARD'='Exchange Online (Plan 1)';
    'EXCHANGESTANDARD_FACULTY'='Exchange (Plan 1 for Faculty)';
    'EXCHANGESTANDARD_GOV'='Exchange Online P1 for Government';
    'EXCHANGESTANDARD_STUDENT'='Exchange Online P1 for Students';
    'EXCHANGETELCO'='Exchange Online Pop';
    'FLOW_DYN_APPS'='Flow for Dynamics 365';
    'FLOW_DYN_P2'='Flow for Dynamics 365';
    'FLOW_DYN_TEAM'='Flow for Dynamics 365';
    'FLOW_FOR_PROJECT'='Flow for Project Online';
    'FLOW_FREE'='Microsoft Power Automate Free';
    'FLOW_FREE_DYN365_CDS_VIRAL'='Flow Free - Common Data Service';
    'FLOW_FREE_FLOW_P2_VIRAL'=' Flow Free - Flow Free';
    'FLOW_O365_P1'='Flow for Office 365';
    'FLOW_O365_P2'='Flow for Office 365';
    'FLOW_O365_P3'='Flow for Office 365';
    'FLOW_O365_S1'='Flow for Office 365 K1';
    'FLOW_P1'='Microsoft Flow Plan 1';
    'FLOW_P2'='Microsoft Flow Plan 2';
    'FLOW_P2_DYN365_CDS_P2'=' Microsoft Flow Plan 2 - Common Data Service';
    'FLOW_P2_FLOW_P2'='Microsoft Flow Plan 2';
    'FLOW_P2_VIRAL'='Flow Free';
    'FLOW_P2_VIRAL_REAL'='Flow P2 Viral';
    'FLOW_PER_USER'='Power Automate per user plan';
    'FORMS_PLAN_E1'='Microsoft Forms (Plan E1)';
    'FORMS_PLAN_E3'='Microsoft Forms (Plan E3)';
    'FORMS_PLAN_E5'='Microsoft Forms (Plan E5)';
    'FORMS_PLAN_K'='Microsoft Forms (Plan F1)';
    'FORMS_PRO'='Forms Pro Trial';
    'FORMS_PRO_DYN365_CDS_FORMS_PRO'='Forms Pro Trial - Common Data Service';
    'FORMS_PRO_FLOW_FORMS_PRO'='Forms Pro Trial- Microsoft Flow';
    'FORMS_PRO_FORMS_PLAN_E5'='Forms Pro Trial - Microsoft Forms (Plan E5)';
    'FORMS_PRO_FORMS_PRO'='Forms Pro Trial';
    'Forms_Pro_USL'='Microsoft Forms Pro (USL)';
    'GLOBAL_SERVICE_MONITOR'='Global Service Monitor Online Service';
    'GUIDES_USER_DYN365_CDS_GUIDES'='User Guides - Common Data Service';
    'GUIDES_USER_GUIDES'='User Guides';
    'GUIDES_USER_POWERAPPS_GUIDES'='User Guides - PowerApps';
    'IDENTITY_THREAT_PROTECTION'='Microsoft 365 E5 Security';
    'IDENTITY_THREAT_PROTECTION_FOR_EMS_E5'='Microsoft 365 E5 Security for EMS E5';
    'INFO_GOVERNANCE'='Microsoft Information Governance';
    'INFOPROTECTION_P2'='Azure Information Protection Premium P2';
    'INFORMATION_BARRIERS'='Information Barriers';
    'INFORMATION_PROTECTION_COMPLIANCE'='Microsoft 365 E5 Compliance';
    'INTUNE_A'='Intune';
    'INTUNE_A_D'='Microsoft Intune Device';
    'INTUNE_A_INTUNE_A'='Microsoft Intune';
    'INTUNE_A_VL'='Intune VL';
    'INTUNE_A_VL_INTUNE_A_VL'='Microsoft Intune VL';
    'INTUNE_EDU'='Intune for Education';
    'INTUNE_O365'='Mobile Device Management for Office 365';
    'INTUNE_O365_STANDALONE'='Mobile Device Management for Office 365';
    'INTUNE_SMB' = 'Microsoft Intune SMB';
    'INTUNE_SMBIZ'='Microsoft Intune SMBIZ';
    'IT_ACADEMY_AD'='Ms Imagine Academy';
    'IT_ACADEMY_AD_IT_ACADEMY_AD'='Ms Imagine Academy';
    'IWs PROJECT_MADEIRA_PREVIEW_IW_SKU'='Dynamics 365 Business Central for';
    'KAIZALA_O365_P1'='Microsoft Kaizala Pro Plan 1';
    'KAIZALA_O365_P3'='Microsoft Kaizala Pro Plan 3';
    'KAIZALA_STANDALONE'='Microsoft Kaizala';
    'KAIZALA_STUDENT'='Microsoft Kaizala Pro for students';
    'LITEPACK'='Office 365 Small Business';
    'LITEPACK_EXCHANGE_L_STANDARD'='O365 Small Business - Exchange Online (P1)';
    'LITEPACK_MCOLITE'='O365 Small Business - Skype for Business Online (P1)';
    'LITEPACK_P2'='Office 365 Small Business Premium';
    'LITEPACK_P2_EXCHANGE_L_STANDARD'='Office 365 Small Business Premium - Exchange Online (P1)';
    'LITEPACK_P3_MCOLITE'='Office 365 Small Business Premium - Skype for Business Online (P1)';
    'LITEPACK_P4_OFFICE_PRO_PLUS_SUBSCRIPTION_SMBIZ'='Office 365 Small Business Premium - Office 365 ProPlus';
    'LITEPACK_P5_SHAREPOINTLITE'='Office 365 Small Business Premium - Sharepointlite';
    'LITEPACK_P6_SWAY'='Office 365 Small Business Premium - Sway';
    'LITEPACK_SHAREPOINTLITE'='O365 Small Business - Sharepointlite';
    'LITEPACK_SWAY'='O365 Small Business - Sway';
    'LOCKBOX'='Customer Lockbox';
    'LOCKBOX_ENTERPRISE'='Customer Lockbox';
    'M365EDU_A3_STUUSEBNFT'='Microsoft 365 A3 for students use benefit';
    'M365EDU_A5_NOPSTNCONF_FACULTY'='Microsoft 365 A5 without Audio Conferencing for faculty';
    'M365_ADVANCED_AUDITING'='Microsoft 365 Advanced Auditing';
    'M365_E5_SUITE_COMPONENTS' = 'Microsoft 365 E5 Suite features';
    'M365_F1'='Microsoft 365 F1';
    'M365_F1_AAD_PREMIUM'='M365 F1 - Azure AD Premium P1';
    'M365_F1_ADALLOM_S_DISCOVERY'='M365 F1 - Cloud App Security Discovery';
    'M365_F1_DYN365_CDS_O365_F1'='M365 F1 - Common Data Service';
    'M365_F1_EXCHANGE_S_DESKLESS'='M365 F1 - Exchange Online Kiosk';
    'M365_F1_INTUNE_A'='M365 F1 - Microsoft Intune';
    'M365_F1_MCOIMP'='M365 F1 - Skype for Business Online (P1)';
    'M365_F1_MFA_PREMIUM'='M365 F1 - Azure Multi-factor Authentication';
    'M365_F1_PROJECTWORKMANAGEMENT'='M365 F1 - Microsoft Planner';
    'M365_F1_RMS_S_ENTERPRISE_GOV'='M365 F1 - Azure Rights Management';
    'M365_F1_RMS_S_PREMIUM'='M365 F1 - Azure Information Protection P1';
    'M365_F1_SHAREPOINTDESKLESS'='M365 F1 - Sharepoint Online Kiosk';
    'M365_F1_STREAM_O365_K'='M365 F1 - Microsoft Stream for O365 K SKU';
    'M365_F1_TEAMS1'='M365 F1 - Microsoft Teams';
    'M365_F1_YAMMER_ENTERPRISE'='M365 F1 - Yammer Enterprise';
    'M365_G3_GOV' = 'Microsoft 365 G3 GCC';
    'M365_SECURITY_COMPLIANCE_FOR_FLW' = 'Microsoft 365 Security and Compliance for FLW';
    'M365EDU_A1'='Microsoft 365 A1';
    'M365EDU_A3_FACULTY'='Microsoft 365 A3 for Faculty';
    'M365EDU_A3_STUDENT'='Microsoft 365 A3 for Students';
    'M365EDU_A5_FACULTY'='Microsoft 365 A5 for Faculty';
    'M365EDU_A5_STUDENT'='Microsoft 365 A5 for Students';
    'MCOCAP' = 'Common Area Phone';
    'MCO_TEAMS_IW'='Microsoft Teams (Conferencing)';
    'MCOCAP_MCOEV'='Common Area Phone - Microsoft Phone System';
    'MCOCAP_MCOSTANDARD'='Common Area Phone - Skype for Business Online (P2)';
    'MCOCAP_TEAMS1'='Common Area Phone - Microsoft Teams';
    'MCOEV'='Skype for Business Cloud Pbx';
    'MCOEV_DOD'='Microsoft 365 Phone System for DoD';
    'MCOEV_FACULTY'='Microsoft 365 Phone System for Faculty';
    'MCOEV_GCCHIGH'='Microsoft Phone System';
    'MCOEV_GOV'='Microsoft 365 Phone System for GCC';
    'MCOEV_MCOEV'='Microsoft Phone System';
    'MCOEV_STUDENT'='Microsoft 365 Phone System for Students';
    'MCOEV_TELSTRA'='Microsoft 365 Phone System for TELSTRA';
    'MCOEV_USGOV_DOD'='Microsoft 365 Phone System for US GOV DoD';
    'MCOEV_USGOV_GCCHIGH'='Microsoft 365 Phone System for  US GOV GCC High';
    'MCOEVSMB_1'='Microsoft 365 Phone System for Small and Medium Business ';
    'MCOIMP'='Skype for Business Online (Plan 1)';
    'MCOIMP_FACULTY'='Lync (Plan 1 for Faculty)';
    'MCOIMP_GOV'='Lync for Government (Plan 1G)';
    'MCOIMP_MCOIMP'='Skype for Business Online (Plan 1)';
    'MCOIMP_STUDENT'='Lync (Plan 1 for Students)';
    'MCOINTERNAL'='Lync Internal Incubation and Corp to Cloud';
    'MCOLITE'='Skype for Business Online (Plan P1)';
    'MCOMEETACPEA' = 'Audio Conferencing Pay Per Minute';
    'MCOMEETADV'='Audio Conferencing';
    'MCOMEETADV_GOC' = 'Microsoft 365 Audio Conferencing for GCC';
    'MCOMEETADV_MCOMEETADV'='Audio Conferencing';
    'MCOPSTN_5_MCOPSTN5'='Domestic Calling Plan (120 min)';
    'MCOPSTN1'='Skype for Business PSTN Domestic Calling';
    'MCOPSTN1_MCOPSTN1'='Domestic Calling Plan';
    'MCOPSTN2'='Skype for Business PSTN Domestic And International Calling';
    'MCOPSTN2_MCOPSTN2'='Domestic and International Calling Plan';
    'MCOPSTN5'='Skype for Business PSTN Domestic Calling';
    'MCOPSTN_5' = 'Microsoft 365 Domestic Calling Plan (120 Minutes)';
    'MCOPSTNC'='Communication Credits';
    'MCOPSTNC_MCOPSTNC'='Skype for Business Communications Credits';
    'MCOPSTNEAU2' = 'TELSTRA Calling for O365';
    'MCOPSTNPP'='Skype for Business Communication Credits - Paid';
    'MCOSTANDARD'='Skype for Business Online (Plan 2)';
    'MCOSTANDARD_FACULTY'='Lync (Plan 2 for Faculty)';
    'MCOSTANDARD_GOV'='Skype for Business Online P2 for Government';
    'MCOSTANDARD_MCOSTANDARD'='Skype for Business Online (Plan 2)';
    'MCOSTANDARD_MIDMARKET'='Skype for Business Online (Plan 2) for Midsize';
    'MCOSTANDARD_STUDENT'='Lync (Plan 2 for Students)';
    'MCOVOICECONF'='Skype for Business Online (Plan 3)';
    'MCOVOICECONF_FACULTY'='Lync Plan 3 for Faculty';
    'MCOVOICECONF_GOV'='Lync for Government (Plan 3G)';
    'MCOVOICECONF_STUDENT'='Lync Plan 3 for Students';
    'MCVOICECONF'='Lync/Skype for Business Online P3';
    'MDATP_XPLAT' = 'Microsoft Defender For Endpoint';
    'MDM_SALES_COLLABORATION'='Microsoft Dynamics Marketing Sales Collaboration';
    'MEE_FACULTY'='Minecraft Education Edition Faculty';
    'MEE_STUDENT'='Minecraft Education Edition Student';
    'MEETING_ROOM' = 'Microsoft Teams Rooms Standard';
    'MEETING_ROOM_INTUNE_A'='Meeting Room - Microsoft Intune';
    'MEETING_ROOM_MCOEV'='Meeting Room - Microsoft Phone System';
    'MEETING_ROOM_MCOMEETADV'='Meeting Room - Audio Conferencing';
    'MEETING_ROOM_MCOSTANDARD'='Meeting Room - Skype for Business Online (P2)';
    'MEETING_ROOM_TEAMS1'='Meeting Room - Microsoft Teams';
    'MFA_PREMIUM'='Microsoft Azure Multi-factor Authentication';
    'MFA_STANDALONE'='Azure Multi-Factor Authentication Premium Standalone';
    'MICROSOFT_BUSINESS_CENTER'='Microsoft Business Center';
    'MICROSOFT_REMOTE_ASSIST' = 'Dynamics 365 Remote Assist';
    'MICROSOFT_REMOTE_ASSIST_CDS_REMOTE_ASSIST'='Microsoft Remote Assistant - Common Data Service';
    'MICROSOFT_REMOTE_ASSIST_HOLOLENS' = 'Dynamics 365 Remote Assist HoloLens';
    'MICROSOFT_REMOTE_ASSIST_MICROSOFT_REMOTE_ASSIST'='Microsoft Remote Assistant';
    'MICROSOFT_REMOTE_ASSIST_TEAMS1'='Microsoft Remote Assistant - Microsft Teams';
    'MICROSOFT_SEARCH'='Microsoft Search';
    'MICROSOFTBOOKINGS'='Microsoft Bookings';
    'MIDSIZEPACK'='Office 365 Midsize Business';
    'MIDSIZEPACK_EXCHANGE_S_STANDARD_MIDMARKET'='O365 Midsize Business - Exchange Online (P1)';
    'MIDSIZEPACK_MCOSTANDARD_MIDMARKET'='O365 Midsize Business - Skype for Business Online (P2)';
    'MIDSIZEPACK_OFFICESUBSCRIPTION'='O365 Midsize Business - Office 365 ProPlus';
    'MIDSIZEPACK_SHAREPOINTENTERPRISE_MIDMARKET'='O365 Midsize Business - SharePoint Online (P1)';
    'MIDSIZEPACK_SHAREPOINTWAC'='O365 Midsize Business - Office for web';
    'MIDSIZEPACK_SWAY'='O365 Midsize Business - Sway';
    'MIDSIZEPACK_YAMMER_MIDSIZE'='O365 Midsize Business - Yammer Enterprise';
    'MINECRAFT_EDUCATION_EDITION'='Minecraft Education Edition';
    'MIP_S_CLP1'='Information Protection for Office 365 - Standard';
    'MIP_S_CLP2'='Information Protection for Office 365 - Premium';
    'MS_TEAMS_IW'='Microsoft Team Trial';
    'MTR_PREM_NOAUDIOCONF_FACULTY'='Teams Rooms Premium without Audio Conferencing for faculty Trial';
    'MYANALYTICS_P2'='Insights By Myanalytics';
    'NBENTERPRISE'='Microsoft Social Engagement - Service Discontinuation';
    'NBPROFESSIONALFORCRM'='Microsoft Social Engagement Professional';
    'NONPROFIT_PORTAL'='Nonprofit Portal';
    'O365_BUSINESS'='Microsoft 365 Apps for Business';
    'O365_BUSINESS_ESSENTIALS'='Microsoft 365 Business Basic';
    'O365_BUSINESS_ESSENTIALS_EXCHANGE_S_STANDARD'='M365 Business Basic - Exchange Online (P2)';
    'O365_BUSINESS_ESSENTIALS_FLOW_O365_P1'='M365 Business Basic - Flow for Office 365';
    'O365_BUSINESS_ESSENTIALS_FORMS_PLAN_E1'='M365 Business Basic - Microsft Forms (Plan E1)';
    'O365_BUSINESS_ESSENTIALS_MCOSTANDARD'='M365 Business Basic - Skype for Business Online (P2)';
    'O365_BUSINESS_ESSENTIALS_POWERAPPS_O365_P1'='M365 Business Basic - PowerApps for Office 365';
    'O365_BUSINESS_ESSENTIALS_PROJECTWORKMANAGEMENT'='M365 Business Basic - Microsoft Planner';
    'O365_BUSINESS_ESSENTIALS_SHAREPOINTSTANDARD'='M365 Business Basic - SharePoint (P1)';
    'O365_BUSINESS_ESSENTIALS_SHAREPOINTWAC'='M365 Business Basic - Office for web';
    'O365_BUSINESS_ESSENTIALS_SWAY'='M365 Business Basic - Sway';
    'O365_BUSINESS_ESSENTIALS_TEAMS1'='M365 Business Basic - Microsoft Teams';
    'O365_BUSINESS_ESSENTIALS_YAMMER_ENTERPRISE'='M365 Business Basic - Yammer Enterprise';
    'O365_BUSINESS_FORMS_PLAN_E1'='M365 Apps for Business - Microsft Forms (Plan E1)';
    'O365_BUSINESS_OFFICE_BUSINESS'='M365 Apps for Business - Office 365 Business';
    'O365_BUSINESS_ONEDRIVESTANDARD'='M365 Apps for Business - OneDrive for Business';
    'O365_BUSINESS_PREMIUM'='Microsoft 365 Business Standard';
    'O365_BUSINESS_PREMIUM_BPOS_S_TODO_1'='M365 Business Standard - To-do (P1)';
    'O365_BUSINESS_PREMIUM_DESKLESS'='M365 Business Standard - Microsoft StaffHub';
    'O365_BUSINESS_PREMIUM_DYN365_CDS_O365_P2'='M365 Business Standard - Common Data Service';
    'O365_BUSINESS_PREMIUM_DYN365BC_MS_INVOICING'='M365 Business Standard - Microsoft Invoicing';
    'O365_BUSINESS_PREMIUM_EXCHANGE_S_STANDARD'='M365 Business Standard - Exchange Online (P2)';
    'O365_BUSINESS_PREMIUM_FLOW_O365_P1'='M365 Business Standard - Flow for Office 365';
    'O365_BUSINESS_PREMIUM_FORMS_PLAN_E1'='M365 Business Standard - Microsft Forms (Plan E1)';
    'O365_BUSINESS_PREMIUM_KAIZALA_O365_P2'='M365 Business Standard - Microsoft Kaizala Pro';
    'O365_BUSINESS_PREMIUM_MCOSTANDARD'='M365 Business Standard - Skype for Business Online (P2)';
    'O365_BUSINESS_PREMIUM_MICROSOFTBOOKINGS'='M365 Business Standard - Microsoft Bookings';
    'O365_BUSINESS_PREMIUM_MYANALYTICS_P2'='M365 Business Standard - Insights by MyAnalytics';
    'O365_BUSINESS_PREMIUM_O365_SB_RELATIONSHIP_MANAGEMENT'='M365 Business Standard - Outlook Customer Manager';
    'O365_BUSINESS_PREMIUM_OFFICE_BUSINESS'='M365 Business Standard - Office 365 Business';
    'O365_BUSINESS_PREMIUM_POWERAPPS_O365_P1'='M365 Business Standard - PowerApps for Office 365';
    'O365_BUSINESS_PREMIUM_PROJECTWORKMANAGEMENT'='M365 Business Standard - Microsoft Planner';
    'O365_BUSINESS_PREMIUM_SHAREPOINTSTANDARD'='M365 Business Standard - SharePoint (P1)';
    'O365_BUSINESS_PREMIUM_SHAREPOINTWAC'='M365 Business Standard - Office for web';
    'O365_BUSINESS_PREMIUM_STREAM_O365_SMB'='M365 Business Standard - Stream for Office 365';
    'O365_BUSINESS_PREMIUM_SWAY'='M365 Business Standard - Sway';
    'O365_BUSINESS_PREMIUM_TEAMS1'='M365 Business Standard - Microsoft Teams';
    'O365_BUSINESS_PREMIUM_WHITEBOARD_PLAN1'='M365 Business Standard - Whiteboard (P1)';
    'O365_BUSINESS_PREMIUM_YAMMER_ENTERPRISE'='M365 Business Standard - Yammer Enterprise';
    'O365_BUSINESS_SHAREPOINTWAC'='M365 Apps for Business - Office for web';
    'O365_BUSINESS_SWAY'='M365 Apps for Business - Sway';
    'O365_SB_Relationship_Management'='Outlook Customer Manager';
    'OFFICE_BASIC'='Office 365 Basic';
    'OFFICE_BUSINESS'='Office 365 Business';
    'OFFICE_FORMS_PLAN_2'='Microsoft Forms (Plan 2)';
    'OFFICE_FORMS_PLAN_3'='Microsoft Forms (Plan 3)';
    'OFFICE365_MULTIGEO'='Multi-Geo Capabilities in Office 365';
    'OFFICEMOBILE_SUBSCRIPTION'='OFFICEMOBILE_SUBSCRIPTION';
    'OFFICESUBSCRIPTION'='Microsoft 365 Apps for Enterprise';
    'OFFICESUBSCRIPTION_FACULTY'='Office 365 ProPlus for Faculty';
    'OFFICESUBSCRIPTION_FORMS_PLAN_E1'='M365 Apps for Enterprise - Microsft Forms (Plan E1)';
    'OFFICESUBSCRIPTION_GOV'='Office 365 ProPlus for Government';
    'OFFICESUBSCRIPTION_OFFICESUBSCRIPTION'='M365 Apps for Enterprise - Office 365 ProPlus';
    'OFFICESUBSCRIPTION_ONEDRIVESTANDARD'='M365 Apps for Enterprise - OneDrive for Business';
    'OFFICESUBSCRIPTION_SHAREPOINTWAC'='M365 Apps for Enterprise - Office for web';
    'OFFICESUBSCRIPTION_STUDENT'='Microsoft 365 Apps for Students';
    'OFFICESUBSCRIPTION_SWAY'='M365 Apps for Enterprise - Sway';
    'ONEDRIVE_BASIC'='OneDrive Basic';
    'ONEDRIVEBASIC'='OneDrive Basic';
    'ONEDRIVEENTERPRISE'='Onedriveenterprise';
    'ONEDRIVESTANDARD'='Onedrivestandard';
    'ONEDRIVESTANDARD_GOV'='OneDrive for Business for Government (Plan 1G)';
    'PAM_ENTERPRISE'='Office 365 Privileged Access Management';
    'PARATURE_ENTERPRISE'='Parature Enterprise';
    'PARATURE_ENTERPRISE_GOV'='Parature Enterprise for Government';
    'PHONESYSTEM_VIRTUALUSER'='Phone System – Virtual User';
    'PHONESYSTEM_VIRTUALUSER_MCOEV_VIRTUALUSER'='Microsoft 365 Phone System - Virtual User';
    'PLANNERSTANDALONE'='Planner Standalone';
    'POWER_BI_ADDON'='Power BI for Office 365 Add-on';
    'POWER_BI_ADDON_BI_AZURE_P1'='Power BI for O365 Add-on - Microsoft Power BI Reporting And Analytics Plan 1';
    'POWER_BI_ADDON_SQL_IS_SSIM'='Power BI for O365 Add-on - Microsoft Power BI Information Services Plan 1';
    'POWER_BI_INDIVIDUAL_USE'='Power BI Individual User';
    'POWER_BI_INDIVIDUAL_USER'='Power BI for Office 365 Individual';
    'POWER_BI_PRO'='Power BI Pro';
    'POWER_BI_PRO_BI_AZURE_P2'='POWER BI PRO - Power BI Pro';
    'POWER_BI_PRO_CE' = 'Power BI Pro (Nonprofit Staff Pricing)';
    'POWER_BI_PRO_FACULTY'='Power BI Pro for faculty';
    'POWER_BI_PRO_STUDENT'='Power BI Pro for students';
    'POWER_BI_STANDALONE'='Power BI for Office 365 Standalone';
    'POWER_BI_STANDALONE_FACULTY'='Power BI for Office 365 for Faculty';
    'POWER_BI_STANDALONE_STUDENT'='Power BI for Office 365 for Students';
    'POWER_BI_STANDARD'='Power BI (free)';
    'POWER_BI_STANDARD_BI_AZURE_P0'='Power BI (free)';
    'POWER_BI_STANDARD_FACULTY'='Power BI (free) for Faculty';
    'POWER_BI_STANDARD_STUDENT'='Power BI (free) for Students';
    'POWERAPPS_DEV' = 'Power Apps for Developer';
    'POWERAPPS_DYN_APPS'='Powerapps for Dynamics 365';
    'POWERAPPS_DYN_P2'='Powerapps for Dynamics 365';
    'POWERAPPS_DYN_TEAM'='Powerapps for Dynamics 365';
    'POWERAPPS_INDIVIDUAL_USER'='Microsoft PowerApps and Logic Flows';
    'POWERAPPS_INDIVIDUAL_USER_POWERAPPSFREE'='Microsoft PowerApps and Logic Flows - Microsoft PowerApps';
    'POWERAPPS_INDIVIDUAL_USER_POWERFLOWSFREE'='Microsoft PowerApps and Logic Flows - Logic Flows';
    'POWERAPPS_INDIVIDUAL_USER_POWERVIDEOSFREE'='Microsoft PowerApps and Logic Flows - Microsoft Power Videos Basic';
    'POWERAPPS_O365_P1'='Powerapps for Office 365';
    'POWERAPPS_O365_P2'='Powerapps for Office 365';
    'POWERAPPS_O365_P3'='Powerapps for Office 365 Plan 3';
    'POWERAPPS_O365_S1'='Powerapps for Office 365 K1';
    'POWERAPPS_P2_VIRAL'='PowerApps Trial';
    'POWERAPPS_PER_USER'='PowerApps Per User Plan';
    'POWERAPPS_PER_APP'='PowerApps Per App Plan '
    'POWERAPPS_PER_APP_IW'='PowerApps per app baseline access';
    'POWERAPPS_VIRAL'='Microsoft PowerApps Plan 2 Trial';
    'POWERAPPS_VIRAL_DYN365_CDS_VIRAL'='MS PowerApps Plan 2 Trial - Common Data Service';
    'POWERAPPS_VIRAL_FLOW_P2_VIRAL'='MS PowerApps Plan 2 Trial - Flow Free';
    'POWERAPPS_VIRAL_FLOW_P2_VIRAL_REAL'='MS PowerApps Plan 2 Trial - Flow P2 Viral';
    'POWERAPPS_VIRAL_POWERAPPS_P2_VIRAL'='MS PowerApps Plan 2 Trial - PowerApps Trial';
    'POWERAPPSFREE'='Microsoft PowerApps';
    'POWERAUTOMATE_ATTENDED_RPA'='Power Automate per user plan with attended RPA';
    'POWERFLOW_P2'='Microsoft PowerApps Plan 2 Trial';
    'POWERFLOW_P2_DYN365_CDS_P2'='Microsoft PowerApps P2 Trial - Common Data Service';
    'POWERFLOW_P2_FLOW_P2'='Microsoft PowerApps P2 Trial';
    'POWERFLOW_P2_POWERAPPS_P2'='Microsoft PowerApps P2 Trial - PowerApps';
    'POWERFLOWSFREE'='Logic flows';
    'POWERVIDEOSFREE'='Microsoft Power Videos Basic';
    'PREMIUM_ENCRYPTION'='Premium Encryption In Office 365';
    'PROJECT_CLIENT_SUBSCRIPTION'='Project Online Desktop Client';
    'PROJECT_ESSENTIALS'='Project Online Essentials';
    'PROJECT_MADEIRA_PREVIEW_IW_SKU'='Dynamics 365 for Financials for IWs';
    'PROJECT_MADEIRA_PREVIEW_IW_SKU_PROJECT_MADEIRA_PREVIEW_IW'='Microsoft Dynamics 365 Business Preview Iw (deprecated)';
    'PROJECT_P1' = 'Project Plan 1';
    'PROJECT_PROFESSIONAL'='Project Online Professional';
    'PROJECTCLIENT'='Project for Office 365';
    'PROJECTCLIENT_FACULTY'='Project Pro for Office 365 for Faculty';
    'PROJECTCLIENT_GOV'='Project Pro for Office 365 for Government';
    'PROJECTCLIENT_PROJECT_CLIENT_SUBSCRIPTION'='Project for O365 - Project Online Desktop Client';
    'PROJECTCLIENT_STUDENT'='Project Pro for Office 365 for Students';
    'PROJECTESSENTIALS'='Project Online Essentials';
    'PROJECTESSENTIALS_FACULTY'='Project Online Essentials for Faculty';
    'PROJECTESSENTIALS_FORMS_PLAN_E1'='Project Online Essentials - Microsft Forms (Plan E1)';
    'PROJECTESSENTIALS_GOV'='Project Essentials for Government';
    'PROJECTESSENTIALS_PROJECT_ESSENTIALS'='Project Online Essentials - Project Online Essential';
    'PROJECTESSENTIALS_SHAREPOINTENTERPRISE'='Project Online Essentials - SharePoint (P2)';
    'PROJECTESSENTIALS_SHAREPOINTWAC'='Project Online Essentials - Office for web';
    'PROJECTESSENTIALS_STUDENT'='Project Online Essentials for Students';
    'PROJECTESSENTIALS_SWAY'='Project Online Essentials - Sway';
    'PROJECTONLINE_PLAN_1'='Project Online Premium Without Project Client';
    'PROJECTONLINE_PLAN_1_FACULTY'='Project Online for Faculty Plan 1';
    'PROJECTONLINE_PLAN_1_FORMS_PLAN_E1'='Project Online Premium Without Project Client - Microsft Forms (Plan E1)';
    'PROJECTONLINE_PLAN_1_GOV'='Project Plan 1for Government';
    'PROJECTONLINE_PLAN_1_SHAREPOINT_PROJECT'='Project Online Premium Without Project Client - Project Online Service';
    'PROJECTONLINE_PLAN_1_SHAREPOINTENTERPRISE'='Project Online Premium Without Project Client - SharePoint (P2)';
    'PROJECTONLINE_PLAN_1_SHAREPOINTWAC'='Project Online Premium Without Project Client - Office for web';
    'PROJECTONLINE_PLAN_1_STUDENT'='Project Online for Students Plan 1';
    'PROJECTONLINE_PLAN_1_SWAY'='Project Online Premium Without Project Client - Sway';
    'PROJECTONLINE_PLAN_2'='Project Online With Project for Office 365';
    'PROJECTONLINE_PLAN_2_FACULTY'='Project Online for Faculty Plan 2';
    'PROJECTONLINE_PLAN_2_FORMS_PLAN_E1'='Project Online With Project for O365 - Microsft Forms (Plan E1)';
    'PROJECTONLINE_PLAN_2_GOV'='Project Plan 2 for Government';
    'PROJECTONLINE_PLAN_2_SHAREPOINT_PROJECT'='Project Online With Project for O365 - Project Online Service';
    'PROJECTONLINE_PLAN_2_STUDENT'='Project Online for Students Plan 2';
    'PROJECTONLINE_PLAN_3_PROJECT_CLIENT_SUBSCRIPTION'='Project Online With Project for O365 - Project Online Desktop Client';
    'PROJECTONLINE_PLAN_3_SHAREPOINTENTERPRISE'='Project Online Premium Without Project Client - SharePoint (P2)';
    'PROJECTONLINE_PLAN_4_SHAREPOINT_PROJECT'='Project Online With Project for O365 - Project Online Service';
    'PROJECTONLINE_PLAN_4_SHAREPOINTWAC'='Project Online Premium Without Project Client - Office for web';
    'PROJECTONLINE_PLAN_5_SHAREPOINTENTERPRISE'='Project Online With Project for O365 - SharePoint (P2)';
    'PROJECTONLINE_PLAN_5_SWAY'='Project Online Premium Without Project Client - Sway';
    'PROJECTONLINE_PLAN_6_SHAREPOINTWAC'='PProject Online With Project for O365 - Office for web';
    'PROJECTONLINE_PLAN_7_SWAY'='Project Online With Project for O365 - Sway';
    'PROJECTONLINE_PLAN1_FACULTY'='Project Online Professional P1 for Faculty';
    'PROJECTONLINE_PLAN1_STUDENT'='Project Online Professional P1 for Students';
    'PROJECTPREMIUM'='Project Online Premium';
    'PROJECTPREMIUM_PROJECT_CLIENT_SUBSCRIPTION'='Project Online Premium - Project Online Desktop Client';
    'PROJECTPREMIUM_SHAREPOINT_PROJECT'='Project Online Premium - Project Online Service';
    'PROJECTPREMIUM_SHAREPOINTENTERPRISE'='Project Online Premium - SharePoint (P2)';
    'PROJECTPREMIUM_SHAREPOINTWAC'='Project Online Premium - Office for web';
    'PROJECTPROFESSIONAL'='Project Online Professional';
    'PROJECTPROFESSIONAL_DYN365_CDS_PROJECT'='Project Online Professional - Common Data Service';
    'PROJECTPROFESSIONAL_FLOW_FOR_PROJECT'='Project Online Professional - Flow for Project Online';
    'PROJECTPROFESSIONAL_PROJECT_CLIENT_SUBSCRIPTION'='Project Online Professional - Project Online Desktop Client';
    'PROJECTPROFESSIONAL_PROJECT_PROFESSIONAL'='Project Online Professional - Project Professional';
    'PROJECTPROFESSIONAL_SHAREPOINT_PROJECT'='Project Online Professional - Project Online Service';
    'PROJECTPROFESSIONAL_SHAREPOINTENTERPRISE'='Project Online Professional - SharePoint (P2)';
    'PROJECTPROFESSIONAL_SHAREPOINTWAC'='Project Online Professional - Office for web';
    'PROJECTWORKMANAGEMENT'='Microsoft Planner';
    'RECORDS_MANAGEMENT'='Microsoft Records Management';
    'RIGHTSMANAGEMENT'='Azure Information Protection Plan 1';
    'RIGHTSMANAGEMENT_ADHOC'='Rights Management Adhoc';
    'RIGHTSMANAGEMENT_ADHOC_RMS_S_ADHOC'='Rights Management Adhoc';
    'RIGHTSMANAGEMENT_FACULTY'='Azure Active Directory Rights for Faculty';
    'RIGHTSMANAGEMENT_GOV'='Azure Active Directory Rights for Government';
    'RIGHTSMANAGEMENT_RMS_S_ENTERPRISE'='Azure Information Protection Plan 1 - Microsoft Azure AD Rights';
    'RIGHTSMANAGEMENT_RMS_S_PREMIUM'='Azure Information Protection Plan 1 - Azure Information Protection Premium P1';
    'RIGHTSMANAGEMENT_RMS_S_PREMIUM2'='Azure Information Protection Plan 1 - Azure Information Protection Premium P2';
    'RIGHTSMANAGEMENT_STANDARD_FACULTY'='Azure Rights Management for faculty';
    'RIGHTSMANAGEMENT_STANDARD_STUDENT'='Azure Rights Management for students';
    'RIGHTSMANAGEMENT_STUDENT'='Azure Active Directory Rights for Students';
    'RMS_S_ADHOC'='Rights Management Adhoc';
    'RMS_S_ENTERPRISE'='Microsoft Azure Active Directory Rights';
    'RMS_S_ENTERPRISE_GOV'='Azure Rights Management';
    'RMS_S_PREMIUM'='Azure Information Protection Premium P1';
    'RMS_S_PREMIUM2'='Azure Information Protection Premium P2';
    'RMSBASIC'='Rights Management Basic';
    'SAFEDOCS'='Office 365 Safedocs';
    'SCHOOL_DATA_SYNC_P1'='School Data Sync (Plan 1)';
    'SCHOOL_DATA_SYNC_P2'='School Data Sync (Plan 2)';
    'SHAREPOINT_PROJECT'='Project Online Service';
    'SHAREPOINT_PROJECT_EDU'='Project Online for Education';
    'SHAREPOINT_S_DEVELOPER'='SHAREPOINT_S_DEVELOPER';
    'SHAREPOINTDESKLESS'='Sharepoint Online Kiosk';
    'SHAREPOINTDESKLESS_GOV'='SharePoint Online Kiosk';
    'SHAREPOINTDESKLESS_SHAREPOINTDESKLESS'='Sharepoint Online Kiosk - Sharepoint Online Kiosk';
    'SHAREPOINTENTERPRISE'='Sharepoint Online (Plan 2)';
    'SHAREPOINTENTERPRISE_EDU'='Sharepoint Plan 2 for EDU';
    'SHAREPOINTENTERPRISE_FACULTY'='SharePoint (Plan 2 for Faculty)';
    'SHAREPOINTENTERPRISE_GOV'='SharePoint P2 for Government';
    'SHAREPOINTENTERPRISE_SHAREPOINTENTERPRISE'='Sharepoint Online (Plan 2)';
    'SHAREPOINTENTERPRISE_STUDENT'='SharePoint (Plan 2 for Students)';
    'SHAREPOINTENTERPRISE_YAMMER'='SharePoint (Plan 2 with Yammer)';
    'SHAREPOINTLITE'='Sharepointlite';
    'SHAREPOINTPARTNER'='SharePoint Online Partner Access';
    'SHAREPOINTSTANDARD'='Sharepoint Online (Plan 1)';
    'SHAREPOINTSTANDARD_EDU'='SharePoint Plan 1 for EDU';
    'SHAREPOINTSTANDARD_FACULTY'='SharePoint (Plan 1 for Faculty)';
    'SHAREPOINTSTANDARD_GOV'='SharePoint for Government (Plan 1G)';
    'SHAREPOINTSTANDARD_SHAREPOINTSTANDARD'='Sharepoint Online (Plan 1)';
    'SHAREPOINTSTANDARD_STUDENT'='SharePoint (Plan 1 for Students)';
    'SHAREPOINTSTANDARD_YAMMER'='SharePoint (Plan 1 with Yammer)';
    'SHAREPOINTSTORAGE'='SharePoint Online Storage';
    'SHAREPOINTWAC'='Office Online';
    'SHAREPOINTWAC_DEVELOPER'='Office Online for Developer';
    'SHAREPOINTWAC_EDU'='Office for The Web (Education)';
    'SHAREPOINTWAC_GOV'='Office Online for Government';
    'SKU ID'='Product Name';
    'SKU_Dynamics_365_for_HCM_Trial'='Dynamics 365 for Talents';
    'SKU_DYNAMICS_365_FOR_HCM_TRIAL_DYN365_CDS_DYN_APPS'='Dynamics 365 for Talents';
    'SKU_DYNAMICS_365_FOR_HCM_TRIAL_DYNAMICS_365_FOR_HCM_TRIAL'='Dynamics 365 for Talents';
    'SKU_DYNAMICS_365_FOR_HCM_TRIAL_DYNAMICS_365_HIRING_FREE_PLAN'='Dynamics 365 for Talents';
    'SKU_DYNAMICS_365_FOR_HCM_TRIAL_DYNAMICS_365_ONBOARDING_FREE_PLAN'='Dynamics 365 for Talents';
    'SKU_DYNAMICS_365_FOR_HCM_TRIAL_FLOW_DYN_APPS'='Dynamics 365 for Talents - Flow for Dynamics 365';
    'SKU_DYNAMICS_365_FOR_HCM_TRIAL_POWERAPPS_DYN_APPS'='Dynamics 365 for Talents';
    'SMB_APPS'='Microsoft Business Apps';
    'SMB_APPS_DYN365BC_MS_INVOICING'='Microsoft Business Apps - Microsoft Invoicing';
    'SMB_APPS_MICROSOFTBOOKINGS'='Microsoft Business Apps - Microsoft Bookings';
    'SMB_BUSINESS'='Microsoft 365 Apps for Business';
    'SMB_BUSINESS_ESSENTIALS'='Microsoft 365 Business Basic';
    'SMB_BUSINESS_ESSENTIALS_EXCHANGE_S_STANDARD'='M365 Business Basic - Exchange Online (P2)';
    'SMB_BUSINESS_ESSENTIALS_FLOW_O365_P1'='M365 Business Basic - Flow for Office 365';
    'SMB_BUSINESS_ESSENTIALS_FORMS_PLAN_E1'='M365 Business Basic - Microsft Forms (Plan E1)';
    'SMB_BUSINESS_ESSENTIALS_MCOSTANDARD'='M365 Business Basic - Skype for Business Online (P2)';
    'SMB_BUSINESS_ESSENTIALS_POWERAPPS_O365_P1'='M365 Business Basic - PowerApps for Office 365';
    'SMB_BUSINESS_ESSENTIALS_PROJECTWORKMANAGEMENT'='M365 Business Basic - Microsoft Planner';
    'SMB_BUSINESS_ESSENTIALS_SHAREPOINTSTANDARD'='M365 Business Basic - SharePoint (P1)';
    'SMB_BUSINESS_ESSENTIALS_SHAREPOINTWAC'='M365 Business Basic - Office for web';
    'SMB_BUSINESS_ESSENTIALS_SWAY'='M365 Business Basic - Sway';
    'SMB_BUSINESS_ESSENTIALS_TEAMS1'='M365 Business Basic - Microsoft Teams';
    'SMB_BUSINESS_ESSENTIALS_YAMMER_MIDSIZE'='M365 Business Basic - Yammer Enterprise';
    'SMB_BUSINESS_FORMS_PLAN_E1'='M365 Apps for Business - Microsft Forms (Plan E1)';
    'SMB_BUSINESS_OFFICE_BUSINESS'='M365 Apps for Business - Office 365 Business';
    'SMB_BUSINESS_ONEDRIVESTANDARD'='M365 Apps for Business - OneDrive for Business';
    'SMB_BUSINESS_PREMIUM'='Microsoft 365 Business Standard';
    'SMB_BUSINESS_PREMIUM_EXCHANGE_S_STANDARD'='M365 Business Standard - Exchange Online (P2)';
    'SMB_BUSINESS_PREMIUM_FLOW_O365_P1'='M365 Business Standard - Flow for Office 365';
    'SMB_BUSINESS_PREMIUM_FORMS_PLAN_E1'='M365 Business Standard - Microsft Forms (Plan E1)';
    'SMB_BUSINESS_PREMIUM_MCOSTANDARD'='M365 Business Standard - Skype for Business Online (P2)';
    'SMB_BUSINESS_PREMIUM_MICROSOFTBOOKINGS'='M365 Business Standard - Microsoft Bookings';
    'SMB_BUSINESS_PREMIUM_O365_SB_RELATIONSHIP_MANAGEMENT'='M365 Business Standard -';
    'SMB_BUSINESS_PREMIUM_OFFICE_BUSINESS'='M365 Business Standard - Office 365 Business';
    'SMB_BUSINESS_PREMIUM_POWERAPPS_O365_P1'='M365 Business Standard - PowerApps for Office 365';
    'SMB_BUSINESS_PREMIUM_PROJECTWORKMANAGEMENT'='M365 Business Standard - Microsoft Planner';
    'SMB_BUSINESS_PREMIUM_SHAREPOINTSTANDARD'='M365 Business Standard - SharePoint (P1)';
    'SMB_BUSINESS_PREMIUM_SHAREPOINTWAC'='M365 Business Standard - Office for web';
    'SMB_BUSINESS_PREMIUM_SWAY'='M365 Business Standard - Sway';
    'SMB_BUSINESS_PREMIUM_TEAMS1'='M365 Business Standard - Microsoft Teams';
    'SMB_BUSINESS_PREMIUM_YAMMER_MIDSIZE'='M365 Business Standard - Yammer Enterprise';
    'SMB_BUSINESS_SHAREPOINTWAC'='M365 Apps for Business - Office for web';
    'SMB_BUSINESS_SWAY'='M365 Apps for Business - Sway';
    'SOCIAL_ENGAGEMENT_APP_USER'='Dynamics 365 AI for Market Insights';
    'SPB'='Microsoft 365 Business Premium';
    'SPE_E3'='Microsoft 365 E3';
    'SPE_E3_USGOV_DOD'='Microsoft 365 E3_USGOV_DOD';
    'SPE_E3_USGOV_GCCHIGH'='Microsoft 365 E3_USGOV_GCCHIGH';
    'SPE_E5'='Microsoft 365 E5';
    'SPE_F1'='Microsoft 365 F3';
    'SPE_F1_AAD_PREMIUM'='M365 F1 - Azure AD Premium P1';
    'SPE_F1_ADALLOM_S_DISCOVERY'='M365 F1 - Cloud App Security Discovery';
    'SPE_F1_BPOS_S_TODO_FIRSTLINE'='M365 F1 - To-do (Firstline)';
    'SPE_F1_DESKLESS'='M365 F1 - Microsoft Staffhub';
    'SPE_F1_DYN365_CDS_O365_F1'='M365 F1 - Common Data Service';
    'SPE_F1_EXCHANGE_S_DESKLESS'='M365 F1 - Exchange Online Kiosk';
    'SPE_F1_FLOW_O365_S1'='M365 F1 - Flow for Office 365 K1';
    'SPE_F1_FORMS_PLAN_K'='M365 F1 - Microsoft Forms (Plan F1)';
    'SPE_F1_INTUNE_A'='M365 F1 - Microsoft Intune';
    'SPE_F1_KAIZALA_O365_P1'='M365 F1 - Microsoft Kaizala';
    'SPE_F1_MCOIMP'='M365 F1 - Skype for Business Online (P1)';
    'SPE_F1_MFA_PREMIUM'='M365 F1 - Azure Multi-factor Authentication';
    'SPE_F1_OFFICEMOBILE_SUBSCRIPTION'='M365 F1 - Office Mobile Apps for Office 365';
    'SPE_F1_POWERAPPS_O365_S1'='M365 F1 - Powerapps for Office 365 K1';
    'SPE_F1_PROJECTWORKMANAGEMENT'='M365 F1 - Microsoft Planner';
    'SPE_F1_RMS_S_ENTERPRISE'='M365 F1 - Azure Rights Management';
    'SPE_F1_RMS_S_PREMIUM'='M365 F1 - Azure Information Protection P1';
    'SPE_F1_SHAREPOINTDESKLESS'='M365 F1 - Sharepoint Online Kiosk';
    'SPE_F1_SHAREPOINTWAC'='M365 F1 - Office for web';
    'SPE_F1_STREAM_O365_K'='M365 F1 - Microsoft Stream for O365 K SKU';
    'SPE_F1_SWAY'='M365 F1 - Sway';
    'SPE_F1_TEAMS1'='M365 F1 - Microsoft Teams';
    'SPE_F1_WHITEBOARD_FIRSTLINE1'='M365 F1 - Whiteboard (Firstline)';
    'SPE_F1_WIN10_ENT_LOC_F1'='M365 F1 - Windows 10 Enterprise E3 (local Only)';
    'SPE_F1_YAMMER_ENTERPRISE'='M365 F1 - Yammer Enterprise';
    'SPZA'='App Connect';
    'SPZA_IW'='App Connect';
    'SPZA_IW_SPZA'='App Connect Iw';
    'SQL_IS_SSIM'='Microsoft Power BI Information Services Plan 1';
    'STANDARD_B_PILOT'='Office 365 (Small Business Preview)';
    'STANDARDPACK'='Office 365 E1';
    'STANDARDPACK_BPOS_S_TODO_1'='O365 E1 - To-do (P1)';
    'STANDARDPACK_DESKLESS'='O365 E1 - Microsoft StaffHub';
    'STANDARDPACK_DYN365_CDS_O365_P1'='O365 E1 - Common Data Service';
    'STANDARDPACK_EXCHANGE_S_STANDARD'='O365 E1 - Exchange Online (P2)';
    'STANDARDPACK_FACULTY'='Office 365 Education E1 for Faculty';
    'STANDARDPACK_FLOW_O365_P1'='O365 E1 - Flow for Office 365';
    'STANDARDPACK_FORMS_PLAN_E1'='O365 E1 - Microsft Forms (Plan E1)';
    'STANDARDPACK_GOV'='Office 365 Enterprise E1 for Government';
    'STANDARDPACK_KAIZALA_O365_P2'='O365 E1 - Microsoft Kaizala Pro';
    'STANDARDPACK_MCOSTANDARD'='O365 E1 - Skype for Business Online (P2)';
    'STANDARDPACK_MYANALYTICS_P2'='O365 E1 - Insights by MyAnalytics';
    'STANDARDPACK_OFFICEMOBILE_SUBSCRIPTION'='O365 E1 - Office Mobile Apps for Office 365';
    'STANDARDPACK_POWERAPPS_O365_P1'='O365 E1 - PowerApps for Office 365';
    'STANDARDPACK_PROJECTWORKMANAGEMENT'='O365 E1 - Microsoft Planner';
    'STANDARDPACK_SHAREPOINTSTANDARD'='O365 E1 - SharePoint (P1)';
    'STANDARDPACK_SHAREPOINTWAC'='O365 E1 - Office for web';
    'STANDARDPACK_STREAM_O365_E1'='O365 E1 - Microsoft Stream for O365 E1 SKU';
    'STANDARDPACK_STUDENT'='Office 365 Education E1 for Students';
    'STANDARDPACK_SWAY'='O365 E1 - Sway';
    'STANDARDPACK_TEAMS1'='O365 E1 - Microsoft Teams';
    'STANDARDPACK_WHITEBOARD_PLAN1'='O365 E1 - Whiteboard (P1)';
    'STANDARDPACK_YAMMER_ENTERPRISE'='O365 E1 - Yammer Enterprise';
    'STANDARDWOFFPACK'='Office 365 E2';
    'STANDARDWOFFPACK_DESKLESS'='O365 E2 - Microsoft StaffHub';
    'STANDARDWOFFPACK_EXCHANGE_S_STANDARD'='O365 E2 - Exchange Online (P2)';
    'STANDARDWOFFPACK_FACULTY'='Office 365 A1 for faculty';
    'STANDARDWOFFPACK_FLOW_O365_P1'='O365 E2 - Flow for Office 365';
    'STANDARDWOFFPACK_FORMS_PLAN_E1'='O365 E2 - Microsft Forms (Plan E1)';
    'STANDARDWOFFPACK_GOV'='Office 365 Enterprise E2 for Government';
    'STANDARDWOFFPACK_IW_FACULTY'='Office 365 Education E2 for Faculty';
    'STANDARDWOFFPACK_IW_STUDENT'='Office 365 Education E2 for Students';
    'STANDARDWOFFPACK_MCOSTANDARD'='O365 E2 - Skype for Business Online (P2)';
    'STANDARDWOFFPACK_POWERAPPS_O365_P1'='O365 E2 - PowerApps for Office 365';
    'STANDARDWOFFPACK_PROJECTWORKMANAGEMENT'='O365 E2 - Microsoft Planner';
    'STANDARDWOFFPACK_SHAREPOINTSTANDARD'='O365 E2 - SharePoint (P1)';
    'STANDARDWOFFPACK_SHAREPOINTWAC'='O365 E2 - Office for web';
    'STANDARDWOFFPACK_STREAM_O365_E1'='O365 E2 - Stream for Office 365';
    'STANDARDWOFFPACK_STUDENT'='Office 365 A1 for students';
    'STANDARDWOFFPACK_SWAY'='O365 E2 - Sway';
    'STANDARDWOFFPACK_TEAMS1'='O365 E2 - Microsoft Teams';
    'STANDARDWOFFPACK_YAMMER_ENTERPRISE'='O365 E2 - Yammer Enterprise';
    'STANDARDWOFFPACKPACK_FACULTY'='Office 365 Plan A2 for Faculty';
    'STANDARDWOFFPACKPACK_STUDENT'='Office 365 Plan A2 for Students';
    'STREAM'='Microsoft Stream Trial';
    'STREAM_MICROSOFT STREAM'='Microsoft Stream Trial';
    'STREAM_O365_E1'='Microsoft Stream for O365 E1 SKU';
    'STREAM_O365_E3'='Microsoft Stream for O365 E3 SKU';
    'STREAM_O365_E5'='Microsoft Stream for O365 E5 SKU';
    'STREAM_O365_K'='Microsoft Stream for O365 K SKU';
    'SWAY'='Sway';
    'TEAMS_AR_DOD'='Microsoft Teams for DoD (ar)';
    'TEAMS_AR_GCCHIGH'='Microsoft Teams for GCC High (ar)';
    'TEAMS_COMMERCIAL_TRIAL_FLOW_O365_P1'='Microsoft Teams Commercial Cloud - Flow for Office 365';
    'TEAMS_COMMERCIAL_TRIAL_FORMS_PLAN_E1'='Microsoft Teams Commercial Cloud - Microsoft Forms (P1)';
    'TEAMS_COMMERCIAL_TRIAL_MCO_TEAMS_IW'='Microsoft Teams Commercial Cloud - Microsoft Teams';
    'TEAMS_COMMERCIAL_TRIAL_POWERAPPS_O365_P1'='Microsoft Teams Commercial Cloud - PowerApps for Office 365';
    'TEAMS_COMMERCIAL_TRIAL_PROJECTWORKMANAGEMENT'='Microsoft Teams Commercial Cloud - Microsoft Planner';
    'TEAMS_COMMERCIAL_TRIAL_SHAREPOINTDESKLESS'='Microsoft Teams Commercial Cloud - SharePoint Kiosk';
    'TEAMS_COMMERCIAL_TRIAL_SHAREPOINTWAC'='Microsoft Teams Commercial Cloud - Office for the web';
    'TEAMS_COMMERCIAL_TRIAL_STREAM_O365_E1'='Microsoft Teams Commercial Cloud - Microsoft Stream for O365 E1 SKU';
    'TEAMS_COMMERCIAL_TRIAL_SWAY'='Microsoft Teams Commercial Cloud - Sway';
    'TEAMS_COMMERCIAL_TRIAL_TEAMS1'='Microsoft Teams Commercial Cloud - Microsoft Teams';
    'TEAMS_COMMERCIAL_TRIAL_WHITEBOARD_PLAN1'='Microsoft Teams Commercial Cloud - Whiteboard (P1)';
    'TEAMS_COMMERCIAL_TRIAL_YAMMER_ENTERPRISE'='Microsoft Teams Commercial Cloud - Yammer Enterprise';
    'TEAMS_EXPLORATORY'='Teams Exploratory Trial';
    'TEAMS_FREE'='Microsoft Teams (Free)';
    'TEAMS1'='Microsoft Teams';
    'THREAT_INTELLIGENCE'='Office 365 Advanced Threat Protection (Plan 2)';
    'TOPIC_EXPERIENCES' = 'Topic Experiences';
    'UNIVERSAL_PRINT_M365'='Universal Print';
    'UNIVERSAL_PRINT_EDU_M365'='Universal Print for Education Trial';
    'Trial DYN365_AI_SERVICE_INSIGHTS'='Dynamics 365 Customer Service Insights';
    'VIDEO_INTEROP'='Polycom Skype Meeting Video Interop for Skype for Business';
    'VIDEO_INTEROP_VIDEO_INTEROP'='Polycom Skype Meeting Video Interop for Skype for Business';
    'Virtualization Rights for Windows 10 (E3/E5+VDA)'='Windows 10 Enterprise (new)';
    'VISIO_CLIENT_SUBSCRIPTION'='Visio Online';
    'VISIOCLIENT'='Visio Online Plan 2';
    'VISIOCLIENT_FACULTY'='Visio Pro for Office 365 for Faculty';
    'VISIOCLIENT_GOV'='Visio Pro for Office 365 for Government';
    'VISIOCLIENT_ONEDRIVE_BASIC'='Visio Online P2 - OneDrive Basic';
    'VISIOCLIENT_STUDENT'='Visio Pro for Office 365 for Students';
    'VISIOCLIENT_VISIO_CLIENT_SUBSCRIPTION'='Visio Online P2 - Visio Online Desktop Client';
    'VISIOCLIENT_VISIOONLINE'='Visio Online P2 - Vision Online';
    'VISIOONLINE'='Visioonline';
    'VISIOONLINE_PLAN1'='Visio Online Plan 1';
    'VISIOONLINE_PLAN1_ONEDRIVE_BASIC'='Visio Online P1 - OneDrive Basic';
    'VISIOONLINE_PLAN1_VISIOONLINE'='Visio Online P1 - Visio Online';
    'WACONEDRIVEENTERPRISE'='Onedrive for Business (Plan 2)';
    'WACONEDRIVEENTERPRISE_ONEDRIVEENTERPRISE'='Onedrive for Business (P2) - OneDrive for Business P2';
    'WACONEDRIVEENTERPRISE_SHAREPOINTWAC'='Onedrive for Business (P2) - Office for web';
    'WACONEDRIVESTANDARD'='Onedrive for Business (Plan 1)';
    'WACONEDRIVESTANDARD_FORMS_PLAN_E1'='Onedrive for Business (P1) - Microsft Forms (Plan E1)';
    'WACONEDRIVESTANDARD_GOV'='OneDrive for Business with Office Web Apps for Government';
    'WACONEDRIVESTANDARD_ONEDRIVESTANDARD'='Onedrive for Business (P1) - OneDrive for Business';
    'WACONEDRIVESTANDARD_SHAREPOINTWAC'='Onedrive for Business (P1) - Office for web';
    'WACONEDRIVESTANDARD_SWAY'='Onedrive for Business (P1) - Sway';
    'WACSHAREPOINTENT'='Office Web Apps with SharePoint Plan 2';
    'WACSHAREPOINTENT_FACULTY'='Office Web Apps (Plan 2 For Faculty)';
    'WACSHAREPOINTENT_GOV'='Office Web Apps (Plan 2G for Government)';
    'WACSHAREPOINTENT_STUDENT'='Office Web Apps (Plan 2 For Students)';
    'WACSHAREPOINTSTD'='Office Online';
    'WACSHAREPOINTSTD_FACULTY'='Office Web Apps (Plan 1 For Faculty)';
    'WACSHAREPOINTSTD_GOV'='Office Web Apps (Plan 1G for Government)';
    'WACSHAREPOINTSTD_STUDENT'='Office Web Apps (Plan 1 For Students)';
    'WHITEBOARD_FIRSTLINE1'='Whiteboard (Firstline)';
    'WHITEBOARD_PLAN2'='Whiteboard (Plan 2)';
    'WHITEBOARD_PLAN3'='Whiteboard (Plan 3)';
    'WIN_DEF_ATP'='Microsoft Defender Advanced Threat Protection';
    'WIN_DEF_ATP_WINDEFATP'='Microsoft Defender Advanced Threat Protection';
    'WIN10_ENT_LOC_F1'='Windows 10 Enterprise E3 (local Only)';
    'WIN10_PRO_ENT_SUB'='Windows 10 Enterprise E3';
    'WIN10_PRO_ENT_SUB_WIN10_PRO_ENT_SUB'='Windows 10 Enterprise E3';
    'WIN10_VDA_E3'='Windows 10 Enterprise E3';
    'WIN10_VDA_E3_VIRTUALIZATION RIGHTS FOR WINDOWS 10 (E3/E5+VDA)'='Windows 10 Enterprise E3 - Windows 10 Enterprise';
    'WIN10_VDA_E5'='Windows 10 Enterprise E5';
    'WIN10_VDA_E5_VIRTUALIZATION RIGHTS FOR WINDOWS 10 (E3/E5+VDA)'='Windows 10 Enterprise E5 - Windows 10 Enterprise';
    'WIN10_VDA_E5_WINDEFATP'='Windows 10 Enterprise E5 - Microsoft Defender Advanced Threat Protection';
    'WINBIZ'='Windows 10 Business';
    'WINDEFATP'='Microsoft Defender Advanced Threat Protection';
    'WORKPLACE_ANALYTICS'='Microsoft Workplace Analytics';
    'WORKPLACE_ANALYTICS_WORKPLACE_ANALYTICS'='Microsoft Workplace Analytics';
    'WSfB_EDU_Faculty'='Windows Store for Business EDU Faculty';
    'YAMMER_EDU'='Yammer for Academic';
    'YAMMER_ENTERPRISE'='Yammer Enterprise';
    'YAMMER_ENTERPRISE_STANDALONE'='Yammer Enterprise Standalone';
    'YAMMER_MIDSIZE'='Yammer Midsize'

}
    "@
    $1_export = @"
function Making (`$text, `$checked, `$enabled, `$loc1, `$loc2, `$width, `$height, `$autoSize, `$object, `$required) {
    `$location                      = New-Object System.Drawing.Point(`$loc1, `$loc2)
    `$obj                           = New-Object `$object
    `$obj.text                      = `$text
    `$obj.width                     = `$width
    `$obj.height                    = `$height
    `$obj.location                  = `$location
    `$obj.AutoSize                  = `$autoSize
    if(`$obj -match 'System.Windows.Forms.TextBox') {
        `$obj.multiline             = `$false
    } 
    if(`$obj -match 'System.Windows.Forms.ComboBox') {
        `$obj.DropDownStyle         = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    } 
    if(`$obj -match 'System.Windows.Forms.CheckBox') {
        `$obj.Checked               = `$checked
        `$obj.Enabled               = `$enabled
    }
    if(`$obj -match 'System.Windows.Forms.Label' -and `$loc2 -eq 40) {
        `$obj.Font                  = [System.Drawing.Font]::new('Microsoft Sans Serif', 11, [System.Drawing.FontStyle]::Bold)
    } else {
        `$obj.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)
    }
    if(`$required -and `$obj -match 'System.Windows.Forms.Label') {
        `$obj.Font                  = [System.Drawing.Font]::new('Microsoft Sans Serif', 10, [System.Drawing.FontStyle]::Bold)
        `$obj.ForeColor             = 'red'
    }
    `$Script.Controls.Add(`$obj)
    `$obj
}
function Domains { 
    `$Domain_UPN.Items.Clear()
    `$Domain_UPN.Items.Add('-- Please select one --')
    `$UPN_Name                      = Get-adforest | select RootDomain,UPNSuffixes
    `$etellerandet                  = @(`$UPN_Name.RootDomain) + @(`$UPN_Name.UPNSuffixes)
    @(`$etellerandet) | ForEach-Object {[void] `$Domain_UPN.Items.Add(`$_)}
    `$Domain_UPN.SelectedIndex      = 0
}
function Countries {
    `$Country.Items.Clear()
    `$Country.Items.Add('-- Please select one --')
    `$Country_Name.Keys | sort-object | ForEach-Object {[void] `$Country.Items.Add(`$_)}
    `$Country.SelectedIndex = 0
}
function AccessRights { 
    `$Domain_UPN.Items.Clear()
    `$UPN_Name = Get-adforest | select RootDomain,UPNSuffixes
    `$etellerandet = @(`$UPN_Name.RootDomain) + @(`$UPN_Name.UPNSuffixes)
    @(`$etellerandet) | ForEach-Object {[void] `$Domain_UPN.Items.Add(`$_)}
}
`$requiredFields                    = $requiredFields
`$testpath = Test-Path -Path C:\Scripts
If (`$testpath -eq `$false){
    new-Item -ItemType Directory -Force -Path C:\Scripts
}
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
`$Script                            = New-Object system.Windows.Forms.Form
`$Script.ClientSize                 = New-Object System.Drawing.Point(700,525)
`$Script.text                       = 'User Creation Script'
`$Script.TopMost                    = `$false
`$General                           = Making 'General' `$false `$false 20 40 95 20 `$true System.Windows.Forms.Label `$false
`$Address                           = Making 'Address' `$false `$false 150 40 95 20 `$true System.Windows.Forms.Label `$false
`$Profile_header                    = Making 'Profile' `$false `$false 280 40 95 20 `$true System.Windows.Forms.Label `$false
`$Telephones                        = Making 'Telephones' `$false `$false 410 40 95 20 `$true System.Windows.Forms.Label `$false
`$Organization                      = Making 'Organization' `$false `$false 540 40 95 20 `$true System.Windows.Forms.Label `$false
`$Select_License                    = Making 'Click here to select licenses to be assigned' `$false `$false 725 40 250 40 `$false System.Windows.Forms.Button `$false
`$Selected_license_Text             = Making 'Licenses selected:' `$false `$false 725 100 95 20 `$true System.Windows.Forms.Label `$false
`$Selected_license                  = Making "" `$true `false 725 125 250 300 `$false System.Windows.Forms.TextBox `$false
`$Selected_license.multiline        = `$true
`$Selected_license.ReadOnly         = `$true
`$Exit                              = Making 'Exit' `$false `$false 570 480 100 30 `$false System.Windows.Forms.Button `$false
`$Create_User                       = Making 'Create User' `$false `$false 450 480 100 30 `$false System.Windows.Forms.Button `$false
`$Exit.Add_Click({ Exit_Button })
`$Create_User.Add_Click({ Create_User })
`$Select_License.Add_Click({ O365_GUI })
`$Create_User.Enabled=`$false
function Validate-IsEmptyTrim (`$Validate, `$label){
    if (`$Validate.Text.Length -eq 0 -or (`$Validate -match 'System.Windows.Forms.ComboBox' -and (`$Validate.SelectedIndex -le 0 -or `$Validate.SelectedItem -eq `$null))) {
        `$label.Font                = [System.Drawing.Font]::new('Microsoft Sans Serif', 10, [System.Drawing.FontStyle]::Bold)
        `$label.ForeColor           = 'red'
    } else {
        `$label.Font                = [System.Drawing.Font]::new('Microsoft Sans Serif', 10, [System.Drawing.FontStyle]::Regular)
        `$label.ForeColor           = 'black'
    }
    if($RequiredValue){
        if (`$OU_Drop.SelectedItem -ne "-- Please select one --" -and `$Domain_UPN.SelectedItem -ne "-- Please select one --" $country_validation){
            `$Create_User.Enabled       = `$true
        } else {
            `$Create_User.Enabled       = `$false
        }
    } else{
        `$Create_User.Enabled       = `$false
	}
}
function OU {
    `$OU_Drop.Items.Clear()
    `$OU_Drop.Items.Add('-- Please select one --')
    Get-ADOrganizationalUnit -filter * | select DistinguishedName | ForEach-Object {[void] `$OU_Drop.Items.Add(`$_.DistinguishedName)}
    `$OU_Drop.SelectedIndex         = 0
}
"@
    Add-Content -path $filename $1_export
    red_white_validate $General_Copy_from "`$Copy_From_Initials_Label           = Making 'Copy From Initials' `$false `$false 20 60 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Copy_From_Initials')" '$Copy_From_Initials                 = Making "" $true $false 20 80 125 20 $false System.Windows.Forms.TextBox $false' "`$Copy_From_Initials.Add_TextChanged({Validate-IsEmptyTrim `$Copy_From_Initials `$Copy_From_Initials_Label})" '' ''
    red_white_validate $General_Initials "`$OU_Label                          = Making 'OU Location' `$false `$false 230 410 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$OU_Drop')" "`$OU_Drop                           = Making '' `$false `$false 230 430 440 20 `$false System.Windows.Forms.ComboBox `$false" "`$OU_Drop.Add_DropDown({ OU })" 'OU' '$OU_Drop.Add_SelectedIndexChanged({Validate-IsEmptyTrim $OU_Drop $OU_Label})'
    red_white_validate $General_Initials "`$Initials_Label                    = Making 'Initials' `$false `$false 20 110 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Initials')" '$Initials                          = Making "" $true $false 20 130 125 20 $false System.Windows.Forms.TextBox $false' "`$Initials.Add_TextChanged({Validate-IsEmptyTrim `$Initials `$Initials_Label})" '' ''
    red_white_validate $General_FirstName "`$First_name_Label                  = Making 'First name' `$false `$false 20 160 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$First_name')" '$First_name                        = Making "" $true $false 20 180 125 20 $false System.Windows.Forms.TextBox $false' "`$First_name.Add_TextChanged({Validate-IsEmptyTrim `$First_name `$First_name_Label})" '' ''
    red_white_validate $General_LastName "`$Last_name_Label                   = Making 'Last name' `$false `$false 20 210 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Last_name')" '$Last_name                         = Making "" $true $false 20 230 125 20 $false System.Windows.Forms.TextBox $false' "`$Last_name.Add_TextChanged({Validate-IsEmptyTrim `$Last_name `$Last_name_Label})" '' ''
    red_white_validate $General_Description "`$Description_Label                       = Making 'Description' `$false `$false 20 260 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Description')" '$Description                 = Making "" $true $false 20 280 125 20 $false System.Windows.Forms.TextBox $false' "`$Description.Add_TextChanged({Validate-IsEmptyTrim `$Description `$Description_Label})" '' ''
    red_white_validate $General_Telephone_Number "`$Phone_Label                        = Making 'Telephone' `$false `$false 20 310 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Phone')" '$Phone                 = Making "" $true $false 20 330 125 20 $false System.Windows.Forms.TextBox $false' "`$Phone.Add_TextChanged({Validate-IsEmptyTrim `$Phone `$Phone_Label})" '' ''
    red_white_validate $General_Web_page "`$Web_page_Label                          = Making 'Web page' `$false `$false 20 360 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Web_page')" '$Web_page                 = Making "" $true $false 20 380 125 20 $false System.Windows.Forms.TextBox $false' "`$Web_page.Add_TextChanged({Validate-IsEmptyTrim `$Web_page `$Web_page_Label})" '' ''
    red_white_validate $Address_Street "`$Address_street_Label                    = Making 'Address street' `$false `$false 150 60 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Address_street')" '$Address_street                 = Making "" $true $false 150 80 125 20 $false System.Windows.Forms.TextBox $false' "`$Address_street.Add_TextChanged({Validate-IsEmptyTrim `$Address_street `$Address_street_Label})" '' ''
    red_white_validate $Address_City "`$City_Label                              = Making 'City' `$false `$false 150 110 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$City')" '$City                 = Making "" $true $false 150 130 125 20 $false System.Windows.Forms.TextBox $false' "`$City.Add_TextChanged({Validate-IsEmptyTrim `$City `$City_Label})" '' ''
    red_white_validate $Address_State_Province "`$State_Province_Label                    = Making 'State/Province' `$false `$false 150 160 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$State_Province')" '$State_Province                 = Making "" $true $false 150 180 125 20 $false System.Windows.Forms.TextBox $false' "`$State_Province.Add_TextChanged({Validate-IsEmptyTrim `$State_Province `$State_Province_Label})" '' ''
    red_white_validate $Address_Zip_Postal_Code "`$ZIP_Postal_Code_Label                   = Making 'ZIP/Postal Code' `$false `$false 150 210 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$ZIP_Postal_Code')" '$ZIP_Postal_Code                 = Making "" $true $false 150 230 125 20 $false System.Windows.Forms.TextBox $false' "`$ZIP_Postal_Code.Add_TextChanged({Validate-IsEmptyTrim `$ZIP_Postal_Code `$ZIP_Postal_Code_Label})" '' ''
    red_white_validate $Profile_Profile_Path "`$Profile_path_Label                      = Making 'Profile path' `$false `$false 280 60 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Profile_path')" '$Profile_path                 = Making "" $true $false 280 80 125 20 $false System.Windows.Forms.TextBox $false' "`$Profile_path.Add_TextChanged({Validate-IsEmptyTrim `$Profile_path `$Profile_path_Label})" '' ''
    red_white_validate $Profile_Logon_Script "`$Logon_script_Label                      = Making 'Logon script' `$false `$false 280 110 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Logon_script')" '$Logon_script                 = Making "" $true $false 280 130 125 20 $false System.Windows.Forms.TextBox $false' "`$Logon_script.Add_TextChanged({Validate-IsEmptyTrim `$Logon_script `$Logon_script_Label})" '' ''
    red_white_validate $Profile_Local_Path "`$Local_path_Label                        = Making  'Local path' `$false `$false 280 160 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Local_path')"  '$Local_path                 = Making "" $true $false 280 180 125 20 $false System.Windows.Forms.TextBox $false' "`$Local_path.Add_TextChanged({Validate-IsEmptyTrim `$Local_path `$Local_path_Label})" '' ''
    red_white_validate $Profile_Connect "`$Connect_x_path_Label                    = Making 'Connect x-path' `$false `$false 280 210 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Connect_x_path')" '$Connect_x_path                 = Making "" $true $false 280 230 125 20 $false System.Windows.Forms.TextBox $false' "`$Connect_x_path.Add_TextChanged({Validate-IsEmptyTrim `$Connect_x_path `$Connect_x_path_Label})" '' ''
    red_white_validate $Profile_Connect "`$Homedrive_Label                    = Making 'Drive:' `$false `$false 410 210 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Homedrive')" '$Homedrive                 = Making "" $true $false 410 230 125 20 $false System.Windows.Forms.TextBox $false' "`$Homedrive.Add_TextChanged({Validate-IsEmptyTrim `$Homedrive `$Homedrive_Label})" '$Homedrive_Label.Forecolor = "red"' "`$Homedrive_Label.Font = [System.Drawing.Font]::new('Microsoft Sans Serif', 10, [System.Drawing.FontStyle]::Bold)"
    red_white_validate $Telephones_Home "`$Telephones_Home_Label                   = Making 'Home' `$false `$false 410 60 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Telephones_Home')" '$Telephones_Home                 = Making "" $true $false 410 80 125 20 $false System.Windows.Forms.TextBox $false' "`$Telephones_Home.Add_TextChanged({Validate-IsEmptyTrim `$Telephones_Home `$Telephones_Home_Label})" '' ''
    red_white_validate $Telephones_Mobile "`$Mobile_Label                            = Making 'Mobile' `$false `$false 410 110 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Mobile')" '$Mobile                 = Making "" $true $false 410 130 125 20 $false System.Windows.Forms.TextBox $false' "`$Mobile.Add_TextChanged({Validate-IsEmptyTrim `$Mobile `$Mobile_Label})" '' ''
    red_white_validate $Telephones_Fax "`$Fax_Label                               = Making 'Fax' `$false `$false 410 160 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Fax')" '$Fax                 = Making "" $true $false 410 180 125 20 $false System.Windows.Forms.TextBox $false' "`$Fax.Add_TextChanged({Validate-IsEmptyTrim `$Fax `$Fax_Label})" '' ''
    red_white_validate $Organization_Job_Title "`$Job_Title_Label                         = Making 'Job Title' `$false `$false 540 60 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Job_Title')" '$Job_Title                 = Making "" $true $false 540 80 125 20 $false System.Windows.Forms.TextBox $false' "`$Job_Title.Add_TextChanged({Validate-IsEmptyTrim `$Job_Title `$Job_Title_Label})" '' ''
    red_white_validate $Organization_Department "`$Department_Label                        = Making 'Department' `$false `$false 540 110 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Department')" '$Department                 = Making "" $true $false 540 130 125 20 $false System.Windows.Forms.TextBox $false' "`$Department.Add_TextChanged({Validate-IsEmptyTrim `$Department `$Department_Label})" '' ''
    red_white_validate $Organization_Company "`$Company_Label                           = Making 'Company' `$false `$false 540 160 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Company')" '$Company                 = Making "" $true $false 540 180 125 20 $false System.Windows.Forms.TextBox $false' "`$Company.Add_TextChanged({Validate-IsEmptyTrim `$Company `$Company_Label})" ''
    red_white_validate $Organization_Manager "`$Manager_Label                           = Making 'Manager initials' `$false `$false 540 210 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Manager')" '$Manager                 = Making "" $true $false 540 230 125 20 $false System.Windows.Forms.TextBox $false' "`$Manager.Add_TextChanged({Validate-IsEmptyTrim `$Manager `$Manager_Label})" '' ''
    red_white_validate $General_Domain "`$Domain_UPN_Label                  = Making '@Domain.xx' `$false `$false 20 410 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Domain_UPN')" '$Domain_UPN                        = Making "" $false $false 20 430 180 20 $false System.Windows.Forms.ComboBox $false' "`$Domain_UPN.Add_DropDown({ Domains })" 'Domains' '$Domain_UPN.Add_SelectedIndexChanged({Validate-IsEmptyTrim $Domain_UPN $Domain_UPN_Label})'
    Add-Content -path $filename $3_export
    export_check $General_Copy_From "" "`$Copy_From_Initials.Add_Leave({" $true
    export_check $General_Copy_From "" "    `$global:Copy_From1 = `$Copy_From_Initials.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' ' " $true
    export_check $General_Copy_From "" "    `$copy = Get-ADUser -identity `$global:Copy_From1 -property * | Select City,PostalCode,State,Company,Department,Manager,Profilepath,ScriptPath,HomeDirectory,HomeDrive,HomePage,UserPrincipalName, co, DistinguishedName" $true
    export_check $General_Copy_From "" '    try {$get_manager = (Get-ADUser "$Manager1") | select SamAccountName, DistinguishedName} catch {}' $true
    export_check $General_Copy_From $Organization_Manager '    $Manager1 = $copy.Manager' $false
    export_check $General_Copy_From $Organization_Manager '    $get_manager = (Get-ADUser "$Manager1") | select SamAccountName, DistinguishedName' $false
    export_check $General_Copy_From $General_Web_page "    `$Web_page.Text = `$copy.HomePage" $false
    export_check $General_Copy_from $General_Domain '    $DistinguishedName = $copy.DistinguishedName' $false
    export_check $General_Copy_from $General_Domain '    $splitted = $DistinguishedName.split(",")' $false
    export_check $General_Copy_from $General_Domain '    $OU_Drop.SelectedIndex = $OU_Drop.Items.IndexOf(($splitted[1..($splitted.Length+1)] -join(",")))' $false
    export_check $General_Copy_from $General_Domain '    $domain = $copy.UserPrincipalName' $false
    export_check $General_Copy_from $General_Domain '    $domain_splitted = $domain.IndexOf("@")+1' $false
    export_check $General_Copy_from $General_Domain '    $domain_length = $domain.Length-$domain_splitted' $false
    export_check $General_Copy_from $General_Domain '    $domain_sub = $domain.Substring($domain_splitted, $domain_length)' $false
    export_check $General_Copy_from $General_Domain '    $select_domain = $Domain_UPN.Items.where({$_ -eq $domain_sub})' $false
    export_check $General_Copy_from $General_Domain '    $Domain_UPN.SelectedItem = $select_domain.Item(0)' $false
    export_check $General_Copy_From $Address_City "    `$City.Text = `$copy.City" $false
    export_check $General_Copy_From $Address_State_Province "    `$State_Province.Text = `$copy.State" $false
    export_check $General_Copy_From $Address_Zip_Postal_Code "    `$ZIP_Postal_Code.Text = `$copy.PostalCode" $false
    export_check $General_Copy_from $Address_Country_Region '    $co = $copy.co' $false
    export_check $General_Copy_from $Address_Country_Region '    $chosen_country = $Country_Name.Keys.where({$_ -eq $co})' $false
    export_check $General_Copy_from $Address_Country_Region '    $Country.SelectedItem = $chosen_country.Item(0)' $false
    export_check $General_Copy_From $Profile_Profile_Path "    `$Profile_path.Text = `$copy.Profilepath" $false
    export_check $General_Copy_From $Profile_Logon_Script "    `$Logon_script.Text = `$copy.ScriptPath" $false
    export_check $General_Copy_From $Profile_Local_Path "    `$Local_path.Text = `$copy.HomeDirectory" $false
    export_check $General_Copy_From $Profile_Connect "    `$Connect_x_path.Text = `$copy.HomeDirectory" $false
    export_check $General_Copy_From $Profile_Connect "    `$Homedrive.Text = `$copy.HomeDrive" $false
    export_check $General_Copy_From $Organization_Department "    `$Department.Text = `$copy.Department" $false
    export_check $General_Copy_From $Organization_Company "    `$Company.Text = `$copy.Company" $false
    export_check $General_Copy_From $Organization_Manager '    $Manager.Text = $get_manager.SamAccountName' $false
    export_check $General_Copy_From "" "})" $true
    export_check $SD_Agreement $Next_SD_Agreement_Blue_White "`$Blue = Making 'SD Agreement Blue Collar' `$false `$true 430 370 95 20 `$true System.Windows.Forms.CheckBox"
    export_check $SD_Agreement $Next_SD_Agreement_Blue_White "`$Blue.Add_Click({ `$White.checked = `$False})"
    export_check $SD_Agreement $Next_SD_Agreement_Blue_White "`$White = Making 'SD Agreement White Collar' `$false `$true 430 390 95 20 `$true System.Windows.Forms.CheckBox"
    export_check $SD_Agreement $Next_SD_Agreement_Blue_White "`$White.Add_Click({ `$Blue.checked = `$False})"
    export_check $SD_Agreement $Next_SD_Agreement_Blue_White "`$White.checked = `$true"

    $2_export = @"
`$global:Country_Name = @{
    "Afghanistan" = "AF,004"
    "Aaland Islands" = "AX,248"
    "Albania" = "AL,008"
    "Algeria" = "DZ,012"
    "American Samoa" = "AS,016"
    "Andorra" = "AD,020"
    "Angola" = "AO,024"
    "Anguilla" = "AI,660"
    "Antarctica" = "AQ,010"
    "Antigua and Barbuda" = "AG,028"
    "Argentina" = "AR,032"
    "Armenia" = "AM,051"
    "Aruba" = "AW,533"
    "Australia" = "AU,036"
    "Austria" = "AT,040"
    "Azerbaijan" = "AZ,031"
    "Bahamas" = "BS,044"
    "Bahrain" = "BH,048"
    "Bangladesh" = "BD,050"
    "Barbados" = "BB,052"
    "Belarus" = "BY,112"
    "Belgium" = "BE,056"
    "Belize" = "BZ,084"
    "Benin" = "BJ,204"
    "Bermuda" = "BM,060"
    "Bhutan" = "BT,064"
    "Bolivia (Plurinational State of)" = "BO,068"
    "Bonaire, Sint Eustatius and Saba" = "BQ,535"
    "Bosnia and Herzegovina" = "BA,070"
    "Botswana" = "BW,072"
    "Bouvet Island" = "BV,074"
    "Brazil" = "BR,076"
    "British Indian Ocean Territory" = "IO,086"
    "Brunei Darussalam" = "BN,096"
    "Bulgaria" = "BG,100"
    "Burkina Faso" = "BF,854"
    "Burundi" = "BI,108"
    "Cabo Verde" = "CV,132"
    "Cambodia" = "KH,116"
    "Cameroon" = "CM,120"
    "Canada" = "CA,124"
    "Cayman Islands" = "KY,136"
    "Central African Republic" = "CF,140"
    "Chad" = "TD,148"
    "Chile" = "CL,152"
    "China" = "CN,156"
    "Christmas Island" = "CX,162"
    "Cocos (Keeling) Islands" = "CC,166"
    "Colombia" = "CO,170"
    "Comoros" = "KM,174"
    "Congo" = "CG,178"
    "Congo (Democratic Republic of the)" = "CD,180"
    "Cook Islands" = "CK,184"
    "Costa Rica" = "CR,188"
    "CÃ´te d Ivoire" = "CI,384"
    "Croatia" = "HR,191"
    "Cuba" = "CU,192"
    "CuraÃ§ao" = "CW,531"
    "Cyprus" = "CY,196"
    "Czechia" = "CZ,203"
    "Denmark" = "DK,208"
    "Djibouti" = "DJ,262"
    "Dominica" = "DM,212"
    "Dominican Republic" = "DO,214"
    "Ecuador" = "EC,218"
    "Egypt" = "EG,818"
    "El Salvador" = "SV,222"
    "Equatorial Guinea" = "GQ,226"
    "Eritrea" = "ER,232"
    "Estonia" = "EE,233"
    "Eswatini" = "SZ,748"
    "Ethiopia" = "ET,231"
    "Falkland Islands (Malvinas)" = "FK,2387"
    "Faroe Islands" = "FO,234"
    "Fiji" = "FJ,242"
    "Finland" = "FI,246"
    "France" = "FR,250"
    "French Guiana" = "GF,254"
    "French Polynesia" = "PF,258"
    "French Southern Territories" = "TF,260"
    "Gabon" = "GA,266"
    "Gambia" = "GM,270"
    "Georgia" = "GE,268"
    "Germany" = "DE,276"
    "Ghana" = "GH,288"
    "Gibraltar" = "GI,292"
    "Greece" = "GR,300"
    "Greenland" = "GL,304"
    "Grenada" = "GD,308"
    "Guadeloupe" = "GP,312"
    "Guam" = "GU,316"
    "Guatemala" = "GT,320"
    "Guernsey" = "GG,831"
    "Guinea" = "GN,324"
    "Guinea-Bissau" = "GW,624"
    "Guyana" = "GY,328"
    "Haiti" = "HT,332"
    "Heard Island and McDonald Islands" = "HM,334"
    "Holy See" = "VA,336"
    "Honduras" = "HN,340"
    "Hong Kong" = "HK,344"
    "Hungary" = "HU,348"
    "Iceland" = "IS,352"
    "India" = "IN,356"
    "Indonesia" = "ID,360"
    "Iran (Islamic Republic of)" = "IR,364"
    "Iraq" = "IQ,364"
    "Ireland" = "IE,372"
    "Isle of Man" = "IM,833"
    "Israel" = "IL,376"
    "Italy" = "IT,380"
    "Jamaica" = "JM,388"
    "Japan" = "JP,392"
    "Jersey" = "JE,832"
    "Jordan" = "JO,400"
    "Kazakhstan" = "KZ,398"
    "Kenya" = "KE,404"
    "Kiribati" = "KI,296"
    "Korea (Democratic Peoples Republic of)" = "KP,4087"
    "Korea (Republic of)" = "KR,410"
    "Kuwait" = "KW,414"
    "Kyrgyzstan" = "KG,417"
    "Lao Peoples Democratic Republic" = "LA,418"
    "Latvia" = "LV,428"
    "Lebanon" = "LB,422"
    "Lesotho" = "LS,426"
    "Liberia" = "LR,430"
    "Libya" = "LY,434"
    "Liechtenstein" = "LI,438"
    "Lithuania" = "LT,440"
    "Luxembourg" = "LU,442"
    "Macao" = "MO,446"
    "Macedonia (the former Yugoslav Republic of)" = "MK,807"
    "Madagascar" = "MG,450"
    "Malawi" = "MW,454"
    "Malaysia" = "MY,458"
    "Maldives" = "MV,462"
    "Mali" = "ML,466"
    "Malta" = "MT,470"
    "Marshall Islands" = "MH,584"
    "Martinique" = "MQ,474"
    "Mauritania" = "MR,478"
    "Mauritius" = "MU,480"
    "Mayotte" = "YT,170"
    "Mexico" = "MX,484"
    "Micronesia (Federated States of)" = "FM,583"
    "Moldova (Republic of)" = "MD,498"
    "Monaco" = "MC,492"
    "Mongolia" = "MN,496"
    "Montenegro" = "ME,499"
    "Montserrat" = "MS,500"
    "Morocco" = "MA,504"
    "Mozambique" = "MZ,508"
    "Myanmar" = "MM,104"
    "Namibia" = "NA,516"
    "Nauru" = "NR,520"
    "Nepal" = "NP,524"
    "Netherlands" = "NL,528"
    "New Caledonia" = "NC,540"
    "New Zealand" = "NZ,554"
    "Nicaragua" = "NI,558"
    "Niger" = "NE,562"
    "Nigeria" = "NG,566"
    "Niue" = "NU,570"
    "Norfolk Island" = "NF,574"
    "Northern Mariana Islands" = "MP,580"
    "Norway" = "NO,578"
    "Oman" = "OM,512"
    "Pakistan" = "PK,586"
    "Palau" = "PW,585"
    "Palestine, State of" = "PS,275"
    "Panama" = "PA,591"
    "Papua New Guinea" = "PG,598"
    "Paraguay" = "PY,600"
    "Peru" = "PE,604"
    "Philippines" = "PH,608"
    "Pitcairn" = "PN,612"
    "Poland" = "PL,161"
    "Portugal" = "PT,620"
    "Puerto Rico" = "PR,630"
    "Qatar" = "QA,634"
    "RÃ©union" = "RE,638"
    "Romania" = "RO,642"
    "Russian Federation" = "RU,643"
    "Rwanda" = "RW,646"
    "Saint BarthÃ©lemy" = "BL,652"
    "Saint Helena, Ascension and Tristan da Cunha" = "SH,654"
    "Saint Kitts and Nevis" = "KN,659"
    "Saint Lucia" = "LC,662"
    "Saint Martin (French part)" = "MF,663"
    "Saint Pierre and Miquelon" = "PM,666"
    "Saint Vincent and the Grenadines" = "VC,670"
    "Samoa" = "WS,882"
    "San Marino" = "SM,674"
    "Sao Tome and Principe" = "ST,678"
    "Saudi Arabia" = "SA,682"
    "Senegal" = "SN,686"
    "Serbia" = "RS,688"
    "Seychelles" = "SC,690"
    "Sierra Leone" = "SL,694"
    "Singapore" = "SG,702"
    "Sint Maarten (Dutch part)" = "SX,534"
    "Slovakia" = "SK,703"
    "Slovenia" = "SI,705"
    "Solomon Islands" = "SB,090"
    "Somalia" = "SO,706"
    "South Africa" = "ZA,710"
    "South Georgia and the South Sandwich Islands" = "GS,239"
    "South Sudan" = "SS,728"
    "Spain" = "ES,724"
    "Sri Lanka" = "LK,144"
    "Sudan" = "SD,729"
    "Suriname" = "SR,740"
    "Svalbard and Jan Mayen" = "SJ,744"
    "Sweden" = "SE,752"
    "Switzerland" = "CH,756"
    "Syrian Arab Republic" = "SY,760"
    "Taiwan, Province of China[a]" = "TW,158"
    "Tajikistan" = "TJ,762"
    "Tanzania, United Republic of" = "TZ,834"
    "Thailand" = "TH,764"
    "Timor-Leste" = "TL,626"
    "Togo" = "TG,768"
    "Tokelau" = "TK,772"
    "Tonga" = "TO,776"
    "Trinidad and Tobago" = "TT,780"
    "Tunisia" = "TN,788"
    "Turkey" = "TR,792"
    "Turkmenistan" = "TM,795"
    "Turks and Caicos Islands" = "TC,796"
    "Tuvalu" = "TV,798"
    "Uganda" = "UG,800"
    "Ukraine" = "UA,804"
    "United Arab Emirates" = "AE,784"
    "United Kingdom of Great Britain and Northern Ireland" = "GB,826"
    "United States of America" = "US,840"
    "United States Minor Outlying Islands" = "UM,581"
    "Uruguay" = "UY,858"
    "Uzbekistan" = "UZ,860"
    "Vanuatu" = "VU,548"
    "Venezuela (Bolivarian Republic of)" = "VE,862"
    "Viet Nam" = "VN,704"
    "Virgin Islands (British)" = "VG,092"
    "Virgin Islands (U.S.)" = "VI,850"
    "Wallis and Futuna" = "WF,876"
    "Western Sahara" = "EH,732"
    "Yemen" = "YE,887"
    "Zambia" = "ZM,894"
    "Zimbabwe" = "ZW,716"
}
"@

    if ($Address_Country_Region.Checked) {
        Add-Content -path $filename $2_export
    }
    red_white_validate $Address_Country_Region "`$Country_Label                     = Making 'Country' `$false `$false 150 260 95 20 `$true System.Windows.Forms.Label `$requiredFields.Contains('`$Country')" '$Country                           = Making "" $false $false 150 280 180 20 $false System.Windows.Forms.ComboBox $false' '$Country.Add_DropDown({ Countries })' 'Countries' '$Country.Add_SelectedIndexChanged({Validate-IsEmptyTrim $Country $Country_Label})'
    $Export_LicenseGUI =@"
function O365_GUI {
    `$Selected_license.Text = ""
    `$O365_Script                            = New-Object system.Windows.Forms.Form
    `$O365_Script.ClientSize                 = New-Object System.Drawing.Point(400,375)
    `$O365_Script.text                       = 'Please select the license you would like'
    `$O365_Script.TopMost                    = `$false
    `$Global:O365_Lic                               = Making "" `$false `$false 20 20 350 300 `$false System.Windows.Forms.CheckedListBox `$false
    `$O365_Lic.CheckOnClick = `$true
    `$O365_Button                            = Making "OK" `$false `$false 320 320 50 30 `$false System.Windows.Forms.Button `$false
    `$O365_Script.Controls.AddRange(@(`$O365_Lic,`$O365_Button))
    `$O365_Button.Add_Click({ O365_OK })
    `$Avaialble = Get-MsolAccountSku | Where-Object { `$_.ActiveUnits -ne `$_.ConsumedUnits }
    `$LicenseArray = @()
    `$accountSku = @{}
    foreach (`$item in `$Avaialble) {
        `$RemoveDomain = (`$item).AccountSkuId
        `$LicenseItem = `$RemoveDomain -split ":" | Select-Object -Last 1
        `$AddDomain = `$RemoveDomain -split ":" | Select-Object -First 1
        `$Global:FullDomain = `$AddDomain + ":"
        `$TextLic = `$Sku.Item("`$LicenseItem")
        `$accountSku.Add(`$Sku.Item("`$LicenseItem"), `$item.AccountSkuId)
        If (!(`$TextLic)) {
            `$LicenseArray += `$LicenseItem
        }
        Else {
            `$LicenseArray += `$TextLic
        } 
    }
    `$O365_Lic.Items.AddRange(`$LicenseArray)

    function O365_OK {
        `$Selected_license.Text = ""
        foreach (`$License_Select in `$O365_Lic.CheckedItems){
            `$Selected_license.Text = `$Selected_license.Text + "`r`n" + `$License_Select
            `$O365_assign = `$SkuLic
            `$value = `$accountSku.Item("`$License_Select")
        }
        [void]`$O365_Script.Close()
    }
    [void]`$O365_Script.ShowDialog()
}
"@
    
    if ($Office365.Checked -or $Exchange_Hybrid_O365.Checked){
        Add-Content -path $filename $Export_LicenseGUI
    }

    $3_export =@"
function Exit_Button {
    [void]`$Script.Close()
}
function Create_User {
"@
    Add-Content -path $filename $3_export
    export_check_create_User $General_Initials "    `$initials1 = `$Initials.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $General_FirstName "    `$FirstName1 = `$First_name.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $General_LastName "    `$LastName1 = `$Last_name.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $General_FirstName "    `$FullName1 = `$FirstName1 + ' ' + `$LastName1"
    export_check_create_User $General_Domain "    `$domain1 = '@' + `$Domain_UPN.SelectedItem"
    export_check_create_User $General_Domain "    `$UPN1 = `$initials1 + `$domain1"
    export_check_create_User $General_Description "    `$Description1 = `$Description.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' ' "
    export_check_create_User $General_Telephone_Number "    `$Telephone1 = `$Phone.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $General_Web_page "    `$Web_page1 = `$Web_page.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Address_Country_Region "    `$Country_Region1 = `$Country_Name.get_item(`$Country.SelectedItem)"
    export_check_create_User $Address_Country_Region "    `$Country_c = `$Country_Region1.Substring(0,2)"
    export_check_create_User $Address_Country_Region "    `$Country_CountryCode = `$Country_Region1.Substring(3,3)"
    export_check_create_User $Address_Country_Region "    `$Country_co = `$Country.SelectedItem"
    export_check_create_User $Address_Street "    `$Address_street1 = `$Address_street.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Address_City "    `$City1 = `$City.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Address_State_Province "    `$State_Province1 = `$State_Province.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Address_Zip_Postal_Code "    `$ZIP_Postal_Code1 = `$ZIP_Postal_Code.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Profile_Profile_Path "    `$Profile_path1 = `$Profile_path.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Profile_Logon_Script "    `$Logon_script1 = `$Logon_script.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Profile_Local_Path "    `$Local_path1 = `$Local_path.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Profile_Connect "    `$Connect_x_path1 = `$Connect_x_path.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Profile_Connect "    `$Homedrive1 = `$Homedrive.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Telephones_Home "    `$Home1 = `$Telephones_Home.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Telephones_Mobile "    `$Mobile1 = `$Mobile.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Telephones_Fax "    `$Fax1 = `$Fax.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Organization_Job_Title "    `$Job_Title1 = `$Job_Title.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Organization_Department "    `$Department1 = `$Department.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Organization_Company "    `$Company1 = `$Company.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $Organization_Manager "    `$Manager1 = `$Manager.Text -replace '(^\s+|\s+`$)','' -replace '\s+',' '"
    export_check_create_User $General_FirstName "    New-ADUser -GivenName `$FirstName1 -Surname `$LastName1 -DisplayName `$Fullname1 -Name `$Fullname1 -AccountPassword(Read-Host -AsSecureString 'Input Password') -SamAccountName `$initials1 -UserPrincipalName `$UPN1 -Enabled `$True -Description `$Description1 -OfficePhone `$Telephone1 -HomePage `$Web_page1 -StreetAddress `$Address_street1 -City `$City1 -State `$State_Province1 -PostalCode `$ZIP_Postal_Code1 -Profilepath `$Profile_path1 -ScriptPath `$Logon_script1 -HomePhone `$Home1 -mobile `$Mobile1 -Fax `$Fax1 -Title `$Job_Title1 -Department `$Department1 -Company `$Company1 -EmailAddress `$UPN1 -path `$OU_Drop.SelectedItem"
    export_check_create_User $Address_Country_Region '    set-aduser $initials1 -Replace @{co=$Country_co;c=$Country_c;CountryCode=$Country_CountryCode}'
    export_check_create_User $Organization_Manager "    set-aduser `$initials1 -Manager `$Manager1"
    export_check_create_User $Profile_Local_Path "    Set-ADUser -Identity `$initials1 -HomeDirectory `$Local_path1"
    export_check_create_User $Profile_Connect "    Set-ADUser -Identity `$initials1 -HomeDirectory `$Connect_x_path1 -HomeDrive `$Homedrive1"
    export_check_create_User $General_Initials "    Get-ADUser -Identity `$initials1 | set-aduser -replace @{mailNickname=`$initials1}"
    export_check_create_User $General_Copy_From '    $copy_groups = Get-ADPrincipalGroupMembership $global:Copy_From1 | select Name'
    export_check_create_User $General_Copy_From '    foreach ($group in $copy_groups.Name) {'
    export_check_create_User $General_Copy_From "       if(`$group -ne 'Domain Users'){"
    export_check_create_User $General_Copy_From '           Add-ADGroupMember -identity $group -members $initials1'
    export_check_create_User $General_Copy_From '       }'
    export_check_create_User $General_Copy_From '   }'
    $Exchange_Remote_Mailbox = @"
    Function RemoteMailbox {
        `$msoldomain = Get-MsolDomain | where IsInitial -eq `$true
        Invoke-command -session `$Global:PSSExch -scriptblock {enable-RemoteMailbox `$args[0] -RemoteRoutingAddress `$args[1]} -ArgumentList "`$initials1", "`$initials1@`$msoldomain.Name" -ErrorAction SilentlyContinue | Out-Null
        Start-Sleep 15
        `$Remote = Invoke-command -session `$Global:PSSExch -scriptblock {get-remotemailbox -identity `$args[0]} -ArgumentList "`$initials1"
    }

"@
    if ($Exchange_Hybrid_O365.Checked) {
        Add-Content -Path $filename $Exchange_Remote_Mailbox

    }
    $ADFS_export = @"
    `$counter = 0
    while(`$counter -lt 1){
        `$getuser365 = get-MsolUser -UserPrincipalName "`$UPN1" -ErrorAction SilentlyContinue
        if(`$getuser365 -eq `$null) {
            `$ErrorActionPreference = "SilentlyContinue"
            `$getaduser = Get-Aduser `$initials1
            if(`$getaduser -ne `$null){
                Invoke-Command -computername `$Global:ADConnect -scriptblock {start-adsyncsynccycle}
                Sleep 60
            }
            else {
                `$counter++
                continue
            }
            `$ErrorActionPreference = "Continue"
        }
        `$counter++
    }
    `$getuser365 = get-MsolUser -UserPrincipalName "`$UPN1" -ErrorAction SilentlyContinue
    if(`$getuser365 -ne `$null) {
        Set-MsolUser -UserPrincipalName "`$UPN1" -UsageLocation "`$Country_c"
        foreach (`$lic in `$O365_Lic.CheckedItems) {
            `$hashvalue = `$Sku.keys | Where-Object {`$Sku["`$_"] -eq `$lic}
            foreach (`$hash in `$hashvalue) {
                `$key = `$FullDomain + `$hash
                foreach (`$s in `$Avaialble.AccountSkuId) {
                    if (`$key -eq `$s) {
                        Set-MsolUserLicense -UserPrincipalName "`$UPN1" -AddLicenses "`$key"
                    }
                }
            }
        }
    }
"@

    if ($Office365.Checked -or $Exchange_Hybrid_O365.Checked) {
        Add-Content -Path $filename $ADFS_export

    }

    Add-Content -Path $filename '#If anything else needs to happen to the newly created user before the scripts ends it can be added here.'
    Add-Content -Path $filename '#For context you can use this as an example:'
    Add-Content -Path $filename '#Add-ADGroupMember -identity "adgroupname" -members $initials1'
    Add-Content -Path $filename ''
    Add-Content -Path $filename ''
    Add-Content -Path $filename 'Get-PSSession | Remove-PSSession'
    Add-Content -Path $filename '}'

if ($Office365.Checked) {
    Add-Content -Path $filename $4_export_Office365

} elseif ($Exchange.Checked) {
    Add-Content -Path $filename $4_export_exchnage

} elseif ($Exchange_Hybrid_O365.Checked) {
    Add-Content -Path $filename $4_export_exchange_Hybrid_O365

}
    

    Add-Content -Path $filename '[void]$Script.ShowDialog()'    
    Rename-Item -Path $filename -NewName "$global:filename_export User Creator.ps1"
######################################################################
#                       Create Shortcut                              #
######################################################################
$TargetFile = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
$ShortcutFile = "C:\Scripts\$global:filename_export User Creator.lnk"
$Arguments = "-ExecutionPolicy Bypass -File " +  '"' + "$global:filename_export User Creator.ps1" + '"' + " -WindowsStyle Hidden"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Arguments = $Arguments
$Shortcut.Save()
######################################################################
#                         End Shortcut                               #
######################################################################
######################################################################
#                        End of Export                               #
######################################################################
}
[void]$Form.ShowDialog()
