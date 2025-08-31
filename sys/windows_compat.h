// Windows compatibility header to force disable all SIMD intrinsics
// This ensures maximum compatibility across different CPU generations

#ifndef WINDOWS_COMPAT_H
#define WINDOWS_COMPAT_H

#ifdef _WIN32

// Undefine all CPU feature macros to prevent any SIMD code from being compiled
#undef __SSE3__
#undef __SSSE3__
#undef __SSE4_1__
#undef __SSE4_2__
#undef __AVX__
#undef __AVX2__
#undef __AVX512F__
#undef __FMA__
#undef __F16C__
#undef __BMI__
#undef __BMI2__
#undef __POPCNT__
#undef __LZCNT__

// Define them as 0 to ensure no SIMD paths are taken
#define __SSE3__ 0
#define __SSSE3__ 0
#define __SSE4_1__ 0
#define __SSE4_2__ 0
#define __AVX__ 0
#define __AVX2__ 0
#define __AVX512F__ 0
#define __FMA__ 0
#define __F16C__ 0
#define __BMI__ 0
#define __BMI2__ 0
#define __POPCNT__ 0
#define __LZCNT__ 0

// Also disable MSVC-specific intrinsics
#ifdef _MSC_VER
#define _M_IX86_FP 0  // No SSE/SSE2 floating point
#endif

#endif // _WIN32

#endif // WINDOWS_COMPAT_H