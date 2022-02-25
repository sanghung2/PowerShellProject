function CheckSoftwareIsInstalled ($software) {
    #Check if application is installed, if not, then install it
    $installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -Match $software })
    $installed.DisplayName
    if ($installed.DisplayName -match $software) 
    {
        Write-Host $software + " is Installed"
    }
    else {
        Write-Host "Not Installed"
    }
}
CheckSoftwareIsInstalled("Docker")

function InstallJava() {
    Start-Process
}
function InstallDocker() {

}
function StartDocker() {
    param ([switch]$wait)
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe" -Verb RunAs
    if ($wait) {
        $attempts = 0
        Write-Host "Checking Docker status..."
     
        do {
            docker ps -a #| Out-Null
     
            if ($?) {
                break;
            }

            $attempts++
            Write-Host "Docker not fully ready, waiting..."
            Start-Sleep 2

        } while ($attempts -le 10)
        Write-Host "Pausing until initialized..."
        Start-Sleep 6
    }
    Write-Host "Docker started"
}
