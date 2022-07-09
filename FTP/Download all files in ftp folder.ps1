Param (
$User_Name='', # Username to authenticate to ftp
$Password='', # Password for user to authenticate to ftp
$FTP='ftp://', # Example ftp://ftp.somedomain.org
$SubFolder='/', # Example / or /subfolder1/subfolder2
$Last_Time_Stamp = '', # Example C:\timestamp\time.dat
$Save_To = '' # Example C:\temp\
)

$FTP_URI = $FTP + $SubFolder
$URI=[system.URI] $FTP_URI
$FTP_Request=[system.net.ftpwebrequest]::Create($URI)
$FTP_Request.Credentials=New-Object System.Net.NetworkCredential($User_Name,$Password)
$FTP_Request.Method=[system.net.WebRequestMethods+ftp]::ListDirectoryDetails
$Response=$FTP_Request.GetResponse()
$strm=$Response.GetResponseStream()
$Reader=New-Object System.IO.StreamReader($strm,'UTF-8')
$list=$Reader.ReadToEnd()
$lines=$list.Split("`r`n")
$Items = $lines | foreach-object {$_.split("`r`n")}
$Result = @()
$Time_Content = get-content $Last_Time_Stamp -Raw
$Time_Content_Trim = $Time_Content.Trim()
foreach ($Item in $Items) {
    write-output $Item
    $Split = $Item.split("  ")
    $Is_DIR = $Split[9]
    if ($Item.Length -gt 39){
        if ($Is_Dir -ne "<DIR>"){
            $Date = $Split[0]
            $Time = $Split[2]
            $Minus_Length = ($Item.Length - 39)
            $File_Name = ($Item.Substring($Item.Length - $Minus_Length))
            $Result += New-Object -TypeName PSObject -Property ([ordered]@{
                'date' = $Date
                'time' = "$Time"
                'file_name' = $File_Name
            })
        }
    }
}
foreach ($File in $Result) {
    $Convert_Time = $File.time | Get-Date -format 'HH:mm'
    $Convert_Date_Time = $File.date + ' ' + $Convert_Time
    if($Convert_Date_Time -gt $Time_Content_Trim){
        $FTP_File_URI = $FTP_URI + '/' + $File.file_name
        $File_name = $File.file_name
        $Local_File = $Save_To + $File_name
        $FTP_Download_URI=[system.URI] $FTP_File_URI
        $FTP_Request1=[system.net.ftpwebrequest]::Create($FTP_Download_URI)
        $FTP_Request1.Credentials=New-Object System.Net.NetworkCredential($User_Name,$Password)
        $FTP_Request1.Method=[system.net.WebRequestMethods+ftp]::DownloadFile
        $FTP_Request1.UseBinary = $true
        $FTP_Request1.KeepAlive = $false
        $Response1=$FTP_Request1.GetResponse()
        $strm1=$Response1.GetResponseStream()
        try {
            $Target_File = New-Object System.IO.FileStream($Local_File,"Create")
            "File created: $Local_File"
            [byte[]]$readbuffer = New-Object byte[] 1024
            do{
                $readlength = $strm1.Read($readbuffer,0,1024)
                $Target_File.Write($readbuffer,0,$readlength)
            }
            while ($readlength -ne 0)
            $Target_File.close()
        }
        catch {
            $_|fl * -Force
        } finally {
            (Get-ChildItem $Local_File).LastWriteTime = $Convert_Date_Time
            $Sorted = $Result |sort-object -property date, time -Descending
            $Last_Modified_Date = $Sorted[0].date
            $Last_Modified_Time = $Sorted[0].time
            $Convert_Last_Modified_Time = $Last_Modified_Time | Get-Date -format 'HH:mm'
            $Last_Modified_Date_Time = $Last_Modified_Date + ' ' + $Convert_Last_Modified_Time
            $Current_Last_Time = get-content $Last_Time_Stamp
            if ($Current_Last_Time -ne $Last_Modified_Date_Time){
                Set-Content -Path $Last_Time_Stamp -Value $Last_Modified_Date_Time
            }
        }
    }
}