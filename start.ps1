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

function InstallJava($frameworkFolderName, $javaJDKFileName) {
    #Add automation framework packaged file name to txt file and parameterize to method
    #Add Java JDK file name to txt file and parameterize to method
    Start-Process -FilePath "C:\Users\" + $env:USER + "Desktop\" + $frameworkFolderName + $javaJDKFileName
}
function InstallDocker($frameworkFolderName, $dockerFileName) {
    #Add Docker file name to txt file and parameterize to method
    Start-Process -FilePath "C:\Users\" + $env:USER + "Desktop\" + $frameworkFolderName + $dockerFileName
}
function StartDocker() {
    param ([switch]$wait)
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe" -Verb RunAs
    if ($wait) {
        $attempts = 0
        Write-Host "Checking Docker status..."
     
        do {
            docker ps -a #Check if docker images are initialized
     
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
