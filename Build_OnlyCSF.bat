@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

rem Создаем лог-файл
set "LOGFILE=Build_OnlyCSF_log.txt"
echo Начало сборки CSF: %date% %time% > "%LOGFILE%"
echo Mental Omega Vision CSF >> "%LOGFILE%"

title MOVision_Builder_OnlyCSF
echo Mental Omega Vision CSF
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

rem Сборка csf-файлов Mental Omega Vision
echo Сборка csf файла содержащего текст новых мультиплеерных карт... >> "%LOGFILE%"
echo Сборка csf файла содержащего текст новых мультиплеерных карт...
if exist ".\Build\MOV" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\stringtable66.txt" -o ".\Build\MOV\stringtable66.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf-файлов для APRA Series... >> "%LOGFILE%"
echo Сборка csf-файлов для APRA Series...
if exist ".\Build\MOV\APRA_Series" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\APRA_Series" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\APRA_Series\stringtable68.txt" -o ".\Build\MOV\APRA_Series\stringtable68.csf" --to-csf >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\APRA_Series\stringtable69.txt" -o ".\Build\MOV\APRA_Series\stringtable69.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf-файла для B.M.A. Series... >> "%LOGFILE%"
echo Сборка csf-файла для B.M.A. Series...
if exist ".\Build\MOV\B.M.A._Series" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\B.M.A._Series" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\B.M.A._Series\stringtable50.txt" -o ".\Build\MOV\B.M.A._Series\stringtable50.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf-файла для Epsilon Mission Pack... >> "%LOGFILE%"
echo Сборка csf-файла для Epsilon Mission Pack...
if exist ".\Build\MOV\Epsilon_Pack" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\Epsilon_Pack" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Epsilon_Pack\stringtable72.txt" -o ".\Build\MOV\Epsilon_Pack\stringtable72.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf-файла для Foehn Mission Pack... >> "%LOGFILE%"
echo Сборка csf-файла для Foehn Mission Pack...
if exist ".\Build\MOV\Foehn_Pack" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\Foehn_Pack" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Foehn_Pack\stringtable73.txt" -o ".\Build\MOV\Foehn_Pack\stringtable73.csf" --to-csf >> "%LOGFILE%" 2>&1

echo Сборка csf-файла для P.M.O.S. Series... >> "%LOGFILE%"
echo Сборка csf-файла для P.M.O.S. Series...
if exist ".\Build\MOV\P.M.O.S._Series" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\P.M.O.S._Series" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\P.M.O.S._Series\stringtable51.txt" -o ".\Build\MOV\P.M.O.S._Series\stringtable51.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf-файла для RA2 and RA2YR Remake... >> "%LOGFILE%"
echo Сборка csf-файла для RA2 and RA2YR Remake...
if exist ".\Build\MOV\RA2_and_RA2YR_Remake" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\RA2_and_RA2YR_Remake" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\stringtable67.txt" -o ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf-файла для Soviet Mission Pack... >> "%LOGFILE%"
echo Сборка csf-файла для Soviet Mission Pack...
if exist ".\Build\MOV\Soviet_Pack" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\Soviet_Pack" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Soviet_Pack\stringtable71.txt" -o ".\Build\MOV\Soviet_Pack\stringtable71.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf-файла для WanNiang Series... >> "%LOGFILE%"
echo Сборка csf-файла для WanNiang Series...
if exist ".\Build\MOV\WanNiang_Series" ( 
    echo Найдена предыдущая папка сборки. >> "%LOGFILE%"
) else ( 
    mkdir ".\Build\MOV\WanNiang_Series" >> "%LOGFILE%" 2>&1
    echo Папка для сборки создана. >> "%LOGFILE%"
)
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\WanNiang_Series\stringtable52.txt" -o ".\Build\MOV\WanNiang_Series\stringtable52.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf-файлов проекта MO Vision завершена. >> "%LOGFILE%"
echo Сборка csf-файлов проекта MO Vision завершена. 
echo Можно закрыть эту консоль.
echo Завершение сборки CSF: %date% %time% >> "%LOGFILE%"
pause