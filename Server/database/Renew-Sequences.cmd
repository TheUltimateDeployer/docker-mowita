@echo off
set /P ORACLE_SID=Oracle SID:
set /P user=Benutzer:
set /P passwort=Passwort:

@set ORACLE_SID=%ORACLE_SID%

tnsping %ORACLE_SID%

sqlplus %user%/%passwort%@%ORACLE_SID% @Refresh-Sequences.sql

echo Fertig!
pause
