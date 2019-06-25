@echo off
set z7_bat_name="7z_batch.bat"
rem 7z_batch文件名
set work_path="C:\userfile\Desktop\压制\batch脚本\test\work"
rem 待压缩文件所在文件夹，即工作文件夹
set run_bat_name="run_7z_batch.bat"
rem 需要额外忽略的一个文件名，若此脚本在工作文件夹内，则需要忽略
@echo on
%z7_bat_name% %work_path% %run_bat_name%
pause