@echo off
REM Patch whisper.cpp to disable all SIMD instructions for Windows compatibility

echo Patching whisper.cpp for maximum CPU compatibility...

REM Create a patch header that will be force-included
echo // Force disable all SIMD for Windows > whisper.cpp\ggml\src\no_simd.h
echo #ifdef _WIN32 >> whisper.cpp\ggml\src\no_simd.h
echo #undef __SSE__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __SSE2__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __SSE3__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __SSSE3__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __SSE4_1__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __SSE4_2__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __AVX__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __AVX2__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __FMA__ >> whisper.cpp\ggml\src\no_simd.h
echo #undef __F16C__ >> whisper.cpp\ggml\src\no_simd.h
echo #define GGML_USE_REFERENCE_IMPL 1 >> whisper.cpp\ggml\src\no_simd.h
echo #endif >> whisper.cpp\ggml\src\no_simd.h

echo Patching complete.