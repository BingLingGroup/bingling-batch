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

set "pyhome_loc=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
set key=PY_HOME
set pyhome_1=27
set pyhome_2=37
set pyhome=

rem does path exist

echo.
@echo on
reg query "%pyhome_loc%" /v %key% >nul
@echo off

if %ERRORLEVEL%==0 (
    rem get value
    goto STR_OLD_2
) else goto CRT_NEW_2

:STR_OLD_2
for /f "delims=^" %%a in ('reg query "%pyhome_loc%" /v %key%') do (
    set "last_line=%%a"
)

set i=0

:STR_SPLITTER
for /f "tokens=1,*" %%a in ('echo %%last_line%%') do (
    set /a i+=1
    if "%i%" GEQ "2" (
        set "pyhome=%last_line%"
        goto CH_OLD_2
    )
    set "last_line=%%b"
    if not defined last_line (
        goto END
    )
    goto STR_SPLITTER
)

:CRT_NEW_2
echo.
echo ����Ҫ�½�PY_HOMEϵͳ����
echo ����������Ҫʹ�õ�python�������ڵ��ļ�·��
echo ���س�ȷ��
set /p pyhome=
setx PY_HOME "%pyhome%" /m
goto :END

:CH_OLD_2
if "%pyhome:~-2%" EQU "%pyhome_1%" (
@echo on
   setx PY_HOME "%pyhome:~0,-2%%pyhome_2%" /m
@echo off
   echo.
   echo ��ǰpython�������л�ΪPython%pyhome_2%^(%pyhome:~0,-2%%pyhome_2%^)
   echo ��ע�������Ѿ��򿪵������л�Powershell����������Ч
   echo.
   goto END
)
@echo on
setx PY_HOME "%pyhome:~0,-2%%pyhome_1%" /m
@echo off
echo.
echo ��ǰpython�������л�ΪPython%pyhome_1%^(%pyhome:~0,-2%%pyhome_1%^)
echo ��ע�������Ѿ��򿪵������л�Powershell����������Ч
echo.

:END
call cmd