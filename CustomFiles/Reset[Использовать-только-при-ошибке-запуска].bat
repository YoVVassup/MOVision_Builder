@echo off
chcp 65001
: git config core.autocrlf false [fix]
title Reset Mental Omega

esentutl /y "MOV\BattleClient_Original.ini" /d "INI\BattleClient.ini" /o
esentutl /y "MOV\MentalOmegaMaps_Original.ini" /d "INI\MentalOmegaMaps.ini" /o
esentutl /y "MOV\ClientDefinitions_Original.ini" /d "Resources\ClientDefinitions.ini" /o
esentutl /y "MOV\GameOptions_Original.ini" /d "Resources\GameOptions.ini" /o
esentutl /y "MOV\SkirmishLobby_Original.ini" /d "Resources\SkirmishLobby.ini" /o
esentutl /y "MOV\thememo_Original.ini" /d "thememo.ini" /o
esentutl /y "MOV\expandmo98_Russian.mix" /d "expandmo98.mix" /o
esentutl /y "MOV\expandmo99_Original.mix" /d "expandmo99.mix" /o
if exist ".\mapselmo.ini" (del /f /q mapselmo.ini)
if exist ".\missionmo.ini" (del /f /q missionmo.ini)
if exist ".\fan_artmo.ini" (del /f /q fan_artmo.ini)
if exist ".\fan_soundmo.ini" (del /f /q fan_soundmo.ini)
if exist ".\ReShade.ini" (del /f /q ReShade.ini)
if exist ".\expandmo01.mix" (del /f /q expandmo01.mix)
if exist ".\expandmo02.mix" (del /f /q expandmo02.mix)
if exist ".\expandmo03.mix" (del /f /q expandmo03.mix)
if exist ".\expandmo09.mix" (del /f /q expandmo09.mix)
if exist ".\expandmo10.mix" (del /f /q expandmo10.mix)
if exist ".\expandmo11.mix" (del /f /q expandmo11.mix)
if exist ".\expandmo12.mix" (del /f /q expandmo12.mix)
if exist ".\expandmo13.mix" (del /f /q expandmo13.mix)
if exist ".\expandmo14.mix" (del /f /q expandmo14.mix)
if exist ".\expandmo20.mix" (del /f /q expandmo20.mix)
if exist ".\expandmo21.mix" (del /f /q expandmo21.mix)
if exist ".\expandmo51.mix" (del /f /q expandmo51.mix)
if exist ".\stringtable50.csf" (del /f /q stringtable50.csf)
if exist ".\stringtable51.csf" (del /f /q stringtable51.csf)
if exist ".\stringtable52.csf" (del /f /q stringtable52.csf)
if exist ".\stringtable66.csf" (del /f /q stringtable66.csf)
if exist ".\stringtable67.csf" (del /f /q stringtable67.csf)
if exist ".\stringtable68.csf" (del /f /q stringtable68.csf)
if exist ".\stringtable69.csf" (del /f /q stringtable69.csf)
if exist ".\stringtable71.csf" (del /f /q stringtable71.csf)
if exist ".\stringtable72.csf" (del /f /q stringtable72.csf)
if exist ".\stringtable73.csf" (del /f /q stringtable73.csf)
if exist ".\TEST.map" (del /f /q TEST.map)
if exist ".\dxgi.dll" (del /f /q dxgi.dll)
if exist ".\d3d9.dll" (del /f /q d3d9.dll)
if exist ".\opengl32.dll" (del /f /q opengl32.dll)
.\Resources\Tools\inifile RA2MO.ini [CustomSettings] /remove
.\Resources\Tools\inifile RA2MO.ini [Options] CheckforUpdates=False