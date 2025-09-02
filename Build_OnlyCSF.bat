@echo off
chcp 65001 > nul
rem git config core.autocrlf false [fix]
title MOVision_Builder_OnlyCSF
echo Mental Omega Vision CSF
echo.

rem Проверка существования \ создание папки Build
echo Проверка существования предыдущей сборки...
if exist ".\Build" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build" && echo Папка для сборки создана. )
echo.

rem Сборка csf-файлов Mental Omega Vision
echo Сборка csf файла содержащего текст новых мультиплеерных карт...
if exist ".\Build\MOV" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\stringtable66.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\stringtable66.txt" -o ".\Build\MOV\stringtable66.csf" -a
echo.

echo Сборка csf-файлов для APRA Series...
if exist ".\Build\MOV\APRA_Series" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\APRA_Series" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\APRA_Series\stringtable68.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\APRA_Series\stringtable68.txt" -o ".\Build\MOV\APRA_Series\stringtable68.csf" -a
copy ".\Tools\stringtable00.csf" ".\Build\MOV\APRA_Series\stringtable69.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\APRA_Series\stringtable69.txt" -o ".\Build\MOV\APRA_Series\stringtable69.csf" -a
echo.

echo Сборка csf-файла для B.M.A. Series...
if exist ".\Build\MOV\B.M.A._Series" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\B.M.A._Series" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\B.M.A._Series\stringtable50.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\B.M.A._Series\stringtable50.txt" -o ".\Build\MOV\B.M.A._Series\stringtable50.csf" -a
echo.

echo Сборка csf-файла для Epsilon Mission Pack...
if exist ".\Build\MOV\Epsilon_Pack" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\Epsilon_Pack" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Epsilon_Pack\stringtable72.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Epsilon_Pack\stringtable72.txt" -o ".\Build\MOV\Epsilon_Pack\stringtable72.csf" -a
echo.

echo Сборка csf-файла для Foehn Mission Pack...
if exist ".\Build\MOV\Foehn_Pack" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\Foehn_Pack" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Foehn_Pack\stringtable73.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Foehn_Pack\stringtable73.txt" -o ".\Build\MOV\Foehn_Pack\stringtable73.csf" -a

echo Сборка csf-файла для P.M.O.S. Series...
if exist ".\Build\MOV\P.M.O.S._Series" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\P.M.O.S._Series" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\P.M.O.S._Series\stringtable51.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\P.M.O.S._Series\stringtable51.txt" -o ".\Build\MOV\P.M.O.S._Series\stringtable51.csf" -a
echo.

echo Сборка csf-файла для RA2 and RA2YR Remake...
if exist ".\Build\MOV\RA2_and_RA2YR_Remake" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\RA2_and_RA2YR_Remake" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\stringtable67.txt" -o ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf" -a
echo.

echo Сборка csf-файла для Soviet Mission Pack...
if exist ".\Build\MOV\Soviet_Pack" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\Soviet_Pack" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Soviet_Pack\stringtable71.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Soviet_Pack\stringtable71.txt" -o ".\Build\MOV\Soviet_Pack\stringtable71.csf" -a
echo.

echo Сборка csf-файла для WanNiang Series...
if exist ".\Build\MOV\WanNiang_Series" ( echo Найдена предыдущая папка сборки. ) else ( mkdir ".\Build\MOV\WanNiang_Series" && echo Папка для сборки создана. )
copy ".\Tools\stringtable00.csf" ".\Build\MOV\WanNiang_Series\stringtable52.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\WanNiang_Series\stringtable52.txt" -o ".\Build\MOV\WanNiang_Series\stringtable52.csf" -a
echo.

echo Сборка csf-файлов проекта MO Vision завершена. 
echo Можно закртыть эту консоль.
pause