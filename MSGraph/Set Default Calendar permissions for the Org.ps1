Param(
    $TenantID = "",
    $ClientID = "",
    $Clientsecret = "",
    $Output_Changed_Permissions = "True", # True or False
    $Output_Users_With_Permissions_Already_In_Place = "False", # True or False
    $Output_Skipped_Users = "False", # True or False
    $Calendar_Permissions = "read" # The role permissions can be seen below:
)
# https://docs.microsoft.com/en-us/graph/api/resources/calendarpermission?view=graph-rest-1.0#calendarroletype-values
# Permissions is one of the following:
# none, freeBusyRead, limitedRead, read, write, delegateWithoutPrivateEventAccess, delegateWithPrivateEventAccess, custom


# Default Token Body
$tokenBody = @{
    Grant_Type = "client_credentials"
    Scope = "https://graph.microsoft.com/.default"
    Client_Id = $clientId
    Client_Secret = $clientSecret
}
# Request a Token
$tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token" -Method POST -Body $tokenBody

# Setting up the authorization headers 
$MicrosoftHeaders = @{
    "Authorization" = "Bearer $($tokenResponse.access_token)"
    "Content-type" = "application/json"
}

####
#calendar
$URL = "https://graph.microsoft.com/v1.0/users/"
$Users = Invoke-RestMethod -Method Get -Uri $URL -Headers $MicrosoftHeaders

foreach ($User in $Users.value) {
    # Check if the user has a serviceplan/license where exchange is activated
    $URL_Lic = $URL + $User.id + "/licenseDetails"
    $URL_User_Has_Lic = Invoke-RestMethod -Method Get -Uri $URL_Lic -Headers $MicrosoftHeaders

    if ($URL_User_Has_Lic.value.servicePlans.servicePlanName -like "*EXCHANGE*") {
        # If the user has a serviceplan with exchange do the following:
        # Get calendar permissions:
        $URL_Perm = $URL + $User.id + "/calendar/calendarPermissions"
        $URL_Cal_Perm = Invoke-RestMethod -Method Get -Uri $URL_Perm -Headers $MicrosoftHeaders
        $test = Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/v1.0/users/d997a40e-3e0a-4f67-baa8-f2c1d4721075/calendar/calendarPermissions/" -Headers $MicrosoftHeaders
        # Specifying that we only want to modify/check permissions of the primary calendar
        foreach ($Calendar in $URL_Cal_Perm.value.id) {
            # Get calendar permissions
            $URL_CAL_Permissions = $URL_Perm + "/RGVmYXVsdA=="
            $CAL_URL = Invoke-RestMethod -Method Get -Uri $URL_CAL_Permissions -Headers $MicrosoftHeaders
            if ($CAL_URL.role -ne $Calendar_Permissions){
                $Set_Cal_Perm = @"
                {
                    "role": "$Calendar_Permissions"
                }
"@
                try {
                    Invoke-RestMethod -Method Patch -Uri $URL_CAL_Permissions -Headers $MicrosoftHeaders -Body $Set_Cal_Perm | Out-Null
                    $Output_text = "Calendar permissions has been changed from " + $CAL_URL.role + " to " + $Calendar_Permissions + " for the user " + $User.mail
                }
                catch {
                    $Output_text = "Error: Unable to change calendar permissions for the user " + $User.mail
                }
                if ($Output_Changed_Permissions -eq "True") {
                    write-output $Output_text
                }
            } else {
                if ($Output_Users_With_Permissions_Already_In_Place -eq "True") {
                    $Output_text = "Permissions is already in place for the user " + $User.mail
                    write-output $Output_text
                }
            }
        }
    } else {
        # If the user does not have access to exchange do the following:
        if ($Output_Skipped_Users -eq "True"){
            $Output_text = "The following user does not have a license for exchange and will be skipped " + $User.mail
            Write-Output $Output_text
        }
    }
}
