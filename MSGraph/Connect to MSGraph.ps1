$TenantID = ""
$ClientID = ""
$Clientsecret = ""

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

# Definging the endpoint URL
$EndPoint = "https://graph.microsoft.com/"

# Adding to the URL
$Endpoint_Addon = "beta/users/"

# Defining the exact URL i would like data from or to
$RequestURL = $EndPoint + $Endpoint_Addon

# You can test connection your connection to data with this command:
# Please remember that the app in this case needs atleast the following permissions:
# User.Read.All
Invoke-RestMethod -Method Get -Uri $RequestURL -Headers $MicrosoftHeaders