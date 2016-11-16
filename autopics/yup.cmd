mkdir pdf
for /r ".\" %%x in (*.pdf) do move "%%x" ".\pdf"

mkdir mp
for /r ".\" %%x in (*.mp4) do move "%%x" ".\mp"
for /r ".\" %%x in (*.mp3) do move "%%x" ".\mp"

mkdir jp
for /r ".\" %%x in (*.jpeg) do move "%%x" ".\jp"
for /r ".\" %%x in (*.jpg) do move "%%x" ".\jp"
mkdir png
for /r ".\" %%x in (*.png) do move "%%x" ".\png"

mkdir gif
for /r ".\" %%x in (*.gif) do move "%%x" ".\gif"
cd /gif
mkdir tumblr
for /r ".\" %%x in (*tumblr*) do move "%%x" ".\tumblr"
cd ..

for /f "usebackq delims=" %%d in (`"dir /ad/b/s | sort /R"`) do rd "%%d"