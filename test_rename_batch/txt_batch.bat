@echo off

for /f "delims=" %%i in (list.txt) do (
    echo %%i > ^"work\%%i^"
)

pause 