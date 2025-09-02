@echo off
echo Building whisper-rs with dual DLL support...

:: Temporarily rename Git's link.exe to avoid conflicts
echo Fixing linker conflicts...
if exist "C:\Program Files\Git\usr\bin\link.exe" (
    ren "C:\Program Files\Git\usr\bin\link.exe" "link.exe.backup"
)

echo.
echo Building scalar version (compatible with all CPUs)...
set WHISPER_BUILD_TYPE=scalar
cargo build --release
if %ERRORLEVEL% neq 0 (
    echo Failed to build scalar version
    goto :restore_link
)

echo.
echo Building AVX-optimized version (requires AVX2 support)...
set WHISPER_BUILD_TYPE=avx
cargo build --release
if %ERRORLEVEL% neq 0 (
    echo Failed to build AVX version
    goto :restore_link
)

:restore_link
:: Restore Git's link.exe
echo Restoring linker...
if exist "C:\Program Files\Git\usr\bin\link.exe.backup" (
    ren "C:\Program Files\Git\usr\bin\link.exe.backup" "link.exe"
)

echo.
echo Both versions built successfully!
echo.
echo DLL files are located in:
for /d %%d in (target\release\build\whisper-rs-sys-*) do (
    if exist "%%d\out\dll\" (
        echo %%d\out\dll\
        echo.
        echo Files:
        dir "%%d\out\dll\*.dll" /b
        echo.
    )
)

echo Copy these DLLs to your Tauri app for distribution.
echo Use whisper_rs::cpu_supports_avx() to detect which version to load at runtime.