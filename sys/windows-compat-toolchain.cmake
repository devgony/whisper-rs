# Windows compatibility toolchain for cross-CPU compatibility
# This forces the compiler to generate code for the lowest common denominator x86-64

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Force MSVC to use the most conservative settings
if(MSVC)
    # Disable all optimizations that might use CPU-specific instructions
    set(CMAKE_C_FLAGS_INIT "/O1 /Oi- /fp:precise /GS /Gy- /Gw-")
    set(CMAKE_CXX_FLAGS_INIT "/O1 /Oi- /fp:precise /GS /Gy- /Gw- /EHsc")
    
    # Force static runtime to avoid DLL dependencies
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded")
    
    # Disable all CPU feature detection
    add_compile_definitions(
        __SSE__=0
        __SSE2__=0
        __SSE3__=0
        __SSSE3__=0
        __SSE4_1__=0
        __SSE4_2__=0
        __AVX__=0
        __AVX2__=0
        __FMA__=0
        __F16C__=0
        __BMI__=0
        __BMI2__=0
        _M_IX86_FP=0
    )
endif()

# Force disable all SIMD for GCC/Clang
if(CMAKE_COMPILER_IS_GNUCC OR CMAKE_C_COMPILER_ID MATCHES "Clang")
    set(CMAKE_C_FLAGS_INIT "-O1 -march=x86-64 -mtune=generic -mno-sse3 -mno-ssse3 -mno-sse4 -mno-sse4.1 -mno-sse4.2 -mno-avx -mno-avx2 -mno-fma -mno-f16c -fno-tree-vectorize")
    set(CMAKE_CXX_FLAGS_INIT "-O1 -march=x86-64 -mtune=generic -mno-sse3 -mno-ssse3 -mno-sse4 -mno-sse4.1 -mno-sse4.2 -mno-avx -mno-avx2 -mno-fma -mno-f16c -fno-tree-vectorize")
endif()

# Override any system processor detection
set(CMAKE_SYSTEM_PROCESSOR "x86_64" CACHE STRING "Target processor" FORCE)
set(CMAKE_HOST_SYSTEM_PROCESSOR "x86_64" CACHE STRING "Host processor" FORCE)