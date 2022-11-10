$DotNetFound = $False
$DotNetValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -Name "Release"

#Check .NET version

    If ($DotNetValue.Release -gt "528049") {
        Write-Host "Greater than .NET 4.8 is installed - " -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "528049") {
        Write-Host ".NET 4.8 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "461814") {
        Write-Host ".NET 4.7.2 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "461310") {
        Write-Host ".NET 4.7.1 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "460805") {
        Write-Host ".NET 4.7.0 is installed." -NoNewLine -ForegroundColor Green
        DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "394806") {
        Write-Host ".NET 4.6.2 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "394271") {
        Write-Host ".NET 4.6.1 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "393297") {
        Write-Host ".NET 4.6.0 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "379893") {
        Write-Host ".NET 4.5.2 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "378758") {
        Write-Host ".NET 4.5.1 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -eq "378389") {
        Write-Host ".NET 4.5.0 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetValue.Release -lt "378389") {
        Write-Host "Version less than .NET 4.5.0 is installed." -NoNewLine -ForegroundColor Green
        $DotNetFound = $True
    }
    If ($DotNetFound -ne $True) {
        Write-Host 'A valid .NET Version not detected' -NoNewLine -ForegroundColor Green
    }

    $global:DotNetVersion = $DotNetValue