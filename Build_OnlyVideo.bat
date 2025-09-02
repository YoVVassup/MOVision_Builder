@echo off
chcp 65001 > nul
rem git config core.autocrlf false [fix]
title MOVision_Builder_OnlyVideo
echo Mental Omega Vision Video
echo.

rem Проверка существования \ создание папки Build
echo Проверка существования предыдущей сборки...
if exist ".\Build\MOV\RA2_and_RA2YR_Remake" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\RA2_and_RA2YR_Remake" && echo Папка для сборки создана. )
echo.

rem Сборка mix файлов катсцен Mental Omega Vision
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 720p...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_720p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_720p.mix"
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 768p...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_768p.mix"
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 1080p...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p.mix"
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 1440p...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p.mix"
echo.

rem Заглушки для катсцен
echo Проверка на отсутствие файлов катсцен и создание заглушек...
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_720p.mix && echo Заглушка катсцен для разрешений 720p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_720p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_768p.mix && echo Заглушка катсцен для разрешений 768p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_768p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_1080p.mix && echo Заглушка катсцен для разрешений 1080p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_1440p.mix && echo Заглушка катсцен для разрешений 1440p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p.mix" 1024
echo.

echo Сборка mix файлов катсцен MO Vision завершена. 
echo Можно закртыть эту консоль.
pause