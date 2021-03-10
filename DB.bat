@echo off
title Database
:DB
ECHO 1. Import_DB
ECHO 2. Export_DB
ECHO 3. Create_DB
ECHO 4. DROP_DB
set /p choice=Enter Option:
if '%choice%'=='' ECHO "%choice%" is not valid please try again
if '%choice%'=='1' goto import
if '%choice%'=='2' goto export
if '%choice%'=='3' goto create
if '%choice%'=='4' goto drop
ECHO.
goto DB


:drop
echo Database Drop
for /f "delims=" %%a in (config.ini) do set %%a
c:\xampp\mysql\bin\mysql --user=%usr% --password=%pass% -e "SHOW DATABASES"
set /P dbdrop="Enter Name Of Database To Drop: "
c:\xampp\mysql\bin\mysql.exe --user=%usr% --password=%pass% -e "DROP DATABASE %dbdrop%"
echo Database Droped
goto enddb


:create
echo Database Create
for /f "delims=" %%a in (config.ini) do set %%a
set /P dbnew="Enter Name Of Database To Create: "
c:\xampp\mysql\bin\mysql.exe --user=%usr% --password=%pass% -e "CREATE DATABASE %dbnew%"
echo Database Created
goto enddb

:import
echo Database Import
for /f "delims=" %%a in (config.ini) do set %%a
Echo To Terminate Program Press CTRL+C Or the X button at top right of program
rem SET usr=root
rem SET pass=root
c:\xampp\mysql\bin\mysql --user=%usr% --password=%pass% -e "SHOW DATABASES"
c:
cd c:\Users\%USERNAME%\Downloads
echo List of files in current directory:
dir /b *.sql
set /P dbname="Enter Name Of Database To Import in: "
set /P dbfilename="Enter Filename to be Imported in %dbname%: "
c:\xampp\mysql\bin\mysql.exe --user=%usr% --password=%pass% %dbname% < %dbfilename%
echo Import is completed!
goto enddb




:export
echo Database Export
for /f "delims=" %%a in (config.ini) do set %%a
Echo To Terminate Program Press CTRL+C Or the X button at top right of program
Echo Note: Make sure you know the Database name located in phpmyadmin &
Echo When the task finsihes your files will be located at C:\Users\%USERNAME%\Downloads
c:\xampp\mysql\bin\mysql --user=%usr% --password=%pass% -e "SHOW DATABASES"
set /P dbname="Enter Name Of Database To Export: "
set /P dbfilename="Enter Filename to be Exported as: "
:start
ECHO.
ECHO 1. Export Once
ECHO 2. Export every 2 min
set /p choice=Enter Option:
if '%choice%'=='' ECHO "%choice%" is not valid please try again
if '%choice%'=='1' goto once
if '%choice%'=='2' goto every_2_min
ECHO.
goto start
:once
ECHO Exporting %dbname% as %dbfilename% for Once
c:\xampp\mysql\bin\mysqldump --user=%usr% --password=%pass% --result-file="C:\Users\%USERNAME%\Downloads\%dbfilename%.sql" %dbname%
echo Exported %dbname% as %dbfilename% located at path C:\Users\%USERNAME%\Downloads
start C:\Users\%USERNAME%\Downloads
Echo To Terminate Program Press CTRL+C Or the X button at top right of program
goto end
:every_2_min
ECHO Exporting %dbname% as %dbfilename% for every 2 min
:a
c:\xampp\mysql\bin\mysqldump --user=%usr% --password=%pass% --result-file="C:\Users\%USERNAME%\Downloads\%dbfilename%.sql" %dbname%
ECHO Exported %dbname% as %dbfilename% located at path C:\Users\%USERNAME%\Downloads (Next export in 2min)
Timeout /T 120 /nobreak >nul
goto a
goto end
:end












goto enddb
:enddb
pause >nul
