@echo off
echo Searching for built DLL files...
echo.

for /r target\ %%f in (*.dll) do (
    echo Found: %%f
)

echo.
echo DLLs should also be copied to:
for /d %%d in (target\release\build\whisper-rs-sys-*) do (
    if exist "%%d\out\dll\" (
        echo %%d\out\dll\
        dir "%%d\out\dll\*.dll" /b 2>nul
    )
)