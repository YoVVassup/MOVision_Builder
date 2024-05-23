@echo off
chcp 65001
: git config core.autocrlf false [fix]
title MOVision_Builder
echo Mental Omega Vision

: Очистка папки Build 
echo Удаление файлов предыдущей сборки...
rmdir /s /q ".\Build"
mkdir ".\Build"
echo.

: Копирование CustomFiles
echo Копирование файлов аддона не требующих предварительной сборки или доработки...
xcopy /s ".\CustomFiles" ".\Build"
echo.

: Сборка основных файлов Mental Omega Vision
echo Сборка mix-файла дополнительных аудиотреков MO Vision...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\expandmo90" --mix ".\Build\expandmo90.mix"
echo.
echo Сборка mix-файла уникальных едениц, юнитов и др. дополнений не имеющих аналогов в оригинальной MO...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo09" --mix ".\Build\MOV\expandmo09.mix"
echo.
echo Сборка mix-файла оригинальных аудиотреков из RA2 и RA2YR...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo10" --mix ".\Build\MOV\expandmo10.mix"
echo.
echo Сборка mix-файла отвечающего за руссификацию оригинальной MO...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo98_Russian" --mix ".\Build\MOV\expandmo98_Russian.mix"
copy ".\Build\MOV\expandmo98_Russian.mix" ".\Build\expandmo98.mix"
echo.
echo Сборка mix-файла отвечающего за руссификацию оригинальной MO (с переопределением едениц, юнитов и др. дополнений из MO)...
move /y ".\CustomCompileFiles\MOV\expandmo98_Vision\COMA.hva" ".\CustomCompileFiles\MOV\expandmo98_Russian"
move /y ".\CustomCompileFiles\MOV\expandmo98_Vision\cryo.hva" ".\CustomCompileFiles\MOV\expandmo98_Russian"
move /y ".\CustomCompileFiles\MOV\expandmo98_Vision\killer.shp" ".\CustomCompileFiles\MOV\expandmo98_Russian"
move /y ".\CustomCompileFiles\MOV\expandmo98_Vision\longbo.hva" ".\CustomCompileFiles\MOV\expandmo98_Russian"
move /y ".\CustomCompileFiles\MOV\expandmo98_Vision\schp.hva" ".\CustomCompileFiles\MOV\expandmo98_Russian"
move /y ".\CustomCompileFiles\MOV\expandmo98_Vision\shad.hva" ".\CustomCompileFiles\MOV\expandmo98_Russian"
move /y ".\CustomCompileFiles\MOV\expandmo98_Vision\WOLF.hva" ".\CustomCompileFiles\MOV\expandmo98_Russian"
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo98_Russian" --mix ".\Build\MOV\expandmo98_Vision.mix"
move /y ".\CustomCompileFiles\MOV\expandmo98_Russian\COMA.hva" ".\CustomCompileFiles\MOV\expandmo98_Vision"
move /y ".\CustomCompileFiles\MOV\expandmo98_Russian\cryo.hva" ".\CustomCompileFiles\MOV\expandmo98_Vision"
move /y ".\CustomCompileFiles\MOV\expandmo98_Russian\killer.shp" ".\CustomCompileFiles\MOV\expandmo98_Vision"
move /y ".\CustomCompileFiles\MOV\expandmo98_Russian\longbo.hva" ".\CustomCompileFiles\MOV\expandmo98_Vision"
move /y ".\CustomCompileFiles\MOV\expandmo98_Russian\schp.hva" ".\CustomCompileFiles\MOV\expandmo98_Vision"
move /y ".\CustomCompileFiles\MOV\expandmo98_Russian\shad.hva" ".\CustomCompileFiles\MOV\expandmo98_Vision"
move /y ".\CustomCompileFiles\MOV\expandmo98_Russian\WOLF.hva" ".\CustomCompileFiles\MOV\expandmo98_Vision"
echo.
echo Копирование оригинального mix-файла содержащего все внутренние ini-настройки игры...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Original.mix"
echo.
echo Создание модифицированного mix-файла содержащего все внутренние ini-настройки игры (без rulesmo.ini)...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Mod.mix"
Tools\sfk replace ".\Build\MOV\expandmo99_Mod.mix" -bin /4D656E74616C204F6D65676120332E332E362041525420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B/4D656E74616C204F6D65676120332E332E362041525420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B3B3B3B0D0A5B23696E636C7564655D3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F6172742E696E69/ /3B3B3B3B3B3B3B3B3B3B4D656E74616C204F6D65676120332E332E3620534F554E4420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B/5B23696E636C7564655D3B4D656E74616C4F6D65676120332E332E3620534F554E4420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0A313D66616E5F736F756E646D6F2E696E69/ /3B3B3B3B3B3B3B3B3B3B4D656E74616C204F6D65676120332E332E3620414920434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B/5B23696E636C7564655D3B4D656E74616C4F6D65676120332E332E3620414920434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F61696D6F2E696E69/ -yes
echo.
echo Создание модифицированного mix-файла содержащего все внутренние ini-настройки игры (с rulesmo.ini)...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Mod_Rules.mix"
Tools\sfk replace ".\Build\MOV\expandmo99_Mod_Rules.mix" -bin /4D656E74616C204F6D65676120332E332E362041525420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B/4D656E74616C204F6D65676120332E332E362041525420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B3B3B3B0D0A5B23696E636C7564655D3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F6172742E696E69/ /3B3B3B3B3B3B3B3B3B3B4D656E74616C204F6D65676120332E332E3620534F554E4420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B/5B23696E636C7564655D3B4D656E74616C4F6D65676120332E332E3620534F554E4420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0A313D66616E5F736F756E646D6F2E696E69/ /3B3B3B3B3B3B3B3B3B3B4D656E74616C204F6D65676120332E332E3620414920434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B/5B23696E636C7564655D3B4D656E74616C4F6D65676120332E332E3620414920434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F61696D6F2E696E69/ /4D656E74616C204F6D65676120332E332E362052554C455320434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B/4D656E74616C204F6D65676120332E332E362052554C455320434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A5B23696E636C7564655D3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F72756C65736D6F2E696E69/ -yes
echo.
echo Сборка csf файла содержащего текст новых мультиплеерных карт...
copy ".\Tools\stringtable00.csf" ".\Build\MOV\stringtable66.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\stringtable66.txt" -o ".\Build\MOV\stringtable66.csf" -a
echo.

echo Сборка csf и mix-файлов для APRA Series...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\APRA_Series\expandmo21" --mix ".\Build\MOV\APRA_Series\expandmo21.mix"
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\APRA_Series\expandmo51" --mix ".\Build\MOV\APRA_Series\expandmo51.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\APRA_Series\stringtable68.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\APRA_Series\stringtable68.txt" -o ".\Build\MOV\APRA_Series\stringtable68.csf" -a
copy ".\Tools\stringtable00.csf" ".\Build\MOV\APRA_Series\stringtable69.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\APRA_Series\stringtable69.txt" -o ".\Build\MOV\APRA_Series\stringtable69.csf" -a
echo.

echo Сборка csf и mix-файлов для B.M.A. Series...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\B.M.A._Series\expandmo12" --mix ".\Build\MOV\B.M.A._Series\expandmo12.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\B.M.A._Series\stringtable50.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\B.M.A._Series\stringtable50.txt" -o ".\Build\MOV\B.M.A._Series\stringtable50.csf" -a
echo.

echo Сборка csf и mix-файлов для Epsilon Mission Pack...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Epsilon_Pack\expandmo02" --mix ".\Build\MOV\Epsilon_Pack\expandmo02.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Epsilon_Pack\stringtable72.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Epsilon_Pack\stringtable72.txt" -o ".\Build\MOV\Epsilon_Pack\stringtable72.csf" -a
echo.

echo Сборка csf и mix-файлов для Foehn Mission Pack...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Foehn_Pack\expandmo03" --mix ".\Build\MOV\Foehn_Pack\expandmo03.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Foehn_Pack\stringtable73.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Foehn_Pack\stringtable73.txt" -o ".\Build\MOV\Foehn_Pack\stringtable73.csf" -a

echo Сборка csf и mix-файлов для P.M.O.S. Series...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\P.M.O.S._Series\expandmo13" --mix ".\Build\MOV\P.M.O.S._Series\expandmo13.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\P.M.O.S._Series\stringtable51.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\P.M.O.S._Series\stringtable51.txt" -o ".\Build\MOV\P.M.O.S._Series\stringtable51.csf" -a
echo.

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
echo Сборка остальных csf и mix-файлов для RA2 and RA2YR Remake...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo20" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo20.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\stringtable67.txt" -o ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf" -a
echo.

echo Сборка csf и mix-файлов для Soviet Mission Pack...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Soviet_Pack\expandmo01" --mix ".\Build\MOV\Soviet_Pack\expandmo01.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Soviet_Pack\stringtable71.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Soviet_Pack\stringtable71.txt" -o ".\Build\MOV\Soviet_Pack\stringtable71.csf" -a
echo.

echo Сборка csf и mix-файлов для WanNiang Series...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\WanNiang_Series\expandmo14" --mix ".\Build\MOV\WanNiang_Series\expandmo14.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\WanNiang_Series\stringtable52.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\WanNiang_Series\stringtable52.txt" -o ".\Build\MOV\WanNiang_Series\stringtable52.csf" -a
echo.

: Копирование набора инструментов для post-пользовательской отладки
echo Добавление набор инструментов для быстрой пользовательской отладки...
mkdir ".\Build\Resources\Tools"
xcopy /s ".\Tools" ".\Build\Resources\Tools"
echo.

: Заглушки для катсцен
echo Проверка на отсутствие файлов катсцен и создание заглушек...
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_720p.mix && echo Заглушка катсцен для разрешений 720p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_720p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_768p.mix && echo Заглушка катсцен для разрешений 768p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_768p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_1080p.mix && echo Заглушка катсцен для разрешений 1080p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p.mix" 1024
where /Q /R ".\Build\MOV\RA2_and_RA2YR_Remake" expandmo11_1440p.mix && echo Заглушка катсцен для разрешений 1440p не требуется. || fsutil file createnew ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1440p.mix" 1024
echo.

: Заглушка для аудиотреков
echo Проверка на отсутствие файлов игровых аудиотреков и создание заглушек...
where /Q /R ".\Build" expandmo90.mix && echo Заглушка для игровых аудиотреков не требуется. || fsutil file createnew ".\Build\expandmo90.mix" 1024
echo.

echo Сборка проекта MO Vision завершена. 
echo Можно закртыть эту консоль.
pause