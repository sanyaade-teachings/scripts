@echo off

:: Change this to where you extracted/installed 7zip
set ZIP=%~dp0\..\..\Tools\7zip\7za.exe

for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined CURRENT_DATE set CURRENT_DATE=%%x
set TODAY=%CURRENT_DATE:~0,4%%CURRENT_DATE:~4,2%%CURRENT_DATE:~6,2%

set ARCHIVE=project_anarchy_android_apks_%TODAY%.zip
set ARCHIVE_X86=project_anarchy_android_apks_x86_%TODAY%.zip

set PACKAGE_DIR=%~dp0\_Packaged
set PACKAGE_X86_DIR=%~dp0\_Packaged_X86

set SOURCE_DIR=%VISION_SDK%\Bin\android_vs2010_anarchy\Release
set SOURCE_X86_DIR=%VISION_SDK%\Bin\android_x86_vs2010_anarchy\Release

:: Android

if exist %PACKAGE_DIR% (
del /q /f %PACKAGE_DIR%\*.*
) else (
mkdir %PACKAGE_DIR%
)

echo Copying APK files to package folder...
xcopy /r /s /y /q %SOURCE_DIR%\*.apk %PACKAGE_DIR%\ /EXCLUDE:excludes.txt

echo Zipping APK files into archive... [%ARCHIVE%]
if exist %ARCHIVE% del %ARCHIVE%
%ZIP% a -tzip %ARCHIVE% %PACKAGE_DIR%\* -mx9

:: Android X86

if exist %PACKAGE_X86_DIR% (
del /q /f %PACKAGE_X86_DIR%\*.*
) else (
mkdir %PACKAGE_X86_DIR%
)

echo Copying APK files to package folder...
xcopy /r /s /y /q %SOURCE_X86_DIR%\*.apk %PACKAGE_X86_DIR%\ /EXCLUDE:excludes.txt

echo Zipping APK files into archive... [%ARCHIVE_X86%]
if exist %ARCHIVE_X86% del %ARCHIVE_X86%
%ZIP% a -tzip %ARCHIVE_X86% %PACKAGE_X86_DIR%\* -mx9

goto END

:MISSING_SOURCE

echo Source directory does not exist: %SOURCE_DIR%
echo Make sure you set the VISION_SDK path to point at the root directory
echo of your Project Anarchy SDK (e.g. C:\Havok\AnarchySDK)
goto END

:ERROR

echo Ran into an IO error!
goto END

:END