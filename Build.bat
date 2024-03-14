@echo off
echo Mental Omega Vision

: ���⪠ ����� Build 
echo �������� 䠩��� �।��饩 ᡮન...
rmdir /s /q ".\Build"
mkdir ".\Build"
echo.

: ����஢���� CustomFiles
echo ����஢���� 䠩��� ������ �� �ॡ���� �।���⥫쭮� ᡮન ��� ��ࠡ�⪨...
xcopy /s ".\CustomFiles" ".\Build"
echo.

: ���ઠ �᭮���� 䠩��� Mental Omega Vision
echo ���ઠ mix-䠩�� �������⥫�� �㤨��४�� MO Vision...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\expandmo90" --mix ".\Build\expandmo90.mix"
echo.
echo ���ઠ mix-䠩�� 㭨������ ������, ⮢ � ��. ���������� �� ������ �������� � �ਣ����쭮� MO...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo09" --mix ".\Build\MOV\expandmo09.mix"
echo.
echo ���ઠ mix-䠩�� �ਣ������� �㤨��४�� �� RA2 � RA2YR...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo10" --mix ".\Build\MOV\expandmo10.mix"
echo.
echo ���ઠ mix-䠩�� �⢥��饣� �� ����䨪��� �ਣ����쭮� MO...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo98_Russian" --mix ".\Build\MOV\expandmo98_Russian.mix"
copy ".\Build\MOV\expandmo98_Russian.mix" ".\Build\expandmo98.mix"
echo.
echo ���ઠ mix-䠩�� �⢥��饣� �� ����䨪��� �ਣ����쭮� MO (� ��८�।������� ������, ⮢ � ��. ���������� �� MO)...
move /y ".\CustomCompileFiles\MOV\expandmo98_Vision\killer.shp" ".\CustomCompileFiles\MOV\expandmo98_Russian"
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\expandmo98_Russian" --mix ".\Build\MOV\expandmo98_Vision.mix"
move /y ".\CustomCompileFiles\MOV\expandmo98_Russian\killer.shp" ".\CustomCompileFiles\MOV\expandmo98_Vision"
echo.
echo ����஢���� �ਣ����쭮�� mix-䠩�� ᮤ�ঠ饣� �� ����७��� ini-����ன�� ����...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Original.mix"
echo.
echo �������� ������஢������ mix-䠩�� ᮤ�ঠ饣� �� ����७��� ini-����ன�� ���� (��� rulesmo.ini)...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Mod.mix"
Tools\sfk replace ".\Build\MOV\expandmo99_Mod.mix" -bin /4D656E74616C204F6D65676120332E332E362041525420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B/4D656E74616C204F6D65676120332E332E362041525420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B3B3B3B0D0A5B23696E636C7564655D3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F6172742E696E69/ /3B3B3B3B3B3B3B3B3B3B4D656E74616C204F6D65676120332E332E3620534F554E4420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B/5B23696E636C7564655D3B4D656E74616C4F6D65676120332E332E3620534F554E4420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0A313D66616E5F736F756E646D6F2E696E69/ /3B3B3B3B3B3B3B3B3B3B4D656E74616C204F6D65676120332E332E3620414920434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B/5B23696E636C7564655D3B4D656E74616C4F6D65676120332E332E3620414920434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F61696D6F2E696E69/ -yes
echo.
echo �������� ������஢������ mix-䠩�� ᮤ�ঠ饣� �� ����७��� ini-����ன�� ���� (� rulesmo.ini)...
copy ".\OriginalFilesMO\expandmo99.mix" ".\Build\MOV\expandmo99_Mod_Rules.mix"
Tools\sfk replace ".\Build\MOV\expandmo99_Mod_Rules.mix" -bin /4D656E74616C204F6D65676120332E332E362041525420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B/4D656E74616C204F6D65676120332E332E362041525420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B3B3B3B0D0A5B23696E636C7564655D3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F6172742E696E69/ /3B3B3B3B3B3B3B3B3B3B4D656E74616C204F6D65676120332E332E3620534F554E4420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B/5B23696E636C7564655D3B4D656E74616C4F6D65676120332E332E3620534F554E4420434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0A313D66616E5F736F756E646D6F2E696E69/ /3B3B3B3B3B3B3B3B3B3B4D656E74616C204F6D65676120332E332E3620414920434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B/5B23696E636C7564655D3B4D656E74616C4F6D65676120332E332E3620414920434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F61696D6F2E696E69/ /4D656E74616C204F6D65676120332E332E362052554C455320434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B/4D656E74616C204F6D65676120332E332E362052554C455320434F4E54524F4C2046494C453B3B3B3B3B3B3B3B3B3B0D0A5B23696E636C7564655D3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B3B0D0A313D66616E5F72756C65736D6F2E696E69/ -yes
echo.

echo ���ઠ csf � mix-䠩��� ��� APRA Series...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\APRA_Series\expandmo21" --mix ".\Build\MOV\APRA_Series\expandmo21.mix"
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\APRA_Series\expandmo51" --mix ".\Build\MOV\APRA_Series\expandmo51.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\APRA_Series\stringtable68.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\APRA_Series\stringtable68.txt" -o ".\Build\MOV\APRA_Series\stringtable68.csf" -a
copy ".\Tools\stringtable00.csf" ".\Build\MOV\APRA_Series\stringtable69.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\APRA_Series\stringtable69.txt" -o ".\Build\MOV\APRA_Series\stringtable69.csf" -a
echo.

echo ���ઠ csf � mix-䠩��� ��� B.M.A. Series...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\B.M.A._Series\expandmo12" --mix ".\Build\MOV\B.M.A._Series\expandmo12.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\B.M.A._Series\stringtable50.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\B.M.A._Series\stringtable50.txt" -o ".\Build\MOV\B.M.A._Series\stringtable50.csf" -a
echo.

echo ���ઠ csf � mix-䠩��� ��� Epsilon Mission Pack...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Epsilon_Pack\expandmo02" --mix ".\Build\MOV\Epsilon_Pack\expandmo02.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Epsilon_Pack\stringtable72.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Epsilon_Pack\stringtable72.txt" -o ".\Build\MOV\Epsilon_Pack\stringtable72.csf" -a
echo.

echo ���ઠ csf � mix-䠩��� ��� Foehn Mission Pack...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Foehn_Pack\expandmo03" --mix ".\Build\MOV\Foehn_Pack\expandmo03.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Foehn_Pack\stringtable73.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Foehn_Pack\stringtable73.txt" -o ".\Build\MOV\Foehn_Pack\stringtable73.csf" -a

echo ���ઠ csf � mix-䠩��� ��� P.M.O.S. Series...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\P.M.O.S._Series\expandmo13" --mix ".\Build\MOV\P.M.O.S._Series\expandmo13.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\P.M.O.S._Series\stringtable51.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\P.M.O.S._Series\stringtable51.txt" -o ".\Build\MOV\P.M.O.S._Series\stringtable51.csf" -a
echo.

echo ���ઠ mix-䠩�� �ਣ������� ����業 (������⠢��) ��� RA2 and RA2YR Remake...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_480p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_480p.mix"
echo.
echo ���ઠ mix-䠩�� ����業 (������⠢��) ��� RA2 and RA2YR Remake ��� ࠧ�襭�� 768p...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_768p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_768p.mix"
echo.
echo ���ઠ mix-䠩�� ����業 (������⠢��) ��� RA2 and RA2YR Remake ��� ࠧ�襭�� 1080p...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo11_1080p.mix"
echo.
echo ���ઠ ��⠫��� csf � mix-䠩��� ��� RA2 and RA2YR Remake...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\expandmo20" --mix ".\Build\MOV\RA2_and_RA2YR_Remake\expandmo20.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\RA2_and_RA2YR_Remake\stringtable67.txt" -o ".\Build\MOV\RA2_and_RA2YR_Remake\stringtable67.csf" -a
echo.

echo ���ઠ csf � mix-䠩��� ��� Soviet Mission Pack...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\Soviet_Pack\expandmo01" --mix ".\Build\MOV\Soviet_Pack\expandmo01.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\Soviet_Pack\stringtable71.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\Soviet_Pack\stringtable71.txt" -o ".\Build\MOV\Soviet_Pack\stringtable71.csf" -a
echo.

echo ���ઠ csf � mix-䠩��� ��� WanNiang Series...
Tools\ccmix.exe --create --lmd --game=ra2 --dir ".\CustomCompileFiles\MOV\WanNiang_Series\expandmo14" --mix ".\Build\MOV\WanNiang_Series\expandmo14.mix"
copy ".\Tools\stringtable00.csf" ".\Build\MOV\WanNiang_Series\stringtable52.csf"
Tools\CSFTool -t ".\CustomCompileFiles\MOV\WanNiang_Series\stringtable52.txt" -o ".\Build\MOV\WanNiang_Series\stringtable52.csf" -a
echo.

: ����஢���� ����� �����㬥�⮢ ��� post-���짮��⥫�᪮� �⫠���
echo ���������� ����� �����㬥�⮢ ��� ����ன ���짮��⥫�᪮� �⫠���...
mkdir ".\Build\Resources\Tools"
xcopy /s ".\Tools" ".\Build\Resources\Tools"
echo.

echo ���ઠ �஥�� MO Vision �����襭�. 
echo ����� �������� ��� ���᮫�.
pause