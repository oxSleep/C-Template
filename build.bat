@echo off
setlocal
cd /D "%~dp0"

:: Parse arguments
for %%a in (%*) do set "%%a=1"
if not "%msvc%"=="1" if not "%clang%"=="1" set msvc=1
if not "%release%"=="1" set debug=1
if "%debug%"=="1"   set release=0 && echo [debug mode]
if "%release%"=="1" set debug=0 && echo [release mode]
if "%msvc%"=="1"    set clang=0 && echo [msvc compile]
if "%clang%"=="1"   set msvc=0 && echo [clang compile]

:: Compile/Link definitions
set cl_common=  /cgthreads2 /MP /std:c11 /Z7 /FC /nologo
set cl_debug=   call cl /Od /DBUILD_DEBUG=1 %cl_common%
set cl_release= call cl /O2 /DBUILD_DEBUG=0 %cl_common%
set cl_link=    /link /INCREMENTAL:NO
set cl_out=     /out:

set clang_common=  -std=c11 -gcodeview -fdiagnostics-absolute-paths -Xclang -flto-visibility-public-std -D_USE_MATH_DEFINES -Dstrdup=_strdup -Dgnu_printf=printf -maes -msse4 -mssse3
set clang_debug=   call clang -g -O0 -DBUILD_DEBUG=1 %clang_common%
set clang_release= call clang -g -O2 -DBUILD_DEBUG=0 %clang_common%
set clang_link=    -fuse-ld=lld -Xlinker /MANIFEST:EMBED
set clang_out=     -o

:: Build settings
set link_dll=-DLL
if "%msvc%"=="1"  set only_compile=/c
if "%msvc%"=="1"  set EHsc=/EHsc
if "%msvc%"=="1"  set no_aslr=/DYNAMICBASE:NO

if "%clang%"=="1" set only_compile=-c
if "%clang%"=="1" set EHsc=
if "%clang%"=="1" set no_aslr=-Wl,/DYNAMICBASE:NO

:: Peak Compile/Link lines
if "%msvc%"=="1" set compile_debug=%cl_debug%
if "%msvc%"=="1" set compile_release=%cl_release%
if "%msvc%"=="1" set compile_link=%cl_link%
if "%msvc%"=="1" set out=%cl_out%

if "%clang%"=="1" set compile_debug=%clang_debug%
if "%clang%"=="1" set compile_release=%clang_release%
if "%clang%"=="1" set compile_link=%clang_link%
if "%clang%"=="1" set out=%clang_out%

if "%debug%"=="1"   set compile=%compile_debug%
if "%release%"=="1" set compile=%compile_release%

:: Prep directory
if not exist build mkdir build

:: Build
pushd build
if "%main%"=="1" %compile% ..\src\main.c %compile_link% %out%main.exe || exit /b 1

:: Unset
for %%a in (%*) do set "%%a=0"
set compile=
set compile_link=
set out=
set msvc=
set debug=
