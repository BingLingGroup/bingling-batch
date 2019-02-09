@echo on
setlocal enabledelayedexpansion

rem 下划线转空格，只会转换当前文件夹的文件

for /f "delims=" %%i in ('dir /b *.*') do (
    if "%%i" NEQ "%~f0" (
        set "foo=%%~nxi"
        set foo=!foo:_= !
        ren "%%~fi" "!foo!"
    )
)

endlocal
call cmd