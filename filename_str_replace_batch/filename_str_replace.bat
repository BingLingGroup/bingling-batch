@echo on
setlocal enabledelayedexpansion

rem �»���ת�ո�ֻ��ת����ǰ�ļ��е��ļ�

for /f "delims=" %%i in ('dir /b *.*') do (
    if "%%i" NEQ "%~f0" (
        set "foo=%%~nxi"
        set foo=!foo:_= !
        ren "%%~fi" "!foo!"
    )
)

endlocal
call cmd