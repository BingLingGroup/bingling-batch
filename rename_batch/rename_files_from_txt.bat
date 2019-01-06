@echo off
setlocal enabledelayedexpansion

set src_dir="%~dp0work"
if not exist %src_dir% goto :PROMPT
rem 如果工作文件夹尚未建立，转至全提示模式

dir %src_dir% /b >src_list.txt
    
if not exist dst_list.txt goto :PROMPT
rem 如果目标文件名列表尚未创建，转至全提示模式

goto :CHECK

:PROMPT
echo.
echo ^[警告^]这里若不退出，下一步将进行重命名
echo 请确认已做好文件备份，以防止意外情况发生
echo.
echo ^[警告^]请确保不要使用任何windows
echo 文件系统禁止使用的符号进行重命名
echo.
echo 全提示模式：
echo.
echo 1.待改名文件在当前路径下的work文件夹内
echo.
echo 2.work文件夹内所有文件都会被重命名
echo.
echo 3.改名后文件名列表dst_list.txt处在当前路径下，
echo   请使用GB2312编码txt，否则会有乱码
echo   (我大窗国自有窗国情在此)
echo.
echo 4.dst_list.txt的文件名列表格式为：
echo   1)一行一个文件名
echo   2)顺序不影响重命名
echo   3)文件名中可以包含空格
echo.
echo 5.输出这段提示信息前，
echo   如果你的work文件夹已存在，
echo   批处理已将其中的文件名输出成列表
echo   到当前路径下的src_list.txt中
echo.
echo 6.请根据自己喜好创建dst_list.txt，
echo   因为下一步程序
echo   1) 不会再改变dst_list.txt
echo   2) 根据src_list.txt和dst_list.txt进行重命名
echo      如果你有特殊需要，可以对src_list.txt中的文件名
echo      进行编辑操作
echo.
echo 7.不会提示给予再次确认改名前后名称对应关系，
echo   改名前请做好文件备份，以免出现意外情况
echo.
echo 8.建议使用excel提前编辑好改名后文件名
echo   并拷贝到dst_list.txt中
echo   注意使用Ctrl-H搜索替换掉excel特有大空格
echo.
echo 9.不会更改扩展名
echo.
echo 10.如果你做好了1-4的准备，再重新运行本批处理
echo    将会进入到另一个重命名模式
echo.
echo 11.重命名之后
echo    src_list.txt和dst_list.txt不会自动删除
echo.
echo 直接回车确认开始重命名，
echo 否则退出
set /p is_lazy=按回车键确认
echo.

if not exist src_list.txt dir %src_dir% /b >src_list.txt
goto :RUN

:CHECK
sort dst_list.txt /o dst_list.txt
echo.
echo ^[警告^]这里若不退出，下一步将进行重命名
echo 请确认已做好文件备份，以防止意外情况发生
echo.
echo ^[警告^]请确保不要使用任何windows
echo 文件系统禁止使用的符号进行重命名
echo.
echo 核对模式：
echo.
echo 1.为了防止你的排序方法
echo   和batch文件名顺序有不一致情况，
echo   已对新文件名列表
echo   按照文件名的顺序重新进行排序，
echo   但是这不代表两种文件顺序
echo   就一定一一对应
echo.
echo 2.^[警告^]如果新旧文件名差异较大，
echo   建议逐行核对
echo.
echo 3.下一步程序
echo   1) 不会再改变dst_list.txt
echo   2) 根据src_list.txt和dst_list.txt进行重命名
echo      如果你有特殊需要，可以对src_list.txt中的文件名
echo      进行编辑操作
echo.
echo 4.重命名之后
echo    src_list.txt和dst_list.txt不会自动删除
echo.
echo 直接回车确认开始重命名，
echo 否则退出
set /p is_lazy=按回车键确认
echo.
if not exist src_list.txt goto :END

:RUN
if defined is_lazy goto :END
if not exist dst_list.txt goto :END

set n=0
for /f "delims=" %%i in (dst_list.txt) do (
set dst_name[!n!]=%%i
set /a n+=1
)
rem batch数组dst_name存储排序后的改名后文件名

set m=%n%
set /a m-=1
rem 数组下标从0开始，到n-1就是n个

set n=0
for /f "delims=" %%i in (src_list.txt) do ( 
set src_name[!n!]=%%i
set src_exte[!n!]=%%~xi
set /a n+=1
)
rem batch数组src_name存储排序后的改名前文件名
rem batch数组src_exte存储排序后的文件扩展名
rem /b表示不输出多余信息，只按行输出文件名，/o表示按照文件名顺序排序

set /a n-=1

if %n% NEQ %m% goto :ECHOEND

cd %src_dir%

for /l %%i in (0,1,%m%) do (
ren "!src_name[%%i]!" "!dst_name[%%i]!!src_exte[%%i]!"
)
rem 使用ren命令进行重命名，从0开始以1为递增单位到n-1(包括n-1)结束

goto :END

:ECHOEND
echo 两个文件列表文件名数量不一致
echo 重命名中止
echo.
:END
endlocal
pause
rem 运行异常时不会暂停，会闪退。若闪退，请在cmd界面下运行并查看错误信息
rem 也可以在pause后面加上call cmd.exe来避免闪退