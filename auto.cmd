@echo off
mkdir arquivos
::IF YOU ARE ADVANCED USER CHANGE 0 to 1 FROM NEXT LINE
set ad=0
set tess=0
if %ad%==0 echo --- ---- -- --- ---- ---
if %ad%==0 echo seu dispositivo é falcon (Moto G)? 
if %ad%==0 echo 1 - Caso seja [enter] caso nao
set /p falcon=
:BLAS
if %ad%==1 echo on
title CM
set camfastboot=.\drivers\adb\fastboot.exe
set camadb=.\drivers\adb\adb.exe
if NOT exist .\arquivos\cm*.zip goto ERRO404
if NOT exist .\arquivos\open_gapps*.zip goto ERRO404
if NOT exist .\arquivos\*.img goto ERRO404

cd arquivos
rename open_gapps*.zip open_gapps.zip
cd..
::goto INICIO
if %ad%==0 if %ad%==0 echo.
if %ad%==0 if %ad%==0 echo Precisa dos drivers para o celular S/N 
if %ad%==0 if %ad%==0 echo S - Se for a primeira vez que voce abre o programa
if %ad%==0 if %ad%==0 echo.
set /p driv=
if %driv%==S goto DRIVER
if %driv%==s goto DRIVER
:DRIVER!
if %ad%==1 goto AQUI!
if %ad%==0 echo.
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo                             AVISO
if %ad%==0 echo CONECTE SEU CELULAR NO COMPUTADOR E ATIVE A PONTE DE DEPURACAO DO
if %ad%==0 echo ANDROID(adb) E PERMITA ESTE PC PARA CONTINUAR
if %ad%==0 echo seu dispositivo sera reiniciado logo em seguida automaticamente
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo.
if %ad%==0 echo esperando por dispositivo....
if %ad%==0 %camadb% wait-for-device
if %ad%==0 %camadb% reboot-bootloader
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo Seu celular foi reiniciado com sucesso...
if %ad%==0 echo.
timeout 3
if %ad%==0 cls
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo                             AVISO
if %ad%==0 echo ESTE PROGRAMA SO FUNCIONA EM DISPOSITIVOS COM FASTBOOT
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo.
timeout 3
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo                              AVISO
if %ad%==0 echo TENHA CERTEZA QUE O OpenGapps ESTA NA MESMA VERSAO DO CyanoGenMod
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo.
timeout 6
:AQUI!
if %ad%==1 set cm=13
if %ad%==1 set gapps=6
if %ad%==1 goto AQUI
:INICIO
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo INSIRA A VERSAO DO CyanoGenMod E PRECIONE ENTER 
if %ad%==0 echo.
set /p cm=
set /a cm=%cm%+0
title CM %cm%
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo INSIRA A VERSAO DO OpenGapps E PRECIONE ENTER 
if %ad%==0 echo.
set /p gapps=
set /a gapps=%gapps%+0
:AQUI
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
if %ad%==0 cls
if %ad%==0 echo DESEJA FORMATAR O DISPOSITIVO? "S/N"       
if %ad%==0 echo.
set /p formats=
if %formats%==S goto FORMAT2
if %formats%==s goto FORMAT2
if %formats%==N goto PERGUNTA1
if %formats%==n goto PERGUNTA1
if NOT %formats%==n goto PERGUNTA2



:FORMAT2
if %ad%==0 cls
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
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo DESEJA FORMATAR OS DADOS DE USUARIO? "S/N"(PERIGO)          
if %ad%==0 echo.
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
if %ad%==0 echo.
if %ad%==0 echo ERRO: Nenhuma "Recovery" encontrada
if %ad%==0 echo P-Pular
if %ad%==0 echo C-Para inserir o nome da recovery
if %ad%==0 echo.
set /p rec=
if %rec%==P goto FLASH
if %rec%==p goto FLASH
if %rec%==C goto C
if %rec%==c goto C
if NOT %rec%==c goto ERRO1
:C
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo INSIRA O NOME DA RECOVERY "nome_da_recovery.img" obs:tem que estar localizada dentro da pasta \arquivos
if %ad%==0 echo e precione "Enter"
if %ad%==0 echo.
set /p rec=
if NOT exist %rec% goto C
%camfastboot% flash %rec%
goto PROCROM
:PHILZ
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo                              AVISO
if %ad%==0 echo INSTALANDO RECOVERY Philz espere um pouco
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo.
%camfastboot% flash recovery .\arquivos\philz.img

goto PROCROM
:TWRP
if %ad%==0 cls
%camfastboot% flash recovery .\arquivos\twrp.img
goto PROCROM
:CM
if %ad%==0 cls
%camfastboot% flash recovery .\arquivos\cm.img




:PROCROM
if %ad%==0 cls
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
goto FLASH1


if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo DESEJA FAZER ROOT? "S/N"
if %ad%==0 echo.
set /p root=
if %root%==S goto ROOT
if %root%==s goto ROOT
timeout 5



:FLASH1
if %ad%==0 cls
if %ad%==0 echo.
title ATUALIZANDO CELULAR
if %ad%==0 echo.
set gapps=.\arquivos\open_gapps-%gapps%.zip
::%camfastboot% update %cm% 
::%camfastboot% boot .\arquivos\philz.img
::"BROKE"
::%camfastboot% update %gapps% 
::"BROKE"
%camfastboot% reboot
::%camadb% wait-for-device
::%camadb% reboot recovery
if %ad%==0 cls
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo                             AVISO
if %ad%==0 echo SIGA AS INSTRUCOES NA TELA PARA SELECIONAR "Recovery"
if %ad%==0 echo E ENTRE NESTE MODO
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo.
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo                             AVISO
if %ad%==0 echo SELECIONE A OPCAO "Install zip/Aplly update" em seguida "Apply update/install zip from sideload"
if %ad%==0 echo e precione enter
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo.
pause>nul
%camadb% wait-for-device
%camadb% sideload %cm%
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo                             AVISO
if %ad%==0 echo AGUARDE O FINAL DA INSTALACAO, ATE DESAPARECER A OPCAO "Cancel sideload" e novamente
if %ad%==0 echo SELECIONE A OPCAO "Install zip/Aplly update" em seguida "Apply update/install zip from sideload"
if %ad%==0 echo e precione entrer
if %ad%==0 echo ------------------------------------------------------------------
pause>nul
%camadb% wait-for-device
%camadb% sideload %gapps%
if %ad%==0 cls
if %ad%==0 echo.
if %ad%==0 echo ------------------------------------------------------------------
if %ad%==0 echo                             AVISO
if %ad%==0 echo AGUARDE O FINAL DA INSTALACAO, ATE DESAPARECER A OPCAO "Cancel sideload"
if %ad%==0 echo seu celular sera reniciado e estara pronto para uso
if %ad%==0 echo ------------------------------------------------------------------
%camadb% wait-for-device
%camadb% reboot
exit




:ROOT
if %ad%==0 echo.
if %ad%==0 echo ----- CF-Auto-Root-falconumtsds-falconretbrds-xt1033 -----
if %ad%==0 echo.
if %ad%==0 echo If you are on Android 5.0 or newer, please make sure the "Allow OEM Unlock"
if %ad%==0 echo option (if present) is enabled in "Settings->Developer Options".
::%camfastboot% oem unlock 1>NUL 2>NUL "POINTLESS"
::%camfastboot% oem unlock 1>NUL 2>NUL "POINTLESS"
::%camfastboot% flashing unlock 1>NUL 2>NUL "POINTLESS"
::%camfastboot% flashing unlock 1>NUL 2>NUL "POINTLESS"
%camfastboot% boot .\drivers\root\CF-AutoRoot.img
if %ad%==0 echo by ChainFire
if %ad%==0 echo.
timeout 3
if %ad%==0 cls
goto FLASH1
pause>nul
exit

:ERRO404
title ERRO404
if %ad%==0 cls
if %ad%==0 echo 404-NOT FOUND
if %ad%==0 echo ARQUIVOS NAO ENCONTRADOS
if %ad%==0 echo TENHA CERTEZA DE QUE O ARQUIVO "cm-xx-xxxxxxxxx.zip" e "open_gapps-xxx-x.x" ESTEJAM NA PASTA \arquivos
if %ad%==0 echo E QUE SUAS VERSOES CONHECIDAM
if %falcon%==1 goto wget
:CONT
if %ad%==0 cls
if %ad%==0 echo --- ---- -- --- ---- ---
if %ad%==0 echo deseja checar a compatibilidade das versoes e baixar os arquivos? "S/N"
set /p teste=
if %teste%==n exit
if %teste%==N exit
start https://wiki.cyanogenmod.org/w/Google_Apps
start https://download.cyanogenmod.org/
start http://opengapps.org/
exit
:wget
if %tess%==1 goto CONT
set tess=1
if %ad%==0 echo ********************************************************************************
if %ad%==0 echo BAIXANDO ARQUIVOS GOOGLE APPS(Marshmellow 6.0 Realease) ... POR FAVOR, ESPERE ...[ERROR]
if %ad%==0 echo ********************************************************************************
if NOT exist .\arquivos\open*.zip drivers\wget\bin\wget.exe --no-check-certificate https://dl.dropboxusercontent.com/u/74069770/open_gapps-6.zip
if %ad%==0 cls
if %ad%==0 echo ********************************************************************************
if %ad%==0 echo BAIXANDO ARQUIVOS CyanoGenMod(Marshmellow 13 Realease 16/05/2016) ... POR FAVOR, ESPERE ...
if %ad%==0 echo ********************************************************************************
if NOT exist .\arquivos\cm*.zip drivers\wget\bin\wget.exe --no-check-certificate https://download.cyanogenmod.org/get/jenkins/162086/cm-13.0-20160516-NIGHTLY-falcon.zip
if %ad%==0 echo ********************************************************************************
if %ad%==0 echo BAIXANDO ARQUIVOS (Philz Recovery) ... POR FAVOR, ESPERE ...
if %ad%==0 echo ********************************************************************************
if NOT exist .\arquivos\*.img drivers\wget\bin\wget.exe --no-check-certificate https://dl.dropboxusercontent.com/u/74069770/philz_touch_6.58.7-falcon.img
move *.zip arquivos
move *.img arquivos
goto BLAS
:ERROR
if %ad%==0 echo versao do CyanoGenMod muito antiga, desculpe!
pause>nul
exit
:DRIVER
if if %ad%==0 .\drivers\wget\bin\wget.exe http://adbdriver.com/upload/adbdriver.zip
start .\drivers\drive\ADBDriverInstaller.exe
goto DRIVER!