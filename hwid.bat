:: Simple professional advanced HWID LOGIN system for users
:: Made for not professional users, with all the explanations
:: Please use editable RAW PASTEBIN to proper authenticate.
:: Also separate your HWID's on the lines.
:: Created by rifteyy#0001 on Discord
:: If found any bugs, please contact me on discord.

::---------------------------------------------------------------------------------------------------------
@echo off
:: Set up old CHCP value
for /f "delims=: tokens=2" %%A in ('chcp') do set "chcp=%%A>nul

:: Change CHCP value temporary due to powershell font bugs
chcp 437>nul 

:: Replace this with your RAW PASTEBIN link
set "pastebin=https://pastebin.com/raw/xxxxxx"

:: Get admin permissions
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

:: Invoke WebRequest to the PASTEBIN and save them to a temp file
powershell -Command "Invoke-WebRequest %pastebin% -OutFile %temp%\hwid.txt" 2>nul >nul

:: Get HWID using "FOR /F" and "wmic csproduct get uuid /format:value ^| find "="'" and save it as variable "%UUID%"
:: For more info use "FOR /?"
for /f "tokens=2 delims==" %%A in ('wmic csproduct get uuid /format:value ^| find "="') do set uuid=%%A

:: Using FIND command to find this PC HWID in the downloaded pastebin
find "%uuid%" %temp%\hwid.txt >nul

:: Using ERRORLEVEL to determine if found/not found
if "%errorlevel%"=="0" (
  goto authenticated
) else (
  goto notauthenticated
)


:: Set UP authenticated GOTO
:: Also paste your work for logged users here
:authenticated

:: Change CHCP to last set value, and reset all the variables.
chcp %chcp% & set chcp= & set uuid= & set pastebin= & cls

:: Delete the temporary HWID file silently
del /f /q %temp%\hwid.txt 2>nul >nul

echo Authenticated!
pause >nul
exit

:: Set UP notauthenticated GOTO
:notauthenticated

:: Delete the temporary HWID file silently
del /f /q %temp%\hwid.txt 2>nul >nul

:: Use CLIP command to save thing to clipboard (CTRL + V)
echo %uuid% | CLIP

:: Change CHCP to last set value, and reset all the variables.
chcp %chcp% & set chcp= & set uuid= & set pastebin= & cls 

echo Not authenticated.
echo Your HWID was copied to clipboard.
pause >nul
exit



::---------------------------------------------------------------------------------------------------------
