function Making ($text, $checked, $enabled, $loc1, $loc2, $width, $height, $autoSize, $object) {
    #Used to make the Gui in the first form
    $location                               = New-Object System.Drawing.Point($loc1, $loc2)
    $obj                                    = New-Object $object
    $obj.text                               = $text
    $obj.width                              = $width
    $obj.height                             = $height
    $obj.location                           = $location
    $obj.AutoSize                           = $autoSize
    if($obj -match 'System.Windows.Forms.Label' -and $loc2 -eq 40) {
        $obj.Font                           = [System.Drawing.Font]::new("Microsoft Sans Serif", 11, [System.Drawing.FontStyle]::Bold)
    }
    $obj
}
$Form                                       = New-Object system.Windows.Forms.Form
$Form.ClientSize                            = New-Object System.Drawing.Point(200,150)
$Form.text                                  = "Do not allow removalable drives"
$Form.TopMost                               = $false
$General                                    = Making "remove permission" $false $false 20 40 95 20 $true System.Windows.Forms.Label

$Next                                       = Making "Do it" $false $false 20 100 100 30 $false System.Windows.Forms.Button
$Next.Add_Click({ Next_Button })
$Form.controls.AddRange(@($General,$Next))

function Next_Button {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Policies\Microsoft\FVE" -Name "RDVDenyWriteAccess" -Value 0
    [void]$Form.Close()
}
[void]$Form.ShowDialog()