@echo off
setlocal enabledelayedexpansion

set src_dir=%~dp0\work
echo ����ģʽ��
echo 1.�������ļ��ڵ�ǰ·���µ�work�ļ�����
echo.
echo 2.work�ļ����������ļ����ᱻ������
echo.
echo 3.�������ļ����б�dst_name.txt���ڵ�ǰ·���£�
echo   ��ʹ��GB2312����txt
echo   (�Ҵ󴰹����д������ڴ�)
echo.
echo 4.dst_name.txt���ļ����б��ʽΪ��
echo   1)һ��һ���ļ���
echo   2)˳��Ӱ��������
echo   3)�ļ����п��԰����ո�
echo.
echo 5.������ǰ
echo   �Ѷ����ļ��������ļ�����˳�����½�������
echo   �����ļ�����˳��Ҳ������ͬ������������
echo   ����dst_name.txt�е��ļ�������Ҫ����˳��
echo.
echo 6.������ʾ�����ٴ�ȷ�ϸ���ǰ�����ƶ�Ӧ��ϵ��
echo   ����ǰ�������ļ����ݣ���������������
echo.
echo 7.����ʹ��excel��ǰ�༭�ø������ļ���
echo   ��������dst_name.txt��
echo.
echo 8.���������չ��
echo.
echo ֱ�ӻس�ȷ��ʹ������ģʽ��
echo �����˳�
set /p is_lazy=���س���ȷ��
echo.

if defined is_lazy goto :END

cd %src_dir% 

set n=0
for /f "delims=" %%i in ('sort %~dp0dst_name.txt') do (
set dst_name[!n!]=%%i
set /a n+=1
)
rem batch����dst_name�洢�����ĸ������ļ���

set m=%n%
set /a m-=1
rem �����±��0��ʼ����n-1����n��

set n=0
for /f "delims=" %%i in ('dir /b /on *') do ( 
set src_name[!n!]=%%i
set src_exte[!n!]=%%~xi
set /a n+=1
)
rem batch����src_name�洢�����ĸ���ǰ�ļ���
rem batch����src_exte�洢�������ļ���չ��
rem /b��ʾ�����������Ϣ��ֻ��������ļ�����/o��ʾ�����ļ���˳������

for /l %%i in (0,1,%m%) do (
ren "!src_name[%%i]!" "!dst_name[%%i]!!src_exte[%%i]!"
)
rem ʹ��ren�����������������0��ʼ��1Ϊ������λ��n-1(����n-1)����

:END
pause
rem �����쳣ʱ������ͣ�������ˡ������ˣ�����cmd���������в��鿴������Ϣ
rem Ҳ������pause�������call cmd.exe����������