@echo off
REM Download the Office Deployment Tool
echo Downloading the Office Deployment Tool...
set ODT_URL=https://aka.ms/ODT
set ODT_PATH=%Officetool%\OfficeDeploymentTool.exe
powershell -Command "Invoke-WebRequest -Uri %ODT_URL% -OutFile %ODT_PATH%"

REM Install the Office Deployment Tool
echo Installing the Office Deployment Tool...
"%ODT_PATH%" /quiet

REM Create the configuration XML for Office 365 installation
echo Creating configuration XML...
set CONFIG_XML=%Officetool%\configuration-Office365-x64.xml
(
echo ^<Configuration^>
echo   ^<Add OfficeClientEdition="64" Channel="Current"^>
echo     ^<Product ID="O365BusinessRetail"^>
echo       ^<Language ID="en-us" /^>
echo     ^</Product^>
echo   ^</Add^>
echo   ^<RemoveMSI /^>
echo   ^<Display Level="None" AcceptEULA="TRUE" /^>
echo   ^<Property Name="SharedComputerLicensing" Value="1" /^>
echo   ^<Property Name="PinIconsToTaskbar" Value="TRUE" /^>
echo   ^<Property Name="SCLCacheOverride" Value="1" /^>
echo   ^<Property Name="AUTOACTIVATE" Value="1" /^>
echo   ^<Property Name="FORCEAPPSHUTDOWN" Value="TRUE" /^>
echo ^</Configuration^>
) > %CONFIG_XML%

REM Install the latest version of Office 365
echo Installing Office 365...
set SETUP_PATH="C:\Officetool\setup.exe"
if exist %SETUP_PATH% (
    "%SETUP_PATH%" /configure %CONFIG_XML%
) else (
    echo Setup executable not found at %SETUP_PATH%.
)

echo Installation complete.
pause
