@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"

setlocal enabledelayedexpansion

set "sys_path_loc=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
set key=path
set sys_path=
set "time=%date:~0,4%_%date:~5,2%_%date:~8,2%_%time:~0,2%_%time:~3,2%_%time:~6,2%"
set "PYHOME=%HOMEDRIVE%\Python27"

rem does path exist
reg query "%sys_path_loc%" /v %key% >"%time%_sys_path_query_result.txt"

if %ERRORLEVEL%==0 (
    rem get value
    goto STR_OLD
) else goto CRT_NEW

:STR_OLD
for /f "delims=^" %%a in ('reg query "%sys_path_loc%" /v %key%') do (
    set "last_line=%%a"
)

set i=0

:STR_SPLITTER
for /f "tokens=1,*" %%a in ('echo %%last_line%%') do (
    set /a i+=1
    if "%i%" GEQ "2" (
        set "sys_path=%last_line%"
        goto CRT_NEW
    )
    set "last_line=%%b"
    if not defined last_line (
        echo 系统变量修改失败，请尝试手动修改
        goto END
    )
    goto STR_SPLITTER
)

:CRT_NEW
echo %sys_path% > "%time%_sys_path_backup.txt"

rem delete python27 and python37 paths
set "sys_path=%sys_path:C:\Python27;=%"
set "sys_path=%sys_path:C:\Python27\Scripts;=%"
set "sys_path=%sys_path:C:\Python37;=%"
set "sys_path=%sys_path:C:\Python37\Scripts;=%"
set "sys_path=!sys_path:%%PY_HOME%%;=!"
set "sys_path=!sys_path:%%PY_HOME%%\Scripts;=!"

echo %sys_path%

rem Set Path variable
rem if necessary, add %%PY_HOME%%\Lib;%%PY_HOME%%\DLLs;%%PY_HOME%%\Lib\lib-tk;

if "%sys_path:~-1%" EQU ";" (
    @echo on
    setx Path "%sys_path%%%PY_HOME%%;%%PY_HOME%%\Scripts;" /m
    @echo off
)
@echo on
setx Path "%sys_path%;%%PY_HOME%%;%%PY_HOME%%\Scripts;" /m
@echo off
start win_py_sw_syspath.bat

:END
endlocal
call cmd
