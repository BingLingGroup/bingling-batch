@echo on
if "%1" EQU "" goto :QUESTION
rem 不通过命令行参数运行，直接打开的情况，跳转至询问界面
set work_dir=%2
rem 以下通过命令行参数运行
if not defined work_dir goto :GET_1
rem 第3个参数，即额外排除的文件名不存在
rem 第1个参数给定了工作文件夹
goto :GET_2
rem 第3个参数存在
rem 需要记录额外排除的文件名
 
:QUESTION
echo 本批处理可以将某一文件夹内的文件逐个压缩
echo.
echo 首先确认命令行7z，也就是7z.exe是否添加到环境变量-系统变量
echo 或者确认7z.exe在待压缩文件所在文件夹
echo.
echo 输入待压缩的文件所在文件夹
set /p work_dir=(默认为当前文件夹，回车为默认): 
echo.
if not defined work_dir set work_dir=%~dp0

echo 输入压缩后的压缩格式后缀(包括点)
set /p dst_exte=(默认为.7z，请输入7z支持的压缩格式，回车为默认): 
set run_bat_name=""
goto :WORK

:GET_1
set work_dir=%1
set run_bat_name=""
goto :WORK

:GET_2
set work_dir=%1
set run_bat_name=%2

:WORK
if not defined dst_exte set dst_exte=.7z
cd %work_dir%
for /f "delims=^" %%i in ('dir /b *') do (
    if %%i NEQ 7z.exe (
        if %%i NEQ %~nx0 (
            if %%i NEQ %run_bat_name% (
                7z a ^"%%~ni%dst_exte%^" ^"%%i^"
            )
        )
    )
)
pause
rem 运行异常时不会暂停，会闪退。若闪退，请在cmd界面下运行并查看错误信息
rem 也可以在pause后面加上call cmd.exe来避免闪退