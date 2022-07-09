$TenantID = "" # Tenant ID
$ClientID = "" # Application (Client) ID
$Clientsecret = "" # (Certificates & Secrets) Secret Value
#               yyyy-MM-dd
$EndDateTime = "2022-12-01T00:00:00" # Specify how far the script should look eks: "2022-12-01T00:00:00" which is 01-DEC-2022
$MailboxName = "mail@contoso.com" # Room@contoso.com you want to remove meetings from
###
### Please note that meetings that are not organized in the calendar but the calendar is invited instead will only send decline email to the organizer
###

$DateTime = (Get-Date).ToUniversalTime()
$Date = Get-Date $DateTime  -Format "yyyy-MM-dd"
$Time = Get-Date $DateTime -Format "HH:mm:ss"

$tokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    Client_Id     = $clientId
    Client_Secret = $clientSecret
}
$tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token" -Method POST -Body $tokenBody
$MicrosoftHeaders = @{
    "Authorization" = "Bearer $($tokenResponse.access_token)"
    "Content-type"  = "application/json"
}

$EndPoint = "https://graph.microsoft.com/beta/users/"
$RequestURL = $EndPoint + "$MailboxName/calendarview?startDateTime=" + $date + "T00:00:01&endDateTime=" + $EndDateTime + "&top=100"

$CalendarEvents = (Invoke-RestMethod -Method Get -Uri $RequestURL -UserAgent "GraphBasicsPs101" -Headers $MicrosoftHeaders)

foreach ($CalendarEvent in $CalendarEvents.value){
    $EventID = $CalendarEvent.id
    $isOrganizer = $CalendarEvent.isOrganizer

    if ($isOrganizer -eq "True") {
        # If the room is the organizer then it will send cancelation mail to all participants
        $uri = "https://graph.microsoft.com/v1.0/users/$MailboxName/calendar/events/$EventID/cancel"
        Invoke-RestMethod -Method POST -Uri $uri -Headers $MicrosoftHeaders
    } else {
        # If the room is not the organizer then it will send decline mail to the organizer only
        $uri = "https://graph.microsoft.com/v1.0/users/$MailboxName/calendar/events/$EventID/decline"
        Invoke-RestMethod -Method POST -Uri $uri -Headers $MicrosoftHeaders
    }
}