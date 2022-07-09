# Sending emails with the Graph API
# Note that your app requires the permission 
# Mail.Send
# Please define the first 6 varribles in order for it to work
Param(
    $clientID = "",
    $Clientsecret = "",
    $tenantID = "",
    $To = "Mail1@contoso.com Mail2@contoso.com Mail3@contoso.com",
    $Cc = "Mail4@contoso.com Mail5@contoso.com",
    $From = "notify@contoso.com"
)
$MailSender = "$From"
$URLsend = "https://graph.microsoft.com/v1.0/users/$MailSender/sendMail"


#Connect to GRAPH API
$tokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    Client_Id     = $clientId
    Client_Secret = $clientSecret
}
$tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token" -Method POST -Body $tokenBody
$headers = @{
    "Authorization" = "Bearer $($tokenResponse.access_token)"
    "Content-type"  = "application/json"
}

function Mail-info {
    param (
		$To = "$To",
		$Cc = "$Cc",
		$From = "$From",
        $Text_Outside = "$Text_Outside"
    )
	# Mail
    $Subject = "This is your subject line"

    # Define your email in this case it has been done with HTML
    # Some examples:
    
    # To make your text Bold put your text between <strong> </strong>
    # <strong>This text will be Bold</strong>
    
    # Set your font size and which font should be used:
    # <p style="font-size:9.0pt;font-family:verdana">

    # To make a new line in your email add the following <br/>

    # To make the character "å" use the following "&#229;"
    # To make the character "ø" use the following "&#248;"
    # To make the character "æ" use the following "&#230;"

    # To make a mailto statement or link use the following:
    # <a href="mailto:contoso@contoso.com">contoso@contoso.com</a>

    # To point to a website or link use the following:
    # <a href="http://your_website.com"><em>The text you would like the link to be over example "www.your_website.com"</em></a>
    
    # To insert a image you can do the following:
    # <img src='https://your_website.com/logo.png'>
    

    $MailContent = @"
    <p style="font-size:9.0pt;font-family:verdana">
    <strong>Some Bold Text</strong>
    <br/>
    Hi there this is an email through the Microsoft graph with powershell
    <br/>
    The above gives us a new line
    <br/>
    You can also pull in something from variables outside of this template like shown below
    <br/>
    Todays date is $Text_Outside
    <br/>
"@
}
    $To = $To.Split(' ')
    if ($Cc)  { 
        $Cc = $Cc.Split(' ') | ? {$_ -Like "???*"}
        $props.Add("CC", $Cc) 
	}
	$BodyJsonsend = @"
	{
		"message": {
			"subject": "$Subject",
			"body": {
				"contentType": "HTML",
				"content": "$MailContent"
			},
			"toRecipients": [
			{
				"emailAddress": {
					"address": "$To"
				}
			}
			],
			"ccRecipients": [
      		{
        		"emailAddress": {
          			"address": "$Cc"
        		}
      		}
    		]
		},
		"saveToSentItems": "true"
	}
"@

    $Exit = 0
    Do {
        Try {
			# Send Mail
            Invoke-RestMethod -Method POST -Uri $URLsend -Headers $headers -Body $BodyJsonsend
            Write-Output "send message"
            $Exit = 8
        }
        Catch {
            $Exit ++
            Write-Output "Failed to send message because: $($Error[0])"
            Write-Output "Try #: $Exit"
            sleep -Seconds 15
            If ($Exit -eq 8){   
				throw "Unable to send message!"
            }
        }
    } Until ($Exit -eq 8)

$Text_added_outsideMail = get-date

Mail-info -To $To -Cc $Cc -From $From -Text_Outside $Text_added_outsideMail
