@echo off

::
:: Run this script as Administrator.
::

set VS_BIN=C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin

call "%VS_BIN%\vcvars32.bat"

set WORKSPACE=%VISION_SDK%\Workspace\Android_VS2010_anarchy
set SLN_ALL=%WORKSPACE%\HavokVision_All_Android_VS2010_anarchy.sln
set SLN_SAMPLES=%WORKSPACE%\HavokVision_Samples_Android_VS2010_anarchy.sln

set WORKSPACE_X86=%VISION_SDK%\Workspace\Android_x86_VS2010_anarchy
set SLN_ALL_X86=%WORKSPACE_X86%\HavokVision_All_Android_x86_VS2010_anarchy.sln
set SLN_SAMPLES_X86=%WORKSPACE_X86%\HavokVision_Samples_Android_x86_VS2010_anarchy.sln

set WORKSPACE_WIN=%VISION_SDK%\Workspace\Win32_VS2010_anarchy_DX9
set SLN_ALL_WIN=%WORKSPACE_WIN%\HavokVision_All_Win32_VS2010_anarchy_DX9.sln
set SLN_SAMPLES_WIN=%WORKSPACE_WIN%\HavokVision_Samples_Win32_VS2010_anarchy_DX9.sln

msbuild %SLN_ALL% /t:Build /p:Configuration=Release
msbuild %SLN_SAMPLES% /t:Build /p:Configuration=Release

msbuild %SLN_ALL_X86% /t:Build /p:Configuration=Release
msbuild %SLN_SAMPLES_X86% /t:Build /p:Configuration=Release

msbuild %SLN_ALL_WIN% /t:Build /p:Configuration="Dev DLL"
msbuild %SLN_SAMPLES_WIN% /t:Build /p:Configuration="Dev DLL"

pause