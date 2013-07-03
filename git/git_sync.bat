@echo off

set HOME=%~dp0

set GIT_BIN=%~dp0\Tools\Git\bin
set GIT=%GIT_ROOT%\git.exe

:: Add git executable to the path
set PATH=%GIT_BIN%;%PATH%

set PA_GIT_SERVER_HTTPS=https://github.com/projectanarchy/projectanarchy.git
set PA_GIT_SERVER=git@github.com:projectanarchy/projectanarchy.git
set GIT_TEMP_FOLDER=_git_temp

if exist %GIT_TEMP_FOLDER% rmdir /q /s %GIT_TEMP_FOLDER%
if exist .ssh (
git clone --no-checkout %PA_GIT_SERVER% %GIT_TEMP_FOLDER%
) else (
git clone --no-checkout %PA_GIT_SERVER_HTTPS% %GIT_TEMP_FOLDER%
)

if exist %GIT_TEMP_FOLDER% (
set CURRENT_DIR=%CD%
cd %GIT_TEMP_FOLDER%
mv .git ..
cd %CURRENT_DIR%

git reset --hard HEAD
)

if exist %GIT_TEMP_FOLDER% rmdir /q /s %GIT_TEMP_FOLDER%