@echo off
:: Please see the GitHub page for more info:
:: https://github.com/Owen-Cochell/File-Guardian

:: General startup stuff here:
title File Guardian
color 0a

:: Please enter your name here:
set name=(INSERT_YOUR_NAME_HERE)

:: Variables for defining name of files are here:
:: locked = The name of the file when locked
:: unlocked = The name of the file when unlocked
:: Using special characters(#, $, ^) or spaces, will probably break the script(So don't use them!).
set locked=(INSERT_NAME_HERE)
set unlocked=(INSERT_NAME_HERE)

set lock=1
if EXIST %locked% set lock=2

:: If this script is going to be locking/unlocking a directory that is NOT in the current working directory,
:: (Like a flash drive)
:: Then the user will need to enter in the path of the target directory.
:: This is useful if you want to put a hidden directory on a flash drive,
:: Or if the user is running the script FROM the flash drive to unlock a local driectory.
:: Change this variable(arc) to ask for file path.
:: SYNTAX:
:: 0 = Will not ask for file path(Default)
:: 1 = WILL ask for file path
:: Prompting for a file path if the directory is in the currently working directory will not break the script(If you enter the correct file path),
:: However, it is just redundant and unnecessary, and may confuse non-advanced users.

set arc=0

:: This variable defines weather this script will execute different blocks of code depending on if the file is open or closed.
:: Reasons why you would want to do this here:
:: https://github.com/Owen-Cochell/File-Guardian/wiki/Securing-File-Guardian
:: 0 = Will execute same block regardless of directory status(Default)
:: 1 = Will execute different blocks depending on directory status.

set oneblock=0

:: This variable defines weather this script will display a startup banner.
:: The banner is not necessary for this script to run properly.
:: SYNTAX:
:: 0 = Will display startup banner(Default)
:: 1 = Will NOT display startup banner
:: (Why would you do this?!?!?)

set banner=0

if %banner%==0 goto start
goto done

:start

:: Pretty cool banner, huh?
echo +======================================================================================+
echo ^|                             +____________________________+                           ^|
echo ^|                             ^|                            ^|                           ^|
echo ^|                             ^| @@@@@@@@@@@@@@@@@@@@@@@@@@ ^|                           ^|
echo ^|                             ^| @                        @ ^|                           ^|
echo ^|                             ^| @   ########             @ ^|                           ^|
echo ^|                             ^| @   #                    @ ^|                           ^|
echo ^|                             ^| @   ########             @ ^|                           ^| 
echo ^|                             ^| @   #                    @ ^|                           ^|
echo ^|                             ^| @   #                    @ ^|                           ^|
echo ^|                             ^| @   #                    @ ^|                           ^|
echo ^|                             ^| @   #                    @ ^|                           ^|
echo ^|                             ^| @                        @ ^|                           ^|
echo ^|                             ^| @         #########      @ ^|                           ^|
echo ^|                             ^| @         #              @ ^|                           ^|
echo ^|                             ^| @         #              @ ^|                           ^|
echo ^|                             ^| @         #     ###      @ ^|                           ^|
echo ^|                             ^| @         #       #      @ ^|                           ^|
echo ^|                             ^| @         #       #      @ ^|                           ^|
echo ^|                              \ @        #########     @ /                            ^|
echo ^|                               \ @                    @ /                             ^|
echo ^|                                \ @                  @ /                              ^|
echo ^|                                 \ @                @ /                               ^|
echo ^|                                  \ @              @ /                                ^|
echo ^|                                   \@@@@@@@@@@@@@@@@/                                 ^|
echo ^|                                    +--------------+                                  ^|
echo +======================================================================================+
echo                                   File Guardian ver. 1.0.0
echo                                        Owen Cochell
pause
goto done

:done

:: Computing variables here:
if %arc%==1 goto dirselect
goto passgen

:dirselect

:: Getting path to file here. Very important!
cls
echo +=======================================================================+
echo Please enter the path to the directory containing the locked directory:
echo (Or type "help" for more info)
echo.
set /p drive=Path to directory:
if %drive%==help goto help
cls
CD /D %drive%
if %drive% NEQ %cd% goto driveerr
goto passgen

:help

:: Help page for drive letters:
cls
echo +====================================================================================+
echo If you would like to lock/unlock a directory that is NOT in the working directory(WD) of File Guardian,
echo (The WD is the directory that this script is currently IN)
echo Then you must input the path of the directory into the PATH menu.
echo.
echo A path to a file is configured like this:
echo.
echo [Drive Letter]\path\to\file
echo.
echo You must input the drive letter in place of "[Drive Letter]"
echo The drive letter is usually "C:" if the file is on the drive that windows is installed on.
echo The drive letter may differ if the directory is on a external drive(Flash drive, floppy drive, external hard drive, ect...)
echo You can find the drive letter by going to "This PC" in the file explorer and looking at the drive in question.
echo If you give Flash Guardian the wrong drive letter, then this script WILL NOT WORK!
echo.
echo You must input the path to the file in the "\path\to\file" section.
echo Using the path should be relatively obvious.
echo Just input each directory that you must "enter" to reach your destination
echo For example, let's say you have to go through the following directories on drive C: to get to your destination:
echo.
echo MyStuff:Stuff:SuperCoolStuff:Data
echo.
echo Then the path will be displayed as:
echo.
echo C:\MyStuff\Stuff\SuperCoolStuff\Data
echo.
echo IMPORTANT:
echo You must enter the path to the directory that the file you wish to lock/unlock IS CURRENTLY IN!
echo If the directory you wish to unlock is "CoolStuff",
echo Then you must enter the path to the directory that "CoolStuff" is in.
echo.
set /p junk=Press any key to return to the drive menu...
goto dirselect

:passgen

:: Computing if file is locked or not
if %oneblock%==0 goto onepass
if %lock%==1 goto open
if %lock%==2 goto closed
goto serr

:onepass

:: Commands under open will be run if the file is unlocked
:: Variable var contains the password.
:: To change the password, enter it below under the negative sign.
:: This is the default option.
:: For obvious reasons, this method of password management is NOT recommended
:: Another option is specifying a text document that contains your password.
:: The password HAS to be in a text document, so this script can easily read it.
:: The idea is that you keep the text document in a safe place.
:: Very insecure, I know, but ways to secure this is provided here:
:: https://github.com/Owen-Cochell/File-Guardian/wiki/Securing-File-Guardian
:: To change this config, uncomment the second line, and comment out the first.
:: More info can be found here:
:: INSERT_LINK_HERE

set var=(PASSWORD_HERE)
::set /p var=<(PATH_TO_FILE_HERE)
goto word

:open

:: Commands under open will be run if the file is unlocked
:: (If the the oneblock variable is equal to 0)
:: See above for password info

set var=(PASSWORD_HERE)
::set /p var=<(PATH_TO_FILE_HERE)
goto word

:closed

:: Commands under closed will be run if the file is locked
:: (If the the oneblock variable is equal to 0)
:: See above for password info.
set var=(PASSWORD_HERE)
::set /p var=(PATH_TO_FILE_HERE)
goto word

:word

:: Password prompt screen here:
cls
echo +========================================================+
echo To Access This Application, Please Enter The Password.
set /p pass=Password:
if %pass%==%var% goto admin
goto f

:f

:: If the password is incorrect,
:: Then commands under f will be ran.
:: Change up anything you like here. Possible ideas:
:: https://github.com/Owen-Cochell/File-Guardian/wiki/Securing-File-Guardian
cls
color 0c
echo !!!!!!!!!!!!!!!!!!!!!!
echo.
echo Incorrect Password!
echo.
echo Please return this drive to:
echo %name%
echo.
echo !!!!!!!!!!!!!!!!!!!!!!
pause
color 0a
goto word

:admin

:: Admin menu for script:
:: Another thing to note, commands here will be executed if password is correct.
cls
echo Welcome, %name%.
echo Please Select An Option:
echo.
echo [A]:Unlock Directory
echo [B]:Lock Directory
echo [C]:Create Directory
echo [D]:Info
echo [E]:Exit
set /p choice=Enter a letter:
goto option

:option

:: Computing your decision here:
if %choice%==a goto un
if %choice% ==A goto un
if %choice%==b goto l
if %choice%==B goto l
if %choice%==c goto creatediag
if %choice%==C goto creatediag
if %choice%==d goto info
if %choice%==D goto info
if %choice%==e goto end
if %choice%==E goto end
goto choiceerr 

:un

:: Commands under un will be ran if the user is unlocking the directory.
cls
if %lock%==1 goto err
attrib -h -s %locked%
ren "%locked%" %unlocked%
cls
:: This is just some rudimentary error handling...
:: Don't expect it to catch everything.
IF NOT EXIST %unlocked% goto unerr
echo +===================================+
echo.
echo File unlocked successfully.
echo.
echo +===================================+
set lock=1
pause
goto admin

:l

:: Commands under l will be ran if the user is locking the directory.
cls
if %lock%==2 goto err
ren %unlocked% "%locked%"
attrib +h +s "%locked%"
:: See above for info...
IF NOT EXIST %locked% goto unerr
cls
echo +====================================+
echo.
echo File locked successfully.
echo.
echo +====================================+
pause
set lock=2
goto admin

:creatediag

IF EXIST %unlocked% goto same
IF EXIST %locked% goto same
goto create

:create

:: Code under create will be executed if a user creates a "targeted" directory.
cls
echo +======================================+
echo Are you sure you want to create a new directory?
set /p createinp=(Y/N):
if %createinp%==n goto admin
if %createinp%==N goto admin
if %createinp%==no goto admin
if %createinp%==No goto admin
if %createinp%==NO goto admin
if %createinp%==y goto makedir
if %createinp%==Y goto makedir
if %createinp%==yes goto makedir
if %createinp%==YES goto makedir
if %createinp%==Yes goto makeidr
goto createoperr

:makedir

cls
echo +======================================+
echo Creating new directory...
mkdir %unlocked%
cls
echo +======================================+
IF NOT EXIST %unlocked% goto createerr
echo Directory successfully created!
echo Put all files that you wish to be hidden into %unlocked%
echo The directory is currently unlocked.
echo Make sure to lock it when you are done.
set lock=1
pause
goto admin

:info

:: Info menu here. Not very important, just some info and credits.
:: Put whatever you like here:
:: (I know you're going to remove my name and put in yours. Not cool!)
cls
echo +====================================================================================+
echo This script(File Guardian) creates a hidden directory to store sensitive files.
echo This script uses system attributes to hide files from a user's veiw.
echo Please visit our github page for more info:
echo https://github.com/Owen-Cochell/File-Guardian
echo.
echo This script Was created By:
echo +================================================================+
echo     ____                         ______           __         ____
echo    / __ \_      _____  ____     / ____/___  _____/ /_  ___  / / /
echo   / / / / ^| /^| / / _ \/ __ \   / /   / __ \/ ___/ __ \/ _ \/ / / 
echo  / /_/ /^| ^|/ ^|/ /  __/ / / /  / /___/ /_/ / /__/ / / /  __/ / /  
echo  \____/ ^|__/^|__/\___/_/ /_/   \____/\____/\___/_/ /_/\___/_/_/ 
echo +================================================================+  
pause
goto admin

:err

:: Error screen here:
:: Code will be executed under err if a user tries to lock a locked foulder, and vice versa.
cls
echo +================================================+
echo.
echo You are trying to unlock a directory that is already unlocked,
echo Or you are trying to lock a directory that is already locked.
echo If this is a mistake, please restart the script, and check if the file exists.
echo.
echo +================================================+
pause
goto admin

:unerr

:: Error screen here:
:: Code will be executed under unerr if a error occurs upon attempting to lock/unlock a file.
:: Please contact me if their are any errors you can't resolve.
echo.
echo +=======================================================+
echo.
echo There was an error in unlocking/locking the flash drive.
echo The error should be displayed above.
echo Please check for a possible solution.
echo.
echo +=======================================================+
pause
goto admin

:choiceerr

:: Error screen here:
:: Code under choiceerr will be executed if an invalid choice is chosen.
cls
echo +==============================================+
echo.
echo %choice%
echo.
echo Is not a valid option!
echo.
echo +==============================================+
pause
goto admin

:same

:: Code under same will be executed if their is a possible duplicate
echo +===============================================+
echo You are attempting to create a new directory.
echo A directory of the same name already exists.
echo Making another directory could cause problems.
echo You will now be taken to the prompt screen, but please keep this in mind.
echo.
pause
goto create
 
:createoperror

cls
echo.
echo +===========================================+
echo.
echo %createinp%
echo.
echo Is not a valid option!
echo.
echo +===========================================+
pause
goto create

:createerr

:: Code under createerr will be executed if there is an error making a new directory
echo.
echo +===========================================+
echo.
echo An error has occurred upon the creation of the new directory.
echo It should be displayed above.
echo Please do not attempt to create a new directory until the problem has been resolved.
echo.
echo +===========================================+
pause

:driveerr

echo.
echo +================================================+
echo.
echo An error occured upon changing the working directory of File Guardian.
echo The path you entered:
echo %drive%
echo Is invalid for some reason. Errors should be above.
echo.
echo +================================================+
pause
goto dirselect

:end

:: The end!
exit
