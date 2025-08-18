@echo off

:: Проверяем версию Windows
for /f "tokens=4-5 delims=. " %%i in ('ver') do (
    set WinVerMajor=%%i
    set WinVerMinor=%%j
)


if "%WinVerMajor%"=="5" (
	:: cmd.exe для windows xp/2003 внутренне вызывает функцию MultiByteToWideChar с использованием аргумента dwFlags со значением 1. 
	:: В документации сказано следующее: «Для UTF-8 dwFlags должен быть установлен в 0. В противном случае функция завершается сбоем».
	:: Патч для этого здесь: https://github.com/carlos-montiers/consolesoft-mirror/releases/download/latest/cmd_xp_65001_fix.zip
	echo Fix cmd.exe for Windows XP/2003...
	Copy "%SystemRoot%\system32\cmd.exe"
	bwpatchw.exe cmd.exe -f cmd-utf8-new.patch
	Copy /Y cmd.exe "%SystemRoot%\system32\cmdutf8.exe"
	Set "key=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cmd.exe"
	Reg.exe add "%key%" /v "Debugger" /d "%SystemRoot%\system32\cmdutf8.exe" /f

	:: Устанавливаем шрифт Lucida Console для cmd, чтобы система использовала шрифт Terminal для кириллицы
    echo Install font Lucida Console for cmd.exe...
    reg add "HKEY_CURRENT_USER\Console" /v "FaceName" /t REG_SZ /d "Lucida Console" /f >nul 2>&1
    reg add "HKEY_CURRENT_USER\Console" /v "FontFamily" /t REG_DWORD /d 0x00000036 /f >nul 2>&1
    reg add "HKEY_CURRENT_USER\Console" /v "FontSize" /t REG_DWORD /d 0x000c0000 /f >nul 2>&1
) else (
    echo ################################################################
	echo # Attention! This script is designed for Windows XP/2003       #
    echo # Current version of Windows: NT%Winvermajor%.%Winverminor%    #
    echo # Font Lucida Console will not be installed                    #
    echo # Click Ctrl+C for canceling or Enter to continue ...          #
    echo ################################################################
    pause
)

