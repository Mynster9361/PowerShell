param (
    $WebPage = "https://nupark.dk/ugensmenu/",
    $Teams_Connection_URI = "", # Insert your teams incomming webhook URI
    $color1 = 253,
    $color2 = 132,
    $color3 = 7
)

$menu = Invoke-WebRequest $WebPage | Select-Object Content | export-csv "C:\Temp\menu.csv" -Encoding UTF8


$menu_import = select-string "C:\Temp\menu.csv" -pattern "MANDAG" 
$Week = "{0:d1}" -f ($(Get-Culture).Calendar.GetWeekOfYear((Get-Date),[System.Globalization.CalendarWeekRule]::FirstFourDayWeek, [DayOfWeek]::Monday))
$This_weeks_menu = $menu_import -replace '<div class=""row row-spacing""><div class=""col col-6 col-12-m menu-group""><h4 class=""zc"">' , [System.Environment]::NewLine
$This_weeks_menu = $This_weeks_menu -replace '</h4><div class=""menu-group__item""><h6 class=""menu-group__day""></h6><h5 class=""menu-group__dish""></h5></div><div class=""menu-group__item""><h6 class=""menu-group__day"">' , ([System.Environment]::NewLine + [System.Environment]::NewLine)
$This_weeks_menu = $This_weeks_menu -replace '</h5></div><div class=""menu-group__item""><h6 class=""menu-group__day""></h6><h5 class=""menu-group__dish"">' , [System.Environment]::NewLine
$This_weeks_menu = $This_weeks_menu -replace '</h4><div class=""menu-group__item"">' , [System.Environment]::NewLine
$This_weeks_menu = $This_weeks_menu -replace '</h6><h5 class=""menu-group__dish"">' , [System.Environment]::NewLine
$This_weeks_menu = $This_weeks_menu -replace '<h6 class=""menu-group__day"">' , [System.Environment]::NewLine
$This_weeks_menu = $This_weeks_menu -replace '</h5></div><div class=""menu-group__item"">' , [System.Environment]::NewLine
$This_weeks_menu = $This_weeks_menu -replace '</h5></div></div></div><br />'
$This_weeks_menu = $This_weeks_menu -replace "Frokostmenu uge $Week"
$This_weeks_menu = $This_weeks_menu -replace "\r\n\r\n\r\n"
$This_weeks_menu = $This_weeks_menu -replace "\r\n", "<br />"
$This_weeks_menu
$mad = $This_weeks_menu.TrimStart("C:\Temp\menu.csv:382:")

$Mandag = "Mandag(.*?)Tirsdag"
$Tirsdag = "Tirsdag(.*?)Onsdag"
$Onsdag = "Onsdag(.*?)Torsdag"
$Torsdag = "Torsdag(.*?)Fredag"
$Fredag = $mad.IndexOf("Fredag")
$result_Mandag = [regex]::match($mad, $Mandag).Groups[1].Value
$result_Tirsdag = [regex]::match($mad, $Tirsdag).Groups[1].Value
$result_Onsdag = [regex]::match($mad, $Onsdag).Groups[1].Value
$result_Torsdag = [regex]::match($mad, $Torsdag).Groups[1].Value
$result_Fredag = $mad.Substring($Fredag+6)
$Dayofweek = (get-date).DayOfWeek

$mad = @"
<span style='color: rgb($color1,$color2,$color3); font-size: 20px'><strong> Frokostmenu uge: $Week </strong></span>
<br /> <br />
<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Mandag: </strong></span>
$result_Mandag

<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Tirsdag: </strong></span>
$result_Tirsdag

<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Onsdag: </strong></span>
$result_Onsdag

<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Torsdag: </strong></span>
$result_Torsdag

<span style='color: rgb($color1,$color2,$color3); font-size: 15px'><strong> Fredag: </strong></span>
$result_Fredag

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
Invoke-RestMethod -Uri $Teams_Connection_URI -Method Post -Body ([System.Text.Encoding]::UTF8.GetBytes($TeamMessageBody)) -ContentType 'application/json'