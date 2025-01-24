Github Project https://github.com/Starkku/FA2sp
Current version 1.6.3

Usage Instructions:
1.Open the Map Editor folder located in the MO336 directory.
2.Delete any files related to FA2Ext.
3.Extract all files from the compressed package into this directory.

Hold CTRL to select multiple items. 
Hold CTRL+SHIFT to deselect tiles. 
Press CTRL+D to deselect all. 
Currently supports raising and lowering individual tiles (and multiple tiles) and checking how much money you have. 
Undo and redo are not supported!

Description of some switches: 
[ExtConfigs] 
BrowserRedraw=Yes ; Redraw the tree view on the left 
BrowserRedraw.GuessMode=0 ; 0 (default) uses Prerequisite, 1 uses the first Owner 
BrowserRedraw.CleanUp=Yes ; Automatically clean up categories with no items 
BrowserRedraw.SafeHouses=Yes ; Safe ownership, but needs to reload the map after creation 
AllowIncludes=No ; Allow [#include], unstable, not recommended 
AllowPlusEqual=No; Allow +=, not recommended 
TutorialTexts.Hide=No ; Hide text for result 11 
TutorialTexts.Fix=No ; Enable if result 11 crashes 
SortByTriggerName=Yes ; Sort triggers by name 
AdjustDropdownWidth=Yes ; Automatically adjust dropdown width 
AdjustDropdownWidth.Factor=6 ; Width per character 
AdjustDropdownWidth.Max=360 ; Maximum width 
CopySelectionBound.Color=0,255,0 ; Color of the copy box 
CursorSelectionBound.Color=0,0,255 ; Color of the mouse selection box 
CursorSelectionBound.HeightIndicatorColor=255,0,0 ; Color of the height indicator 
Waypoint.Background=Yes ; Fill background for waypoints 
Waypoint.Background.Color=128,128,128 ; Background color for waypoints 
Waypoint.Color=255,255,0 ; Color of waypoint text 
Waypoint.Text.ExtraOffset=0,0 ; Extra offset for waypoint text 
ExtWaypoints=Yes ; Support for unlimited waypoints (requires Phobos version 0.2 or higher) 
UndoRedoLimit=128 ; Specify the limit for undo and redo, default is 16 
SaveMap.AutoSave=Yes ; Enable auto-save 
SaveMap.AutoSave.Interval=300 ; Auto-save interval in seconds, default is 300s, minimum is 30 
SaveMap.AutoSave.MaxCount=5 ; Maximum number of auto-saves, -1 means unlimited 
SaveMap.OnlySaveMAP=Yes ; Only save .map files 
SaveMap.DefaultPreviewOptionMP=0 ; Multiplayer map update [PreviewPack] 
SaveMap.DefaultPreviewOptionSP=1 ; Single-player map does not regenerate [PreviewPack] 
VerticalLayout=Yes ; Align the boxes vertically on the right 
RecentFileLimit=9 ; Limit for the number of recent files 
MultiSelectionColor=0,255,0 ; Mixed color for selected tiles