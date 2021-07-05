:: Simple professional advanced LOGIN system for users
:: Made for not professional users, with all the explanations
:: Created by rifteyy#9999 on Discord
:: If found any bugs, please contact me on discord.

::---------------------------------------------------------------------------------------------------------
@echo off
:: Replace this variable with your PASSWORD to login
set "yourpassword=mypassword"

:: Replace this variable with your USERNAME to login
set "yourusername=myusername"

:: Set up old CHCP value and password errorlevel value
:: The value "loginerrorlevel" is neccesary, do not edit/remove it.
for /f "delims=: tokens=2" %%A in ('chcp') do set "chcp=%%A>nul
set /a loginerrorlevel=0

:: Change CHCP value temporary due to powershell font bugs
chcp 437>nul & echo [8m

:: Default SET /P command to get user input, using ANSII color codes to hide the "-"
:: For more information "SET /?"
set /p username= [30m----------------------[0m username: 
echo.

:: Set up powershell command variable
:: To edit user information, edit "[30m----------------------[0m password" and change it to yours.
:: For more information POWERSHELL /?
::			SET /?
::			FOR /?
::			CHCP /?
 set "psCommand=powershell.exe -Command "$pword = read-host '[30m----------------------[0m password'-AsSecureString ; ^
      $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
            [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""

:: Use usebackq delims in the powershell command to prompt the user input with "*"
:: To edit password variable, change the "password" varible in "FOR /F" command.
for /f "usebackq delims=" %%p in (`%psCommand%`) do set password=%%p


:: Username value is "%username%" and password value is "%password%"
:: Make sure to paste your password into "%yourpassword%" variable with set "yourpassword=mypassword"
:: We are going to use "IF" command to check if you can login
if "%password%"=="%yourpassword%" set /a loginerrorlevel=loginerrorlevel + 1
if "%username%"=="%yourusername%" set /a loginerrorlevel=loginerrorlevel + 1

:: Check "loginerrorlevel" value, if 0-1 goto "invalidpassword", if 2 goto "loggedin"
if %loginerrorlevel%==0 goto invalidpassword
if %loginerrorlevel%==1 goto invalidpassword
if %loginerrorlevel%==2 goto loggedin


:: Set invalidpassword GOTO
:invalidpassword
cls
echo Invalid password/username.
pause >nul

:: Change CHCP to last set value, and reset all the variables.
chcp %chcp% & set chcp= & set psCommand=
exit


:: Set up loggedin GOTO
:: Here you can paste your work to logged users.
:loggedin
cls
echo Success! You are now logged in.

:: Change CHCP to last set value, and reset all the variables.
chcp %chcp% & set chcp= & set psCommand=
pause >nul



::---------------------------------------------------------------------------------------------------------





