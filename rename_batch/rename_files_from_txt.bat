@echo off
setlocal enabledelayedexpansion

set src_dir="%~dp0work"
if not exist %src_dir% goto :PROMPT
rem ��������ļ�����δ������ת��ȫ��ʾģʽ

dir %src_dir% /b >src_list.txt
    
if not exist dst_list.txt goto :PROMPT
rem ���Ŀ���ļ����б���δ������ת��ȫ��ʾģʽ

goto :CHECK

:PROMPT
echo.
echo ^[����^]���������˳�����һ��������������
echo ��ȷ���������ļ����ݣ��Է�ֹ�����������
echo.
echo ^[����^]��ȷ����Ҫʹ���κ�windows
echo �ļ�ϵͳ��ֹʹ�õķ��Ž���������
echo.
echo ȫ��ʾģʽ��
echo.
echo 1.�������ļ��ڵ�ǰ·���µ�work�ļ�����
echo.
echo 2.work�ļ����������ļ����ᱻ������
echo.
echo 3.�������ļ����б�dst_list.txt���ڵ�ǰ·���£�
echo   ��ʹ��GB2312����txt�������������
echo   (�Ҵ󴰹����д������ڴ�)
echo.
echo 4.dst_list.txt���ļ����б��ʽΪ��
echo   1)һ��һ���ļ���
echo   2)˳��Ӱ��������
echo   3)�ļ����п��԰����ո�
echo.
echo 5.��������ʾ��Ϣǰ��
echo   ������work�ļ����Ѵ��ڣ�
echo   �������ѽ����е��ļ���������б�
echo   ����ǰ·���µ�src_list.txt��
echo.
echo 6.������Լ�ϲ�ô���dst_list.txt��
echo   ��Ϊ��һ������
echo   1) �����ٸı�dst_list.txt
echo   2) ����src_list.txt��dst_list.txt����������
echo      �������������Ҫ�����Զ�src_list.txt�е��ļ���
echo      ���б༭����
echo.
echo 7.������ʾ�����ٴ�ȷ�ϸ���ǰ�����ƶ�Ӧ��ϵ��
echo   ����ǰ�������ļ����ݣ���������������
echo.
echo 8.����ʹ��excel��ǰ�༭�ø������ļ���
echo   ��������dst_list.txt��
echo   ע��ʹ��Ctrl-H�����滻��excel���д�ո�
echo.
echo 9.���������չ��
echo.
echo 10.�����������1-4��׼�������������б�������
echo    ������뵽��һ��������ģʽ
echo.
echo 11.������֮��
echo    src_list.txt��dst_list.txt�����Զ�ɾ��
echo.
echo ֱ�ӻس�ȷ�Ͽ�ʼ��������
echo �����˳�
set /p is_lazy=���س���ȷ��
echo.

if not exist src_list.txt dir %src_dir% /b >src_list.txt
goto :RUN

:CHECK
sort dst_list.txt /o dst_list.txt
echo.
echo ^[����^]���������˳�����һ��������������
echo ��ȷ���������ļ����ݣ��Է�ֹ�����������
echo.
echo ^[����^]��ȷ����Ҫʹ���κ�windows
echo �ļ�ϵͳ��ֹʹ�õķ��Ž���������
echo.
echo �˶�ģʽ��
echo.
echo 1.Ϊ�˷�ֹ������򷽷�
echo   ��batch�ļ���˳���в�һ�������
echo   �Ѷ����ļ����б�
echo   �����ļ�����˳�����½�������
echo   �����ⲻ���������ļ�˳��
echo   ��һ��һһ��Ӧ
echo.
echo 2.^[����^]����¾��ļ�������ϴ�
echo   �������к˶�
echo.
echo 3.��һ������
echo   1) �����ٸı�dst_list.txt
echo   2) ����src_list.txt��dst_list.txt����������
echo      �������������Ҫ�����Զ�src_list.txt�е��ļ���
echo      ���б༭����
echo.
echo 4.������֮��
echo    src_list.txt��dst_list.txt�����Զ�ɾ��
echo.
echo ֱ�ӻس�ȷ�Ͽ�ʼ��������
echo �����˳�
set /p is_lazy=���س���ȷ��
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
rem batch����dst_name�洢�����ĸ������ļ���

set m=%n%
set /a m-=1
rem �����±��0��ʼ����n-1����n��

set n=0
for /f "delims=" %%i in (src_list.txt) do ( 
set src_name[!n!]=%%i
set src_exte[!n!]=%%~xi
set /a n+=1
)
rem batch����src_name�洢�����ĸ���ǰ�ļ���
rem batch����src_exte�洢�������ļ���չ��
rem /b��ʾ�����������Ϣ��ֻ��������ļ�����/o��ʾ�����ļ���˳������

set /a n-=1

if %n% NEQ %m% goto :ECHOEND

cd %src_dir%

for /l %%i in (0,1,%m%) do (
ren "!src_name[%%i]!" "!dst_name[%%i]!!src_exte[%%i]!"
)
rem ʹ��ren�����������������0��ʼ��1Ϊ������λ��n-1(����n-1)����

goto :END

:ECHOEND
echo �����ļ��б��ļ���������һ��
echo ��������ֹ
echo.
:END
endlocal
pause
rem �����쳣ʱ������ͣ�������ˡ������ˣ�����cmd���������в��鿴������Ϣ
rem Ҳ������pause�������call cmd.exe����������