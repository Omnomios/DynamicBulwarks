rem ## Packs mission into PBO files for distribution ##

@echo off

for %%* in (.) do set DirName=%%~nx*
cd ..
robocopy %DirName% packsource /s /e /XD .git /XF mapList.txt pack.bat /NJH /NJS

for /F "eol=; tokens=1 delims=," %%i in  ( ./%DirName%/mapList.txt ) do  (
   echo Processing %%i...
   PBOConsole.exe -pack ./packsource ./DynamicBulwarks10.%%i.pbo > nul
)
echo Cleaning up.

rd /s /q "./packsource"
cd %DirName%

echo Done.
