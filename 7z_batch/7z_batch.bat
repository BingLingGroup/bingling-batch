@echo on
if "%1" EQU "" goto :QUESTION
rem ��ͨ�������в������У�ֱ�Ӵ򿪵��������ת��ѯ�ʽ���
set work_dir=%2
rem ����ͨ�������в�������
if not defined work_dir goto :GET_1
rem ��3���������������ų����ļ���������
rem ��1�����������˹����ļ���
goto :GET_2
rem ��3����������
rem ��Ҫ��¼�����ų����ļ���
 
:QUESTION
echo ����������Խ�ĳһ�ļ����ڵ��ļ����ѹ��
echo.
echo ����ȷ��������7z��Ҳ����7z.exe�Ƿ���ӵ���������-ϵͳ����
echo ����ȷ��7z.exe�ڴ�ѹ���ļ������ļ���
echo.
echo �����ѹ�����ļ������ļ���
set /p work_dir=(Ĭ��Ϊ��ǰ�ļ��У��س�ΪĬ��): 
echo.
if not defined work_dir set work_dir=%~dp0

echo ����ѹ�����ѹ����ʽ��׺(������)
set /p dst_exte=(Ĭ��Ϊ.7z��������7z֧�ֵ�ѹ����ʽ���س�ΪĬ��): 
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
rem �����쳣ʱ������ͣ�������ˡ������ˣ�����cmd���������в��鿴������Ϣ
rem Ҳ������pause�������call cmd.exe����������