@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

rem Создаем лог-файл
set "LOGFILE=Build_OnlyVideo_log.txt"
echo Начало сборки видео: %date% %time% > "%LOGFILE%"
echo Mental Omega Vision Video >> "%LOGFILE%"

title MOVision_Builder_OnlyVideo
echo Mental Omega Vision Video
echo.

rem Проверка существования \ создание папки Build
echo Проверка существования предыдущей сборки... >> "%LOGFILE%"
echo Проверка существования предыдущей сборки...
if exist ".\Build\MOV\RA2_and_RA2YR_Remake" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\RA2_and_RA2YR_Remake" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
echo.

rem Сборка mix файлов катсцен Mental Omega Vision
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 720p... >> "%LOGFILE%"
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 720p...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_720p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_720p.mix" >> "%LOGFILE%" 2>&1
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 768p... >> "%LOGFILE%"
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 768p...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_768p.mix" >> "%LOGFILE%" 2>&1
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 1080p... >> "%LOGFILE%"
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 1080p...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p.mix" >> "%LOGFILE%" 2>&1
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 1440p... >> "%LOGFILE%"
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 1440p...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p.mix" >> "%LOGFILE%" 2>&1
echo.

rem Заглушки для катсцен
echo Проверка на отсутствие файлов катсцен и создание заглушек... >> "%LOGFILE%"
echo Проверка на отсутствие файлов катсцен и создание заглушек...
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_720p.mix && echo Заглушка катсцен для разрешений 720p не требуется. >> "%LOGFILE%" || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_720p.mix" 1024 >> "%LOGFILE%" 2>&1
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_768p.mix && echo Заглушка катсцен для разрешений 768p не требуется. >> "%LOGFILE%" || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_768p.mix" 1024 >> "%LOGFILE%" 2>&1
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_1080p.mix && echo Заглушка катсцен для разрешений 1080p не требуется. >> "%LOGFILE%" || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_1440p.mix && echo Заглушка катсцен для разрешений 1440p не требуется. >> "%LOGFILE%" || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p.mix" 1024 >> "%LOGFILE%" 2>&1
echo.

echo Сборка mix файлов катсцен MO Vision завершена. >> "%LOGFILE%"
echo Сборка mix файлов катсcen MO Vision завершена. 
echo Можно закрыть эту консоль.
echo Завершение сборки видео: %date% %time% >> "%LOGFILE%"
pause