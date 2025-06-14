#ifndef CORE_H
#define CORE_H

#include <stdint.h>
#include <stdio.h>

//~ Base-Types
typedef int8_t   S8;
typedef int16_t  S16;
typedef int32_t  S32;
typedef int64_t  S64;
typedef uint8_t  U8;
typedef uint16_t U16;
typedef uint32_t U32;
typedef uint64_t U64;
typedef S8       B8;
typedef S16      B16;
typedef S32      B32;
typedef S64      B64;
typedef float    F32;
typedef double   F64;

//~ Misc macro
#define ArrayCount(a) (sizeof(a) / sizeof((a)[0]))

//~ For-Loop Construct Macros
#define DeferLoop(begin, end)        for(int _i_ = ((begin), 0); !_i_; _i_ += 1, (end))
#define DeferLoopChecked(begin, end) for(int _i_ = 2 * !(begin); (_i_ == 2 ? ((end), 0) : !_i_); _i_ += 1, (end))

#define EachIndex(it, count)         (U64 it = 0; it < (count); it += 1)
#define EachElement(it, array)       (U64 it = 0; it < ArrayCount(array); it += 1)
#define EachEnumVal(type, it)        (type it = (type)0; it < type##_COUNT; it = (type)(it+1))
#define EachNonZeroEnumVal(type, it) (type it = (type)1; it < type##_COUNT; it = (type)(it+1))

#endif // CORE_H
