@echo off
rem ���ļ�����ָ���ļ���д�뵽txt�У����������ļ���
set exte=".bat"
rem ʹ��*��ͨ�����ʾ������չ������չ����ӵ㣬��������������Ҫ
set file_name="*"
rem ƥ���ض��ļ���
set dir_name=%~dp0
rem ָ���ض�Ŀ¼��%~dp0��ʾ��ǰĿ¼
set txt_name="list.txt"
rem ָ��txt���Ŀ¼���ļ�����Ĭ��Ϊ��ǰĿ¼�µ�list.txt

@echo on
cd %dir_name%
dir "%file_name:~1,-1%%exte:~1,-1%" /b >list.txt