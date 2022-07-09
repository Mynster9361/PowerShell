$regs = Get-Item -Path 'Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts' | Select-Object -ExpandProperty Property
foreach ($reg in $regs){

    if($reg -like "*redirected*"){
        Remove-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts' -Name $reg
    }
    
}