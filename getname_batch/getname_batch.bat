@echo off
rem 将文件夹内指定文件名写入到txt中，不包括子文件夹
set exte=".bat"
rem 使用*号通配符表示所有扩展名，扩展名需加点，除非你有特殊需要
set file_name="*"
rem 匹配特定文件名
set dir_name=%~dp0
rem 指定特定目录，%~dp0表示当前目录
set txt_name="list.txt"
rem 指定txt输出目录和文件名，默认为当前目录下的list.txt

@echo on
cd %dir_name%
dir "%file_name:~1,-1%%exte:~1,-1%" /b >list.txt