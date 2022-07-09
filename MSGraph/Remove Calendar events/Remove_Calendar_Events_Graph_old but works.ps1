$TenantID = "385e600e-81a2-4ddc-979b-9bed35384cb8"
$ClientID = "2ea5ca7a-a86b-42d8-93af-8c6ba80b922b"
$Clientsecret = "n9u7Q~rmcX~FdrLfkZ6W~xr68hEsyS9nJzvhJ"



$MailboxName = "DK_HRS_Museum2_Adm_G_8@mjrecycling.com"
#DK_HRS_Museum2_Adm_G_8@mjrecycling.com

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
$RequestURL = $EndPoint + "$MailboxName/calendarview?startDateTime=" + $date + "T09:00:01&endDateTime=2022-12-01T00:00:00&top=100"


$CalendarEvents = (Invoke-RestMethod -Method Get -Uri $RequestURL -UserAgent "GraphBasicsPs101" -Headers $MicrosoftHeaders)


$CalendarEventsCounter = 0

while ($CalendarEventsCounter -lt $CalendarEvents.value.Count) {
    $CalendarEventID = $CalendarEvents.value[$CalendarEventsCounter].id
    $isOrganizer = $CalendarEvents.value[$CalendarEventsCounter].isOrganizer
    
    if ($isOrganizer -eq "True") {
        $uri = "https://graph.microsoft.com/v1.0/users/$MailboxName/calendar/events/$CalendarEventID/cancel"
        Invoke-RestMethod -Method POST -Uri $uri -Headers $MicrosoftHeaders
    }

    if ($isOrganizer -ne "True") {
        $uri = "https://graph.microsoft.com/v1.0/users/$MailboxName/calendar/events/$CalendarEventID/decline"
        Invoke-RestMethod -Method POST -Uri $uri -Headers $MicrosoftHeaders
    }
    $CalendarEventsCounter++
}