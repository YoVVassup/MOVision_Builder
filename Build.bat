@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

rem Создаем лог-файл
set "LOGFILE=Build_log.txt"
echo Начало сборки: %date% %time% > "%LOGFILE%"
echo Mental Omega Vision >> "%LOGFILE%"

title MOVision_Builder
echo Mental Omega Vision
echo.

rem Очистка папки Build 
echo Удаление файлов предыдущей сборки... >> "%LOGFILE%"
echo Удаление файлов предыдущей сборки...
rmdir /s /q ".\Build" >> "%LOGFILE%" 2>&1
mkdir ".\Build" >> "%LOGFILE%" 2>&1
echo.

rem Копирование CustomFiles
echo Копирование файлов аддона не требующих предварительной сборки или доработки... >> "%LOGFILE%"
echo Копирование файлов аддона не требующих предварительной сборки или доработки...
xcopy /s ".\CustomFiles" ".\Build" >> "%LOGFILE%" 2>&1
echo.

rem Сборка основных файлов Mental Omega Vision
echo Сборка mix-файла дополнительных аудиотреков MO Vision... >> "%LOGFILE%"
echo Сборка mix-файла дополнительных аудиотреков MO Vision...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\expandmo90" --mix ".\Build\expandmo90.mix" >> "%LOGFILE%" 2>&1
echo.

echo Сборка mix-файла уникальных едениц, юнитов и др. дополнений MO Vision... >> "%LOGFILE%"
echo Сборка mix-файла уникальных едениц, юнитов и др. дополнений MO Vision...
where /Q /R ".\PreBuild\MOV\expandmo09" audio??.* && xcopy /s /y ".\PreBuild\MOV\expandmo09" ".\CustomCompileFiles\MOV\expandmo09" >> "%LOGFILE%" 2>&1 || echo Файлов дополнительных звуков для MO Vision небыло обнаружено. >> "%LOGFILE%"
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo09" --mix ".\Build\MOV\expandmo09.mix" >> "%LOGFILE%" 2>&1
echo.

echo Сборка mix-файла оригинальных аудиотреков из RA2 и RA2YR + MO2... >> "%LOGFILE%"
echo Сборка mix-файла оригинальных аудиотреков из RA2 и RA2YR + MO2...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo10" --mix ".\Build\MOV\expandmo10.mix" >> "%LOGFILE%" 2>&1
echo.

echo Сборка mix-файла отвечающего за руссификацию оригинальной MO... >> "%LOGFILE%"
echo Сборка mix-файла отвечающего за руссификацию оригинальной MO...
where /Q /R ".\PreBuild\MOV\expandmo98_Russian" *.csf && xcopy /s /y ".\PreBuild\MOV\expandmo98_Russian" ".\CustomCompileFiles\MOV\expandmo98_Russian" >> "%LOGFILE%" 2>&1 || echo Файлов измененной русской локализации для Mental Omega небыло обнаружено. >> "%LOGFILE%"
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo98_Russian" --mix ".\Build\MOV\expandmo98_Russian.mix" >> "%LOGFILE%" 2>&1
copy ".\Build\MOV\expandmo98_Russian.mix" ".\Build\expandmo98.mix" >> "%LOGFILE%" 2>&1
echo.

echo Сборка mix-файла отвечающего за руссификацию оригинальной MO (с переопределением едениц, юнитов и др. дополнений из MO)... >> "%LOGFILE%"
echo Сборка mix-файла отвечающего за руссификацию оригинальной MO (с переопределением едениц, юнитов и др. дополнений из MO)...
xcopy /s /y ".\CustomCompileFiles\MOV\expandmo98_Russian\" ".\CustomCompileFiles\MOV\expandmo98_Vision\" >> "%LOGFILE%" 2>&1
xcopy /s /y ".\PreCustomCompileFiles\MOV\expandmo98_Vision\" ".\CustomCompileFiles\MOV\expandmo98_Vision\" >> "%LOGFILE%" 2>&1
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo98_Vision" --mix ".\Build\MOV\expandmo98_Vision.mix" >> "%LOGFILE%" 2>&1
echo.

echo Копирование оригинального mix-файла содержащего все внутренние ini-настройки игры... >> "%LOGFILE%"
echo Копирование оригинального mix-файла содержащего все внутренние ini-настройки игры...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Original.mix" >> "%LOGFILE%" 2>&1
echo.

echo Создание модифицированного mix-файла содержащего все внутренние ini-настройки игры (без rulesmo.ini)... >> "%LOGFILE%"
echo Создание модифицированного mix-файла содержащего все внутренние ini-настройки игры (без rulesmo.ini)...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem [#include]
echo '4918da: 5b23 696e 636c 7564 655d' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem 1=fan_artmo.ini
echo '491912: 313d 6661 6e5f 6172 746d 6f2e 696e 69' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem [#include];Menta // fix ужатие + перенос
echo '56cf22: 5b23 696e 636c 7564 655d 3b4d 656e 7461' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem l
echo '56cf32: 6c' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem 1=fan_soundmo.in // fix перенос
echo '56cf5c: 313d 6661 6e5f 736f 756e 646d 6f2e 696e' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem i
echo '56cf6c: 69' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem [#include];Menta // fix ужатие + перенос
echo '95d0b2: 5b23 696e 636c 7564 655d 3b4d 656e 7461' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem l
echo '95d0c2: 6c' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
rem 1=fan_aimo.ini
echo '95d0ea: 313d 6661 6e5f 6169 6d6f 2e69 6e69' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix" >> "%LOGFILE%" 2>&1
echo.

echo Создание модифицированного mix-файла содержащего все внутренние ini-настройки игры (с rulesmo.ini)... >> "%LOGFILE%"
echo Создание модифицированного mix-файла содержащего все внутренние ini-настройки игры (с rulesmo.ini)...
copy ".\Build\MOV\expandmo99_Mod.mix" ".\Build\MOV\expandmo99_Mod_Rules.mix" >> "%LOGFILE%" 2>&1
rem [#include]
echo '252c5d: 5b 2369 6e63 6c75 6465 5d' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod_Rules.mix" >> "%LOGFILE%" 2>&1
rem 1=fan_rulesmo.in // fix перенос
echo '252c98: 31 3d66 616e 5f72 756c 6573 6d6f 2e69 6e' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod_Rules.mix" >> "%LOGFILE%" 2>&1
rem i
echo '252ca8: 69' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod_Rules.mix" >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf файла содержащего текст новых мультиплеерных карт... >> "%LOGFILE%"
echo Сборка csf файла содержащего текст новых мультиплеерных карт...
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\stringtable66.txt" -o ".\Build\MOV\stringtable66.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf и mix-файлов для APRA Series... >> "%LOGFILE%"
echo Сборка csf и mix-файлов для APRA Series...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\APRA_Series\expandmo21" --mix ".\Build\MOV\APRA_Series\expandmo21.mix" >> "%LOGFILE%" 2>&1
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\APRA_Series\expandmo51" --mix ".\Build\MOV\APRA_Series\expandmo51.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\APRA_Series\stringtable68.txt" -o ".\Build\MOV\APRA_Series\stringtable68.csf" --to-csf >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\APRA_Series\stringtable69.txt" -o ".\Build\MOV\APRA_Series\stringtable69.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf и mix-файлов для B.M.A. Series... >> "%LOGFILE%"
echo Сборка csf и mix-файлов для B.M.A. Series...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\B.M.A._Series\expandmo62" --mix ".\Build\MOV\B.M.A._Series\expandmo62.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\B.M.A._Series\stringtable50.txt" -o ".\Build\MOV\B.M.A._Series\stringtable50.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf и mix-файлов для Epsilon Mission Pack... >> "%LOGFILE%"
echo Сборка csf и mix-файлов для Epsilon Mission Pack...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Epsilon_Pack\expandmo02" --mix ".\Build\MOV\Epsilon_Pack\expandmo02.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Epsilon_Pack\stringtable72.txt" -o ".\Build\MOV\Epsilon_Pack\stringtable72.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf и mix-файлов для Foehn Mission Pack... >> "%LOGFILE%"
echo Сборка csf и mix-файлов для Foehn Mission Pack...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Foehn_Pack\expandmo03" --mix ".\Build\MOV\Foehn_Pack\expandmo03.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Foehn_Pack\stringtable73.txt" -o ".\Build\MOV\Foehn_Pack\stringtable73.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf и mix-файлов для P.M.O.S. Series... >> "%LOGFILE%"
echo Сборка csf и mix-файлов для P.M.O.S. Series...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\P.M.O.S._Series\expandmo63" --mix ".\Build\MOV\P.M.O.S._Series\expandmo63.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\P.M.O.S._Series\stringtable51.txt" -o ".\Build\MOV\P.M.O.S._Series\stringtable51.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Cоздание заглушек mix-файлов катсцен (видевставок) для RA2 and RA2YR Remake... >> "%LOGFILE%"
echo Cоздание заглушек mix-файлов катсцен (видевставок) для RA2 and RA2YR Remake...
mkdir ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf" >> "%LOGFILE%" 2>&1
mkdir ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]" >> "%LOGFILE%" 2>&1
mkdir ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus" >> "%LOGFILE%" 2>&1
mkdir ".\Build\MOV\RA2_and_RA2YR_Remake\Original" >> "%LOGFILE%" 2>&1
mkdir ".\Build\MOV\RA2_and_RA2YR_Remake\Russian project" >> "%LOGFILE%" 2>&1
mkdir ".\Build\MOV\RA2_and_RA2YR_Remake\Triada" >> "%LOGFILE%" 2>&1
mkdir ".\Build\MOV\RA2_and_RA2YR_Remake\XXI Vek [8 Bit]" >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo11_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo11_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo11_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo11_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo11_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo12.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo13_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo13_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo13_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo13_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo13_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\7wolf\expandmo14.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo11_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo11_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo11_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo11_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo11_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo12.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo13_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo13_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo13_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo13_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo13_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\City [Dyadyushka Risyotch]\expandmo14.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo11_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo11_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo11_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo11_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo11_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo12.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo13_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo13_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo13_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo13_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo13_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Fargus\expandmo14.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo11_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo11_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo11_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo11_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo11_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo12.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo13_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo13_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo13_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo13_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo13_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Original\expandmo14.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Russian project\expandmo11_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Russian project\expandmo11_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Russian project\expandmo11_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Russian project\expandmo11_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Russian project\expandmo11_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Russian project\expandmo12.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo11_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo11_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo11_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo11_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo11_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo12.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo13_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo13_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo13_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo13_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo13_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\Triada\expandmo14.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\XXI Vek [8 Bit]\expandmo11_600p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\XXI Vek [8 Bit]\expandmo11_720p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\XXI Vek [8 Bit]\expandmo11_768p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\XXI Vek [8 Bit]\expandmo11_900p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\XXI Vek [8 Bit]\expandmo11_1080p.mix" 1024 >> "%LOGFILE%" 2>&1
fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\XXI Vek [8 Bit]\expandmo12.mix" 1024 >> "%LOGFILE%" 2>&1

echo.
echo Сборка остальных csf и mix-файлов для RA2 and RA2YR Remake... >> "%LOGFILE%"
echo Сборка остальных csf и mix-файлов для RA2 and RA2YR Remake...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo20" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo20.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\stringtable67.txt" -o ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf и mix-файлов для Soviet Mission Pack... >> "%LOGFILE%"
echo Сборка csf и mix-файлов для Soviet Mission Pack...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Soviet_Pack\expandmo01" --mix ".\Build\MOV\Soviet_Pack\expandmo01.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Soviet_Pack\stringtable71.txt" -o ".\Build\MOV\Soviet_Pack\stringtable71.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf и mix-файлов для WanNiang Series... >> "%LOGFILE%"
echo Сборка csf и mix-файлов для WanNiang Series...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\WanNiang_Series\expandmo64" --mix ".\Build\MOV\WanNiang_Series\expandmo64.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\WanNiang_Series\stringtable52.txt" -o ".\Build\MOV\WanNiang_Series\stringtable52.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

echo Сборка csf и mix-файлов для Allied Mission Pack... >> "%LOGFILE%"
echo Сборка csf и mix-файлов для Allied Mission Pack...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Allied_Pack\expandmo04" --mix ".\Build\MOV\Allied_Pack\expandmo04.mix" >> "%LOGFILE%" 2>&1
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Allied_Pack\stringtable70.txt" -o ".\Build\MOV\Allied_Pack\stringtable70.csf" --to-csf >> "%LOGFILE%" 2>&1
echo.

rem Копирование набора инструментов для post-пользовательской отладки
echo Добавление набор инструментов для быстрой пользовательской отладки... >> "%LOGFILE%"
echo Добавление набор инструментов для быстрой пользовательской отладки...
mkdir ".\Build\Resources\Tools" >> "%LOGFILE%" 2>&1
xcopy /s ".\Tools" ".\Build\Resources\Tools" >> "%LOGFILE%" 2>&1
echo.

rem Заглушка для аудиотреков
echo Проверка на отсутствие файлов игровых аудиотреков и создание заглушек... >> "%LOGFILE%"
echo Проверка на отсутствие файлов игровых аудиотреков и создание заглушек...
where /Q /R ".\Build" expandmo90.mix && echo Заглушка для игровых аудиотреков не требуется. >> "%LOGFILE%" || fsutil file createnew ".\Build\expandmo90.mix" 1024 >> "%LOGFILE%" 2>&1
echo.

echo Сборка проекта MO Vision завершена. >> "%LOGFILE%"
echo Сборка проекта MO Vision завершена. 
echo Можно закрыть эту консоль.
echo Завершение сборки: %date% %time% >> "%LOGFILE%"
pause