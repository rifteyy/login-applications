:: Simple Discord webhook login.
:: Replace variable "webhook" with a valid webhook. Users copy and paste the message sent on the webhook channel.
:: If user has low internet, it might take few minutes to download curl and its certificate.
:: Made for not professional users, with all the explanations
:: Created by rifteyy#9999 on Discord
:: If found any bugs, please contact me on discord.

::---------------------------------------------------------------------------------------------------------


@echo off
cls
:: Set up old CHCP value
for /f "delims=: tokens=2" %%A in ('chcp') do set "chcp=%%A>nul

:: Change CHCP value temporary due to powershell font bugs
chcp 437>nul

:: Paste here cdn.discordapp.com link with CURL.exe & CURL-CA-BUNDLE.crt
set curllink=
set curlcabundlelink=

:: Do SETLOCAL to proper generate of auth ID
setlocal ENABLEEXTENSIONS 
setlocal ENABLEDELAYEDEXPANSION

:: Set alfanum variable to generate password
set alfanum=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789

:: Reset AUTH ID
set auth=

:: Replace with a valid webhook
set webhook=https://discord.com/api/webhooks/?/?-?_?

:: Download CURL.exe and CURL-CA-BUNDLE.crt to post text on a webhook.
if NOT exist %temp%\curl.exe echo Downloading CURL.exe, please wait... & powershell -Command "Invoke-WebRequest %curllink% -OutFile %temp%\curl.exe" >nul 
if NOT exist %temp%\curl-ca-bundle.crt echo Downloading CURL-CA-BUNDLE.crt, please wait... & powershell -Command "Invoke-WebRequest %curlcabundlelink% -OutFile %temp%\curl-ca-bundle.crt" >nul 

:: Checks if both downloaded file exists, if not, quits.
if NOT exist "%temp%\curl.exe" echo CURL.EXE not found. & pause >nul & exit
if NOT exist "%temp%\curl-ca-bundle.crt" echo CURL-CA-BUNDLE.CRT not found. & pause >nul & exit

:: String generate (AUTH ID) and save as variable "%auth%"
FOR /L %%b IN (0, 1, 100) DO (
SET /A auth_num=!RANDOM! * 59 / 32768 + 1
for /F %%c in ('echo %%alfanum:~!auth_num!^,1%%') do set auth=!auth!%%c
)
cls
echo Posting to the webhook AUTH ID...
:: Type AUTH ID on a webhook.
%temp%\curl.exe --silent -X POST -H "Content-type: application/json" --insecure --data "{\"content\": \"**AUTH ID FOR %USERNAME%**\n```asciidoc\nAUTH ID: %auth%\n\n```\n\"}" %webhook% 2>nul >nul
cls
echo You can find your AUTH ID from Discord channel.

:: Default SET /P to get user input-
set /p authid= [30m---[0m Auth ID: 

:: Checks if users input is same as AUTH ID
if %authid%==%auth% goto authenticated
if NOT %authid%==%auth% (

:: Change CHCP to last set value, and reset CHCP variable.
chcp %chcp% & set chcp=

set authid= & set auth= & set webhook= & set alfanum= & set auth_num= & set alfanum= & chcp %chcp% & set chcp= & endlocal 
cls
echo Invalid AUTH ID. Please try again.
pause >nul
exit
)

:: Authenticated 

:: Change CHCP to last set value, and reset CHCP variable.
chcp %chcp% & set chcp=

:: Instead of "pause >nul & exit" paste your work for authenticated users here.
:authenticated
set authid= & set auth= & set webhook= & set alfanum= & set auth_num= & set alfanum= & chcp %chcp% & set chcp= & endlocal
cls & echo Success! You are authenticated.
pause >nul
exit


