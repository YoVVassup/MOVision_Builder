@echo off
chcp 65001
title MOVision_Builder_OnlyAudio
echo Mental Omega Vision Audio

: Проверка существования \ создание папки Build
echo Проверка существования предыдущей сборки...
if exist ".\Build" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build" && echo Папка для сборки создана. )
echo.

: Сборка mix файла дополнительных аудиотреков Mental Omega Vision
echo Сборка mix-файла дополнительных аудиотреков MO Vision...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\expandmo90" --mix ".\Build\expandmo90.mix"
echo.

: Заглушка для аудиотреков
echo Проверка на отсутствие файлов игровых аудиотреков и создание заглушек...
where /Q /R ".\Build" expandmo90.mix && echo Заглушка для игровых аудиотреков не требуется. || fsutil file createnew ".\Build\expandmo90.mix" 1024
echo.

echo Сборка mix файла дополнительных аудиотреков MO Vision завершена. 
echo Можно закртыть эту консоль.
pause