@echo off
chcp 65001 > nul
rem git config core.autocrlf false [fix]

rem Обязательная предварительная сборка
echo Ожидание завершения предварительной сборки...
echo.
call PreBuild.bat
echo.

title MOVision_Builder
echo Mental Omega Vision
echo.

rem Очистка папки Build 
echo Удаление файлов предыдущей сборки...
rmdir /s /q ".\Build"
mkdir ".\Build"
echo.

rem Копирование CustomFiles
echo Копирование файлов аддона не требующих предварительной сборки или доработки...
xcopy /s ".\CustomFiles" ".\Build"
echo.

rem Сборка основных файлов Mental Omega Vision
echo Сборка mix-файла дополнительных аудиотреков MO Vision...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\expandmo90" --mix ".\Build\expandmo90.mix"
echo.
echo Сборка mix-файла уникальных едениц, юнитов и др. дополнений MO Vision...
where /Q /R ".\PreBuild\MOV\expandmo09" audio??.* && xcopy /s /y ".\PreBuild\MOV\expandmo09" ".\CustomCompileFiles\MOV\expandmo09" || echo Файлов дополнительных звуков для MO Vision небыло обнаружено.
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo09" --mix ".\Build\MOV\expandmo09.mix"
echo.
echo Сборка mix-файла оригинальных аудиотреков из RA2 и RA2YR + MO2...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo10" --mix ".\Build\MOV\expandmo10.mix"
echo.
echo Сборка mix-файла отвечающего за руссификацию оригинальной MO...
where /Q /R ".\PreBuild\MOV\expandmo98_Russian" *.csf && xcopy /s /y ".\PreBuild\MOV\expandmo98_Russian" ".\CustomCompileFiles\MOV\expandmo98_Russian" || echo Файлов измененной русской локализации для Mental Omega небыло обнаружено.
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo98_Russian" --mix ".\Build\MOV\expandmo98_Russian.mix"
copy ".\Build\MOV\expandmo98_Russian.mix" ".\Build\expandmo98.mix"
echo.
echo Сборка mix-файла отвечающего за руссификацию оригинальной MO (с переопределением едениц, юнитов и др. дополнений из MO)...
xcopy /s /y ".\CustomCompileFiles\MOV\expandmo98_Russian\" ".\CustomCompileFiles\MOV\expandmo98_Vision\"
xcopy /s /y ".\PreCustomCompileFiles\MOV\expandmo98_Vision\" ".\CustomCompileFiles\MOV\expandmo98_Vision\"
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo98_Vision" --mix ".\Build\MOV\expandmo98_Vision.mix"
echo.
echo Копирование оригинального mix-файла содержащего все внутренние ini-настройки игры...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Original.mix"
echo.
echo Создание модифицированного mix-файла содержащего все внутренние ini-настройки игры (без rulesmo.ini)...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Mod.mix"
rem [#include]
echo '4918da: 5b23 696e 636c 7564 655d' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
rem 1=fan_artmo.ini
echo '491912: 313d 6661 6e5f 6172 746d 6f2e 696e 69' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
rem [#include];Menta // fix ужатие + перенос
echo '56cf22: 5b23 696e 636c 7564 655d 3b4d 656e 7461' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
rem l
echo '56cf32: 6c' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
rem 1=fan_soundmo.in // fix перенос
echo '56cf5c: 313d 6661 6e5f 736f 756e 646d 6f2e 696e' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
rem i
echo '56cf6c: 69' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
rem [#include];Menta // fix ужатие + перенос
echo '95d0b2: 5b23 696e 636c 7564 655d 3b4d 656e 7461' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
rem l
echo '95d0c2: 6c' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
rem 1=fan_aimo.ini
echo '95d0ea: 313d 6661 6e5f 6169 6d6f 2e69 6e69' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod.mix"
echo.
echo Создание модифицированного mix-файла содержащего все внутренние ini-настройки игры (с rulesmo.ini)...
copy ".\Build\MOV\expandmo99_Mod.mix" ".\Build\MOV\expandmo99_Mod_Rules.mix"
rem [#include]
echo '252c5d: 5b 2369 6e63 6c75 6465 5d' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod_Rules.mix"
rem 1=fan_rulesmo.in // fix перенос
echo '252c98: 31 3d66 616e 5f72 756c 6573 6d6f 2e69 6e' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod_Rules.mix"
rem i
echo '252ca8: 69' | Tools\xxd -r - ".\Build\MOV\expandmo99_Mod_Rules.mix"
echo.
echo Сборка csf файла содержащего текст новых мультиплеерных карт...
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\stringtable66.txt" -o ".\Build\MOV\stringtable66.csf" --to-csf
echo.

echo Сборка csf и mix-файлов для APRA Series...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\APRA_Series\expandmo21" --mix ".\Build\MOV\APRA_Series\expandmo21.mix"
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\APRA_Series\expandmo51" --mix ".\Build\MOV\APRA_Series\expandmo51.mix"
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\APRA_Series\stringtable68.txt" -o ".\Build\MOV\APRA_Series\stringtable68.csf" --to-csf
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\APRA_Series\stringtable69.txt" -o ".\Build\MOV\APRA_Series\stringtable69.csf" --to-csf
echo.

echo Сборка csf и mix-файлов для B.M.A. Series...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\B.M.A._Series\expandmo12" --mix ".\Build\MOV\B.M.A._Series\expandmo12.mix"
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\B.M.A._Series\stringtable50.txt" -o ".\Build\MOV\B.M.A._Series\stringtable50.csf" --to-csf
echo.

echo Сборка csf и mix-файлов для Epsilon Mission Pack...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Epsilon_Pack\expandmo02" --mix ".\Build\MOV\Epsilon_Pack\expandmo02.mix"
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Epsilon_Pack\stringtable72.txt" -o ".\Build\MOV\Epsilon_Pack\stringtable72.csf" --to-csf
echo.

echo Сборка csf и mix-файлов для Foehn Mission Pack...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Foehn_Pack\expandmo03" --mix ".\Build\MOV\Foehn_Pack\expandmo03.mix"
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Foehn_Pack\stringtable73.txt" -o ".\Build\MOV\Foehn_Pack\stringtable73.csf" --to-csf

echo Сборка csf и mix-файлов для P.M.O.S. Series...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\P.M.O.S._Series\expandmo13" --mix ".\Build\MOV\P.M.O.S._Series\expandmo13.mix"
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\P.M.O.S._Series\stringtable51.txt" -o ".\Build\MOV\P.M.O.S._Series\stringtable51.csf" --to-csf
echo.

echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 720p...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_720p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_720p.mix"
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 768p...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_768p.mix"
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 1080p...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p.mix"
echo.
echo Сборка mix-файла катсцен (видевставок) для RA2 and RA2YR Remake для разрешений 1440p...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p.mix"
echo.
echo Сборка остальных csf и mix-файлов для RA2 and RA2YR Remake...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo20" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo20.mix"
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\stringtable67.txt" -o ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf" --to-csf
echo.

echo Сборка csf и mix-файлов для Soviet Mission Pack...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Soviet_Pack\expandmo01" --mix ".\Build\MOV\Soviet_Pack\expandmo01.mix"
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\Soviet_Pack\stringtable71.txt" -o ".\Build\MOV\Soviet_Pack\stringtable71.csf" --to-csf
echo.

echo Сборка csf и mix-файлов для WanNiang Series...
Tools\ccmix --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\WanNiang_Series\expandmo14" --mix ".\Build\MOV\WanNiang_Series\expandmo14.mix"
Tools\CsfStudio -i ".\CustomCompileFiles\MOV\WanNiang_Series\stringtable52.txt" -o ".\Build\MOV\WanNiang_Series\stringtable52.csf" --to-csf
echo.

rem Копирование набора инструментов для post-пользовательской отладки
echo Добавление набор инструментов для быстрой пользовательской отладки...
mkdir ".\Build\Resources\Tools"
xcopy /s ".\Tools" ".\Build\Resources\Tools"
echo.

rem Заглушки для катсцен
echo Проверка на отсутствие файлов катсцен и создание заглушек...
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_720p.mix && echo Заглушка катсцен для разрешений 720p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_720p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_768p.mix && echo Заглушка катсцен для разрешений 768p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_768p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_1080p.mix && echo Заглушка катсцен для разрешений 1080p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_1440p.mix && echo Заглушка катсцен для разрешений 1440p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p.mix" 1024
echo.

rem Заглушка для аудиотреков
echo Проверка на отсутствие файлов игровых аудиотреков и создание заглушек...
where /Q /R ".\Build" expandmo90.mix && echo Заглушка для игровых аудиотреков не требуется. || fsutil file createnew ".\Build\expandmo90.mix" 1024
echo.

echo Сборка проекта MO Vision завершена. 
echo Можно закртыть эту консоль.
pause