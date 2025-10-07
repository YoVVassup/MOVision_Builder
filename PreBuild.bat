@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

rem Создаем лог-файл
set "LOGFILE=PreBuild_log.txt"
echo Начало предварительной сборки: %date% %time% > "%LOGFILE%"
echo Pre(Custom) Mental Omega >> "%LOGFILE%"

title MOVision_Pre_Builder
echo Pre(Custom) Mental Omega
echo.

rem Очистка папки PreBuild 
echo Удаление файлов предыдущей предсборки... >> "%LOGFILE%"
echo Удаление файлов предыдущей предсборки...
rmdir /s /q ".\PreBuild" >> "%LOGFILE%" 2>&1
mkdir ".\PreBuild\MOV\expandmo09" >> "%LOGFILE%" 2>&1
mkdir ".\PreBuild\MOV\expandmo98_Russian" >> "%LOGFILE%" 2>&1
echo.

rem Предсборка дополнительных файлов Mental Omega Vision
echo Сборка bag и idx файлов дополнительных звуков MO Vision... >> "%LOGFILE%"
echo Сборка bag и idx файлов дополнительных звуков MO Vision...
Tools\BagFileTool -o ".\PreBuild\MOV\expandmo09\audio99.bag" -a ".\PreCustomCompileFiles\MOV\expandmo09\audio99" -n 99 -y >> "%LOGFILE%" 2>&1
echo.

rem Предсборка csf-файлов для оригинальной Mental Omega
echo Сборка csf-файлов для оригинальной Mental Omega... >> "%LOGFILE%"
echo Сборка csf-файлов для оригинальной Mental Omega...
Tools\CsfStudio -i ".\PreCustomCompileFiles\MOV\expandmo98_Russian\ra2md.txt" -o ".\PreBuild\MOV\expandmo98_Russian\ra2md.csf" --to-csf >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\PreCustomCompileFiles\MOV\expandmo98_Russian\stringtable00.txt" -o ".\PreBuild\MOV\expandmo98_Russian\stringtable00.csf" --to-csf >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\PreCustomCompileFiles\MOV\expandmo98_Russian\stringtable01.txt" -o ".\PreBuild\MOV\expandmo98_Russian\stringtable01.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Предсборка файлов для Mental Omega и MO Vision завершена. >> "%LOGFILE%"
echo Предсборка файлов для Mental Omega и MO Vision завершена.
echo Завершение предварительной сборки: %date% %time% >> "%LOGFILE%"