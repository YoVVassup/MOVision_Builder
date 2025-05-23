@echo off
chcp 65001 > nul
: git config core.autocrlf false [fix]
title MOVision_Pre_Builder
echo Pre(Custom) Mental Omega
echo.

: Очистка папки PreBuild 
echo Удаление файлов предыдущей предсборки...
rmdir /s /q ".\PreBuild"
mkdir ".\PreBuild\MOV\expandmo09"
mkdir ".\PreBuild\MOV\expandmo98_Russian"
echo.

: Предсборка дополнительных файлов Mental Omega Vision
echo Сборка bag и idx файлов дополнительных звуков MO Vision...
Tools\BagFileTool.exe -i ".\Tools\audio00.bag" -o ".\PreBuild\MOV\expandmo09\audio99.bag" -a ".\PreCustomCompileFiles\MOV\expandmo09\audio99"
echo.

: Передсборка csf-файлов для оригинальной Mental Omega
copy ".\Tools\stringtable00.csf" ".\PreBuild\MOV\expandmo98_Russian\ra2md.csf"
Tools\CSFTool -t ".\PreCustomCompileFiles\MOV\expandmo98_Russian\ra2md.txt" -o ".\PreBuild\MOV\expandmo98_Russian\ra2md.csf" -a
copy ".\Tools\stringtable00.csf" ".\PreBuild\MOV\expandmo98_Russian\stringtable00.csf"
Tools\CSFTool -t ".\PreCustomCompileFiles\MOV\expandmo98_Russian\stringtable00.txt" -o ".\PreBuild\MOV\expandmo98_Russian\stringtable00.csf" -a
copy ".\Tools\stringtable00.csf" ".\PreBuild\MOV\expandmo98_Russian\stringtable01.csf"
Tools\CSFTool -t ".\PreCustomCompileFiles\MOV\expandmo98_Russian\stringtable01.txt" -o ".\PreBuild\MOV\expandmo98_Russian\stringtable01.csf" -a
echo.

echo Предсборка файлов для Mental Omega и MO Vision завершена.