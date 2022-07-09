Param(
    $Taget = "google.dk"
)

ping.exe -t $Taget | ForEach-Object{"{0} - {1}" -f (Get-Date),$_} >>C:\temp\ping_$Taget.txt