param (
$file = "C:\Temp\menu.pdf", # Temp location for PDF file from website
$itextsharpdll_loc = "C:\ps\itextsharp.dll", # Location for the itextsharp dll see available download links here: http://allthesystems.com/2020/10/read-text-from-a-pdf-with-powershell/
$link = "https://www.gastro-catering.dk/frokost-menu/", # URL to lookup
$Search_string = "*usercontent*.pdf*",
$connectorUri = "", # Insert your teams incomming webhook URI
$color1 = 253,
$color2 = 132,
$color3 = 7
)
$array =@()
$result =@()
function convert-PDFtoText {
	param(
		[Parameter(Mandatory=$true)][string]$file
	)	
	Add-Type -Path $itextsharpdll_loc
	$pdf = New-Object iTextSharp.text.pdf.pdfreader -ArgumentList $file
	for ($page = 1; $page -le $pdf.NumberOfPages; $page++){
		$text=[iTextSharp.text.pdf.parser.PdfTextExtractor]::GetTextFromPage($pdf,$page)
	}	
	$pdf.Close()
    $array = $text.split("`n")
    foreach ($line in $array) {
        if ($line -like "Dagens varme:*" -or $line -like "Dagens ret:*"){
            $Dagens_ret = $line
        }elseif ($line -like "Tilbehør:*"){
            $Dagens_til = $line
        }elseif ($line -like "Den grønne:*"){
            $Dagens_groenne = $line
        }elseif ($line -like "Salat #1:*"){
            $Dagens_salat1 = $line
        }elseif ($line -like "Salat #2:*"){
            $Dagens_salat2 = $line
        }elseif ($line -like "Dagens kolde anretning:*"){
            $Dagens_kolde = $line
        }elseif ($line -like "Grøntgnaver:*"){
            $Dagens_gnaver = $line
        }elseif ($line -like "Det daglige brød:*"){
            $Dagens_broed = $line
        }
        if ($Dagens_broed -ne $null){
            $Global:result += New-Object -TypeName PSObject -Property ([ordered]@{
                "Dagens ret:" = $Dagens_ret
                "Dagens tilbehør:" = $Dagens_til
                "Den grønne:" = $Dagens_groenne
                "Salat #1:" = $Dagens_salat1
                "Salat #2:" = $Dagens_salat2
                "Dagens kolde anretning:" = $Dagens_kolde
                "Grøntgnaver:" = $Dagens_gnaver
                "Det daglige brød:" = $Dagens_broed
            })
            $Dagens_broed = $null
        }
    }
    Remove-item $file
}
$lookup_url = Invoke-WebRequest $link

foreach ($uri in $lookup_url.Links.href) {
    if($uri -like $Search_string){
        Invoke-WebRequest -Uri $uri -OutFile $file
        $uge_loc = $uri.IndexOf('uge-')
        $pdf_loc = $uri.IndexOf('.pdf')
        $exclude_uge = $uge_loc + 4
        $exclude_pdf = $pdf_loc - $exclude_uge
        $uge = $uri.Substring($exclude_uge,$exclude_pdf)
    }
}

convert-PDFtoText $file
$Dagens_array = $result.'Dagens ret:'.split("`n")
$tilbehoer_array = $result.'Dagens tilbehør:'.split("`n")
$Den_groenne_array = $result.'Den grønne:'.split("`n")
$Salat1_array = $result.'Salat #1:'.split("`n")
$Salat2_array = $result.'Salat #2:'.split("`n")
$Dagens_Kolde_array = $result.'Dagens kolde anretning:'.split("`n")
$Groentgnaver_array = $result.'Grøntgnaver:'.split("`n")
$Daglige_Broed_array = $result.'Det daglige brød:'.split("`n")


$Mandag = $Dagens_array[0] + "<br />" + $tilbehoer_array[0] + "<br />" + $Den_groenne_array[0] + "<br />" + $Salat1_array[0] + "<br />" + $Salat2_array[0] + "<br />" + $Dagens_Kolde_array[0] + "<br />" + $Groentgnaver_array[0] + "<br />" + $Daglige_Broed_array[0] + "<br />" + "<br />"
$Tirsdag = $Dagens_array[1] + "<br />" + $tilbehoer_array[1] + "<br />" + $Den_groenne_array[1] + "<br />" + $Salat1_array[1] + "<br />" + $Salat2_array[1] + "<br />" + $Dagens_Kolde_array[1] + "<br />" + $Groentgnaver_array[1] + "<br />" + $Daglige_Broed_array[1] + "<br />" + "<br />"
$Onsdag = $Dagens_array[2] + "<br />" + $tilbehoer_array[2] + "<br />" + $Den_groenne_array[2] + "<br />" + $Salat1_array[2] + "<br />" + $Salat2_array[2] + "<br />" + $Dagens_Kolde_array[2] + "<br />" + $Groentgnaver_array[2] + "<br />" + $Daglige_Broed_array[2] + "<br />" + "<br />"
$Torsdag = $Dagens_array[3] + "<br />" + $tilbehoer_array[3] + "<br />" + $Den_groenne_array[3] + "<br />" + $Salat1_array[3] + "<br />" + $Salat2_array[3] + "<br />" + $Dagens_Kolde_array[3] + "<br />" + $Groentgnaver_array[3] + "<br />" + $Daglige_Broed_array[3] + "<br />" + "<br />"
$Fredag = $Dagens_array[4] + "<br />" + $tilbehoer_array[4] + "<br />" + $Den_groenne_array[4] + "<br />" + $Salat1_array[4] + "<br />" + $Salat2_array[4] + "<br />" + $Dagens_Kolde_array[4] + "<br />" + $Groentgnaver_array[4] + "<br />" + $Daglige_Broed_array[4] + "<br />" + "<br />"



$mad = @"
<span style='color: rgb($color1,$color2,$color3); font-size: 20px'><strong> Frokostmenu uge: $uge </strong></span>
<br /> <br />
<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Mandag: </strong></span> <br />
$Mandag

<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Tirsdag: </strong></span> <br />
$Tirsdag

<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Onsdag: </strong></span> <br />
$Onsdag

<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Torsdag: </strong></span> <br />
$Torsdag

<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Fredag: </strong></span> <br />
$Fredag

"@

$JSONBody = [PSCustomObject][Ordered]@{
    "@type" = "MessageCard"
    "@context" = "<http://schema.org/extensions>"
    "summary" = "$mad"
    "themeColor" = '0078D7'
    "title" = ""
    "text" = "$mad"
}


$TeamMessageBody = ConvertTo-Json $JSONBody
Invoke-RestMethod -Uri $connectorUri -Method Post -Body ([System.Text.Encoding]::UTF8.GetBytes($TeamMessageBody)) -ContentType 'application/json'