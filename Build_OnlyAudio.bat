@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

rem Создаем лог-файл
set "LOGFILE=Build_OnlyAudio_log.txt"
echo Начало сборки аудио: %date% %time% > "%LOGFILE%"
echo Mental Omega Vision Audio >> "%LOGFILE%"

title MOVision_Builder_OnlyAudio
echo Mental Omega Vision Audio
echo.

rem Проверка существования \ создание папки Build
echo Проверка существования предыдущей сборки... >> "%LOGFILE%"
echo Проверка существования предыдущей сборки...
if exist ".\Build" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
    echo Найдена предыдущая папка сборки. 
) else ( 
    mkdir ".\Build" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
    echo Папка для сборки создана.
)
echo.

rem Сборка mix файла дополнительных аудиотреков Mental Omega Vision
echo Сборка mix-файла дополнительных аудиотреков MO Vision... >> "%LOGFILE%"
echo Сборка mix-файла дополнительных аудиотреков MO Vision...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\expandmo90" --mix ".\Build\expandmo90.mix" >> "%LOGFILE%" 2>&1
echo.

rem Заглушка для аудиотреков
echo Проверка на отсутствие файлов игровых аудиотреков и создание заглушек... >> "%LOGFILE%"
echo Проверка на отсутствие файлов игровых аудиотреков и создание заглушек...
where /Q /R ".\Build" expandmo90.mix && echo Заглушка для игровых аудиотреков не требуется. >> "%LOGFILE%" || fsutil file createnew ".\Build\expandmo90.mix" 1024 >> "%LOGFILE%" 2>&1
echo.

echo Сборка mix файла дополнительных аудиотреков MO Vision завершена. >> "%LOGFILE%"
echo Сборка mix файла дополнительных аудиотреков MO Vision завершена. 
echo Можно закрыть эту консоль.
echo Завершение сборки аудио: %date% %time% >> "%LOGFILE%"
pause