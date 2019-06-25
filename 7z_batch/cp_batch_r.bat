@echo off
xcopy ".\work\*.7z" ".\release\" /e
pause
rem 运行异常时不会暂停，会闪退。若闪退，请在cmd界面下运行并查看错误信息
rem 也可以在pause后面加上call cmd.exe来避免闪退