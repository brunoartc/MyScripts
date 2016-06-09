@echo off
set wget="./bin/wget/wget.exe"
set z="./bin/7z/7za.exe"
if NOT EXIST dolphin*.7z %wget% --no-check-certificate http://dl.dolphin-emu.org/builds/dolphin-master-4.0-9440-x64.7z
if NOT EXIST NUS*.7z %wget% --no-check-certificate https://www.dropbox.com/s/3iuuhhagnzlhzng/NUSDownloader_v19.7z
rename file NUS.7z
if NOT EXIST *.app %wget% --no-check-certificate https://www.dropbox.com/s/559exxpvloivk21/00000011.app
rename file 00000011.app
if NOT EXIST extract_certs.exe %wget% --no-check-certificate https://www.dropbox.com/s/r9dic4xd7c1q4rl/extract_certs.exe
rename file extract_certs.exe
if NOT EXIST Wii*.exe %wget% --no-check-certificate https://www.dropbox.com/s/0xa9p8b2fknl8cx/Wiimmfi%20Unbanner.exe
rename file WiiUnbanner.exe
%z% x *.7z 
%z% x *.zip


:MaK
cls
echo --------------------------------------
echo.
echo Deseja Baixar Mario Kart (S/N)
echo.
echo -------------------------------------- 
set /p MK=
if %MK%==S %wget% --no-check-certificate https://www.dropbox.com/s/70n8peb2t8tjink/Mario%20Kart%20%28Scrubbed%29.torrent
if %MK%==s %wget% --no-check-certificate https://www.dropbox.com/s/70n8peb2t8tjink/Mario%20Kart%20%28Scrubbed%29.torrent
if %MK%==N goto pra
if %MK%==n goto pra
::if NOT %MK%==n goto MaK
rename file mario.torrent

:MaKF
cls
echo --------------------------------------
echo.
echo Deseja Baixar O Patcher Mario Kart Fun (S/N)
echo.
echo -------------------------------------- 
set /p MK=
if %MK%==S %wget% --no-check-certificate http://wiimm.de/r/d/fun-2016-02
if %MK%==s %wget% --no-check-certificate http://wiimm.de/r/d/fun-2016-02
if %MK%==N goto pra
if %MK%==n goto pra
::if NOT %MK%==n goto MaKF



:pra
if NOT EXIST C:\Windows\System32\vcruntime140.dll %wget% --no-check-certificate https://www.dropbox.com/s/j06qbkimsis1w0w/vc_redist.x64.exe
if NOT EXIST C:\Windows\System32\vcruntime140.dll echo ERRO DLL NAO ENCONTRADA INSTALANDO... AGUARDE
if NOT EXIST C:\Windows\System32\vcruntime140.dll rename file vc_redist.x64.exe
::if NOT EXIT C:\Windows\System32\msvcp140.dll %wget% --no-check-certificate https://www.dropbox.com/s/74vv0exj27x35wa/vc_redist.x86.exe
::rename file vc_redist.x86.exe
if NOT EXIST C:\Windows\System32\vcruntime140.dll start vc_redist.x64.exe /quiet
timeout /NOBREAK 5





cd Dolphin-x64
start Dolphin.exe
cd ..
cls
echo --------------------------------------
echo.
echo espere acabai a configuracao e pressione uma tecla...
echo.
echo -------------------------------------- 
pause /NOBREAK 5
taskkill /IM dolphin.exe

if EXIST *.app goto EXTRACT
cls
echo --------------------------------------
echo.
echo Clique em "Database..."
echo Depois em "IOS"
echo "IOS 13"
echo "Latest Version"
echo.
echo -------------------------------------- 
cd "NUSDownloader_v19"
pause
start NUS*.exe
pause
copy titles\000000010000000D\1032\00000011 .\

:EXTRACT
extract_certs.exe 00000011.app
timeout /NOBREAK 3
if EXIST "%userprofile%\OneDrive\Documentos\Dolphin Emulator\Wii" copy *.pem "%userprofile%\OneDrive\Documentos\Dolphin Emulator\Wii"
if EXIST "%userprofile%\Documentos\Dolphin Emulator\Wii" copy *.pem "%userprofile%\Documentos\Dolphin Emulator\Wii"
if EXIST "%userprofile%\Documents\Dolphin Emulator\Wii" copy *.pem "%userprofile%\Documents\Dolphin Emulator\Wii"
if EXIST "%userprofile%\OneDrive\Documents\Dolphin Emulator\Wii" copy *.pem "%userprofile%\OneDrive\Documents\Dolphin Emulator\Wii"
cls
echo --------------------------------------
echo.
echo Uma janala abrira logo em seguida...
if EXIST "%userprofile%\OneDrive\Documentos\Dolphin Emulator\Wii" echo "%userprofile%\OneDrive\Documentos\Dolphin Emulator"
if EXIST "%userprofile%\Documentos\Dolphin Emulator\Wii" echo "%userprofile%\Documentos\Dolphin Emulator"
if EXIST "%userprofile%\Documents\Dolphin Emulator\Wii" echo "%userprofile%\Documents\Dolphin Emulator"
if EXIST "%userprofile%\OneDrive\Documents\Dolphin Emulator\Wii" echo "%userprofile%\OneDrive\Documents\Dolphin Emulator"
echo Copie o texto acima na proxima tela e precione enter..
echo.
echo -------------------------------------- 
pause
taskkill /IM dolphin.exe
start WiiUnbanner.exe
del *.zip
del *.exe
del *.7z
del *.app
del *.pem
exit




