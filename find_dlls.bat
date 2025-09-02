@echo off
echo Searching for built DLL files...
echo.

:: Use CARGO_TARGET_DIR if set, otherwise default to target
if defined CARGO_TARGET_DIR (
    set TARGET_BASE=%CARGO_TARGET_DIR%
    echo Using CARGO_TARGET_DIR: %CARGO_TARGET_DIR%
) else (
    set TARGET_BASE=target
    echo Using default target directory
)

echo.
echo Searching for DLL files in %TARGET_BASE%...
for /r "%TARGET_BASE%\" %%f in (*.dll) do (
    echo Found: %%f
)

echo.
echo DLLs should also be copied to:
for /d %%d in ("%TARGET_BASE%\release\build\whisper-rs-sys-*") do (
    if exist "%%d\out\dll\" (
        echo %%d\out\dll\
        dir "%%d\out\dll\*.dll" /b 2>nul
    )
)