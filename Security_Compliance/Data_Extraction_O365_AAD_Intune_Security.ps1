Param(
    $Tenant_Id = '', # Paste your own tenant ID here
    $App_Id = '', # Paste your own app ID here
    $App_Secret = '', # Paste your own app secret here
    $CSV_Path = 'C:\Temp\'
)

# function
function Data_Graph {
    param (
        $URL
    )
    try {
        $Body = @{
            client_id     = $App_Id
            scope         = "https://graph.microsoft.com/.default"
            client_secret = $App_Secret
            grant_type    = "client_credentials"
        }

        $Login_URL = "https://login.microsoftonline.com/$Tenant_Id/oauth2/v2.0/token"
        $O_Auth = Invoke-RestMethod -Method Post -Uri $Login_URL -Body $Body
        $Header_Params = @{'Authorization' = "$($O_Auth.token_type) $($O_Auth.access_token)" }
    }
    catch {
        Write-Output "Failed to get OAuth access token"
    }
    # Get data
    try {
        $Counter = 0
        $Query_Results = @()
        do {
            $Counter++
            Write-Output "Count: $Counter"
                
            $JSON_Response = Invoke-WebRequest -Method Get -Uri $URL -Headers $Header_Params -UseBasicParsing -ContentType "application/json"
            $Results = $JSON_Response.Content | ConvertFrom-Json 
            if ($Results.value) {
                $Query_Results += $Results.value
            }
            else {
                $Query_Results += $Results.value
            }
            $URL = $Results.'@odata.nextlink'
        } until (!($URL))
        $Query_Results
    }
    catch {
        Write-Output "Failed to access - Statuscode: $($JSON_Response.StatusCode)"    
    }
}

#user V2
$Sign_In_Activity = Data_Graph -URL 'https://graph.microsoft.com/beta/users?$select=displayName,userPrincipalName,signInActivity,accountEnabled,userType,onPremisesSyncEnabled'
$User_And_MFA = Data_Graph -URL 'https://graph.microsoft.com/beta/reports/credentialUserRegistrationDetails'

$Sign_In_Activity = $Sign_In_Activity | ForEach-Object { 
    $Sign_In = $Sign_In_Activity | Where-Object userPrincipalName -Like $_.userPrincipalName | Select-Object signInActivity
    $Last_Sign_In = $Sign_In.signInActivity.lastSignInDateTime

    $Non_Sign_In = $Sign_In_Activity | Where-Object userPrincipalName -Like $_.userPrincipalName | Select-Object signInActivity
    $Last_Non_Sign_In = $Non_Sign_In.signInActivity.lastNonInteractiveSignInDateTime

    $User_Properties = $Sign_In_Activity | Where-Object userPrincipalName -Like $_.userPrincipalName | Select-Object accountEnabled, userType, onPremisesSyncEnabled
    $User_Type = $User_Properties.userType
    $Account_Enabled = $User_Properties.accountEnabled
    $On_Prem_Sync = $User_Properties.onPremisesSyncEnabled

    $mfa = $User_And_MFA | Where-Object userPrincipalName -Like $_.userPrincipalName

    [PSCustomObject]@{
        "UserPrincipalName"                = $_.userPrincipalName
        "DisplayName"                      = $_.displayName
        "Registered SSPR"                  = $mfa.isRegistered
        "SSPR Enabled"                     = $mfa.isEnabled
        "Capable of SSPR or MFA"           = $mfa.isCapable
        "MfA Registered"                   = $mfa.isMfaRegistered
        "AuthMethods"                      = ($mfa.authMethods) -join ','
        "LastSignInDateTime"               = $Last_Sign_In
        "LastNonInteractiveSignInDateTime" = $Last_Non_Sign_In
        "UserType"                         = $User_Type
        "AccountEnabled"                   = $Account_Enabled
        "OnPremisesSyncEnabled"            = $On_Prem_Sync
    }
}
$Sign_In_Activity_Path = $CSV_Path + "Users.csv"
$Sign_In_Activity | Export-Csv -Path $Sign_In_Activity_Path -NoTypeInformation -Delimiter ";" -Encoding "UTF8"


#MFA conditionalAccess

$conditionalAccess = Data_Graph -URL "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies"
$Con_Access = foreach ($CA in $conditionalAccess) {
    $Object_Properties = @{
        DisplayName      = $ca.displayName
        createdDateTime  = $ca.createdDateTime 
        modifiedDateTime = $ca.modifiedDateTime
        state            = $ca.state
        clientAppTypes   = $CA.conditions.clientAppTypes -join ','
        includeLocations = $CA.conditions.locations.includeLocations -join ','
        excludeLocations = $CA.conditions.locations.excludeLocations -join ','
        builtInControls  = $CA.grantControls.builtInControls -join ','
        includeUsers     = $ca.conditions.users.includeUsers -join ','
        excludeUsers     = $ca.conditions.users.excludeUsers -join ','
        includeGroups    = $ca.conditions.users.includeGroups -join ','
        excludeGroups    = $ca.conditions.users.excludeGroups -join ','
        includeRoles     = $ca.conditions.users.includeRoles -join ','
        excludeRoles     = $ca.conditions.users.excludeRoles -join ','

    }
    New-Object psobject -Property $Object_Properties 
}
$Con_Access_Path = $CSV_Path + "Conditional_Access_Rules.csv"
$Con_Access | Select-Object DisplayName, createdDateTime, modifiedDateTime, state, clientAppTypes, includeLocations, excludeLocations, builtInControls, includeUsers, excludeUsers, includeGroups, excludeGroups, includeRoles, excludeRoles | Export-Csv -Path $Con_Access_Path -NoTypeInformation -Delimiter ";" -Encoding "UTF8"

#PC


$Machine_Responses_AAD = Data_Graph -URL "https://graph.microsoft.com/v1.0/devices"
$Machine_Responses_AAD = $Machine_Responses_AAD | Where-Object operatingSystem -Like "Windows"


$Resource_App_Id_Uri = 'https://securitycenter.onmicrosoft.com/windowsatpservice'
$O_AuthUri = "https://login.microsoftonline.com/$Tenant_Id/oauth2/token"
$Auth_Body = [Ordered] @{
    resource      = "$Resource_App_Id_Uri"
    client_id     = "$App_Id"
    client_secret = "$App_Secret"
    grant_type    = 'client_credentials'
}
$Auth_Response = Invoke-RestMethod -Method Post -Uri $O_AuthUri -Body $Auth_Body -UseBasicParsing -ErrorAction Stop 
$AAD_Token = $Auth_Response.access_token

$Alert_URL = "https://api.securitycenter.microsoft.com/api/machines"
$Headers = @{ 
    'Content-Type' = 'application/json'
    Accept         = 'application/json'
    Authorization  = "Bearer $AAD_Token" 
}
$Machine_Responses = Invoke-WebRequest -Method Get -Uri $Alert_URL -Headers $Headers -UseBasicParsing -ErrorAction Stop
$Machine_Responses = ($Machine_Responses | ConvertFrom-Json).value
$Machine_Responses = $Machine_Responses | Where-Object osPlatform -Like "Windows1?"


$Not_In_AAD = $Machine_Responses | Where-Object { $_.aadDeviceId -notin $Machine_Responses_AAD.deviceId }
$Not_In_AAD = $Not_In_AAD | Where-Object { $_.computerDnsName -notin $Machine_Responses_AAD.displayName }

$Not_In_ATP = $Machine_Responses_AAD | Where-Object { $_.deviceId -notin $Machine_Responses.aadDeviceId }
$Not_In_ATP = $Not_In_ATP | Where-Object { $_.displayName -notin $Machine_Responses_AAD.computerDnsName }

$Machine_Responses_AAD_To_CSV = foreach ($Item in $Machine_Responses_AAD) {
    if ($Item.deviceId -in $Machine_Responses.aadDeviceId) {
        $ATP = "True"
    }
    else {
        $ATP = "False"
    }
    $Count_D = $Machine_Responses_AAD | Where-Object displayName -Like $Item.displayName

    if ($Count_D.Count -lt 1) {
        $Display_Name = "False"
    }
    else {
        $Display_Name = "True"
    }
    $Owner_URL = "https://graph.microsoft.com/beta/devices/"
    $Owner_Req_URL = $Owner_URL + $Item.id + "/registeredOwners"
    $Owner = Data_Graph -URL $Owner_Req_URL | Select-Object displayName, userPrincipalName

    $Object_Properties = ([ordered]@{
            accountEnabled                = $Item.accountEnabled
            approximateLastSignInDateTime = $Item.approximateLastSignInDateTime
            createdDateTime               = $Item.createdDateTime
            deviceId                      = $Item.deviceId
            deviceOwnership               = $Item.deviceOwnership
            displayName                   = $Item.displayName
            UserDisplayName               = $Owner.displayName
            UserPricipalName              = $Owner.userPrincipalName
            domainName                    = $Item.domainName
            enrollmentProfileName         = $Item.enrollmentProfileName
            enrollmentType                = $Item.enrollmentType
            isCompliant                   = $Item.isCompliant
            isManaged                     = $Item.isManaged
            managementType                = $Item.managementType
            manufacturer                  = $Item.manufacturer
            model                         = $Item.model
            onPremisesSyncEnabled         = $Item.onPremisesSyncEnabled
            operatingSystem               = $Item.operatingSystem
            operatingSystemVersion        = $Item.operatingSystemVersion
            trustType                     = $Item.trustType 
            seebyATP                      = $ATP
            NotunidisplayName             = $Display_Name
        })
    New-Object psobject -Property $Object_Properties 
}


$Missing_KB_Update = foreach ($Item in $Machine_Responses) {
    $IDm = $Item.id
    #missingKBs
    $Alert_URL = "https://api.securitycenter.microsoft.com/api/machines/$IDm/getmissingkbs"
    $Headers = @{ 
        'Content-Type' = 'application/json'
        Accept         = 'application/json'
        Authorization  = "Bearer $AAD_Token" 
    }
    do {

        try {
            $Missing_KBs = Invoke-WebRequest -Method Get -Uri $Alert_URL -Headers $Headers  -UseBasicParsing -ErrorAction Stop
        }
        catch { 
            Start-Sleep -s 2

        }
    
    } until ($Missing_KBs)

    $Missing_KBs = ($Missing_KBs | ConvertFrom-Json).value
    foreach ($M_KBs in $Missing_KBs) {
        if ($M_KBs.id -ne $null) {
            $Object_Properties = @{
                KBID            = $M_KBs.id
                url             = $M_KBs.url
                WUname          = $M_KBs.name
                machineMissedOn = $M_KBs.machineMissedOn
                PCName          = $Item.computerDnsName
            }
            New-Object psobject -Property $Object_Properties 
        }
    }
}
$Missing_KB_Update_Path = $CSV_Path + "missingKBs.csv"
$Missing_KB_Update  | Export-Csv -Path $Missing_KB_Update_Path -NoTypeInformation -Delimiter ";" -Encoding "UTF8"

$Machine_Responses_AAD_Path = $CSV_Path + "machinesResponseazuread.csv"
$Machine_Responses_AAD_To_CSV | Export-Csv -Path $Machine_Responses_AAD_Path -NoTypeInformation -Delimiter ";" -Encoding "UTF8"

$Not_In_AAD_Path = $CSV_Path + "notinazureda.csv"
$Not_In_AAD | Export-Csv -Path $Not_In_AAD_Path -NoTypeInformation -Delimiter ";" -Encoding "UTF8"

$Not_In_ATP_Path = $CSV_Path + "notinATP.csv"
$Not_In_ATP | Export-Csv -Path $Not_In_ATP_Path -NoTypeInformation -Delimiter ";" -Encoding "UTF8"

$Security_Recommendationsdeics = foreach ($Item in $Machine_Responses) {
    $IDm = $Item.id
    $Alert_URL = "https://api.securitycenter.microsoft.com/api/machines/$IDm/recommendations"
    $Headers = @{ 
        'Content-Type' = 'application/json'
        Accept         = 'application/json'
        Authorization  = "Bearer $AAD_Token" 
    }

    do {

        try {
            $Security_Recommendations = Invoke-WebRequest -Method Get -Uri $Alert_URL -Headers $Headers  -UseBasicParsing -ErrorAction Stop
        }
        catch { 
            Start-Sleep -s 2
    
        }
        
    } until ($Security_Recommendations)
    $Security_Recommendations = ($Security_Recommendations | ConvertFrom-Json).value
    $Security_Recommendations = $Security_Recommendations | Where-Object { ($_.recommendationCategory -like "Application") -or ($_.recommendationName -like "*Onboard devices to Microsoft Defender for Endpoint*") -or ($_.recommendationName -like "*BitLocker*") -or ($_.recommendationName -like "*Turn on Microsoft Defender Antivirus*") -or ($_.recommendationName -like "*Update Microsoft Defender Antivirus definitions*") }
    foreach ($Security  in $Security_Recommendations) {
        $Object_Properties = @{
            recommendationName = $Security.recommendationName
            productName        = $Security.productName 
            relatedComponent   = $Security.relatedComponent
            subCategory        = $Security.subCategory
            vendor             = $Security.vendor
            PCName             = $Item.computerDnsName
            Lastseen           = $Item.lastSeen
        }
        New-Object psobject -Property $Object_Properties 
    }
}
$Security_Recommendations_Path = $CSV_Path + "securityrecommendations.csv"
$Security_Recommendationsdeics | Export-Csv -Path $Security_Recommendations_Path -NoTypeInformation -Delimiter ";" -Encoding "UTF8"

$Device_S_F | Format-List
$Device_S_F = Data_Graph -URL "https://graph.microsoft.com/v1.0/deviceManagement/managedDevices"

$Devices_Path = $CSV_Path + "Devices.csv"
$Device_S_F | Select-Object deviceName, managedDeviceOwnerType, operatingSystem, complianceState, osVersion, azureADRegistered, model, manufacturer, phoneNumber, userPrincipalName, userDisplayName, lastSyncDateTime | Export-Csv -Path $Devices_Path -NoTypeInformation -Delimiter ";" -Encoding "UTF8"

