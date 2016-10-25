set ad=1
@echo on
set mes=1
set dia=1
set ano=2014
:ANO
if ad==0 cls
echo Ate Qual Ano?
set /p anoc=
set /a anoc=%anoc%+1
if %anoc%==1 goto ANO
if ad==0 cls
echo Local Para salvar?(C:/...)
:LOCAL
set /p local=
if ad==0 cls
	if [%local%]==[] (
		set local=%USERPROFILE%
		echo Local tmp Definido como %USERPROFILE%
		::timeout 2 /NOBREAK
		set fm=1
		pause ) ELSE (
		echo local definido como %local%
		set fm=0
		pause
	)
mkdir %local%\autopic
set local=%local%\autopic
:DIA
mkdir %local%\%ano%\%mes%
if %dia% LSS 10 (
	if %mes% LSS 10 for /r ".\" %%x in (*%ano%0%mes%0%dia%-*) do move "%%x" "%local%\%ano%\%mes%"
	if %mes% GEQ 10 for /r ".\" %%x in (*%ano%%mes%0%dia%-*) do move "%%x" "%local%\%ano%\%mes%" ) ELSE (
	
	if %mes% LSS 10 for /r ".\" %%x in (*%ano%0%mes%%dia%-*) do move "%%x" "%local%\%ano%\%mes%"
	if %mes% GEQ 10 for /r ".\" %%x in (*%ano%%mes%%dia%-*) do move "%%x" "%local%\%ano%\%mes%"	)
	
	
set /a dia=%dia%+1
if NOT %dia%==32 goto DIA
set dia=1
set /a mes=%mes%+1
if NOT %mes%==13 goto DIA
set mes=1
set dia=1
set /a ano=%ano%+1
if NOT %ano%==%anoc% goto DIA
set al=%cd%
cd %local%
for /f "usebackq delims=" %%d in (`"dir /ad/b/s | sort /R"`) do rd "%%d"
cd %al%
if %fm%==1 move %local% %cd%
echo Tudo terminado :] , procure pela pasta autopics em %local% ou %cd% 
pause