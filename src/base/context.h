#ifndef CONTEXT_H
#define CONTEXT_H

//~ OS Context
#if defined(_WIN32)
# define OS_WINDOWS 1
#elif defined(__gnu_linux__) || defined(__linux__)
# define OS_LINUX 1
#endif

//~ Compiler Context
#if defined(_MSC_VER)
# define COMPILER_MSVC 1
#elif defined(__clang__)
# define COMPILER_CLANG 1
#endif

//~ Build options
#if !defined(BUILD_DEBUG)
# define BUILD_DEBUG 1
#endif

#endif // CONTEXT_H
