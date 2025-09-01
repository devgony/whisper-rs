# PowerShell script to build with maximum CPU compatibility
# This forces the build to use only baseline x86-64 instructions

Write-Host "Setting up environment for maximum CPU compatibility build..." -ForegroundColor Green

# Set environment variables to disable CPU feature detection
$env:CARGO_CFG_TARGET_FEATURE = ""
$env:CARGO_CFG_TARGET_CPU = "x86-64"

# Force MSVC to use conservative settings with dynamic runtime
$env:_CL_ = "/O1 /Oi- /fp:precise /MD /D__SSE__=0 /D__SSE2__=0 /D__AVX__=0 /D__AVX2__=0"
$env:_LINK_ = "/MACHINE:X64 /SUBSYSTEM:WINDOWS"

# Disable any CPU detection in CMake
$env:CMAKE_SYSTEM_PROCESSOR = "x86_64"
$env:CMAKE_HOST_SYSTEM_PROCESSOR = "x86_64"

# Use dynamic runtime
$env:CMAKE_MSVC_RUNTIME_LIBRARY = "MultiThreadedDLL"

# Clean previous builds
Write-Host "Cleaning previous build artifacts..." -ForegroundColor Yellow
if (Test-Path "target") {
    Remove-Item -Recurse -Force "target"
}

# Build with explicit target
Write-Host "Building with x86-64 baseline target..." -ForegroundColor Green
cargo build --release --target x86_64-pc-windows-msvc

Write-Host "Build complete. The binary should now work across different Intel CPU generations." -ForegroundColor Green