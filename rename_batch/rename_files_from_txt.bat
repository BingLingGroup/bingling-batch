@echo off
setlocal enabledelayedexpansion

set src_dir=%~dp0work
echo 懒人模式：
echo 1.待改名文件在当前路径下的work文件夹内
echo.
echo 2.work文件夹内所有文件都会被重命名
echo.
echo 3.改名后文件名列表dst_list.txt处在当前路径下，
echo   请使用GB2312编码txt
echo   (我大窗国自有窗国情在此)
echo.
echo 4.dst_list.txt的文件名列表格式为：
echo   1)一行一个文件名
echo   2)顺序不影响重命名
echo   3)文件名中可以包含空格
echo.
echo 5.重命名前
echo   已对新文件名按照文件名的顺序重新进行排序，
echo   而旧文件名的顺序也按照相同方法进行排序，
echo   所以dst_list.txt中的文件名不需要考虑顺序
echo.
echo 6.不会提示给予再次确认改名前后名称对应关系，
echo   改名前请做好文件备份，以免出现意外情况
echo.
echo 7.建议使用excel提前编辑好改名后文件名
echo   并拷贝到dst_list.txt中
echo.
echo 8.不会更改扩展名
echo.
echo 直接回车确认使用懒人模式，
echo 否则退出
set /p is_lazy=按回车键确认
echo.

if defined is_lazy goto :END

sort dst_list.txt /o dst_list.txt

set n=0
for /f "delims=" %%i in (dst_list.txt) do (
set dst_name[!n!]=%%i
set /a n+=1
)
rem batch数组dst_name存储排序后的改名后文件名

set m=%n%
set /a m-=1
rem 数组下标从0开始，到n-1就是n个

cd %src_dir% 

set n=0
for /f "delims=" %%i in ('dir /b *') do ( 
set src_name[!n!]=%%i
set src_exte[!n!]=%%~xi
set /a n+=1
)
rem batch数组src_name存储排序后的改名前文件名
rem batch数组src_exte存储排序后的文件扩展名
rem /b表示不输出多余信息，只按行输出文件名，/o表示按照文件名顺序排序

for /l %%i in (0,1,%m%) do (
ren "!src_name[%%i]!" "!dst_name[%%i]!!src_exte[%%i]!"
)
rem 使用ren命令进行重命名，从0开始以1为递增单位到n-1(包括n-1)结束

:END
endlocal
pause
rem 运行异常时不会暂停，会闪退。若闪退，请在cmd界面下运行并查看错误信息
rem 也可以在pause后面加上call cmd.exe来避免闪退