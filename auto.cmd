@echo off
::IF YOU ARE ADVANCED USER CHANGE 0 to 1 FROM NEXT LINE
set ad=0
if %ad%==1 echo on
title CM
set camfastboot=.\drivers\adb\fastboot.exe
set camadb=.\drivers\adb\adb.exe
if NOT exist .\arquivos\cm*.zip goto ERRO404
if NOT exist .\arquivos\open_gapps*.zip goto ERRO404
cd arquivos
rename open_gapps*.zip open_gapps.zip
cd..
::goto INICIO
if %ad%==0 echo.
if %ad%==0 echo Precisa dos drivers para o celular S/N 
if %ad%==0 echo S - Se for a primeira vez que voce abre o programa
if %ad%==0 echo.
if %ad%==0 set /p driv=
if %ad%==0 if %driv%==S goto DRIVER
if %ad%==0 if %driv%==s goto DRIVER
:DRIVER!

echo.
echo ------------------------------------------------------------------
echo                             AVISO
echo CONECTE SEU CELULAR NO COMPUTADOR E ATIVE A PONTE DE DEPURACAO DO
echo ANDROID(adb) E PERMITA ESTE PC PARA CONTINUAR
echo seu dispositivo sera reiniciado logo em seguida automaticamente
echo ------------------------------------------------------------------
echo.
echo esperando por dispositivo....
if %ad%==0 %camadb% wait-for-device
if %ad%==0 %camadb% reboot-bootloader
cls
echo.
echo Seu celular foi reiniciado com sucesso...
echo.
timeout 3
cls
echo ------------------------------------------------------------------
echo                             AVISO
echo ESTE PROGRAMA SO FUNCIONA EM DISPOSITIVOS COM FASTBOOT
echo ------------------------------------------------------------------
echo.
timeout 3
cls
echo.
echo ------------------------------------------------------------------
echo                              AVISO
echo TENHA CERTEZA QUE O OpenGapps ESTA NA MESMA VERSAO DO CyanoGenMod
echo ------------------------------------------------------------------
echo.
timeout 6
:INICIO
cls
echo.
echo INSIRA A VERSAO DO CyanoGenMod E PRECIONE ENTER 
echo.
set /p cm=
set /a cm=%cm%+0
title CM %cm%
cls
echo.
echo INSIRA A VERSAO DO OpenGapps E PRECIONE ENTER 
echo.
set /p gapps=
set /a gapps=%gapps%+0
cd arquivos
rename open_gapps*.zip open_gapps-%gapps%.zip
cd..

if %cm% GEQ 13 goto gapps1
goto teste21
:gapps1
if NOT %gapps% GEQ 6 goto ERRO404
:teste21
if %cm% GEQ 12 goto gapps2
goto ERROR
:gapps2
if NOT %gapps% GEQ 5 goto ERRO404
:PERGUNTA2
cls
echo DESEJA FORMATAR O DISPOSITIVO? "S/N"       
echo.
set /p formats=
if %formats%==S goto FORMAT2
if %formats%==s goto FORMAT2
if %formats%==N goto PERGUNTA1
if %formats%==n goto PERGUNTA1
if NOT %formats%==n goto PERGUNTA2



:FORMAT2
cls
::%camfastboot% erase splash1 "OUTDATE"
%camfastboot% erase recovery
%camfastboot% erase boot
%camfastboot% erase system
%camfastboot% erase cache
::%camfastboot% format splash1 "OUTDATE"
%camfastboot% format recovery
%camfastboot% format boot
%camfastboot% format system
%camfastboot% format cache


:PERGUNTA1
cls
echo.
echo DESEJA FORMATAR OS DADOS DE USUARIO? "S/N"(PERIGO)          
echo.
set /p formats=
if %formats%==N goto NF
if %formats%==n goto NF
if %formats%==S goto FORMAT3
if %formats%==s goto FORMAT3
:FORMAT3
if NOT %formats%==s goto PERGUNTA1
::%camfastboot% erase userdata "OUTDATE"
::%camfastboot% format userdata "OUTDATE"
%camfastboot% -w


:NF

if exist .\arquivos\philz*.img goto PHILZ1
goto TWRP2
:PHILZ1
cd arquivos
rename philz*.img philz.img
cd..
goto PHILZ

:TWRP2
if exist .\arquivos\twrp*.img goto TWRP1
goto CM2
:TWRP1
cd arquivos
rename twrp*.img twrp.img
cd..
goto TWRP

:CM2
if exist .\arquivos\cm-%cm%*.img goto CM1
goto ERRO1
:CM1
cd arquivos
rename cm-%cm%*.img cm-%cm%.img
cd..
goto CM
:ERRO1
echo.
echo ERRO: Nenhuma "Recovery" encontrada
echo P-Pular
echo C-Para inserir o nome da recovery
echo.
set /p rec=
if %rec%==P goto FLASH
if %rec%==p goto FLASH
if %rec%==C goto C
if %rec%==c goto C
if NOT %rec%==c goto ERRO1
:C
cls
echo.
echo INSIRA O NOME DA RECOVERY "nome_da_recovery.img" obs:tem que estar localizada dentro da pasta \arquivos
echo e precione "Enter"
echo.
set /p rec=
if NOT exist %rec% goto C
%camfastboot% flash %rec%
goto PROCROM
:PHILZ
cls
echo.
echo ------------------------------------------------------------------
echo                              AVISO
echo INSTALANDO RECOVERY Philz espere um pouco
echo ------------------------------------------------------------------
echo.
%camfastboot% flash recovery .\arquivos\philz.img

goto PROCROM
:TWRP
cls
%camfastboot% flash recovery .\arquivos\twrp.img
goto PROCROM
:CM
cls
%camfastboot% flash recovery .\arquivos\cm.img




:PROCROM
cls
if exist .\arquivos\cm-%cm%*.zip goto CMFLASHC
goto CMFLASHCF
:CMFLASHC
cd arquivos
rename cm-%cm%*.zip cm-%cm%.zip
cd..
set cm=.\arquivos\cm-%cm%.zip
GOTO FLASH
:CMFLASHCF


if exist .\arquivos\cm-12*.zip goto CMFLASH12
:CMFLASH12
goto CMFLASH12F 
cd arquivos
rename cm-12*.zip cm-12.zip
cd..
set cm=.\arquivos\cm-12.zip
title CM 12(Android Lolipop)
GOTO FLASH
:CMFLASH12F

if exist .\arquivos\cm-13*.zip goto CMFLASH13
:CMFLASH13
goto CMFLASH13F
cd arquivos
rename cm-13*.zip cm-13.zip
cd..
set cm=.\arquivos\cm-13.zip
title CM 13(Android Marshmellow)
GOTO FLASH
:CMFLASH13F



:FLASH
cls
echo.
echo DESEJA FAZER ROOT? "S/N"
echo.
set /p root=
if %rootr%==S goto ROOT
if %rootr%==s goto ROOT
timeout 5



:FLASH1
cls
echo.
title ATUALIZANDO CELULAR
echo.
set gapps=.\arquivos\open_gapps-%gapps%.zip
::%camfastboot% update %cm% "BROKE"
::%camfastboot% update %gapps% "BROKE"
%camfastboot% reboot
%camadb% wait-for-device
%camadb% reboot recovery
cls
echo ------------------------------------------------------------------
echo                             AVISO
echo SELECIONE A OPCAO "Install zip/Aplly update" em seguida "Apply update/install zip from sideload"
echo e precione uma tecla para continuar
echo ------------------------------------------------------------------
echo.
pause>nul
%camadb% sideload %cm%
cls
echo.
echo ------------------------------------------------------------------
echo                             AVISO
echo AGUARDE O FINAL DA INSTALACAO, ATE DESAPARECER A OPCAO "Cancel sideload" e novamente
echo SELECIONE A OPCAO "Install zip/Aplly update" em seguida "Apply update/install zip from sideload"
echo e precione uma tecla para continuar
echo ------------------------------------------------------------------
pause>nul
%camadb% sideload %gapps%
cls
echo.
echo ------------------------------------------------------------------
echo                             AVISO
echo AGUARDE O FINAL DA INSTALACAO, ATE DESAPARECER A OPCAO "Cancel sideload" e novamente
echo seu celular sera reniciado e estara pronto para uso
echo ------------------------------------------------------------------
%camfastboot% reboot
exit




:ROOT
echo.
echo ----- CF-Auto-Root-falconumtsds-falconretbrds-xt1033 -----
echo.
echo If you are on Android 5.0 or newer, please make sure the "Allow OEM Unlock"
echo option (if present) is enabled in "Settings->Developer Options".
::%camfastboot% oem unlock 1>NUL 2>NUL "POINTLESS"
::%camfastboot% oem unlock 1>NUL 2>NUL "POINTLESS"
::%camfastboot% flashing unlock 1>NUL 2>NUL "POINTLESS"
::%camfastboot% flashing unlock 1>NUL 2>NUL "POINTLESS"
%camfastboot% boot .\drivers\root\CF-AutoRoot.img
echo by ChainFire
echo.
timeout 3
cls
goto FLASH1
pause>nul
exit

:ERRO404
title ERRO404
cls
echo 404-NOT FOUND
echo ARQUIVOS NAO ENCONTRADOS
echo TENHA CERTEZA DE QUE O ARQUIVO "cm-xx-xxxxxxxxx.zip" e "open_gapps-xxx-x.x" ESTEJAM NA PASTA \arquivos
echo E QUE SUAS VERSOES CONHECIDAM
echo --- ---- -- --- ---- ---
echo deseja checar a compatibilidade das versoes e baixar os arquivos? "S/N"
set /p teste=
if %teste%==n exit
if %teste%==N exit
start https://wiki.cyanogenmod.org/w/Google_Apps
start https://download.cyanogenmod.org/
start http://opengapps.org/
exit
:ERROR
echo versao do CyanoGenMod muito antiga, desculpe!
pause>nul
exit
:DRIVER
start .\drivers\drive\ADBDriverInstaller.exe
if if %ad%==0 .\drivers\wget\bin\wget.exe http://adbdriver.com/upload/adbdriver.zip
goto DRIVER!