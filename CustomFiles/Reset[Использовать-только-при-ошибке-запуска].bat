@echo off
chcp 65001
: git config core.autocrlf false [fix]
title Reset Mental Omega

copy /Y ".\MOV\BattleClient_Original.ini" /A ".\INI\BattleClient.ini"
copy /Y ".\MOV\MentalOmegaMaps_Original.ini" /A ".\INI\MentalOmegaMaps.ini"
copy /Y ".\MOV\ClientDefinitions_Original.ini" /A ".\Resources\ClientDefinitions.ini"
copy /Y ".\MOV\GameOptions_Original.ini" /A ".\Resources\GameOptions.ini"
copy /Y ".\MOV\SkirmishLobby_Original.ini" /A ".\Resources\SkirmishLobby.ini"
copy /Y ".\MOV\thememo_Original.ini" /A ".\thememo.ini"
copy /Y ".\MOV\expandmo98_Russian.mix" ".\expandmo98.mix"
copy /Y ".\MOV\expandmo99_Original.mix" ".\expandmo99.mix"
copy /Y ".\MOV\Extention\Fonts\DTA\SpriteFont0_Original.xnb" ".\Resources\SpriteFont0.xnb"
copy /Y ".\MOV\Extention\Fonts\DTA\SpriteFont1_Original.xnb" ".\Resources\SpriteFont1.xnb"
copy /Y ".\MOV\Extention\Fonts\DTA\SpriteFont2_Original.xnb" ".\Resources\SpriteFont2.xnb"
copy /Y ".\MOV\Extention\Fonts\DTA\SpriteFont3_Original.xnb" ".\Resources\SpriteFont3.xnb"
copy /Y ".\MOV\Extention\Fonts\DTA\SpriteFont4_Original.xnb" ".\Resources\SpriteFont4.xnb"
copy /Y ".\MOV\Extention\Fonts\DTA\SpriteFont5_Original.xnb" ".\Resources\SpriteFont5.xnb"
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
if exist ".\game.fnt" (del /f /q game.fnt)
if exist ".\dxgi.dll" (del /f /q dxgi.dll)
if exist ".\d3d9.dll" (del /f /q d3d9.dll)
if exist ".\opengl32.dll" (del /f /q opengl32.dll)
if exist ".\RAIN.shp" (del /f /q RAIN.shp)
if exist ".\SNOW.shp" (del /f /q SNOW.shp)
if exist ".\Map Editor\aqrit.cfg" (del /f /q ".\Map Editor\aqrit.cfg")
if exist ".\Map Editor\CncVxlRenderText.dll" (del /f /q ".\Map Editor\CncVxlRenderText.dll")
if exist ".\Map Editor\ddraw.dll" (del /f /q ".\Map Editor\ddraw.dll")
if exist ".\Map Editor\FA2sp.dll" (del /f /q ".\Map Editor\FA2sp.dll")
if exist ".\Map Editor\theater.mix" (del /f /q ".\Map Editor\theater.mix")
copy /Y ".\MOV\Extention\Map Editor\Ext\FA2Ext.dll" ".\Map Editor\Ext\FA2Ext.dll"
copy /Y ".\MOV\Extention\Map Editor\Ext\FA2Ext.dll.inj" ".\Map Editor\Ext\FA2Ext.dll.inj"
copy /Y ".\MOV\Extention\Map Editor\Ext\fadata.ini" /A ".\Map Editor\Ext\fadata.ini"
if exist ".\ExtMiniFix.dll" (del /f /q ExtMiniFix.dll)
if exist ".\ObjectInfo.dll" (del /f /q ObjectInfo.dll)
if exist ".\objectinfo.ini" (del /f /q objectinfo.ini)
.\Resources\Tools\inifile RA2MO.ini [CustomSettings] /remove
.\Resources\Tools\inifile RA2MO.ini [Options] CheckforUpdates=False