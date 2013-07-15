@echo off

::
:: WARNING: This will overwrite existing changes to your source files
::          and will delete the local .git repository.
::

set GIT_BIN=C:\Projects\ProjectAnarchy\Tools\PortableGit-1.8.0-preview20121022\bin
set PATH=%GIT_BIN%;%PATH%

set PA_GIT_SERVER_HTTPS=https://github.com/projectanarchy/projectanarchy.git
set GIT_TEMP_FOLDER=%~dp0_git_temp

:: Remove the existing target folders if they exist
echo Removing existing target folders...
if exist .git rmdir /q /s .git
if exist %GIT_TEMP_FOLDER% rmdir /q /s %GIT_TEMP_FOLDER%

echo Cloning Git repository into temporary folder...
git clone --no-checkout %PA_GIT_SERVER_HTTPS% %GIT_TEMP_FOLDER%

if exist %GIT_TEMP_FOLDER% (
	echo Moving Git repository to root of Anarchy SDK folder..
	cd %GIT_TEMP_FOLDER%
	attrib -H .git
	move .git ..
	cd ..

	git reset --hard HEAD
) else ( goto giterror )

echo Cleaning up temporary folder...
if exist %GIT_TEMP_FOLDER% rmdir /q /s %GIT_TEMP_FOLDER%

:gitfailure
echo Git failure, make sure Git is installed and on your path
echo See http://www.projectanarchy.com/git for more details
goto end

:success
echo Finished syncing to newest source code!
goto end

:end
pause
