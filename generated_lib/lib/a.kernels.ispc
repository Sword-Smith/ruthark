
#define bool uint8
typedef int64 int64_t;
typedef int32 int32_t;
typedef int16 int16_t;
typedef int8 int8_t;
typedef int8 char;
typedef unsigned int64 uint64_t;
typedef unsigned int32 uint32_t;
typedef unsigned int16 uint16_t;
typedef unsigned int8 uint8_t;
#define volatile

#define FUTHARK_SUCCESS 0
#define FUTHARK_PROGRAM_ERROR 2
#define FUTHARK_OUT_OF_MEMORY 3

#define INFINITY (floatbits((uniform int)0x7f800000))
#define NAN (floatbits((uniform int)0x7fc00000))
#define fabs(x) abs(x)
#define FUTHARK_F64_ENABLED
// Start of scalar.h.

// Implementation of the primitive scalar operations.  Very
// repetitive.  This code is inserted directly into both CUDA and
// OpenCL programs, as well as the CPU code, so it has some #ifdefs to
// work everywhere.  Some operations are defined as macros because
// this allows us to use them as constant expressions in things like
// array sizes and static initialisers.

// Some of the #ifdefs are because OpenCL uses type-generic functions
// for some operations (e.g. sqrt), while C and CUDA sensibly use
// distinct functions for different precisions (e.g. sqrtf() and
// sqrt()).  This is quite annoying.  Due to C's unfortunate casting
// rules, it is also really easy to accidentally implement
// floating-point functions in the wrong precision, so be careful.

// Double-precision definitions are only included if the preprocessor
// macro FUTHARK_F64_ENABLED is set.

static inline uint8_t add8(uint8_t x, uint8_t y) {
  return x + y;
}

static inline uint16_t add16(uint16_t x, uint16_t y) {
  return x + y;
}

static inline uint32_t add32(uint32_t x, uint32_t y) {
  return x + y;
}

static inline uint64_t add64(uint64_t x, uint64_t y) {
  return x + y;
}

static inline uint8_t sub8(uint8_t x, uint8_t y) {
  return x - y;
}

static inline uint16_t sub16(uint16_t x, uint16_t y) {
  return x - y;
}

static inline uint32_t sub32(uint32_t x, uint32_t y) {
  return x - y;
}

static inline uint64_t sub64(uint64_t x, uint64_t y) {
  return x - y;
}

static inline uint8_t mul8(uint8_t x, uint8_t y) {
  return x * y;
}

static inline uint16_t mul16(uint16_t x, uint16_t y) {
  return x * y;
}

static inline uint32_t mul32(uint32_t x, uint32_t y) {
  return x * y;
}

static inline uint64_t mul64(uint64_t x, uint64_t y) {
  return x * y;
}

#if ISPC

static inline uint8_t udiv8(uint8_t x, uint8_t y) {
  // This strange pattern is used to prevent the ISPC compiler from
  // causing SIGFPEs and bogus results on divisions where inactive lanes
  // have 0-valued divisors. It ensures that any inactive lane instead
  // has a divisor of 1. https://github.com/ispc/ispc/issues/2292
  uint8_t ys = 1;
  foreach_active(i){
    ys = y;
  }

  return x / ys;
}

static inline uint16_t udiv16(uint16_t x, uint16_t y) {
  uint16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x / ys;
}

static inline uint32_t udiv32(uint32_t x, uint32_t y) {
  uint32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  

  return x / ys;
}

static inline uint64_t udiv64(uint64_t x, uint64_t y) {
  uint64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  

  return x / ys;
}

static inline uint8_t udiv_up8(uint8_t x, uint8_t y) {
  uint8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  

  return (x + y - 1) / ys;
}

static inline uint16_t udiv_up16(uint16_t x, uint16_t y) {
  uint16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return (x + y - 1) / ys;
}

static inline uint32_t udiv_up32(uint32_t x, uint32_t y) {
  uint32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return (x + y - 1) / ys;
}

static inline uint64_t udiv_up64(uint64_t x, uint64_t y) {
  uint64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return (x + y - 1) / ys;
}

static inline uint8_t umod8(uint8_t x, uint8_t y) {
  uint8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x % ys;
}

static inline uint16_t umod16(uint16_t x, uint16_t y) {
  uint16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  

  return x % ys;
}

static inline uint32_t umod32(uint32_t x, uint32_t y) {
  uint32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x % ys;
}

static inline uint64_t umod64(uint64_t x, uint64_t y) {
  uint64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x % ys;
}

static inline uint8_t udiv_safe8(uint8_t x, uint8_t y) {
  uint8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x / ys;
}

static inline uint16_t udiv_safe16(uint16_t x, uint16_t y) {
  uint16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x / ys;
}

static inline uint32_t udiv_safe32(uint32_t x, uint32_t y) {
  uint32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x / ys;
}

static inline uint64_t udiv_safe64(uint64_t x, uint64_t y) {
  uint64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x / ys;
}

static inline uint8_t udiv_up_safe8(uint8_t x, uint8_t y) {
  uint8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : (x + y - 1) / ys;
}

static inline uint16_t udiv_up_safe16(uint16_t x, uint16_t y) {
  uint16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : (x + y - 1) / ys;
}

static inline uint32_t udiv_up_safe32(uint32_t x, uint32_t y) {
  uint32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : (x + y - 1) / ys;
}

static inline uint64_t udiv_up_safe64(uint64_t x, uint64_t y) {
  uint64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : (x + y - 1) / ys;
}

static inline uint8_t umod_safe8(uint8_t x, uint8_t y) {
  uint8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x % ys;
}

static inline uint16_t umod_safe16(uint16_t x, uint16_t y) {
  uint16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x % ys;
}

static inline uint32_t umod_safe32(uint32_t x, uint32_t y) {
  uint32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x % ys;
}

static inline uint64_t umod_safe64(uint64_t x, uint64_t y) {
  uint64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x % ys;
}

static inline int8_t sdiv8(int8_t x, int8_t y) {
  int8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  int8_t q = x / ys;
  int8_t r = x % ys;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline int16_t sdiv16(int16_t x, int16_t y) {
  int16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  int16_t q = x / ys;
  int16_t r = x % ys;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline int32_t sdiv32(int32_t x, int32_t y) {
  int32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  int32_t q = x / ys;
  int32_t r = x % ys;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline int64_t sdiv64(int64_t x, int64_t y) {
  int64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  int64_t q = x / ys;
  int64_t r = x % ys;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline int8_t sdiv_up8(int8_t x, int8_t y) {
  return sdiv8(x + y - 1, y);
}

static inline int16_t sdiv_up16(int16_t x, int16_t y) {
  return sdiv16(x + y - 1, y);
}

static inline int32_t sdiv_up32(int32_t x, int32_t y) {
  return sdiv32(x + y - 1, y);
}

static inline int64_t sdiv_up64(int64_t x, int64_t y) {
  return sdiv64(x + y - 1, y);
}

static inline int8_t smod8(int8_t x, int8_t y) {
  int8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  int8_t r = x % ys;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline int16_t smod16(int16_t x, int16_t y) {
  int16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  int16_t r = x % ys;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline int32_t smod32(int32_t x, int32_t y) {
  int32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  int32_t r = x % ys;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline int64_t smod64(int64_t x, int64_t y) {
  int64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  int64_t r = x % ys;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline int8_t sdiv_safe8(int8_t x, int8_t y) {
  return y == 0 ? 0 : sdiv8(x, y);
}

static inline int16_t sdiv_safe16(int16_t x, int16_t y) {
  return y == 0 ? 0 : sdiv16(x, y);
}

static inline int32_t sdiv_safe32(int32_t x, int32_t y) {
  return y == 0 ? 0 : sdiv32(x, y);
}

static inline int64_t sdiv_safe64(int64_t x, int64_t y) {
  return y == 0 ? 0 : sdiv64(x, y);
}

static inline int8_t sdiv_up_safe8(int8_t x, int8_t y) {
  return sdiv_safe8(x + y - 1, y);
}

static inline int16_t sdiv_up_safe16(int16_t x, int16_t y) {
  return sdiv_safe16(x + y - 1, y);
}

static inline int32_t sdiv_up_safe32(int32_t x, int32_t y) {
  return sdiv_safe32(x + y - 1, y);
}

static inline int64_t sdiv_up_safe64(int64_t x, int64_t y) {
  return sdiv_safe64(x + y - 1, y);
}

static inline int8_t smod_safe8(int8_t x, int8_t y) {
  return y == 0 ? 0 : smod8(x, y);
}

static inline int16_t smod_safe16(int16_t x, int16_t y) {
  return y == 0 ? 0 : smod16(x, y);
}

static inline int32_t smod_safe32(int32_t x, int32_t y) {
  return y == 0 ? 0 : smod32(x, y);
}

static inline int64_t smod_safe64(int64_t x, int64_t y) {
  return y == 0 ? 0 : smod64(x, y);
}

static inline int8_t squot8(int8_t x, int8_t y) {
  int8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x / ys;
}

static inline int16_t squot16(int16_t x, int16_t y) {
  int16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x / ys;
}

static inline int32_t squot32(int32_t x, int32_t y) {
  int32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x / ys;
}

static inline int64_t squot64(int64_t x, int64_t y) {
  int64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x / ys;
}

static inline int8_t srem8(int8_t x, int8_t y) {
  int8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x % ys;
}

static inline int16_t srem16(int16_t x, int16_t y) {
  int16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x % ys;
}

static inline int32_t srem32(int32_t x, int32_t y) {
  int32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x % ys;
}

static inline int64_t srem64(int64_t x, int64_t y) {
  int8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return x % ys;
}

static inline int8_t squot_safe8(int8_t x, int8_t y) {
  int8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x / ys;
}

static inline int16_t squot_safe16(int16_t x, int16_t y) {
  int16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x / ys;
}

static inline int32_t squot_safe32(int32_t x, int32_t y) {
  int32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x / ys;
}

static inline int64_t squot_safe64(int64_t x, int64_t y) {
  int64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x / ys;
}

static inline int8_t srem_safe8(int8_t x, int8_t y) {
  int8_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x % ys;
}

static inline int16_t srem_safe16(int16_t x, int16_t y) {
  int16_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x % ys;
}

static inline int32_t srem_safe32(int32_t x, int32_t y) {
  int32_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x % ys;
}

static inline int64_t srem_safe64(int64_t x, int64_t y) {
  int64_t ys = 1;
  foreach_active(i){
    ys = y;
  }
  
  return y == 0 ? 0 : x % ys;
}

#else

static inline uint8_t udiv8(uint8_t x, uint8_t y) {
  return x / y;
}

static inline uint16_t udiv16(uint16_t x, uint16_t y) {
  return x / y;
}

static inline uint32_t udiv32(uint32_t x, uint32_t y) {
  return x / y;
}

static inline uint64_t udiv64(uint64_t x, uint64_t y) {
  return x / y;
}

static inline uint8_t udiv_up8(uint8_t x, uint8_t y) {
  return (x + y - 1) / y;
}

static inline uint16_t udiv_up16(uint16_t x, uint16_t y) {
  return (x + y - 1) / y;
}

static inline uint32_t udiv_up32(uint32_t x, uint32_t y) {
  return (x + y - 1) / y;
}

static inline uint64_t udiv_up64(uint64_t x, uint64_t y) {
  return (x + y - 1) / y;
}

static inline uint8_t umod8(uint8_t x, uint8_t y) {
  return x % y;
}

static inline uint16_t umod16(uint16_t x, uint16_t y) {
  return x % y;
}

static inline uint32_t umod32(uint32_t x, uint32_t y) {
  return x % y;
}

static inline uint64_t umod64(uint64_t x, uint64_t y) {
  return x % y;
}

static inline uint8_t udiv_safe8(uint8_t x, uint8_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uint16_t udiv_safe16(uint16_t x, uint16_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uint32_t udiv_safe32(uint32_t x, uint32_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uint64_t udiv_safe64(uint64_t x, uint64_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uint8_t udiv_up_safe8(uint8_t x, uint8_t y) {
  return y == 0 ? 0 : (x + y - 1) / y;
}

static inline uint16_t udiv_up_safe16(uint16_t x, uint16_t y) {
  return y == 0 ? 0 : (x + y - 1) / y;
}

static inline uint32_t udiv_up_safe32(uint32_t x, uint32_t y) {
  return y == 0 ? 0 : (x + y - 1) / y;
}

static inline uint64_t udiv_up_safe64(uint64_t x, uint64_t y) {
  return y == 0 ? 0 : (x + y - 1) / y;
}

static inline uint8_t umod_safe8(uint8_t x, uint8_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uint16_t umod_safe16(uint16_t x, uint16_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uint32_t umod_safe32(uint32_t x, uint32_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uint64_t umod_safe64(uint64_t x, uint64_t y) {
  return y == 0 ? 0 : x % y;
}

static inline int8_t sdiv8(int8_t x, int8_t y) {
  int8_t q = x / y;
  int8_t r = x % y;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline int16_t sdiv16(int16_t x, int16_t y) {
  int16_t q = x / y;
  int16_t r = x % y;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline int32_t sdiv32(int32_t x, int32_t y) {
  int32_t q = x / y;
  int32_t r = x % y;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline int64_t sdiv64(int64_t x, int64_t y) {
  int64_t q = x / y;
  int64_t r = x % y;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline int8_t sdiv_up8(int8_t x, int8_t y) {
  return sdiv8(x + y - 1, y);
}

static inline int16_t sdiv_up16(int16_t x, int16_t y) {
  return sdiv16(x + y - 1, y);
}

static inline int32_t sdiv_up32(int32_t x, int32_t y) {
  return sdiv32(x + y - 1, y);
}

static inline int64_t sdiv_up64(int64_t x, int64_t y) {
  return sdiv64(x + y - 1, y);
}

static inline int8_t smod8(int8_t x, int8_t y) {
  int8_t r = x % y;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline int16_t smod16(int16_t x, int16_t y) {
  int16_t r = x % y;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline int32_t smod32(int32_t x, int32_t y) {
  int32_t r = x % y;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline int64_t smod64(int64_t x, int64_t y) {
  int64_t r = x % y;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline int8_t sdiv_safe8(int8_t x, int8_t y) {
  return y == 0 ? 0 : sdiv8(x, y);
}

static inline int16_t sdiv_safe16(int16_t x, int16_t y) {
  return y == 0 ? 0 : sdiv16(x, y);
}

static inline int32_t sdiv_safe32(int32_t x, int32_t y) {
  return y == 0 ? 0 : sdiv32(x, y);
}

static inline int64_t sdiv_safe64(int64_t x, int64_t y) {
  return y == 0 ? 0 : sdiv64(x, y);
}

static inline int8_t sdiv_up_safe8(int8_t x, int8_t y) {
  return sdiv_safe8(x + y - 1, y);
}

static inline int16_t sdiv_up_safe16(int16_t x, int16_t y) {
  return sdiv_safe16(x + y - 1, y);
}

static inline int32_t sdiv_up_safe32(int32_t x, int32_t y) {
  return sdiv_safe32(x + y - 1, y);
}

static inline int64_t sdiv_up_safe64(int64_t x, int64_t y) {
  return sdiv_safe64(x + y - 1, y);
}

static inline int8_t smod_safe8(int8_t x, int8_t y) {
  return y == 0 ? 0 : smod8(x, y);
}

static inline int16_t smod_safe16(int16_t x, int16_t y) {
  return y == 0 ? 0 : smod16(x, y);
}

static inline int32_t smod_safe32(int32_t x, int32_t y) {
  return y == 0 ? 0 : smod32(x, y);
}

static inline int64_t smod_safe64(int64_t x, int64_t y) {
  return y == 0 ? 0 : smod64(x, y);
}

static inline int8_t squot8(int8_t x, int8_t y) {
  return x / y;
}

static inline int16_t squot16(int16_t x, int16_t y) {
  return x / y;
}

static inline int32_t squot32(int32_t x, int32_t y) {
  return x / y;
}

static inline int64_t squot64(int64_t x, int64_t y) {
  return x / y;
}

static inline int8_t srem8(int8_t x, int8_t y) {
  return x % y;
}

static inline int16_t srem16(int16_t x, int16_t y) {
  return x % y;
}

static inline int32_t srem32(int32_t x, int32_t y) {
  return x % y;
}

static inline int64_t srem64(int64_t x, int64_t y) {
  return x % y;
}

static inline int8_t squot_safe8(int8_t x, int8_t y) {
  return y == 0 ? 0 : x / y;
}

static inline int16_t squot_safe16(int16_t x, int16_t y) {
  return y == 0 ? 0 : x / y;
}

static inline int32_t squot_safe32(int32_t x, int32_t y) {
  return y == 0 ? 0 : x / y;
}

static inline int64_t squot_safe64(int64_t x, int64_t y) {
  return y == 0 ? 0 : x / y;
}

static inline int8_t srem_safe8(int8_t x, int8_t y) {
  return y == 0 ? 0 : x % y;
}

static inline int16_t srem_safe16(int16_t x, int16_t y) {
  return y == 0 ? 0 : x % y;
}

static inline int32_t srem_safe32(int32_t x, int32_t y) {
  return y == 0 ? 0 : x % y;
}

static inline int64_t srem_safe64(int64_t x, int64_t y) {
  return y == 0 ? 0 : x % y;
}

#endif

static inline int8_t smin8(int8_t x, int8_t y) {
  return x < y ? x : y;
}

static inline int16_t smin16(int16_t x, int16_t y) {
  return x < y ? x : y;
}

static inline int32_t smin32(int32_t x, int32_t y) {
  return x < y ? x : y;
}

static inline int64_t smin64(int64_t x, int64_t y) {
  return x < y ? x : y;
}

static inline uint8_t umin8(uint8_t x, uint8_t y) {
  return x < y ? x : y;
}

static inline uint16_t umin16(uint16_t x, uint16_t y) {
  return x < y ? x : y;
}

static inline uint32_t umin32(uint32_t x, uint32_t y) {
  return x < y ? x : y;
}

static inline uint64_t umin64(uint64_t x, uint64_t y) {
  return x < y ? x : y;
}

static inline int8_t smax8(int8_t x, int8_t y) {
  return x < y ? y : x;
}

static inline int16_t smax16(int16_t x, int16_t y) {
  return x < y ? y : x;
}

static inline int32_t smax32(int32_t x, int32_t y) {
  return x < y ? y : x;
}

static inline int64_t smax64(int64_t x, int64_t y) {
  return x < y ? y : x;
}

static inline uint8_t umax8(uint8_t x, uint8_t y) {
  return x < y ? y : x;
}

static inline uint16_t umax16(uint16_t x, uint16_t y) {
  return x < y ? y : x;
}

static inline uint32_t umax32(uint32_t x, uint32_t y) {
  return x < y ? y : x;
}

static inline uint64_t umax64(uint64_t x, uint64_t y) {
  return x < y ? y : x;
}

static inline uint8_t shl8(uint8_t x, uint8_t y) {
  return (uint8_t)(x << y);
}

static inline uint16_t shl16(uint16_t x, uint16_t y) {
  return (uint16_t)(x << y);
}

static inline uint32_t shl32(uint32_t x, uint32_t y) {
  return x << y;
}

static inline uint64_t shl64(uint64_t x, uint64_t y) {
  return x << y;
}

static inline uint8_t lshr8(uint8_t x, uint8_t y) {
  return x >> y;
}

static inline uint16_t lshr16(uint16_t x, uint16_t y) {
  return x >> y;
}

static inline uint32_t lshr32(uint32_t x, uint32_t y) {
  return x >> y;
}

static inline uint64_t lshr64(uint64_t x, uint64_t y) {
  return x >> y;
}

static inline int8_t ashr8(int8_t x, int8_t y) {
  return x >> y;
}

static inline int16_t ashr16(int16_t x, int16_t y) {
  return x >> y;
}

static inline int32_t ashr32(int32_t x, int32_t y) {
  return x >> y;
}

static inline int64_t ashr64(int64_t x, int64_t y) {
  return x >> y;
}

static inline uint8_t and8(uint8_t x, uint8_t y) {
  return x & y;
}

static inline uint16_t and16(uint16_t x, uint16_t y) {
  return x & y;
}

static inline uint32_t and32(uint32_t x, uint32_t y) {
  return x & y;
}

static inline uint64_t and64(uint64_t x, uint64_t y) {
  return x & y;
}

static inline uint8_t or8(uint8_t x, uint8_t y) {
  return x | y;
}

static inline uint16_t or16(uint16_t x, uint16_t y) {
  return x | y;
}

static inline uint32_t or32(uint32_t x, uint32_t y) {
  return x | y;
}

static inline uint64_t or64(uint64_t x, uint64_t y) {
  return x | y;
}

static inline uint8_t xor8(uint8_t x, uint8_t y) {
  return x ^ y;
}

static inline uint16_t xor16(uint16_t x, uint16_t y) {
  return x ^ y;
}

static inline uint32_t xor32(uint32_t x, uint32_t y) {
  return x ^ y;
}

static inline uint64_t xor64(uint64_t x, uint64_t y) {
  return x ^ y;
}

static inline bool ult8(uint8_t x, uint8_t y) {
  return x < y;
}

static inline bool ult16(uint16_t x, uint16_t y) {
  return x < y;
}

static inline bool ult32(uint32_t x, uint32_t y) {
  return x < y;
}

static inline bool ult64(uint64_t x, uint64_t y) {
  return x < y;
}

static inline bool ule8(uint8_t x, uint8_t y) {
  return x <= y;
}

static inline bool ule16(uint16_t x, uint16_t y) {
  return x <= y;
}

static inline bool ule32(uint32_t x, uint32_t y) {
  return x <= y;
}

static inline bool ule64(uint64_t x, uint64_t y) {
  return x <= y;
}

static inline bool slt8(int8_t x, int8_t y) {
  return x < y;
}

static inline bool slt16(int16_t x, int16_t y) {
  return x < y;
}

static inline bool slt32(int32_t x, int32_t y) {
  return x < y;
}

static inline bool slt64(int64_t x, int64_t y) {
  return x < y;
}

static inline bool sle8(int8_t x, int8_t y) {
  return x <= y;
}

static inline bool sle16(int16_t x, int16_t y) {
  return x <= y;
}

static inline bool sle32(int32_t x, int32_t y) {
  return x <= y;
}

static inline bool sle64(int64_t x, int64_t y) {
  return x <= y;
}

static inline uint8_t pow8(uint8_t x, uint8_t y) {
  uint8_t res = 1, rem = y;

  while (rem != 0) {
    if (rem & 1)
      res *= x;
    rem >>= 1;
    x *= x;
  }
  return res;
}

static inline uint16_t pow16(uint16_t x, uint16_t y) {
  uint16_t res = 1, rem = y;

  while (rem != 0) {
    if (rem & 1)
      res *= x;
    rem >>= 1;
    x *= x;
  }
  return res;
}

static inline uint32_t pow32(uint32_t x, uint32_t y) {
  uint32_t res = 1, rem = y;

  while (rem != 0) {
    if (rem & 1)
      res *= x;
    rem >>= 1;
    x *= x;
  }
  return res;
}

static inline uint64_t pow64(uint64_t x, uint64_t y) {
  uint64_t res = 1, rem = y;

  while (rem != 0) {
    if (rem & 1)
      res *= x;
    rem >>= 1;
    x *= x;
  }
  return res;
}

static inline bool itob_i8_bool(int8_t x) {
  return x != 0;
}

static inline bool itob_i16_bool(int16_t x) {
  return x != 0;
}

static inline bool itob_i32_bool(int32_t x) {
  return x != 0;
}

static inline bool itob_i64_bool(int64_t x) {
  return x != 0;
}

static inline int8_t btoi_bool_i8(bool x) {
  return x;
}

static inline int16_t btoi_bool_i16(bool x) {
  return x;
}

static inline int32_t btoi_bool_i32(bool x) {
  return x;
}

static inline int64_t btoi_bool_i64(bool x) {
  return x;
}

#define sext_i8_i8(x) ((int8_t) (int8_t) (x))
#define sext_i8_i16(x) ((int16_t) (int8_t) (x))
#define sext_i8_i32(x) ((int32_t) (int8_t) (x))
#define sext_i8_i64(x) ((int64_t) (int8_t) (x))
#define sext_i16_i8(x) ((int8_t) (int16_t) (x))
#define sext_i16_i16(x) ((int16_t) (int16_t) (x))
#define sext_i16_i32(x) ((int32_t) (int16_t) (x))
#define sext_i16_i64(x) ((int64_t) (int16_t) (x))
#define sext_i32_i8(x) ((int8_t) (int32_t) (x))
#define sext_i32_i16(x) ((int16_t) (int32_t) (x))
#define sext_i32_i32(x) ((int32_t) (int32_t) (x))
#define sext_i32_i64(x) ((int64_t) (int32_t) (x))
#define sext_i64_i8(x) ((int8_t) (int64_t) (x))
#define sext_i64_i16(x) ((int16_t) (int64_t) (x))
#define sext_i64_i32(x) ((int32_t) (int64_t) (x))
#define sext_i64_i64(x) ((int64_t) (int64_t) (x))
#define zext_i8_i8(x) ((int8_t) (uint8_t) (x))
#define zext_i8_i16(x) ((int16_t) (uint8_t) (x))
#define zext_i8_i32(x) ((int32_t) (uint8_t) (x))
#define zext_i8_i64(x) ((int64_t) (uint8_t) (x))
#define zext_i16_i8(x) ((int8_t) (uint16_t) (x))
#define zext_i16_i16(x) ((int16_t) (uint16_t) (x))
#define zext_i16_i32(x) ((int32_t) (uint16_t) (x))
#define zext_i16_i64(x) ((int64_t) (uint16_t) (x))
#define zext_i32_i8(x) ((int8_t) (uint32_t) (x))
#define zext_i32_i16(x) ((int16_t) (uint32_t) (x))
#define zext_i32_i32(x) ((int32_t) (uint32_t) (x))
#define zext_i32_i64(x) ((int64_t) (uint32_t) (x))
#define zext_i64_i8(x) ((int8_t) (uint64_t) (x))
#define zext_i64_i16(x) ((int16_t) (uint64_t) (x))
#define zext_i64_i32(x) ((int32_t) (uint64_t) (x))
#define zext_i64_i64(x) ((int64_t) (uint64_t) (x))

static int8_t abs8(int8_t x) {
  return (int8_t)abs(x);
}

static int16_t abs16(int16_t x) {
  return (int16_t)abs(x);
}

static int32_t abs32(int32_t x) {
  return abs(x);
}

static int64_t abs64(int64_t x) {
#if defined(__OPENCL_VERSION__) || defined(ISPC)
  return abs(x);
#else
  return llabs(x);
#endif
}

#if defined(__OPENCL_VERSION__)
static int32_t futrts_popc8(int8_t x) {
  return popcount(x);
}

static int32_t futrts_popc16(int16_t x) {
  return popcount(x);
}

static int32_t futrts_popc32(int32_t x) {
  return popcount(x);
}

static int32_t futrts_popc64(int64_t x) {
  return popcount(x);
}
#elif defined(__CUDA_ARCH__)

static int32_t futrts_popc8(int8_t x) {
  return __popc(zext_i8_i32(x));
}

static int32_t futrts_popc16(int16_t x) {
  return __popc(zext_i16_i32(x));
}

static int32_t futrts_popc32(int32_t x) {
  return __popc(x);
}

static int32_t futrts_popc64(int64_t x) {
  return __popcll(x);
}

#else // Not OpenCL or CUDA, but plain C.

static int32_t futrts_popc8(uint8_t x) {
  int c = 0;
  for (; x; ++c) { x &= x - 1; }
  return c;
}

static int32_t futrts_popc16(uint16_t x) {
  int c = 0;
  for (; x; ++c) { x &= x - 1; }
  return c;
}

static int32_t futrts_popc32(uint32_t x) {
  int c = 0;
  for (; x; ++c) { x &= x - 1; }
  return c;
}

static int32_t futrts_popc64(uint64_t x) {
  int c = 0;
  for (; x; ++c) { x &= x - 1; }
  return c;
}
#endif

#if defined(__OPENCL_VERSION__)
static uint8_t futrts_mul_hi8(uint8_t a, uint8_t b) {
  return mul_hi(a, b);
}

static uint16_t futrts_mul_hi16(uint16_t a, uint16_t b) {
  return mul_hi(a, b);
}

static uint32_t futrts_mul_hi32(uint32_t a, uint32_t b) {
  return mul_hi(a, b);
}

static uint64_t futrts_mul_hi64(uint64_t a, uint64_t b) {
  return mul_hi(a, b);
}

#elif defined(__CUDA_ARCH__)

static uint8_t futrts_mul_hi8(uint8_t a, uint8_t b) {
  uint16_t aa = a;
  uint16_t bb = b;

  return aa * bb >> 8;
}

static uint16_t futrts_mul_hi16(uint16_t a, uint16_t b) {
  uint32_t aa = a;
  uint32_t bb = b;

  return aa * bb >> 16;
}

static uint32_t futrts_mul_hi32(uint32_t a, uint32_t b) {
  return mulhi(a, b);
}

static uint64_t futrts_mul_hi64(uint64_t a, uint64_t b) {
  return mul64hi(a, b);
}

#elif ISPC

static uint8_t futrts_mul_hi8(uint8_t a, uint8_t b) {
  uint16_t aa = a;
  uint16_t bb = b;

  return aa * bb >> 8;
}

static uint16_t futrts_mul_hi16(uint16_t a, uint16_t b) {
  uint32_t aa = a;
  uint32_t bb = b;

  return aa * bb >> 16;
}

static uint32_t futrts_mul_hi32(uint32_t a, uint32_t b) {
  uint64_t aa = a;
  uint64_t bb = b;

  return aa * bb >> 32;
}

static uint64_t futrts_mul_hi64(uint64_t a, uint64_t b) {
  uint64_t ah = a >> 32;
  uint64_t al = a & 0xffffffff;
  uint64_t bh = b >> 32;
  uint64_t bl = b & 0xffffffff;

  uint64_t p1 = al * bl;
  uint64_t p2 = al * bh;
  uint64_t p3 = ah * bl;
  uint64_t p4 = ah * bh;

  uint64_t p1h = p1 >> 32;
  uint64_t p2h = p2 >> 32;
  uint64_t p3h = p3 >> 32;
  uint64_t p2l = p2 & 0xffffffff;
  uint64_t p3l = p3 & 0xffffffff;

  uint64_t l = p1h + p2l  + p3l;
  uint64_t m = (p2 >> 32) + (p3 >> 32);
  uint64_t h = (l >> 32) + m + p4;

  return h;
}

#else // Not OpenCL, ISPC, or CUDA, but plain C.

static uint8_t futrts_mul_hi8(uint8_t a, uint8_t b) {
  uint16_t aa = a;
  uint16_t bb = b;

  return aa * bb >> 8;
}

static uint16_t futrts_mul_hi16(uint16_t a, uint16_t b) {
  uint32_t aa = a;
  uint32_t bb = b;

  return aa * bb >> 16;
}

static uint32_t futrts_mul_hi32(uint32_t a, uint32_t b) {
  uint64_t aa = a;
  uint64_t bb = b;

  return aa * bb >> 32;
}

static uint64_t futrts_mul_hi64(uint64_t a, uint64_t b) {
  __uint128_t aa = a;
  __uint128_t bb = b;

  return aa * bb >> 64;
}
#endif

#if defined(__OPENCL_VERSION__)
static uint8_t futrts_mad_hi8(uint8_t a, uint8_t b, uint8_t c) {
  return mad_hi(a, b, c);
}

static uint16_t futrts_mad_hi16(uint16_t a, uint16_t b, uint16_t c) {
  return mad_hi(a, b, c);
}

static uint32_t futrts_mad_hi32(uint32_t a, uint32_t b, uint32_t c) {
  return mad_hi(a, b, c);
}

static uint64_t futrts_mad_hi64(uint64_t a, uint64_t b, uint64_t c) {
  return mad_hi(a, b, c);
}

#else // Not OpenCL

static uint8_t futrts_mad_hi8(uint8_t a, uint8_t b, uint8_t c) {
  return futrts_mul_hi8(a, b) + c;
}

static uint16_t futrts_mad_hi16(uint16_t a, uint16_t b, uint16_t c) {
  return futrts_mul_hi16(a, b) + c;
}

static uint32_t futrts_mad_hi32(uint32_t a, uint32_t b, uint32_t c) {
  return futrts_mul_hi32(a, b) + c;
}

static uint64_t futrts_mad_hi64(uint64_t a, uint64_t b, uint64_t c) {
  return futrts_mul_hi64(a, b) + c;
}
#endif

#if defined(__OPENCL_VERSION__)
static int32_t futrts_clzz8(int8_t x) {
  return clz(x);
}

static int32_t futrts_clzz16(int16_t x) {
  return clz(x);
}

static int32_t futrts_clzz32(int32_t x) {
  return clz(x);
}

static int32_t futrts_clzz64(int64_t x) {
  return clz(x);
}

#elif defined(__CUDA_ARCH__)

static int32_t futrts_clzz8(int8_t x) {
  return __clz(zext_i8_i32(x)) - 24;
}

static int32_t futrts_clzz16(int16_t x) {
  return __clz(zext_i16_i32(x)) - 16;
}

static int32_t futrts_clzz32(int32_t x) {
  return __clz(x);
}

static int32_t futrts_clzz64(int64_t x) {
  return __clzll(x);
}

#elif ISPC

static int32_t futrts_clzz8(int8_t x) {
  return count_leading_zeros((int32_t)(uint8_t)x)-24;
}

static int32_t futrts_clzz16(int16_t x) {
  return count_leading_zeros((int32_t)(uint16_t)x)-16;
}

static int32_t futrts_clzz32(int32_t x) {
  return count_leading_zeros(x);
}

static int32_t futrts_clzz64(int64_t x) {
  return count_leading_zeros(x);
}

#else // Not OpenCL, ISPC or CUDA, but plain C.

static int32_t futrts_clzz8(int8_t x) {
  return x == 0 ? 8 : __builtin_clz((uint32_t)zext_i8_i32(x)) - 24;
}

static int32_t futrts_clzz16(int16_t x) {
  return x == 0 ? 16 : __builtin_clz((uint32_t)zext_i16_i32(x)) - 16;
}

static int32_t futrts_clzz32(int32_t x) {
  return x == 0 ? 32 : __builtin_clz((uint32_t)x);
}

static int32_t futrts_clzz64(int64_t x) {
  return x == 0 ? 64 : __builtin_clzll((uint64_t)x);
}
#endif

#if defined(__OPENCL_VERSION__)
static int32_t futrts_ctzz8(int8_t x) {
  int i = 0;
  for (; i < 8 && (x & 1) == 0; i++, x >>= 1)
    ;
  return i;
}

static int32_t futrts_ctzz16(int16_t x) {
  int i = 0;
  for (; i < 16 && (x & 1) == 0; i++, x >>= 1)
    ;
  return i;
}

static int32_t futrts_ctzz32(int32_t x) {
  int i = 0;
  for (; i < 32 && (x & 1) == 0; i++, x >>= 1)
    ;
  return i;
}

static int32_t futrts_ctzz64(int64_t x) {
  int i = 0;
  for (; i < 64 && (x & 1) == 0; i++, x >>= 1)
    ;
  return i;
}

#elif defined(__CUDA_ARCH__)

static int32_t futrts_ctzz8(int8_t x) {
  int y = __ffs(x);
  return y == 0 ? 8 : y - 1;
}

static int32_t futrts_ctzz16(int16_t x) {
  int y = __ffs(x);
  return y == 0 ? 16 : y - 1;
}

static int32_t futrts_ctzz32(int32_t x) {
  int y = __ffs(x);
  return y == 0 ? 32 : y - 1;
}

static int32_t futrts_ctzz64(int64_t x) {
  int y = __ffsll(x);
  return y == 0 ? 64 : y - 1;
}

#elif ISPC

static int32_t futrts_ctzz8(int8_t x) {
  return x == 0 ? 8 : count_trailing_zeros((int32_t)x);
}

static int32_t futrts_ctzz16(int16_t x) {
  return x == 0 ? 16 : count_trailing_zeros((int32_t)x);
}

static int32_t futrts_ctzz32(int32_t x) {
  return count_trailing_zeros(x);
}

static int32_t futrts_ctzz64(int64_t x) {
  return count_trailing_zeros(x);
}

#else // Not OpenCL or CUDA, but plain C.

static int32_t futrts_ctzz8(int8_t x) {
  return x == 0 ? 8 : __builtin_ctz((uint32_t)x);
}

static int32_t futrts_ctzz16(int16_t x) {
  return x == 0 ? 16 : __builtin_ctz((uint32_t)x);
}

static int32_t futrts_ctzz32(int32_t x) {
  return x == 0 ? 32 : __builtin_ctz((uint32_t)x);
}

static int32_t futrts_ctzz64(int64_t x) {
  return x == 0 ? 64 : __builtin_ctzll((uint64_t)x);
}
#endif

static inline float fdiv32(float x, float y) {
  return x / y;
}

static inline float fadd32(float x, float y) {
  return x + y;
}

static inline float fsub32(float x, float y) {
  return x - y;
}

static inline float fmul32(float x, float y) {
  return x * y;
}

static inline bool cmplt32(float x, float y) {
  return x < y;
}

static inline bool cmple32(float x, float y) {
  return x <= y;
}

static inline float sitofp_i8_f32(int8_t x) {
  return (float) x;
}

static inline float sitofp_i16_f32(int16_t x) {
  return (float) x;
}

static inline float sitofp_i32_f32(int32_t x) {
  return (float) x;
}

static inline float sitofp_i64_f32(int64_t x) {
  return (float) x;
}

static inline float uitofp_i8_f32(uint8_t x) {
  return (float) x;
}

static inline float uitofp_i16_f32(uint16_t x) {
  return (float) x;
}

static inline float uitofp_i32_f32(uint32_t x) {
  return (float) x;
}

static inline float uitofp_i64_f32(uint64_t x) {
  return (float) x;
}

#ifdef __OPENCL_VERSION__
static inline float fabs32(float x) {
  return fabs(x);
}

static inline float fmax32(float x, float y) {
  return fmax(x, y);
}

static inline float fmin32(float x, float y) {
  return fmin(x, y);
}

static inline float fpow32(float x, float y) {
  return pow(x, y);
}

#elif ISPC

static inline float fabs32(float x) {
  return abs(x);
}

static inline float fmax32(float x, float y) {
  return isnan(x) ? y : isnan(y) ? x : max(x, y);
}

static inline float fmin32(float x, float y) {
  return isnan(x) ? y : isnan(y) ? x : min(x, y);
}

static inline float fpow32(float a, float b) {
  float ret;
  foreach_active (i) {
      uniform float r = __stdlib_powf(extract(a, i), extract(b, i));
      ret = insert(ret, i, r);
  }
  return ret;
}

#else // Not OpenCL, but CUDA or plain C.

static inline float fabs32(float x) {
  return fabsf(x);
}

static inline float fmax32(float x, float y) {
  return fmaxf(x, y);
}

static inline float fmin32(float x, float y) {
  return fminf(x, y);
}

static inline float fpow32(float x, float y) {
  return powf(x, y);
}
#endif

static inline bool futrts_isnan32(float x) {
  return isnan(x);
}

#if ISPC

static inline bool futrts_isinf32(float x) {
  return !isnan(x) && isnan(x - x);
}

static inline bool futrts_isfinite32(float x) {
  return !isnan(x) && !futrts_isinf32(x);
}

#else

static inline bool futrts_isinf32(float x) {
  return isinf(x);
}

#endif

static inline int8_t fptosi_f32_i8(float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (int8_t) x;
  }
}

static inline int16_t fptosi_f32_i16(float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (int16_t) x;
  }
}

static inline int32_t fptosi_f32_i32(float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (int32_t) x;
  }
}

static inline int64_t fptosi_f32_i64(float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (int64_t) x;
  };
}

static inline uint8_t fptoui_f32_i8(float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uint8_t) (int8_t) x;
  }
}

static inline uint16_t fptoui_f32_i16(float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uint16_t) (int16_t) x;
  }
}

static inline uint32_t fptoui_f32_i32(float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uint32_t) (int32_t) x;
  }
}

static inline uint64_t fptoui_f32_i64(float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uint64_t) (int64_t) x;
  }
}

static inline bool ftob_f32_bool(float x) {
  return x != 0;
}

static inline float btof_bool_f32(bool x) {
  return x ? 1 : 0;
}

#ifdef __OPENCL_VERSION__
static inline float futrts_log32(float x) {
  return log(x);
}

static inline float futrts_log2_32(float x) {
  return log2(x);
}

static inline float futrts_log10_32(float x) {
  return log10(x);
}

static inline float futrts_sqrt32(float x) {
  return sqrt(x);
}

static inline float futrts_cbrt32(float x) {
  return cbrt(x);
}

static inline float futrts_exp32(float x) {
  return exp(x);
}

static inline float futrts_cos32(float x) {
  return cos(x);
}

static inline float futrts_sin32(float x) {
  return sin(x);
}

static inline float futrts_tan32(float x) {
  return tan(x);
}

static inline float futrts_acos32(float x) {
  return acos(x);
}

static inline float futrts_asin32(float x) {
  return asin(x);
}

static inline float futrts_atan32(float x) {
  return atan(x);
}

static inline float futrts_cosh32(float x) {
  return cosh(x);
}

static inline float futrts_sinh32(float x) {
  return sinh(x);
}

static inline float futrts_tanh32(float x) {
  return tanh(x);
}

static inline float futrts_acosh32(float x) {
  return acosh(x);
}

static inline float futrts_asinh32(float x) {
  return asinh(x);
}

static inline float futrts_atanh32(float x) {
  return atanh(x);
}

static inline float futrts_atan2_32(float x, float y) {
  return atan2(x, y);
}

static inline float futrts_hypot32(float x, float y) {
  return hypot(x, y);
}

static inline float futrts_gamma32(float x) {
  return tgamma(x);
}

static inline float futrts_lgamma32(float x) {
  return lgamma(x);
}

static inline float futrts_erf32(float x) {
  return erf(x);
}

static inline float futrts_erfc32(float x) {
  return erfc(x);
}

static inline float fmod32(float x, float y) {
  return fmod(x, y);
}

static inline float futrts_round32(float x) {
  return rint(x);
}

static inline float futrts_floor32(float x) {
  return floor(x);
}

static inline float futrts_ceil32(float x) {
  return ceil(x);
}

static inline float futrts_nextafter32(float x, float y) {
  return nextafter(x, y);
}

static inline float futrts_lerp32(float v0, float v1, float t) {
  return mix(v0, v1, t);
}

static inline float futrts_mad32(float a, float b, float c) {
  return mad(a, b, c);
}

static inline float futrts_fma32(float a, float b, float c) {
  return fma(a, b, c);
}

#elif ISPC

static inline float futrts_log32(float x) {
  return futrts_isfinite32(x) || (futrts_isinf32(x) && x < 0)? log(x) : x;
}

static inline float futrts_log2_32(float x) {
  return futrts_log32(x) / log(2.0f);
}

static inline float futrts_log10_32(float x) {
  return futrts_log32(x) / log(10.0f);
}

static inline float futrts_sqrt32(float x) {
  return sqrt(x);
}

extern "C" unmasked uniform float cbrtf(uniform float);
static inline float futrts_cbrt32(float x) {
  float res;
  foreach_active (i) {
    uniform float r = cbrtf(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

static inline float futrts_exp32(float x) {
  return exp(x);
}

static inline float futrts_cos32(float x) {
  return cos(x);
}

static inline float futrts_sin32(float x) {
  return sin(x);
}

static inline float futrts_tan32(float x) {
  return tan(x);
}

static inline float futrts_acos32(float x) {
  return acos(x);
}

static inline float futrts_asin32(float x) {
  return asin(x);
}

static inline float futrts_atan32(float x) {
  return atan(x);
}

static inline float futrts_cosh32(float x) {
  return (exp(x)+exp(-x)) / 2.0f;
}

static inline float futrts_sinh32(float x) {
  return (exp(x)-exp(-x)) / 2.0f;
}

static inline float futrts_tanh32(float x) {
  return futrts_sinh32(x)/futrts_cosh32(x);
}

static inline float futrts_acosh32(float x) {
  float f = x+sqrt(x*x-1);
  if(futrts_isfinite32(f)) return log(f);
  return f;
}

static inline float futrts_asinh32(float x) {
  float f = x+sqrt(x*x+1);
  if(futrts_isfinite32(f)) return log(f);
  return f;

}

static inline float futrts_atanh32(float x) {
  float f = (1+x)/(1-x);
  if(futrts_isfinite32(f)) return log(f)/2.0f;
  return f;

}

static inline float futrts_atan2_32(float x, float y) {
  return (x == 0.0f && y == 0.0f) ? 0.0f : atan2(x, y);
}

static inline float futrts_hypot32(float x, float y) {
  if (futrts_isfinite32(x) && futrts_isfinite32(y)) {
    x = abs(x);
    y = abs(y);
    float a;
    float b;
    if (x >= y){
        a = x;
        b = y;
    } else {
        a = y;
        b = x;
    }
    if(b == 0){
      return a;
    }

    int e;
    float an;
    float bn;
    an = frexp (a, &e);
    bn = ldexp (b, - e);
    float cn;
    cn = sqrt (an * an + bn * bn);
    return ldexp (cn, e);
  } else {
    if (futrts_isinf32(x) || futrts_isinf32(y)) return INFINITY;
    else return x + y;
  }

}

extern "C" unmasked uniform float tgammaf(uniform float x);
static inline float futrts_gamma32(float x) {
  float res;
  foreach_active (i) {
    uniform float r = tgammaf(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

extern "C" unmasked uniform float lgammaf(uniform float x);
static inline float futrts_lgamma32(float x) {
  float res;
  foreach_active (i) {
    uniform float r = lgammaf(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

extern "C" unmasked uniform float erff(uniform float x);
static inline float futrts_erf32(float x) {
  float res;
  foreach_active (i) {
    uniform float r = erff(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

extern "C" unmasked uniform float erfcf(uniform float x);
static inline float futrts_erfc32(float x) {
  float res;
  foreach_active (i) {
    uniform float r = erfcf(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

static inline float fmod32(float x, float y) {
  return x - y * trunc(x/y);
}

static inline float futrts_round32(float x) {
  return round(x);
}

static inline float futrts_floor32(float x) {
  return floor(x);
}

static inline float futrts_ceil32(float x) {
  return ceil(x);
}

extern "C" unmasked uniform float nextafterf(uniform float x, uniform float y);
static inline float futrts_nextafter32(float x, float y) {
  float res;
  foreach_active (i) {
    uniform float r = nextafterf(extract(x, i), extract(y, i));
    res = insert(res, i, r);
  }
  return res;
}

static inline float futrts_lerp32(float v0, float v1, float t) {
  return v0 + (v1 - v0) * t;
}

static inline float futrts_mad32(float a, float b, float c) {
  return a * b + c;
}

static inline float futrts_fma32(float a, float b, float c) {
  return a * b + c;
}

#else // Not OpenCL or ISPC, but CUDA or plain C.

static inline float futrts_log32(float x) {
  return logf(x);
}

static inline float futrts_log2_32(float x) {
  return log2f(x);
}

static inline float futrts_log10_32(float x) {
  return log10f(x);
}

static inline float futrts_sqrt32(float x) {
  return sqrtf(x);
}

static inline float futrts_cbrt32(float x) {
  return cbrtf(x);
}

static inline float futrts_exp32(float x) {
  return expf(x);
}

static inline float futrts_cos32(float x) {
  return cosf(x);
}

static inline float futrts_sin32(float x) {
  return sinf(x);
}

static inline float futrts_tan32(float x) {
  return tanf(x);
}

static inline float futrts_acos32(float x) {
  return acosf(x);
}

static inline float futrts_asin32(float x) {
  return asinf(x);
}

static inline float futrts_atan32(float x) {
  return atanf(x);
}

static inline float futrts_cosh32(float x) {
  return coshf(x);
}

static inline float futrts_sinh32(float x) {
  return sinhf(x);
}

static inline float futrts_tanh32(float x) {
  return tanhf(x);
}

static inline float futrts_acosh32(float x) {
  return acoshf(x);
}

static inline float futrts_asinh32(float x) {
  return asinhf(x);
}

static inline float futrts_atanh32(float x) {
  return atanhf(x);
}

static inline float futrts_atan2_32(float x, float y) {
  return atan2f(x, y);
}

static inline float futrts_hypot32(float x, float y) {
  return hypotf(x, y);
}

static inline float futrts_gamma32(float x) {
  return tgammaf(x);
}

static inline float futrts_lgamma32(float x) {
  return lgammaf(x);
}

static inline float futrts_erf32(float x) {
  return erff(x);
}

static inline float futrts_erfc32(float x) {
  return erfcf(x);
}

static inline float fmod32(float x, float y) {
  return fmodf(x, y);
}

static inline float futrts_round32(float x) {
  return rintf(x);
}

static inline float futrts_floor32(float x) {
  return floorf(x);
}

static inline float futrts_ceil32(float x) {
  return ceilf(x);
}

static inline float futrts_nextafter32(float x, float y) {
  return nextafterf(x, y);
}

static inline float futrts_lerp32(float v0, float v1, float t) {
  return v0 + (v1 - v0) * t;
}

static inline float futrts_mad32(float a, float b, float c) {
  return a * b + c;
}

static inline float futrts_fma32(float a, float b, float c) {
  return fmaf(a, b, c);
}
#endif

#if ISPC
static inline int32_t futrts_to_bits32(float x) {
  return intbits(x);
}

static inline float futrts_from_bits32(int32_t x) {
  return floatbits(x);
}
#else
static inline int32_t futrts_to_bits32(float x) {
  union {
    float f;
    int32_t t;
  } p;

  p.f = x;
  return p.t;
}

static inline float futrts_from_bits32(int32_t x) {
  union {
    int32_t f;
    float t;
  } p;

  p.f = x;
  return p.t;
}
#endif

static inline float fsignum32(float x) {
  return futrts_isnan32(x) ? x : (x > 0 ? 1 : 0) - (x < 0 ? 1 : 0);
}

#ifdef FUTHARK_F64_ENABLED

#if ISPC
static inline bool futrts_isinf64(float x) {
  return !isnan(x) && isnan(x - x);
}

static inline bool futrts_isfinite64(float x) {
  return !isnan(x) && !futrts_isinf64(x);
}

static inline double fdiv64(double x, double y) {
  return x / y;
}

static inline double fadd64(double x, double y) {
  return x + y;
}

static inline double fsub64(double x, double y) {
  return x - y;
}

static inline double fmul64(double x, double y) {
  return x * y;
}

static inline bool cmplt64(double x, double y) {
  return x < y;
}

static inline bool cmple64(double x, double y) {
  return x <= y;
}

static inline double sitofp_i8_f64(int8_t x) {
  return (double) x;
}

static inline double sitofp_i16_f64(int16_t x) {
  return (double) x;
}

static inline double sitofp_i32_f64(int32_t x) {
  return (double) x;
}

static inline double sitofp_i64_f64(int64_t x) {
  return (double) x;
}

static inline double uitofp_i8_f64(uint8_t x) {
  return (double) x;
}

static inline double uitofp_i16_f64(uint16_t x) {
  return (double) x;
}

static inline double uitofp_i32_f64(uint32_t x) {
  return (double) x;
}

static inline double uitofp_i64_f64(uint64_t x) {
  return (double) x;
}

static inline double fabs64(double x) {
  return abs(x);
}

static inline double fmax64(double x, double y) {
  return isnan(x) ? y : isnan(y) ? x : max(x, y);
}

static inline double fmin64(double x, double y) {
  return isnan(x) ? y : isnan(y) ? x : min(x, y);
}

static inline double fpow64(double a, double b) {
  float ret;
  foreach_active (i) {
      uniform float r = __stdlib_powf(extract(a, i), extract(b, i));
      ret = insert(ret, i, r);
  }
  return ret;
}

static inline double futrts_log64(double x) {
  return futrts_isfinite64(x) || (futrts_isinf64(x) && x < 0)? log(x) : x;
}

static inline double futrts_log2_64(double x) {
  return futrts_log64(x)/log(2.0d);
}

static inline double futrts_log10_64(double x) {
  return futrts_log64(x)/log(10.0d);
}

static inline double futrts_sqrt64(double x) {
  return sqrt(x);
}

extern "C" unmasked uniform double cbrt(uniform double);
static inline double futrts_cbrt64(double x) {
  double res;
  foreach_active (i) {
    uniform double r = cbrtf(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

static inline double futrts_exp64(double x) {
  return exp(x);
}

static inline double futrts_cos64(double x) {
  return cos(x);
}

static inline double futrts_sin64(double x) {
  return sin(x);
}

static inline double futrts_tan64(double x) {
  return tan(x);
}

static inline double futrts_acos64(double x) {
  return acos(x);
}

static inline double futrts_asin64(double x) {
  return asin(x);
}

static inline double futrts_atan64(double x) {
  return atan(x);
}

static inline double futrts_cosh64(double x) {
  return (exp(x)+exp(-x)) / 2.0d;
}

static inline double futrts_sinh64(double x) {
  return (exp(x)-exp(-x)) / 2.0d;
}

static inline double futrts_tanh64(double x) {
  return futrts_sinh64(x)/futrts_cosh64(x);
}

static inline double futrts_acosh64(double x) {
  double f = x+sqrt(x*x-1.0d);
  if(futrts_isfinite64(f)) return log(f);
  return f;
}

static inline double futrts_asinh64(double x) {
  double f = x+sqrt(x*x+1.0d);
  if(futrts_isfinite64(f)) return log(f);
  return f;
}

static inline double futrts_atanh64(double x) {
  double f = (1.0d+x)/(1.0d-x);
  if(futrts_isfinite64(f)) return log(f)/2.0d;
  return f;

}

static inline double futrts_atan2_64(double x, double y) {
  return atan2(x, y);
}

extern "C" unmasked uniform double hypot(uniform double x, uniform double y);
static inline double futrts_hypot64(double x, double y) {
  double res;
  foreach_active (i) {
    uniform double r = hypot(extract(x, i), extract(y, i));
    res = insert(res, i, r);
  }
  return res;
}

extern "C" unmasked uniform double tgamma(uniform double x);
static inline double futrts_gamma64(double x) {
  double res;
  foreach_active (i) {
    uniform double r = tgamma(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

extern "C" unmasked uniform double lgamma(uniform double x);
static inline double futrts_lgamma64(double x) {
  double res;
  foreach_active (i) {
    uniform double r = lgamma(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

extern "C" unmasked uniform double erf(uniform double x);
static inline double futrts_erf64(double x) {
  double res;
  foreach_active (i) {
    uniform double r = erf(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

extern "C" unmasked uniform double erfc(uniform double x);
static inline double futrts_erfc64(double x) {
  double res;
  foreach_active (i) {
    uniform double r = erfc(extract(x, i));
    res = insert(res, i, r);
  }
  return res;
}

static inline double futrts_fma64(double a, double b, double c) {
  return a * b + c;
}

static inline double futrts_round64(double x) {
  return round(x);
}

static inline double futrts_ceil64(double x) {
  return ceil(x);
}

extern "C" unmasked uniform double nextafter(uniform float x, uniform double y);
static inline float futrts_nextafter64(double x, double y) {
  double res;
  foreach_active (i) {
    uniform double r = nextafter(extract(x, i), extract(y, i));
    res = insert(res, i, r);
  }
  return res;
}

static inline double futrts_floor64(double x) {
  return floor(x);
}

static inline bool futrts_isnan64(double x) {
  return isnan(x);
}

static inline int8_t fptosi_f64_i8(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (int8_t) x;
  }
}

static inline int16_t fptosi_f64_i16(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (int16_t) x;
  }
}

static inline int32_t fptosi_f64_i32(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (int32_t) x;
  }
}

static inline int64_t fptosi_f64_i64(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (int64_t) x;
  }
}

static inline uint8_t fptoui_f64_i8(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uint8_t) (int8_t) x;
  }
}

static inline uint16_t fptoui_f64_i16(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uint16_t) (int16_t) x;
  }
}

static inline uint32_t fptoui_f64_i32(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uint32_t) (int32_t) x;
  }
}

static inline uint64_t fptoui_f64_i64(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uint64_t) (int64_t) x;
  }
}

static inline bool ftob_f64_bool(double x) {
  return x != 0.0;
}

static inline double btof_bool_f64(bool x) {
  return x ? 1.0 : 0.0;
}

static inline int64_t futrts_to_bits64(double x) {
  int64_t res;
  foreach_active (i) {
    uniform double tmp = extract(x, i);
    uniform int64_t r = *((uniform int64_t* uniform)&tmp);
    res = insert(res, i, r);
  }
  return res;
}

static inline double futrts_from_bits64(int64_t x) {
  double res;
  foreach_active (i) {
    uniform int64_t tmp = extract(x, i);
    uniform double r = *((uniform double* uniform)&tmp);
    res = insert(res, i, r);
  }
  return res;
}

static inline double fmod64(double x, double y) {
  return x - y * trunc(x/y);
}

static inline double fsignum64(double x) {
  return futrts_isnan64(x) ? x : (x > 0 ? 1.0d : 0.0d) - (x < 0 ? 1.0d : 0.0d);
}

static inline double futrts_lerp64(double v0, double v1, double t) {
  return v0 + (v1 - v0) * t;
}

static inline double futrts_mad64(double a, double b, double c) {
  return a * b + c;
}

static inline float fpconv_f32_f32(float x) {
  return (float) x;
}

static inline double fpconv_f32_f64(float x) {
  return (double) x;
}

static inline float fpconv_f64_f32(double x) {
  return (float) x;
}

static inline double fpconv_f64_f64(double x) {
  return (double) x;
}

#else

static inline double fdiv64(double x, double y) {
  return x / y;
}

static inline double fadd64(double x, double y) {
  return x + y;
}

static inline double fsub64(double x, double y) {
  return x - y;
}

static inline double fmul64(double x, double y) {
  return x * y;
}

static inline bool cmplt64(double x, double y) {
  return x < y;
}

static inline bool cmple64(double x, double y) {
  return x <= y;
}

static inline double sitofp_i8_f64(int8_t x) {
  return (double) x;
}

static inline double sitofp_i16_f64(int16_t x) {
  return (double) x;
}

static inline double sitofp_i32_f64(int32_t x) {
  return (double) x;
}

static inline double sitofp_i64_f64(int64_t x) {
  return (double) x;
}

static inline double uitofp_i8_f64(uint8_t x) {
  return (double) x;
}

static inline double uitofp_i16_f64(uint16_t x) {
  return (double) x;
}

static inline double uitofp_i32_f64(uint32_t x) {
  return (double) x;
}

static inline double uitofp_i64_f64(uint64_t x) {
  return (double) x;
}

static inline double fabs64(double x) {
  return fabs(x);
}

static inline double fmax64(double x, double y) {
  return fmax(x, y);
}

static inline double fmin64(double x, double y) {
  return fmin(x, y);
}

static inline double fpow64(double x, double y) {
  return pow(x, y);
}

static inline double futrts_log64(double x) {
  return log(x);
}

static inline double futrts_log2_64(double x) {
  return log2(x);
}

static inline double futrts_log10_64(double x) {
  return log10(x);
}

static inline double futrts_sqrt64(double x) {
  return sqrt(x);
}

static inline double futrts_cbrt64(double x) {
  return cbrt(x);
}

static inline double futrts_exp64(double x) {
  return exp(x);
}

static inline double futrts_cos64(double x) {
  return cos(x);
}

static inline double futrts_sin64(double x) {
  return sin(x);
}

static inline double futrts_tan64(double x) {
  return tan(x);
}

static inline double futrts_acos64(double x) {
  return acos(x);
}

static inline double futrts_asin64(double x) {
  return asin(x);
}

static inline double futrts_atan64(double x) {
  return atan(x);
}

static inline double futrts_cosh64(double x) {
  return cosh(x);
}

static inline double futrts_sinh64(double x) {
  return sinh(x);
}

static inline double futrts_tanh64(double x) {
  return tanh(x);
}

static inline double futrts_acosh64(double x) {
  return acosh(x);
}

static inline double futrts_asinh64(double x) {
  return asinh(x);
}

static inline double futrts_atanh64(double x) {
  return atanh(x);
}

static inline double futrts_atan2_64(double x, double y) {
  return atan2(x, y);
}

static inline double futrts_hypot64(double x, double y) {
  return hypot(x, y);
}

static inline double futrts_gamma64(double x) {
  return tgamma(x);
}

static inline double futrts_lgamma64(double x) {
  return lgamma(x);
}

static inline double futrts_erf64(double x) {
  return erf(x);
}

static inline double futrts_erfc64(double x) {
  return erfc(x);
}

static inline double futrts_fma64(double a, double b, double c) {
  return fma(a, b, c);
}

static inline double futrts_round64(double x) {
  return rint(x);
}

static inline double futrts_ceil64(double x) {
  return ceil(x);
}

static inline float futrts_nextafter64(float x, float y) {
  return nextafter(x, y);
}

static inline double futrts_floor64(double x) {
  return floor(x);
}

static inline bool futrts_isnan64(double x) {
  return isnan(x);
}

static inline bool futrts_isinf64(double x) {
  return isinf(x);
}

static inline int8_t fptosi_f64_i8(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (int8_t) x;
  }
}

static inline int16_t fptosi_f64_i16(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (int16_t) x;
  }
}

static inline int32_t fptosi_f64_i32(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (int32_t) x;
  }
}

static inline int64_t fptosi_f64_i64(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (int64_t) x;
  }
}

static inline uint8_t fptoui_f64_i8(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uint8_t) (int8_t) x;
  }
}

static inline uint16_t fptoui_f64_i16(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uint16_t) (int16_t) x;
  }
}

static inline uint32_t fptoui_f64_i32(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uint32_t) (int32_t) x;
  }
}

static inline uint64_t fptoui_f64_i64(double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uint64_t) (int64_t) x;
  }
}

static inline bool ftob_f64_bool(double x) {
  return x != 0;
}

static inline double btof_bool_f64(bool x) {
  return x ? 1 : 0;
}

static inline int64_t futrts_to_bits64(double x) {
  union {
    double f;
    int64_t t;
  } p;

  p.f = x;
  return p.t;
}

static inline double futrts_from_bits64(int64_t x) {
  union {
    int64_t f;
    double t;
  } p;

  p.f = x;
  return p.t;
}

static inline double fmod64(double x, double y) {
  return fmod(x, y);
}

static inline double fsignum64(double x) {
  return futrts_isnan64(x) ? x : (x > 0) - (x < 0);
}

static inline double futrts_lerp64(double v0, double v1, double t) {
#ifdef __OPENCL_VERSION__
  return mix(v0, v1, t);
#else
  return v0 + (v1 - v0) * t;
#endif
}

static inline double futrts_mad64(double a, double b, double c) {
#ifdef __OPENCL_VERSION__
  return mad(a, b, c);
#else
  return a * b + c;
#endif
}

static inline float fpconv_f32_f32(float x) {
  return (float) x;
}

static inline double fpconv_f32_f64(float x) {
  return (double) x;
}

static inline float fpconv_f64_f32(double x) {
  return (float) x;
}

static inline double fpconv_f64_f64(double x) {
  return (double) x;
}

#endif

#endif

// End of scalar.h.
// Start of scalar_f16.h.

// Half-precision is emulated if needed (e.g. in straight C) with the
// native type used if possible.  The emulation works by typedef'ing
// 'float' to 'f16', and then implementing all operations on single
// precision.  To cut down on duplication, we use the same code for
// those Futhark functions that require just operators or casts.  The
// in-memory representation for arrays will still be 16 bits even
// under emulation, so the compiler will have to be careful when
// generating reads or writes.

#if !defined(cl_khr_fp16) && !(defined(__CUDA_ARCH__) && __CUDA_ARCH__ >= 600) && !(defined(ISPC))
#define EMULATE_F16
#endif

#if !defined(EMULATE_F16) && defined(__OPENCL_VERSION__)
#pragma OPENCL EXTENSION cl_khr_fp16 : enable
#endif

#ifdef EMULATE_F16

// Note that the half-precision storage format is still 16 bits - the
// compiler will have to be real careful!
typedef float f16;

#elif ISPC
typedef float16 f16;

#else

#ifdef __CUDA_ARCH__
#include <cuda_fp16.h>
#endif

typedef half f16;

#endif

// Some of these functions convert to single precision because half
// precision versions are not available.

static inline f16 fadd16(f16 x, f16 y) {
  return x + y;
}

static inline f16 fsub16(f16 x, f16 y) {
  return x - y;
}

static inline f16 fmul16(f16 x, f16 y) {
  return x * y;
}

static inline bool cmplt16(f16 x, f16 y) {
  return x < y;
}

static inline bool cmple16(f16 x, f16 y) {
  return x <= y;
}

static inline f16 sitofp_i8_f16(int8_t x) {
  return (f16) x;
}

static inline f16 sitofp_i16_f16(int16_t x) {
  return (f16) x;
}

static inline f16 sitofp_i32_f16(int32_t x) {
  return (f16) x;
}

static inline f16 sitofp_i64_f16(int64_t x) {
  return (f16) x;
}

static inline f16 uitofp_i8_f16(uint8_t x) {
  return (f16) x;
}

static inline f16 uitofp_i16_f16(uint16_t x) {
  return (f16) x;
}

static inline f16 uitofp_i32_f16(uint32_t x) {
  return (f16) x;
}

static inline f16 uitofp_i64_f16(uint64_t x) {
  return (f16) x;
}

static inline int8_t fptosi_f16_i8(f16 x) {
  return (int8_t) (float) x;
}

static inline int16_t fptosi_f16_i16(f16 x) {
  return (int16_t) x;
}

static inline int32_t fptosi_f16_i32(f16 x) {
  return (int32_t) x;
}

static inline int64_t fptosi_f16_i64(f16 x) {
  return (int64_t) x;
}

static inline uint8_t fptoui_f16_i8(f16 x) {
  return (uint8_t) (float) x;
}

static inline uint16_t fptoui_f16_i16(f16 x) {
  return (uint16_t) x;
}

static inline uint32_t fptoui_f16_i32(f16 x) {
  return (uint32_t) x;
}

static inline uint64_t fptoui_f16_i64(f16 x) {
  return (uint64_t) x;
}

static inline bool ftob_f16_bool(f16 x) {
  return x != (f16)0;
}

static inline f16 btof_bool_f16(bool x) {
  return x ? 1 : 0;
}

#ifndef EMULATE_F16
static inline bool futrts_isnan16(f16 x) {
  return isnan((float)x);
}

#ifdef __OPENCL_VERSION__

static inline f16 fabs16(f16 x) {
  return fabs(x);
}

static inline f16 fmax16(f16 x, f16 y) {
  return fmax(x, y);
}

static inline f16 fmin16(f16 x, f16 y) {
  return fmin(x, y);
}

static inline f16 fpow16(f16 x, f16 y) {
  return pow(x, y);
}

#elif ISPC
static inline f16 fabs16(f16 x) {
  return abs(x);
}

static inline f16 fmax16(f16 x, f16 y) {
  return futrts_isnan16(x) ? y : futrts_isnan16(y) ? x : max(x, y);
}

static inline f16 fmin16(f16 x, f16 y) {
  return futrts_isnan16(x) ? y : futrts_isnan16(y) ? x : min(x, y);
}

static inline f16 fpow16(f16 x, f16 y) {
  return pow(x, y);
}
#else // Assuming CUDA.

static inline f16 fabs16(f16 x) {
  return fabsf(x);
}

static inline f16 fmax16(f16 x, f16 y) {
  return fmaxf(x, y);
}

static inline f16 fmin16(f16 x, f16 y) {
  return fminf(x, y);
}

static inline f16 fpow16(f16 x, f16 y) {
  return powf(x, y);
}
#endif

#if ISPC
static inline bool futrts_isinf16(float x) {
  return !futrts_isnan16(x) && futrts_isnan16(x - x);
}
static inline bool futrts_isfinite16(float x) {
  return !futrts_isnan16(x) && !futrts_isinf16(x);
}

#else

static inline bool futrts_isinf16(f16 x) {
  return isinf((float)x);
}
#endif

#ifdef __OPENCL_VERSION__
static inline f16 futrts_log16(f16 x) {
  return log(x);
}

static inline f16 futrts_log2_16(f16 x) {
  return log2(x);
}

static inline f16 futrts_log10_16(f16 x) {
  return log10(x);
}

static inline f16 futrts_sqrt16(f16 x) {
  return sqrt(x);
}

static inline f16 futrts_cbrt16(f16 x) {
  return cbrt(x);
}

static inline f16 futrts_exp16(f16 x) {
  return exp(x);
}

static inline f16 futrts_cos16(f16 x) {
  return cos(x);
}

static inline f16 futrts_sin16(f16 x) {
  return sin(x);
}

static inline f16 futrts_tan16(f16 x) {
  return tan(x);
}

static inline f16 futrts_acos16(f16 x) {
  return acos(x);
}

static inline f16 futrts_asin16(f16 x) {
  return asin(x);
}

static inline f16 futrts_atan16(f16 x) {
  return atan(x);
}

static inline f16 futrts_cosh16(f16 x) {
  return cosh(x);
}

static inline f16 futrts_sinh16(f16 x) {
  return sinh(x);
}

static inline f16 futrts_tanh16(f16 x) {
  return tanh(x);
}

static inline f16 futrts_acosh16(f16 x) {
  return acosh(x);
}

static inline f16 futrts_asinh16(f16 x) {
  return asinh(x);
}

static inline f16 futrts_atanh16(f16 x) {
  return atanh(x);
}

static inline f16 futrts_atan2_16(f16 x, f16 y) {
  return atan2(x, y);
}

static inline f16 futrts_hypot16(f16 x, f16 y) {
  return hypot(x, y);
}

static inline f16 futrts_gamma16(f16 x) {
  return tgamma(x);
}

static inline f16 futrts_lgamma16(f16 x) {
  return lgamma(x);
}

static inline f16 futrts_erf16(f16 x) {
  return erf(x);
}

static inline f16 futrts_erfc16(f16 x) {
  return erfc(x);
}

static inline f16 fmod16(f16 x, f16 y) {
  return fmod(x, y);
}

static inline f16 futrts_round16(f16 x) {
  return rint(x);
}

static inline f16 futrts_floor16(f16 x) {
  return floor(x);
}

static inline f16 futrts_ceil16(f16 x) {
  return ceil(x);
}

static inline f16 futrts_nextafter16(f16 x, f16 y) {
  return nextafter(x, y);
}

static inline f16 futrts_lerp16(f16 v0, f16 v1, f16 t) {
  return mix(v0, v1, t);
}

static inline f16 futrts_mad16(f16 a, f16 b, f16 c) {
  return mad(a, b, c);
}

static inline f16 futrts_fma16(f16 a, f16 b, f16 c) {
  return fma(a, b, c);
}
#elif ISPC

static inline f16 futrts_log16(f16 x) {
  return futrts_isfinite16(x) || (futrts_isinf16(x) && x < 0) ? log(x) : x;
}

static inline f16 futrts_log2_16(f16 x) {
  return futrts_log16(x) / log(2.0f16);
}

static inline f16 futrts_log10_16(f16 x) {
  return futrts_log16(x) / log(10.0f16);
}

static inline f16 futrts_sqrt16(f16 x) {
  return (float16)sqrt((float)x);
}

static inline f16 futrts_exp16(f16 x) {
  return exp(x);
}

static inline f16 futrts_cos16(f16 x) {
  return (float16)cos((float)x);
}

static inline f16 futrts_sin16(f16 x) {
  return (float16)sin((float)x);
}

static inline f16 futrts_tan16(f16 x) {
  return (float16)tan((float)x);
}

static inline f16 futrts_acos16(f16 x) {
  return (float16)acos((float)x);
}

static inline f16 futrts_asin16(f16 x) {
  return (float16)asin((float)x);
}

static inline f16 futrts_atan16(f16 x) {
  return (float16)atan((float)x);
}

static inline f16 futrts_cosh16(f16 x) {
  return (exp(x)+exp(-x)) / 2.0f16;
}

static inline f16 futrts_sinh16(f16 x) {
  return (exp(x)-exp(-x)) / 2.0f16;
}

static inline f16 futrts_tanh16(f16 x) {
  return futrts_sinh16(x)/futrts_cosh16(x);
}

static inline f16 futrts_acosh16(f16 x) {
  float16 f = x+(float16)sqrt((float)(x*x-1));
  if(futrts_isfinite16(f)) return log(f);
  return f;
}

static inline f16 futrts_asinh16(f16 x) {
  float16 f = x+(float16)sqrt((float)(x*x+1));
  if(futrts_isfinite16(f)) return log(f);
  return f;
}

static inline f16 futrts_atanh16(f16 x) {
  float16 f = (1+x)/(1-x);
  if(futrts_isfinite16(f)) return log(f)/2.0f16;
  return f;
}

static inline f16 futrts_atan2_16(f16 x, f16 y) {
  return (float16)atan2((float)x, (float)y);
}

static inline f16 futrts_hypot16(f16 x, f16 y) {
  return (float16)futrts_hypot32((float)x, (float)y);
}

extern "C" unmasked uniform float tgammaf(uniform float x);
static inline f16 futrts_gamma16(f16 x) {
  f16 res;
  foreach_active (i) {
    uniform f16 r = (f16)tgammaf(extract((float)x, i));
    res = insert(res, i, r);
  }
  return res;
}

extern "C" unmasked uniform float lgammaf(uniform float x);
static inline f16 futrts_lgamma16(f16 x) {
  f16 res;
  foreach_active (i) {
    uniform f16 r = (f16)lgammaf(extract((float)x, i));
    res = insert(res, i, r);
  }
  return res;
}

static inline f16 futrts_cbrt16(f16 x) {
  f16 res = (f16)futrts_cbrt32((float)x);
  return res;
}

static inline f16 futrts_erf16(f16 x) {
  f16 res = (f16)futrts_erf32((float)x);
  return res;
}

static inline f16 futrts_erfc16(f16 x) {
  f16 res = (f16)futrts_erfc32((float)x);
  return res;
}

static inline f16 fmod16(f16 x, f16 y) {
  return x - y * (float16)trunc((float) (x/y));
}

static inline f16 futrts_round16(f16 x) {
  return (float16)round((float)x);
}

static inline f16 futrts_floor16(f16 x) {
  return (float16)floor((float)x);
}

static inline f16 futrts_ceil16(f16 x) {
  return (float16)ceil((float)x);
}

static inline f16 futrts_nextafter16(f16 x, f16 y) {
  return (float16)futrts_nextafter32((float)x, (float) y);
}

static inline f16 futrts_lerp16(f16 v0, f16 v1, f16 t) {
  return v0 + (v1 - v0) * t;
}

static inline f16 futrts_mad16(f16 a, f16 b, f16 c) {
  return a * b + c;
}

static inline f16 futrts_fma16(f16 a, f16 b, f16 c) {
  return a * b + c;
}

#else // Assume CUDA.

static inline f16 futrts_log16(f16 x) {
  return hlog(x);
}

static inline f16 futrts_log2_16(f16 x) {
  return hlog2(x);
}

static inline f16 futrts_log10_16(f16 x) {
  return hlog10(x);
}

static inline f16 futrts_sqrt16(f16 x) {
  return hsqrt(x);
}

static inline f16 futrts_cbrt16(f16 x) {
  return cbrtf(x);
}

static inline f16 futrts_exp16(f16 x) {
  return hexp(x);
}

static inline f16 futrts_cos16(f16 x) {
  return hcos(x);
}

static inline f16 futrts_sin16(f16 x) {
  return hsin(x);
}

static inline f16 futrts_tan16(f16 x) {
  return tanf(x);
}

static inline f16 futrts_acos16(f16 x) {
  return acosf(x);
}

static inline f16 futrts_asin16(f16 x) {
  return asinf(x);
}

static inline f16 futrts_atan16(f16 x) {
  return atanf(x);
}

static inline f16 futrts_cosh16(f16 x) {
  return coshf(x);
}

static inline f16 futrts_sinh16(f16 x) {
  return sinhf(x);
}

static inline f16 futrts_tanh16(f16 x) {
  return tanhf(x);
}

static inline f16 futrts_acosh16(f16 x) {
  return acoshf(x);
}

static inline f16 futrts_asinh16(f16 x) {
  return asinhf(x);
}

static inline f16 futrts_atanh16(f16 x) {
  return atanhf(x);
}

static inline f16 futrts_atan2_16(f16 x, f16 y) {
  return atan2f(x, y);
}

static inline f16 futrts_hypot16(f16 x, f16 y) {
  return hypotf(x, y);
}

static inline f16 futrts_gamma16(f16 x) {
  return tgammaf(x);
}

static inline f16 futrts_lgamma16(f16 x) {
  return lgammaf(x);
}

static inline f16 futrts_erf16(f16 x) {
  return erff(x);
}

static inline f16 futrts_erfc16(f16 x) {
  return erfcf(x);
}

static inline f16 fmod16(f16 x, f16 y) {
  return fmodf(x, y);
}

static inline f16 futrts_round16(f16 x) {
  return rintf(x);
}

static inline f16 futrts_floor16(f16 x) {
  return hfloor(x);
}

static inline f16 futrts_ceil16(f16 x) {
  return hceil(x);
}

static inline f16 futrts_nextafter16(f16 x, f16 y) {
  return __ushort_as_half(halfbitsnextafter(__half_as_ushort(x), __half_as_ushort(y)));
}

static inline f16 futrts_lerp16(f16 v0, f16 v1, f16 t) {
  return v0 + (v1 - v0) * t;
}

static inline f16 futrts_mad16(f16 a, f16 b, f16 c) {
  return a * b + c;
}

static inline f16 futrts_fma16(f16 a, f16 b, f16 c) {
  return fmaf(a, b, c);
}

#endif

// The CUDA __half type cannot be put in unions for some reason, so we
// use bespoke conversion functions instead.
#ifdef __CUDA_ARCH__
static inline int16_t futrts_to_bits16(f16 x) {
  return __half_as_ushort(x);
}
static inline f16 futrts_from_bits16(int16_t x) {
  return __ushort_as_half(x);
}
#elif ISPC

static inline int16_t futrts_to_bits16(f16 x) {
  varying int16_t y = *((varying int16_t * uniform)&x);
  return y;
}

static inline f16 futrts_from_bits16(int16_t x) {
  varying f16 y = *((varying f16 * uniform)&x);
  return y;
}
#else
static inline int16_t futrts_to_bits16(f16 x) {
  union {
    f16 f;
    int16_t t;
  } p;

  p.f = x;
  return p.t;
}

static inline f16 futrts_from_bits16(int16_t x) {
  union {
    int16_t f;
    f16 t;
  } p;

  p.f = x;
  return p.t;
}
#endif

#else // No native f16 - emulate.

static inline f16 fabs16(f16 x) {
  return fabs32(x);
}

static inline f16 fmax16(f16 x, f16 y) {
  return fmax32(x, y);
}

static inline f16 fmin16(f16 x, f16 y) {
  return fmin32(x, y);
}

static inline f16 fpow16(f16 x, f16 y) {
  return fpow32(x, y);
}

static inline bool futrts_isnan16(f16 x) {
  return futrts_isnan32(x);
}

static inline bool futrts_isinf16(f16 x) {
  return futrts_isinf32(x);
}

static inline f16 futrts_log16(f16 x) {
  return futrts_log32(x);
}

static inline f16 futrts_log2_16(f16 x) {
  return futrts_log2_32(x);
}

static inline f16 futrts_log10_16(f16 x) {
  return futrts_log10_32(x);
}

static inline f16 futrts_sqrt16(f16 x) {
  return futrts_sqrt32(x);
}

static inline f16 futrts_cbrt16(f16 x) {
  return futrts_cbrt32(x);
}

static inline f16 futrts_exp16(f16 x) {
  return futrts_exp32(x);
}

static inline f16 futrts_cos16(f16 x) {
  return futrts_cos32(x);
}

static inline f16 futrts_sin16(f16 x) {
  return futrts_sin32(x);
}

static inline f16 futrts_tan16(f16 x) {
  return futrts_tan32(x);
}

static inline f16 futrts_acos16(f16 x) {
  return futrts_acos32(x);
}

static inline f16 futrts_asin16(f16 x) {
  return futrts_asin32(x);
}

static inline f16 futrts_atan16(f16 x) {
  return futrts_atan32(x);
}

static inline f16 futrts_cosh16(f16 x) {
  return futrts_cosh32(x);
}

static inline f16 futrts_sinh16(f16 x) {
  return futrts_sinh32(x);
}

static inline f16 futrts_tanh16(f16 x) {
  return futrts_tanh32(x);
}

static inline f16 futrts_acosh16(f16 x) {
  return futrts_acosh32(x);
}

static inline f16 futrts_asinh16(f16 x) {
  return futrts_asinh32(x);
}

static inline f16 futrts_atanh16(f16 x) {
  return futrts_atanh32(x);
}

static inline f16 futrts_atan2_16(f16 x, f16 y) {
  return futrts_atan2_32(x, y);
}

static inline f16 futrts_hypot16(f16 x, f16 y) {
  return futrts_hypot32(x, y);
}

static inline f16 futrts_gamma16(f16 x) {
  return futrts_gamma32(x);
}

static inline f16 futrts_lgamma16(f16 x) {
  return futrts_lgamma32(x);
}

static inline f16 futrts_erf16(f16 x) {
  return futrts_erf32(x);
}

static inline f16 futrts_erfc16(f16 x) {
  return futrts_erfc32(x);
}

static inline f16 fmod16(f16 x, f16 y) {
  return fmod32(x, y);
}

static inline f16 futrts_round16(f16 x) {
  return futrts_round32(x);
}

static inline f16 futrts_floor16(f16 x) {
  return futrts_floor32(x);
}

static inline f16 futrts_ceil16(f16 x) {
  return futrts_ceil32(x);
}

static inline f16 futrts_nextafter16(f16 x, f16 y) {
  return halfbits2float(halfbitsnextafter(float2halfbits(x), float2halfbits(y)));
}

static inline f16 futrts_lerp16(f16 v0, f16 v1, f16 t) {
  return futrts_lerp32(v0, v1, t);
}

static inline f16 futrts_mad16(f16 a, f16 b, f16 c) {
  return futrts_mad32(a, b, c);
}

static inline f16 futrts_fma16(f16 a, f16 b, f16 c) {
  return futrts_fma32(a, b, c);
}

// Even when we are using an OpenCL that does not support cl_khr_fp16,
// it must still support vload_half for actually creating a
// half-precision number, which can then be efficiently converted to a
// float.  Similarly for vstore_half.
#ifdef __OPENCL_VERSION__

static inline int16_t futrts_to_bits16(f16 x) {
  int16_t y;
  // Violating strict aliasing here.
  vstore_half((float)x, 0, (half*)&y);
  return y;
}

static inline f16 futrts_from_bits16(int16_t x) {
  return (f16)vload_half(0, (half*)&x);
}

#else

static inline int16_t futrts_to_bits16(f16 x) {
  return (int16_t)float2halfbits(x);
}

static inline f16 futrts_from_bits16(int16_t x) {
  return halfbits2float((uint16_t)x);
}

static inline f16 fsignum16(f16 x) {
  return futrts_isnan16(x) ? x : (x > 0 ? 1 : 0) - (x < 0 ? 1 : 0);
}

#endif

#endif

static inline float fpconv_f16_f16(f16 x) {
  return x;
}

static inline float fpconv_f16_f32(f16 x) {
  return x;
}

static inline f16 fpconv_f32_f16(float x) {
  return (f16) x;
}

#ifdef FUTHARK_F64_ENABLED

static inline double fpconv_f16_f64(f16 x) {
  return (double) x;
}

#if ISPC
static inline f16 fpconv_f64_f16(double x) {
  return (f16) ((float)x);
}
#else
static inline f16 fpconv_f64_f16(double x) {
  return (f16) x;
}
#endif
#endif


// End of scalar_f16.h.


// Start of uniform.h

// Uniform versions of all library functions as to
// improve performance in ISPC when in an uniform context.

#if ISPC

static inline uniform uint8_t add8(uniform uint8_t x, uniform uint8_t y) {
  return x + y;
}

static inline uniform uint16_t add16(uniform uint16_t x, uniform uint16_t y) {
  return x + y;
}

static inline uniform uint32_t add32(uniform uint32_t x, uniform uint32_t y) {
  return x + y;
}

static inline uniform uint64_t add64(uniform uint64_t x, uniform uint64_t y) {
  return x + y;
}

static inline uniform uint8_t sub8(uniform uint8_t x, uniform uint8_t y) {
  return x - y;
}

static inline uniform uint16_t sub16(uniform uint16_t x, uniform uint16_t y) {
  return x - y;
}

static inline uniform uint32_t sub32(uniform uint32_t x, uniform uint32_t y) {
  return x - y;
}

static inline uniform uint64_t sub64(uniform uint64_t x, uniform uint64_t y) {
  return x - y;
}

static inline uniform uint8_t mul8(uniform uint8_t x, uniform uint8_t y) {
  return x * y;
}

static inline uniform uint16_t mul16(uniform uint16_t x, uniform uint16_t y) {
  return x * y;
}

static inline uniform uint32_t mul32(uniform uint32_t x, uniform uint32_t y) {
  return x * y;
}

static inline uniform uint64_t mul64(uniform uint64_t x, uniform uint64_t y) {
  return x * y;
}

static inline uniform uint8_t udiv8(uniform uint8_t x, uniform uint8_t y) {
  return x / y;
}

static inline uniform uint16_t udiv16(uniform uint16_t x, uniform uint16_t y) {
  return x / y;
}

static inline uniform uint32_t udiv32(uniform uint32_t x, uniform uint32_t y) {
  return x / y;
}

static inline uniform uint64_t udiv64(uniform uint64_t x, uniform uint64_t y) {
  return x / y;
}

static inline uniform uint8_t udiv_up8(uniform uint8_t x, uniform uint8_t y) {
  return (x + y - 1) / y;
}

static inline uniform uint16_t udiv_up16(uniform uint16_t x, uniform uint16_t y) {
  return (x + y - 1) / y;
}

static inline uniform uint32_t udiv_up32(uniform uint32_t x, uniform uint32_t y) {
  return (x + y - 1) / y;
}

static inline uniform uint64_t udiv_up64(uniform uint64_t x, uniform uint64_t y) {
  return (x + y - 1) / y;
}

static inline uniform uint8_t umod8(uniform uint8_t x, uniform uint8_t y) {
  return x % y;
}

static inline uniform uint16_t umod16(uniform uint16_t x, uniform uint16_t y) {
  return x % y;
}

static inline uniform uint32_t umod32(uniform uint32_t x, uniform uint32_t y) {
  return x % y;
}

static inline uniform uint64_t umod64(uniform uint64_t x, uniform uint64_t y) {
  return x % y;
}

static inline uniform uint8_t udiv_safe8(uniform uint8_t x, uniform uint8_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uniform uint16_t udiv_safe16(uniform uint16_t x, uniform uint16_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uniform uint32_t udiv_safe32(uniform uint32_t x, uniform uint32_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uniform uint64_t udiv_safe64(uniform uint64_t x, uniform uint64_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uniform uint8_t udiv_up_safe8(uniform uint8_t x, uniform uint8_t y) {
  return y == 0 ? 0 : (x + y - 1) / y;
}

static inline uniform uint16_t udiv_up_safe16(uniform uint16_t x, uniform uint16_t y) {
  return y == 0 ? 0 : (x + y - 1) / y;
}

static inline uniform uint32_t udiv_up_safe32(uniform uint32_t x, uniform uint32_t y) {
  return y == 0 ? 0 : (x + y - 1) / y;
}

static inline uniform uint64_t udiv_up_safe64(uniform uint64_t x, uniform uint64_t y) {
  return y == 0 ? 0 : (x + y - 1) / y;
}

static inline uniform uint8_t umod_safe8(uniform uint8_t x, uniform uint8_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uniform uint16_t umod_safe16(uniform uint16_t x, uniform uint16_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uniform uint32_t umod_safe32(uniform uint32_t x, uniform uint32_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uniform uint64_t umod_safe64(uniform uint64_t x, uniform uint64_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uniform int8_t sdiv8(uniform int8_t x, uniform int8_t y) {
  uniform int8_t q = x / y;
  uniform int8_t r = x % y;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline uniform int16_t sdiv16(uniform int16_t x, uniform int16_t y) {
  uniform int16_t q = x / y;
  uniform int16_t r = x % y;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline uniform int32_t sdiv32(uniform int32_t x, uniform int32_t y) {
  uniform int32_t q = x / y;
  uniform int32_t r = x % y;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline uniform int64_t sdiv64(uniform int64_t x, uniform int64_t y) {
  uniform int64_t q = x / y;
  uniform int64_t r = x % y;

  return q - ((r != 0 && r < 0 != y < 0) ? 1 : 0);
}

static inline uniform int8_t sdiv_up8(uniform int8_t x, uniform int8_t y) {
  return sdiv8(x + y - 1, y);
}

static inline uniform int16_t sdiv_up16(uniform int16_t x, uniform int16_t y) {
  return sdiv16(x + y - 1, y);
}

static inline uniform int32_t sdiv_up32(uniform int32_t x, uniform int32_t y) {
  return sdiv32(x + y - 1, y);
}

static inline uniform int64_t sdiv_up64(uniform int64_t x, uniform int64_t y) {
  return sdiv64(x + y - 1, y);
}

static inline uniform int8_t smod8(uniform int8_t x, uniform int8_t y) {
  uniform int8_t r = x % y;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline uniform int16_t smod16(uniform int16_t x, uniform int16_t y) {
  uniform int16_t r = x % y;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline uniform int32_t smod32(uniform int32_t x, uniform int32_t y) {
  uniform int32_t r = x % y;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline uniform int64_t smod64(uniform int64_t x, uniform int64_t y) {
  uniform int64_t r = x % y;

  return r + (r == 0 || (x > 0 && y > 0) || (x < 0 && y < 0) ? 0 : y);
}

static inline uniform int8_t sdiv_safe8(uniform int8_t x, uniform int8_t y) {
  return y == 0 ? 0 : sdiv8(x, y);
}

static inline uniform int16_t sdiv_safe16(uniform int16_t x, uniform int16_t y) {
  return y == 0 ? 0 : sdiv16(x, y);
}

static inline uniform int32_t sdiv_safe32(uniform int32_t x, uniform int32_t y) {
  return y == 0 ? 0 : sdiv32(x, y);
}

static inline uniform int64_t sdiv_safe64(uniform int64_t x, uniform int64_t y) {
  return y == 0 ? 0 : sdiv64(x, y);
}

static inline uniform int8_t sdiv_up_safe8(uniform int8_t x, uniform int8_t y) {
  return sdiv_safe8(x + y - 1, y);
}

static inline uniform int16_t sdiv_up_safe16(uniform int16_t x, uniform int16_t y) {
  return sdiv_safe16(x + y - 1, y);
}

static inline uniform int32_t sdiv_up_safe32(uniform int32_t x, uniform int32_t y) {
  return sdiv_safe32(x + y - 1, y);
}

static inline uniform int64_t sdiv_up_safe64(uniform int64_t x, uniform int64_t y) {
  return sdiv_safe64(x + y - 1, y);
}

static inline uniform int8_t smod_safe8(uniform int8_t x, uniform int8_t y) {
  return y == 0 ? 0 : smod8(x, y);
}

static inline uniform int16_t smod_safe16(uniform int16_t x, uniform int16_t y) {
  return y == 0 ? 0 : smod16(x, y);
}

static inline uniform int32_t smod_safe32(uniform int32_t x, uniform int32_t y) {
  return y == 0 ? 0 : smod32(x, y);
}

static inline uniform int64_t smod_safe64(uniform int64_t x, uniform int64_t y) {
  return y == 0 ? 0 : smod64(x, y);
}

static inline uniform int8_t squot8(uniform int8_t x, uniform int8_t y) {
  return x / y;
}

static inline uniform int16_t squot16(uniform int16_t x, uniform int16_t y) {
  return x / y;
}

static inline uniform int32_t squot32(uniform int32_t x, uniform int32_t y) {
  return x / y;
}

static inline uniform int64_t squot64(uniform int64_t x, uniform int64_t y) {
  return x / y;
}

static inline uniform int8_t srem8(uniform int8_t x, uniform int8_t y) {
  return x % y;
}

static inline uniform int16_t srem16(uniform int16_t x, uniform int16_t y) {
  return x % y;
}

static inline uniform int32_t srem32(uniform int32_t x, uniform int32_t y) {
  return x % y;
}

static inline uniform int64_t srem64(uniform int64_t x, uniform int64_t y) {
  return x % y;
}

static inline uniform int8_t squot_safe8(uniform int8_t x, uniform int8_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uniform int16_t squot_safe16(uniform int16_t x, uniform int16_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uniform int32_t squot_safe32(uniform int32_t x, uniform int32_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uniform int64_t squot_safe64(uniform int64_t x, uniform int64_t y) {
  return y == 0 ? 0 : x / y;
}

static inline uniform int8_t srem_safe8(uniform int8_t x, uniform int8_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uniform int16_t srem_safe16(uniform int16_t x, uniform int16_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uniform int32_t srem_safe32(uniform int32_t x, uniform int32_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uniform int64_t srem_safe64(uniform int64_t x, uniform int64_t y) {
  return y == 0 ? 0 : x % y;
}

static inline uniform int8_t smin8(uniform int8_t x, uniform int8_t y) {
  return x < y ? x : y;
}

static inline uniform int16_t smin16(uniform int16_t x, uniform int16_t y) {
  return x < y ? x : y;
}

static inline uniform int32_t smin32(uniform int32_t x, uniform int32_t y) {
  return x < y ? x : y;
}

static inline uniform int64_t smin64(uniform int64_t x, uniform int64_t y) {
  return x < y ? x : y;
}

static inline uniform uint8_t umin8(uniform uint8_t x, uniform uint8_t y) {
  return x < y ? x : y;
}

static inline uniform uint16_t umin16(uniform uint16_t x, uniform uint16_t y) {
  return x < y ? x : y;
}

static inline uniform uint32_t umin32(uniform uint32_t x, uniform uint32_t y) {
  return x < y ? x : y;
}

static inline uniform uint64_t umin64(uniform uint64_t x, uniform uint64_t y) {
  return x < y ? x : y;
}

static inline uniform int8_t smax8(uniform int8_t x, uniform int8_t y) {
  return x < y ? y : x;
}

static inline uniform int16_t smax16(uniform int16_t x, uniform int16_t y) {
  return x < y ? y : x;
}

static inline uniform int32_t smax32(uniform int32_t x, uniform int32_t y) {
  return x < y ? y : x;
}

static inline uniform int64_t smax64(uniform int64_t x, uniform int64_t y) {
  return x < y ? y : x;
}

static inline uniform uint8_t umax8(uniform uint8_t x, uniform uint8_t y) {
  return x < y ? y : x;
}

static inline uniform uint16_t umax16(uniform uint16_t x, uniform uint16_t y) {
  return x < y ? y : x;
}

static inline uniform uint32_t umax32(uniform uint32_t x, uniform uint32_t y) {
  return x < y ? y : x;
}

static inline uniform uint64_t umax64(uniform uint64_t x, uniform uint64_t y) {
  return x < y ? y : x;
}

static inline uniform uint8_t shl8(uniform uint8_t x, uniform uint8_t y) {
  return (uniform uint8_t)(x << y);
}

static inline uniform uint16_t shl16(uniform uint16_t x, uniform uint16_t y) {
  return (uniform uint16_t)(x << y);
}

static inline uniform uint32_t shl32(uniform uint32_t x, uniform uint32_t y) {
  return x << y;
}

static inline uniform uint64_t shl64(uniform uint64_t x, uniform uint64_t y) {
  return x << y;
}

static inline uniform uint8_t lshr8(uniform uint8_t x, uniform uint8_t y) {
  return x >> y;
}

static inline uniform uint16_t lshr16(uniform uint16_t x, uniform uint16_t y) {
  return x >> y;
}

static inline uniform uint32_t lshr32(uniform uint32_t x, uniform uint32_t y) {
  return x >> y;
}

static inline uniform uint64_t lshr64(uniform uint64_t x, uniform uint64_t y) {
  return x >> y;
}

static inline uniform int8_t ashr8(uniform int8_t x, uniform int8_t y) {
  return x >> y;
}

static inline uniform int16_t ashr16(uniform int16_t x, uniform int16_t y) {
  return x >> y;
}

static inline uniform int32_t ashr32(uniform int32_t x, uniform int32_t y) {
  return x >> y;
}

static inline uniform int64_t ashr64(uniform int64_t x, uniform int64_t y) {
  return x >> y;
}

static inline uniform uint8_t and8(uniform uint8_t x, uniform uint8_t y) {
  return x & y;
}

static inline uniform uint16_t and16(uniform uint16_t x, uniform uint16_t y) {
  return x & y;
}

static inline uniform uint32_t and32(uniform uint32_t x, uniform uint32_t y) {
  return x & y;
}

static inline uniform uint64_t and64(uniform uint64_t x, uniform uint64_t y) {
  return x & y;
}

static inline uniform uint8_t or8(uniform uint8_t x, uniform uint8_t y) {
  return x | y;
}

static inline uniform uint16_t or16(uniform uint16_t x, uniform uint16_t y) {
  return x | y;
}

static inline uniform uint32_t or32(uniform uint32_t x, uniform uint32_t y) {
  return x | y;
}

static inline uniform uint64_t or64(uniform uint64_t x, uniform uint64_t y) {
  return x | y;
}

static inline uniform uint8_t xor8(uniform uint8_t x, uniform uint8_t y) {
  return x ^ y;
}

static inline uniform uint16_t xor16(uniform uint16_t x, uniform uint16_t y) {
  return x ^ y;
}

static inline uniform uint32_t xor32(uniform uint32_t x, uniform uint32_t y) {
  return x ^ y;
}

static inline uniform uint64_t xor64(uniform uint64_t x, uniform uint64_t y) {
  return x ^ y;
}

static inline uniform bool ult8(uniform uint8_t x, uniform uint8_t y) {
  return x < y;
}

static inline uniform bool ult16(uniform uint16_t x, uniform uint16_t y) {
  return x < y;
}

static inline uniform bool ult32(uniform uint32_t x, uniform uint32_t y) {
  return x < y;
}

static inline uniform bool ult64(uniform uint64_t x, uniform uint64_t y) {
  return x < y;
}

static inline uniform bool ule8(uniform uint8_t x, uniform uint8_t y) {
  return x <= y;
}

static inline uniform bool ule16(uniform uint16_t x, uniform uint16_t y) {
  return x <= y;
}

static inline uniform bool ule32(uniform uint32_t x, uniform uint32_t y) {
  return x <= y;
}

static inline uniform bool ule64(uniform uint64_t x, uniform uint64_t y) {
  return x <= y;
}

static inline uniform bool slt8(uniform int8_t x, uniform int8_t y) {
  return x < y;
}

static inline uniform bool slt16(uniform int16_t x, uniform int16_t y) {
  return x < y;
}

static inline uniform bool slt32(uniform int32_t x, uniform int32_t y) {
  return x < y;
}

static inline uniform bool slt64(uniform int64_t x, uniform int64_t y) {
  return x < y;
}

static inline uniform bool sle8(uniform int8_t x, uniform int8_t y) {
  return x <= y;
}

static inline uniform bool sle16(uniform int16_t x, uniform int16_t y) {
  return x <= y;
}

static inline uniform bool sle32(uniform int32_t x, uniform int32_t y) {
  return x <= y;
}

static inline uniform bool sle64(uniform int64_t x, uniform int64_t y) {
  return x <= y;
}

static inline uniform uint8_t pow8(uniform uint8_t x, uniform uint8_t y) {
  uniform uint8_t res = 1, rem = y;

  while (rem != 0) {
    if (rem & 1)
      res *= x;
    rem >>= 1;
    x *= x;
  }
  return res;
}

static inline uniform uint16_t pow16(uniform uint16_t x, uniform uint16_t y) {
  uniform uint16_t res = 1, rem = y;

  while (rem != 0) {
    if (rem & 1)
      res *= x;
    rem >>= 1;
    x *= x;
  }
  return res;
}

static inline uniform uint32_t pow32(uniform uint32_t x, uniform uint32_t y) {
  uniform uint32_t res = 1, rem = y;

  while (rem != 0) {
    if (rem & 1)
      res *= x;
    rem >>= 1;
    x *= x;
  }
  return res;
}

static inline uniform uint64_t pow64(uniform uint64_t x, uniform uint64_t y) {
  uniform uint64_t res = 1, rem = y;

  while (rem != 0) {
    if (rem & 1)
      res *= x;
    rem >>= 1;
    x *= x;
  }
  return res;
}

static inline uniform bool itob_i8_bool(uniform int8_t x) {
  return x != 0;
}

static inline uniform bool itob_i16_bool(uniform int16_t x) {
  return x != 0;
}

static inline uniform bool itob_i32_bool(uniform int32_t x) {
  return x != 0;
}

static inline uniform bool itob_i64_bool(uniform int64_t x) {
  return x != 0;
}

static inline uniform int8_t btoi_bool_i8(uniform bool x) {
  return x;
}

static inline uniform int16_t btoi_bool_i16(uniform bool x) {
  return x;
}

static inline uniform int32_t btoi_bool_i32(uniform bool x) {
  return x;
}

static inline uniform int64_t btoi_bool_i64(uniform bool x) {
  return x;
}


static uniform int8_t abs8(uniform int8_t x) {
  return (uniform int8_t)abs(x);
}

static uniform int16_t abs16(uniform int16_t x) {
  return (uniform int16_t)abs(x);
}

static uniform int32_t abs32(uniform int32_t x) {
  return abs(x);
}

static uniform int64_t abs64(uniform int64_t x) {
  return abs(x);
}

static uniform int32_t futrts_popc8(uniform uint8_t x) {
  uniform int c = 0;
  for (; x; ++c) { x &= x - 1; }
  return c;
}

static uniform int32_t futrts_popc16(uniform uint16_t x) {
  uniform int c = 0;
  for (; x; ++c) { x &= x - 1; }
  return c;
}

static uniform int32_t futrts_popc32(uniform uint32_t x) {
  uniform int c = 0;
  for (; x; ++c) { x &= x - 1; }
  return c;
}

static uniform int32_t futrts_popc64(uniform uint64_t x) {
  uniform int c = 0;
  for (; x; ++c) { x &= x - 1; }
  return c;
}

static uniform uint8_t futrts_mul_hi8(uniform uint8_t a, uniform uint8_t b) {
  uniform uint16_t aa = a;
  uniform uint16_t bb = b;

  return aa * bb >> 8;
}

static uniform uint16_t futrts_mul_hi16(uniform uint16_t a, uniform uint16_t b) {
  uniform uint32_t aa = a;
  uniform uint32_t bb = b;

  return aa * bb >> 16;
}

static uniform uint32_t futrts_mul_hi32(uniform uint32_t a, uniform uint32_t b) {
  uniform uint64_t aa = a;
  uniform uint64_t bb = b;

  return aa * bb >> 32;
}

static uniform uint64_t futrts_mul_hi64(uniform uint64_t a, uniform uint64_t b) {
  uniform uint64_t ah = a >> 32;
  uniform uint64_t al = a & 0xffffffff;
  uniform uint64_t bh = b >> 32;
  uniform uint64_t bl = b & 0xffffffff;

  uniform uint64_t p1 = al * bl;
  uniform uint64_t p2 = al * bh;
  uniform uint64_t p3 = ah * bl;
  uniform uint64_t p4 = ah * bh;

  uniform uint64_t p1h = p1 >> 32;
  uniform uint64_t p2h = p2 >> 32;
  uniform uint64_t p3h = p3 >> 32;
  uniform uint64_t p2l = p2 & 0xffffffff;
  uniform uint64_t p3l = p3 & 0xffffffff;

  uniform uint64_t l = p1h + p2l  + p3l;
  uniform uint64_t m = (p2 >> 32) + (p3 >> 32);
  uniform uint64_t h = (l >> 32) + m + p4;

  return h;
}

static uniform uint8_t futrts_mad_hi8(uniform uint8_t a, uniform uint8_t b, uniform uint8_t c) {
  return futrts_mul_hi8(a, b) + c;
}

static uniform uint16_t futrts_mad_hi16(uniform uint16_t a, uniform uint16_t b, uniform uint16_t c) {
  return futrts_mul_hi16(a, b) + c;
}

static uniform uint32_t futrts_mad_hi32(uniform uint32_t a, uniform uint32_t b, uniform uint32_t c) {
  return futrts_mul_hi32(a, b) + c;
}

static uniform uint64_t futrts_mad_hi64(uniform uint64_t a, uniform uint64_t b, uniform uint64_t c) {
  return futrts_mul_hi64(a, b) + c;
}

static uniform int32_t futrts_clzz8(uniform int8_t x) {
  return count_leading_zeros((uniform int32_t)(uniform uint8_t)x)-24;
}

static uniform int32_t futrts_clzz16(uniform int16_t x) {
  return count_leading_zeros((uniform int32_t)(uniform uint16_t)x)-16;
}

static uniform int32_t futrts_clzz32(uniform int32_t x) {
  return count_leading_zeros(x);
}

static uniform int32_t futrts_clzz64(uniform int64_t x) {
  return count_leading_zeros(x);
}

static uniform int32_t futrts_ctzz8(uniform int8_t x) {
  return x == 0 ? 8 : count_trailing_zeros((uniform int32_t)x);
}

static uniform int32_t futrts_ctzz16(uniform int16_t x) {
  return x == 0 ? 16 : count_trailing_zeros((uniform int32_t)x);
}

static uniform int32_t futrts_ctzz32(uniform int32_t x) {
  return count_trailing_zeros(x);
}

static uniform int32_t futrts_ctzz64(uniform int64_t x) {
  return count_trailing_zeros(x);
}


static inline uniform float fdiv32(uniform float x, uniform float y) {
  return x / y;
}

static inline uniform float fadd32(uniform float x, uniform float y) {
  return x + y;
}

static inline uniform float fsub32(uniform float x, uniform float y) {
  return x - y;
}

static inline uniform float fmul32(uniform float x, uniform float y) {
  return x * y;
}

static inline uniform bool cmplt32(uniform float x, uniform float y) {
  return x < y;
}

static inline uniform bool cmple32(uniform float x, uniform float y) {
  return x <= y;
}

static inline uniform float sitofp_i8_f32(uniform int8_t x) {
  return (uniform float) x;
}

static inline uniform float sitofp_i16_f32(uniform int16_t x) {
  return (uniform float) x;
}

static inline uniform float sitofp_i32_f32(uniform int32_t x) {
  return (uniform float) x;
}

static inline uniform float sitofp_i64_f32(uniform int64_t x) {
  return (uniform float) x;
}

static inline uniform float uitofp_i8_f32(uniform uint8_t x) {
  return (uniform float) x;
}

static inline uniform float uitofp_i16_f32(uniform uint16_t x) {
  return (uniform float) x;
}

static inline uniform float uitofp_i32_f32(uniform uint32_t x) {
  return (uniform float) x;
}

static inline uniform float uitofp_i64_f32(uniform uint64_t x) {
  return (uniform float) x;
}


static inline uniform float fabs32(uniform float x) {
  return abs(x);
}

static inline uniform float fmax32(uniform float x, uniform float y) {
  return isnan(x) ? y : isnan(y) ? x : max(x, y);
}

static inline uniform float fmin32(uniform float x, uniform float y) {
  return isnan(x) ? y : isnan(y) ? x : min(x, y);
}

static inline uniform float fpow32(uniform float x, uniform float y) {
  return __stdlib_powf(x, y);
}

static inline uniform bool futrts_isnan32(uniform float x) {
  return isnan(x);
}

static inline uniform bool futrts_isinf32(uniform float x) {
  return !isnan(x) && isnan(x - x);
}
static inline uniform bool futrts_isfinite32(uniform float x) {
  return !isnan(x) && !futrts_isinf32(x);
}


static inline uniform int8_t fptosi_f32_i8(uniform float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uniform int8_t) x;
  }
}

static inline uniform int16_t fptosi_f32_i16(uniform float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uniform int16_t) x;
  }
}

static inline uniform int32_t fptosi_f32_i32(uniform float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uniform int32_t) x;
  }
}

static inline uniform int64_t fptosi_f32_i64(uniform float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uniform int64_t) x;
  };
}

static inline uniform uint8_t fptoui_f32_i8(uniform float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uniform uint8_t) (uniform int8_t) x;
  }
}

static inline uniform uint16_t fptoui_f32_i16(uniform float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uniform uint16_t) (uniform int16_t) x;
  }
}

static inline uniform uint32_t fptoui_f32_i32(uniform float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uniform uint32_t) (uniform int32_t) x;
  }
}

static inline uniform uint64_t fptoui_f32_i64(uniform float x) {
  if (futrts_isnan32(x) || futrts_isinf32(x)) {
    return 0;
  } else {
    return (uniform uint64_t) (uniform int64_t) x;
  }
}


static inline uniform float futrts_log32(uniform float x) {
  return futrts_isfinite32(x) || (futrts_isinf32(x) && x < 0)? log(x) : x;
}

static inline uniform float futrts_log2_32(uniform float x) {
  return futrts_log32(x) / log(2.0f);
}

static inline uniform float futrts_log10_32(uniform float x) {
  return futrts_log32(x) / log(10.0f);
}

static inline uniform float futrts_sqrt32(uniform float x) {
  return sqrt(x);
}

extern "C" unmasked uniform float cbrtf(uniform float);
static inline uniform float futrts_cbrt32(uniform float x) {
  return cbrtf(x);
}

static inline uniform float futrts_exp32(uniform float x) {
  return exp(x);
}

static inline uniform float futrts_cos32(uniform float x) {
  return cos(x);
}

static inline uniform float futrts_sin32(uniform float x) {
  return sin(x);
}

static inline uniform float futrts_tan32(uniform float x) {
  return tan(x);
}

static inline uniform float futrts_acos32(uniform float x) {
  return acos(x);
}

static inline uniform float futrts_asin32(uniform float x) {
  return asin(x);
}

static inline uniform float futrts_atan32(uniform float x) {
  return atan(x);
}

static inline uniform float futrts_cosh32(uniform float x) {
  return (exp(x)+exp(-x)) / 2.0f;
}

static inline uniform float futrts_sinh32(uniform float x) {
  return (exp(x)-exp(-x)) / 2.0f;
}

static inline uniform float futrts_tanh32(uniform float x) {
  return futrts_sinh32(x)/futrts_cosh32(x);
}

static inline uniform float futrts_acosh32(uniform float x) {
  uniform float f = x+sqrt(x*x-1);
  if(futrts_isfinite32(f)) return log(f);
  return f;
}

static inline uniform float futrts_asinh32(uniform float x) {
  uniform float f = x+sqrt(x*x+1);
  if(futrts_isfinite32(f)) return log(f);
  return f;

}

static inline uniform float futrts_atanh32(uniform float x) {
  uniform float f = (1+x)/(1-x);
  if(futrts_isfinite32(f)) return log(f)/2.0f;
  return f;

}

static inline uniform float futrts_atan2_32(uniform float x, uniform float y) {
  return (x == 0.0f && y == 0.0f) ? 0.0f : atan2(x, y);
}

static inline uniform float futrts_hypot32(uniform float x, uniform float y) {
  if (futrts_isfinite32(x) && futrts_isfinite32(y)) {
    x = abs(x);
    y = abs(y);
    uniform float a;
    uniform float b;
    if (x >= y){
        a = x;
        b = y;
    } else {
        a = y;
        b = x;
    }
    if(b == 0){
      return a;
    }

    uniform int e;
    uniform float an;
    uniform float bn;
    an = frexp (a, &e);
    bn = ldexp (b, - e);
    uniform float cn;
    cn = sqrt (an * an + bn * bn);
    return ldexp (cn, e);
  } else {
    if (futrts_isinf32(x) || futrts_isinf32(y)) return INFINITY;
    else return x + y;
  }

}

extern "C" unmasked uniform float tgammaf(uniform float x);
static inline uniform float futrts_gamma32(uniform float x) {
  return tgammaf(x);
}

extern "C" unmasked uniform float tgammaf(uniform float x);
static inline uniform float futrts_lgamma32(uniform float x) {
  return lgammaf(x);
}

extern "C" unmasked uniform float erff(uniform float);
static inline uniform float futrts_erf32(uniform float x) {
  return erff(x);
}

extern "C" unmasked uniform float erfcf(uniform float);
static inline uniform float futrts_erfc32(uniform float x) {
  return erfcf(x);
}

static inline uniform float fmod32(uniform float x, uniform float y) {
  return x - y * trunc(x/y);
}

static inline uniform float futrts_round32(uniform float x) {
  return round(x);
}

static inline uniform float futrts_floor32(uniform float x) {
  return floor(x);
}

static inline uniform float futrts_ceil32(uniform float x) {
  return ceil(x);
}

static inline uniform float futrts_lerp32(uniform float v0, uniform float v1, uniform float t) {
  return v0 + (v1 - v0) * t;
}

static inline uniform float futrts_mad32(uniform float a, uniform float b, uniform float c) {
  return a * b + c;
}

static inline uniform float futrts_fma32(uniform float a, uniform float b, uniform float c) {
  return a * b + c;
}

static inline uniform int32_t futrts_to_bits32(uniform float x) {
  return intbits(x);
}

static inline uniform float futrts_from_bits32(uniform int32_t x) {
  return floatbits(x);
}

static inline uniform float fsignum32(uniform float x) {
  return futrts_isnan32(x) ? x : (x > 0 ? 1 : 0) - (x < 0 ? 1 : 0);
}

#ifdef FUTHARK_F64_ENABLED

static inline uniform bool futrts_isinf64(uniform float x) {
  return !isnan(x) && isnan(x - x);
}
static inline uniform bool futrts_isfinite64(uniform float x) {
  return !isnan(x) && !futrts_isinf64(x);
}

static inline uniform double fdiv64(uniform double x, uniform double y) {
  return x / y;
}

static inline uniform double fadd64(uniform double x, uniform double y) {
  return x + y;
}

static inline uniform double fsub64(uniform double x, uniform double y) {
  return x - y;
}

static inline uniform double fmul64(uniform double x, uniform double y) {
  return x * y;
}

static inline uniform bool cmplt64(uniform double x, uniform double y) {
  return x < y;
}

static inline uniform bool cmple64(uniform double x, uniform double y) {
  return x <= y;
}

static inline uniform double sitofp_i8_f64(uniform int8_t x) {
  return (uniform double) x;
}

static inline uniform double sitofp_i16_f64(uniform int16_t x) {
  return (uniform double) x;
}

static inline uniform double sitofp_i32_f64(uniform int32_t x) {
  return (uniform double) x;
}

static inline uniform double sitofp_i64_f64(uniform int64_t x) {
  return (uniform double) x;
}

static inline uniform double uitofp_i8_f64(uniform uint8_t x) {
  return (uniform double) x;
}

static inline uniform double uitofp_i16_f64(uniform uint16_t x) {
  return (uniform double) x;
}

static inline uniform double uitofp_i32_f64(uniform uint32_t x) {
  return (uniform double) x;
}

static inline uniform double uitofp_i64_f64(uniform uint64_t x) {
  return (uniform double) x;
}

static inline uniform double fabs64(uniform double x) {
  return abs(x);
}

static inline uniform double fmax64(uniform double x, uniform double y) {
  return isnan(x) ? y : isnan(y) ? x : max(x, y);
}

static inline uniform double fmin64(uniform double x, uniform double y) {
  return isnan(x) ? y : isnan(y) ? x : min(x, y);
}

static inline uniform double fpow64(uniform double x, uniform double y) {
  return __stdlib_powf(x, y);
}

static inline uniform double futrts_log64(uniform double x) {
  return futrts_isfinite64(x) || (futrts_isinf64(x) && x < 0)? log(x) : x;
}

static inline uniform double futrts_log2_64(uniform double x) {
  return futrts_log64(x)/log(2.0d);
}

static inline uniform double futrts_log10_64(uniform double x) {
  return futrts_log64(x)/log(10.0d);
}

static inline uniform double futrts_sqrt64(uniform double x) {
  return sqrt(x);
}

extern "C" unmasked uniform double cbrt(uniform double);
static inline uniform double futrts_cbrt64(uniform double x) {
  return cbrt(x);
}

static inline uniform double futrts_exp64(uniform double x) {
  return exp(x);
}

static inline uniform double futrts_cos64(uniform double x) {
  return cos(x);
}

static inline uniform double futrts_sin64(uniform double x) {
  return sin(x);
}

static inline uniform double futrts_tan64(uniform double x) {
  return tan(x);
}

static inline uniform double futrts_acos64(uniform double x) {
  return acos(x);
}

static inline uniform double futrts_asin64(uniform double x) {
  return asin(x);
}

static inline uniform double futrts_atan64(uniform double x) {
  return atan(x);
}

static inline uniform double futrts_cosh64(uniform double x) {
  return (exp(x)+exp(-x)) / 2.0d;
}

static inline uniform double futrts_sinh64(uniform double x) {
  return (exp(x)-exp(-x)) / 2.0d;
}

static inline uniform double futrts_tanh64(uniform double x) {
  return futrts_sinh64(x)/futrts_cosh64(x);
}

static inline uniform double futrts_acosh64(uniform double x) {
  uniform double f = x+sqrt(x*x-1.0d);
  if(futrts_isfinite64(f)) return log(f);
  return f;
}

static inline uniform double futrts_asinh64(uniform double x) {
  uniform double f = x+sqrt(x*x+1.0d);
  if(futrts_isfinite64(f)) return log(f);
  return f;
}

static inline uniform double futrts_atanh64(uniform double x) {
  uniform double f = (1.0d+x)/(1.0d-x);
  if(futrts_isfinite64(f)) return log(f)/2.0d;
  return f;

}

static inline uniform double futrts_atan2_64(uniform double x, uniform double y) {
  return atan2(x, y);
}

extern "C" unmasked uniform double hypot(uniform double x, uniform double y);
static inline uniform double futrts_hypot64(uniform double x, uniform double y) {
  return hypot(x, y);
}

extern "C" unmasked uniform double tgamma(uniform double x);
static inline uniform double futrts_gamma64(uniform double x) {
  return tgamma(x);
}

extern "C" unmasked uniform double lgamma(uniform double x);
static inline uniform double futrts_lgamma64(uniform double x) {
  return lgamma(x);
}

extern "C" unmasked uniform double erf(uniform double);
static inline uniform double futrts_erf64(uniform double x) {
  return erf(x);
}

extern "C" unmasked uniform double erfc(uniform double);
static inline uniform double futrts_erfc64(uniform double x) {
  return erfc(x);
}

static inline uniform double futrts_fma64(uniform double a, uniform double b, uniform double c) {
  return a * b + c;
}

static inline uniform double futrts_round64(uniform double x) {
  return round(x);
}

static inline uniform double futrts_ceil64(uniform double x) {
  return ceil(x);
}

static inline uniform double futrts_floor64(uniform double x) {
  return floor(x);
}

static inline uniform bool futrts_isnan64(uniform double x) {
  return isnan(x);
}

static inline uniform int8_t fptosi_f64_i8(uniform double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uniform int8_t) x;
  }
}

static inline uniform int16_t fptosi_f64_i16(uniform double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uniform int16_t) x;
  }
}

static inline uniform int32_t fptosi_f64_i32(uniform double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uniform int32_t) x;
  }
}

static inline uniform int64_t fptosi_f64_i64(uniform double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uniform int64_t) x;
  }
}

static inline uniform uint8_t fptoui_f64_i8(uniform double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uniform uint8_t) (uniform int8_t) x;
  }
}

static inline uniform uint16_t fptoui_f64_i16(uniform double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uniform uint16_t) (uniform int16_t) x;
  }
}

static inline uniform uint32_t fptoui_f64_i32(uniform double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uniform uint32_t) (uniform int32_t) x;
  }
}

static inline uniform uint64_t fptoui_f64_i64(uniform double x) {
  if (futrts_isnan64(x) || futrts_isinf64(x)) {
    return 0;
  } else {
    return (uniform uint64_t) (uniform int64_t) x;
  }
}

static inline uniform bool ftob_f64_bool(uniform double x) {
  return x != 0.0;
}

static inline uniform double btof_bool_f64(uniform bool x) {
  return x ? 1.0 : 0.0;
}

static inline uniform bool ftob_f32_bool(uniform float x) {
  return x != 0;
}

static inline uniform float btof_bool_f32(uniform bool x) {
  return x ? 1 : 0;
}

static inline uniform int64_t futrts_to_bits64(uniform double x) {
  return *((uniform int64_t* uniform)&x);
}

static inline uniform double futrts_from_bits64(uniform int64_t x) {
  return *((uniform double* uniform)&x);
}

static inline uniform double fmod64(uniform double x, uniform double y) {
  return x - y * trunc(x/y);
}

static inline uniform double fsignum64(uniform double x) {
  return futrts_isnan64(x) ? x : (x > 0 ? 1.0d : 0.0d) - (x < 0 ? 1.0d : 0.0d);
}

static inline uniform double futrts_lerp64(uniform double v0, uniform double v1, uniform double t) {
  return v0 + (v1 - v0) * t;
}

static inline uniform double futrts_mad64(uniform double a, uniform double b, uniform double c) {
  return a * b + c;
}

static inline uniform float fpconv_f32_f32(uniform float x) {
  return (uniform float) x;
}

static inline uniform double fpconv_f32_f64(uniform float x) {
  return (uniform double) x;
}

static inline uniform float fpconv_f64_f32(uniform double x) {
  return (uniform float) x;
}

static inline uniform double fpconv_f64_f64(uniform double x) {
  return (uniform double) x;
}

static inline uniform double fpconv_f16_f64(uniform f16 x) {
  return (uniform double) x;
}

static inline uniform f16 fpconv_f64_f16(uniform double x) {
  return (uniform f16) ((uniform float)x); 
}

#endif


static inline uniform f16 fadd16(uniform f16 x, uniform f16 y) {
  return x + y;
}

static inline uniform f16 fsub16(uniform f16 x, uniform f16 y) {
  return x - y;
}

static inline uniform f16 fmul16(uniform f16 x, uniform f16 y) {
  return x * y;
}

static inline uniform bool cmplt16(uniform f16 x, uniform f16 y) {
  return x < y;
}

static inline uniform bool cmple16(uniform f16 x, uniform f16 y) {
  return x <= y;
}

static inline uniform f16 sitofp_i8_f16(uniform int8_t x) {
  return (uniform f16) x;
}

static inline uniform f16 sitofp_i16_f16(uniform int16_t x) {
  return (uniform f16) x;
}

static inline uniform f16 sitofp_i32_f16(uniform int32_t x) {
  return (uniform f16) x;
}

static inline uniform f16 sitofp_i64_f16(uniform int64_t x) {
  return (uniform f16) x;
}

static inline uniform f16 uitofp_i8_f16(uniform uint8_t x) {
  return (uniform f16) x;
}

static inline uniform f16 uitofp_i16_f16(uniform uint16_t x) {
  return (uniform f16) x;
}

static inline uniform f16 uitofp_i32_f16(uniform uint32_t x) {
  return (uniform f16) x;
}

static inline uniform f16 uitofp_i64_f16(uniform uint64_t x) {
  return (uniform f16) x;
}

static inline uniform int8_t fptosi_f16_i8(uniform f16 x) {
  return (uniform int8_t) (uniform float) x;
}

static inline uniform int16_t fptosi_f16_i16(uniform f16 x) {
  return (uniform int16_t) x;
}

static inline uniform int32_t fptosi_f16_i32(uniform f16 x) {
  return (uniform int32_t) x;
}

static inline uniform int64_t fptosi_f16_i64(uniform f16 x) {
  return (uniform int64_t) x;
}

static inline uniform uint8_t fptoui_f16_i8(uniform f16 x) {
  return (uniform uint8_t) (uniform float) x;
}

static inline uniform uint16_t fptoui_f16_i16(uniform f16 x) {
  return (uniform uint16_t) x;
}

static inline uniform uint32_t fptoui_f16_i32(uniform f16 x) {
  return (uniform uint32_t) x;
}

static inline uniform uint64_t fptoui_f16_i64(uniform f16 x) {
  return (uniform uint64_t) x;
}

static inline uniform f16 fabs16(uniform f16 x) {
  return abs(x);
}

static inline uniform bool futrts_isnan16(uniform f16 x) {
  return isnan((uniform float)x);
}

static inline uniform f16 fmax16(uniform f16 x, uniform f16 y) {
  return futrts_isnan16(x) ? y : futrts_isnan16(y) ? x : max(x, y);
}

static inline uniform f16 fmin16(uniform f16 x, uniform f16 y) {
  return min(x, y);
}

static inline uniform f16 fpow16(uniform f16 x, uniform f16 y) {
  return pow(x, y);
}

static inline uniform bool futrts_isinf16(uniform float x) {
  return !futrts_isnan16(x) && futrts_isnan16(x - x);
}
static inline uniform bool futrts_isfinite16(uniform float x) {
  return !futrts_isnan16(x) && !futrts_isinf16(x);
}


static inline uniform f16 futrts_log16(uniform f16 x) {
  return futrts_isfinite16(x) || (futrts_isinf16(x) && x < 0)? log(x) : x;
}

static inline uniform f16 futrts_log2_16(uniform f16 x) {
  return futrts_log16(x) / log(2.0f16);
}

static inline uniform f16 futrts_log10_16(uniform f16 x) {
  return futrts_log16(x) / log(10.0f16);
}

static inline uniform f16 futrts_sqrt16(uniform f16 x) {
  return (uniform f16)sqrt((uniform float)x);
}

extern "C" unmasked uniform float cbrtf(uniform float);
static inline uniform f16 futrts_cbrt16(uniform f16 x) {
  return (uniform f16)cbrtf((uniform float)x);
}

static inline uniform f16 futrts_exp16(uniform f16 x) {
  return exp(x);
}

static inline uniform f16 futrts_cos16(uniform f16 x) {
  return (uniform f16)cos((uniform float)x);
}

static inline uniform f16 futrts_sin16(uniform f16 x) {
  return (uniform f16)sin((uniform float)x);
}

static inline uniform f16 futrts_tan16(uniform f16 x) {
  return (uniform f16)tan((uniform float)x);
}

static inline uniform f16 futrts_acos16(uniform f16 x) {
  return (uniform f16)acos((uniform float)x);
}

static inline uniform f16 futrts_asin16(uniform f16 x) {
  return (uniform f16)asin((uniform float)x);
}

static inline uniform f16 futrts_atan16(uniform f16 x) {
  return (uniform f16)atan((uniform float)x);
}

static inline uniform f16 futrts_cosh16(uniform f16 x) {
  return (exp(x)+exp(-x)) / 2.0f16;
}

static inline uniform f16 futrts_sinh16(uniform f16 x) {
  return (exp(x)-exp(-x)) / 2.0f16;
}

static inline uniform f16 futrts_tanh16(uniform f16 x) {
  return futrts_sinh16(x)/futrts_cosh16(x);
}

static inline uniform f16 futrts_acosh16(uniform f16 x) {
  uniform f16 f = x+(uniform f16)sqrt((uniform float)(x*x-1));
  if(futrts_isfinite16(f)) return log(f);
  return f;
}

static inline uniform f16 futrts_asinh16(uniform f16 x) {
  uniform f16 f = x+(uniform f16)sqrt((uniform float)(x*x+1));
  if(futrts_isfinite16(f)) return log(f);
  return f;
}

static inline uniform f16 futrts_atanh16(uniform f16 x) {
  uniform f16 f = (1+x)/(1-x);
  if(futrts_isfinite16(f)) return log(f)/2.0f16;
  return f;
}

static inline uniform f16 futrts_atan2_16(uniform f16 x, uniform f16 y) {
  return (uniform f16)atan2((uniform float)x, (uniform float)y);
}

static inline uniform f16 futrts_hypot16(uniform f16 x, uniform f16 y) {
  return (uniform f16)futrts_hypot32((uniform float)x, (uniform float)y);
}

extern "C" unmasked uniform float tgammaf(uniform float x);
static inline uniform f16 futrts_gamma16(uniform f16 x) {
  return (uniform f16)tgammaf((uniform float)x);
}

extern "C" unmasked uniform float lgammaf(uniform float x);
static inline uniform f16 futrts_lgamma16(uniform f16 x) {
  return (uniform f16)lgammaf((uniform float)x);
}

extern "C" unmasked uniform float erff(uniform float);
static inline uniform f16 futrts_erf32(uniform f16 x) {
  return (uniform f16)erff((uniform float)x);
}

extern "C" unmasked uniform float erfcf(uniform float);
static inline uniform f16 futrts_erfc32(uniform f16 x) {
  return (uniform f16)erfcf((uniform float)x);
}

static inline uniform f16 fmod16(uniform f16 x, uniform f16 y) {
  return x - y * (uniform f16)trunc((uniform float) (x/y));
}

static inline uniform f16 futrts_round16(uniform f16 x) {
  return (uniform f16)round((uniform float)x);
}

static inline uniform f16 futrts_floor16(uniform f16 x) {
  return (uniform f16)floor((uniform float)x);
}

static inline uniform f16 futrts_ceil16(uniform f16 x) {
  return (uniform f16)ceil((uniform float)x);
}

static inline uniform f16 futrts_lerp16(uniform f16 v0, uniform f16 v1, uniform f16 t) {
  return v0 + (v1 - v0) * t;
}

static inline uniform f16 futrts_mad16(uniform f16 a, uniform f16 b, uniform f16 c) {
  return a * b + c;
}

static inline uniform f16 futrts_fma16(uniform f16 a, uniform f16 b, uniform f16 c) {
  return a * b + c;
}

static inline uniform int16_t futrts_to_bits16(uniform f16 x) {
  return *((uniform int16_t *)&x);
}

static inline uniform f16 futrts_from_bits16(uniform int16_t x) {
  return *((uniform f16 *)&x);
}

static inline uniform float fpconv_f16_f16(uniform f16 x) {
  return x;
}

static inline uniform float fpconv_f16_f32(uniform f16 x) {
  return x;
}

static inline uniform f16 fpconv_f32_f16(uniform float x) {
  return (uniform f16) x;
}
#endif

// End of uniform.h.

// Start of ispc_util.h.

// This header file implements various operations that are useful only when
// generating ISPC code. This includes wrappers for parts of Futhark's C runtime.

// Expose gang size
export uniform int64_t get_gang_size() {
  return programCount;
}

// Generate missing overloads for extract on pointers
#define make_extract(ty)                                                                \
static inline uniform ty * uniform extract(uniform ty * varying ptr, uniform int idx) { \
    int64 c = (int64)ptr;                                                               \
    uniform int64 r = extract(c, idx);                                                  \
    return (uniform ty * uniform)r;                                                     \
}

make_extract(int8)
make_extract(int16)
make_extract(int32)
make_extract(int64)
make_extract(uint8)
make_extract(uint16)
make_extract(uint32)
make_extract(uint64)
make_extract(float16)
make_extract(float)
make_extract(double)
make_extract(int8* uniform)
make_extract(int16* uniform)
make_extract(int32* uniform)
make_extract(int64* uniform)
make_extract(uint8* uniform)
make_extract(uint16* uniform)
make_extract(uint32* uniform)
make_extract(uint64* uniform)
make_extract(float16* uniform)
make_extract(float* uniform)
make_extract(double* uniform)
make_extract(struct futhark_context)
make_extract(struct memblock)


// Handling of atomics
// Atomic CAS acts differently in GCC and ISPC, so we emulate it.
#define make_atomic_compare_exchange_wrapper(ty)                                     \
static inline uniform bool atomic_compare_exchange_wrapper(uniform ty * uniform mem, \
                                                           uniform ty * uniform old, \
                                                           const uniform ty val){    \
  uniform ty actual = atomic_compare_exchange_global(mem, *old, val);                \
  if (actual == *old){                                                               \
    return 1;                                                                        \
  }                                                                                  \
  *old = actual;                                                                     \
  return 0;                                                                          \
}                                                                                    \
static inline varying bool atomic_compare_exchange_wrapper(uniform ty * varying mem, \
                                                           varying ty * uniform old, \
                                                           const varying ty val){    \
  varying ty actual = atomic_compare_exchange_global(mem, *old, val);                \
  bool res = 0;                                                                      \
  if(actual == *old){                                                                \
    res = 1;                                                                         \
  } else {                                                                           \
    *old = actual;                                                                   \
  }                                                                                  \
  return res;                                                                        \
}                                                                                    \
static inline varying bool atomic_compare_exchange_wrapper(varying ty * uniform mem, \
                                                           varying ty * uniform old, \
                                                           const varying ty val){    \
  uniform ty * uniform base_mem = (uniform ty * uniform)mem;                         \
  uniform ty * uniform base_old = (uniform ty * uniform)old;                         \
  bool res = 0;                                                                      \
  foreach_active (i) {                                                               \
    uniform ty * uniform curr_mem = base_mem + i;                                    \
    uniform ty * uniform curr_old = base_old + i;                                    \
    uniform ty curr_val = extract(val, i);                                           \
    uniform bool curr = atomic_compare_exchange_wrapper(                             \
                            curr_mem, curr_old, curr_val);                           \
    res = insert(res, i, curr);                                                      \
  }                                                                                  \
  return res;                                                                        \
}                                                                                    \
static inline uniform bool atomic_compare_exchange_wrapper(uniform ty * uniform mem, \
                                                           uniform ty * uniform old, \
                                                           const varying ty val){    \
  uniform ty v = 0;                                                                  \
  foreach_active (i) v = extract(val, i);                                            \
  return atomic_compare_exchange_wrapper(mem, old, v);                               \
}

make_atomic_compare_exchange_wrapper(int32)
make_atomic_compare_exchange_wrapper(int64)
make_atomic_compare_exchange_wrapper(uint32)
make_atomic_compare_exchange_wrapper(uint64)
make_atomic_compare_exchange_wrapper(float)
make_atomic_compare_exchange_wrapper(double)

// This code generates missing overloads for atomic operations on uniform
// pointers to varying values.
#define make_single_atomic(name, ty)                                        \
static inline ty atomic_##name##_global(varying ty * uniform mem, ty val) { \
  uniform ty * uniform base_mem = (uniform ty * uniform)mem;                \
  ty res = 0;                                                               \
  foreach_active (i) {                                                      \
    uniform ty * uniform curr_mem = base_mem + i;                           \
    uniform ty curr_val = extract(val, i);                                  \
    uniform ty curr = atomic_##name##_global(curr_mem, curr_val);           \
    res = insert(res, i, curr);                                             \
  }                                                                         \
  return res;                                                               \
}

#define make_all_atomic(name)    \
make_single_atomic(name, int32)  \
make_single_atomic(name, int64)  \
make_single_atomic(name, uint32) \
make_single_atomic(name, uint64)

make_all_atomic(add)
make_all_atomic(subtract)
make_all_atomic(and)
make_all_atomic(or)
make_all_atomic(xor)
make_all_atomic(swap)

// This is a hack to prevent literals (which have unbound variability)
// from causing us to pick the wrong overload for atomic operations.
static inline varying int32  make_varying(uniform int32  x) { return x; }
static inline varying int32  make_varying(varying int32  x) { return x; }
static inline varying int64  make_varying(uniform int64  x) { return x; }
static inline varying int64  make_varying(varying int64  x) { return x; }
static inline varying uint32 make_varying(uniform uint32 x) { return x; }
static inline varying uint32 make_varying(varying uint32 x) { return x; }
static inline varying uint64 make_varying(uniform uint64 x) { return x; }
static inline varying uint64 make_varying(varying uint64 x) { return x; }

// Redirect atomic operations to the relevant ISPC overloads.
#define __atomic_fetch_add(x,y,z) atomic_add_global(x,make_varying(y))
#define __atomic_fetch_sub(x,y,z) atomic_sub_global(x,make_varying(y))
#define __atomic_fetch_and(x,y,z) atomic_and_global(x,make_varying(y))
#define __atomic_fetch_or(x,y,z) atomic_or_global(x,make_varying(y))
#define __atomic_fetch_xor(x,y,z) atomic_xor_global(x,make_varying(y))
#define __atomic_exchange_n(x,y,z) atomic_swap_global(x,make_varying(y))
#define __atomic_compare_exchange_n(x,y,z,h,j,k) atomic_compare_exchange_wrapper(x,y,z)


// Memory allocation handling
struct memblock {
    int32_t * references;
    uint8_t * mem;
    int64_t size;
    const int8_t * desc;
};

static inline void free(void* ptr) {
  delete ptr;
}

static inline void free(void* uniform ptr) {
  delete ptr;
}

extern "C" unmasked uniform unsigned char * uniform realloc(uniform unsigned char * uniform ptr, uniform int64_t new_size);
extern "C" unmasked uniform char * uniform lexical_realloc_error(uniform struct futhark_context * uniform ctx, uniform int64_t new_size);

static inline uniform int lexical_realloc(uniform struct futhark_context * uniform ctx,
                                          unsigned char uniform * uniform * uniform ptr,
                                          int64_t uniform * uniform old_size,
                                          uniform int64_t new_size) {
  uniform unsigned char * uniform memptr = realloc(*ptr, new_size);
  if (memptr == NULL) {
    lexical_realloc_error(ctx, new_size);
    return FUTHARK_OUT_OF_MEMORY;
  } else {
    *ptr = memptr;
    *old_size = new_size;
    return FUTHARK_SUCCESS;
  }
}


static inline uniform int lexical_realloc(uniform struct futhark_context *ctx,
                                          unsigned char uniform * uniform * uniform ptr,
                                          int64_t uniform * uniform old_size,
                                          varying int64_t new_size) {
  return lexical_realloc(ctx, ptr, old_size, reduce_max(new_size));
}

static inline uniform int lexical_realloc(uniform struct futhark_context * uniform ctx,
                                          unsigned char uniform * varying * uniform ptr,
                                          int64_t uniform * varying old_size,
                                          varying int64_t new_size) {
  uniform int err = FUTHARK_SUCCESS;
  foreach_active(i){
    uniform unsigned char * uniform memptr = realloc(extract(*ptr,i), extract(new_size,i));
    if (memptr == NULL) {
      lexical_realloc_error(ctx, extract(new_size,i));
      err = FUTHARK_OUT_OF_MEMORY;
    } else {
      *ptr = (uniform unsigned char * varying)insert((int64_t)*ptr, i, (uniform int64_t) memptr);
      *old_size = new_size;
    }
  }
  return err;
}

static inline uniform int lexical_realloc(uniform struct futhark_context * uniform ctx,
                                          unsigned char uniform * varying * uniform ptr,
                                          int64_t varying * uniform old_size,
                                          varying int64_t new_size) {
  uniform int err = FUTHARK_SUCCESS;
  foreach_active(i){
    uniform unsigned char * uniform memptr = realloc(extract(*ptr,i), extract(new_size,i));
    if (memptr == NULL) {
      lexical_realloc_error(ctx, extract(new_size,i));
      err = FUTHARK_OUT_OF_MEMORY;
    } else {
      *ptr = (uniform unsigned char * varying)insert((int64_t)*ptr, i, (uniform int64_t) memptr);
      *old_size = new_size;
    }
  }
  return err;
}

static inline uniform int lexical_realloc(uniform struct futhark_context * uniform ctx,
                                          unsigned char uniform * varying * uniform ptr,
                                          size_t varying * uniform old_size,
                                          varying int64_t new_size) {
  return lexical_realloc(ctx, ptr, (varying int64_t * uniform)old_size, new_size);
}

static inline uniform int lexical_realloc(uniform struct futhark_context * uniform ctx,
                                          unsigned char varying * uniform * uniform ptr,
                                          size_t varying * uniform old_size,
                                          uniform int64_t new_size) {
  uniform int err = FUTHARK_SUCCESS;
  uniform unsigned char * uniform memptr = realloc((uniform unsigned char * uniform )*ptr,
                                                        new_size*programCount);
  if (memptr == NULL) {
    lexical_realloc_error(ctx, new_size);
    err = FUTHARK_OUT_OF_MEMORY;
  } else {
    *ptr = (varying unsigned char * uniform)memptr;
    *old_size = new_size;
  }

  return err;
}

static inline uniform int lexical_realloc(uniform struct futhark_context * uniform ctx,
                                          unsigned char varying * uniform * uniform ptr,
                                          size_t varying * uniform old_size,
                                          varying int64_t new_size) {
  return lexical_realloc(ctx, ptr, old_size, reduce_max(new_size));
}

extern "C" unmasked uniform int memblock_unref(uniform struct futhark_context * uniform ctx,
                                               uniform struct memblock * uniform lhs,
                                               uniform const char * uniform lhs_desc);

static uniform int memblock_unref(uniform struct futhark_context * varying ctx,
                                  uniform struct memblock * varying lhs,
                                  uniform const char * uniform lhs_desc)
{
  uniform int err = 0;

  foreach_active(i) {
    err |= memblock_unref(extract(ctx,i), extract(lhs,i), lhs_desc);
  }

  return err;
}
static uniform int memblock_unref(uniform struct futhark_context * uniform ctx,
                                  varying struct memblock * uniform lhs,
                                  uniform const char * uniform lhs_desc)
{
  uniform int err = 0;

  varying struct memblock _lhs = *lhs;
  uniform struct memblock aos[programCount];
  aos[programIndex] = _lhs;

  foreach_active(i){
    err |= memblock_unref(ctx,
           &aos[i],
           lhs_desc);
  }

  *lhs = aos[programIndex];

  return err;
}

extern "C" unmasked uniform int memblock_alloc(uniform struct futhark_context * uniform ctx,
                                               uniform struct memblock * uniform block,
                                               uniform int64_t size,
                                               uniform const char * uniform block_desc);

static uniform int memblock_alloc(uniform struct futhark_context * varying ctx,
                                  uniform struct memblock * varying block,
                                  varying int64_t size,
                                  uniform const char * uniform block_desc) {
  uniform int err = 0;

  foreach_active(i){
    err |= memblock_alloc(extract(ctx,i), extract(block,i), extract(size, i), block_desc);
  }

  return err;
}

static uniform int memblock_alloc(uniform struct futhark_context * uniform ctx,
                                  varying struct memblock * uniform block,
                                  uniform int64_t size,
                                  uniform const char * uniform block_desc) {
  uniform int err = 0;

  varying struct memblock _block = *block;
  uniform struct memblock aos[programCount];
  aos[programIndex] = _block;

  foreach_active(i){
    err |= memblock_alloc(ctx, &aos[i], size, block_desc);
  }
  *block = aos[programIndex];

  return err;
}

static uniform int memblock_alloc(uniform struct futhark_context * uniform ctx,
                                  varying struct memblock * uniform block,
                                  varying int64_t size,
                                  uniform const char * uniform block_desc) {
  uniform int err = 0;

  varying struct memblock _block = *block;
  uniform struct memblock aos[programCount];
  aos[programIndex] = _block;
  foreach_active(i){
    err |= memblock_alloc(ctx, &aos[i], extract(size, i), block_desc);
  }
  *block = aos[programIndex];

  return err;
}

extern "C" unmasked uniform int memblock_set(uniform struct futhark_context * uniform ctx,
                                             uniform struct memblock * uniform lhs,
                                             uniform struct memblock * uniform rhs,
                                             uniform const char * uniform lhs_desc);

static uniform int memblock_set (uniform struct futhark_context * uniform ctx,
                                 varying struct memblock * uniform lhs,
                                 varying struct memblock * uniform rhs,
                                 uniform const char * uniform lhs_desc) {
  uniform int err = 0;

  varying struct memblock _lhs = *lhs;
  varying struct memblock _rhs = *rhs;
  uniform struct memblock aos1[programCount];
  aos1[programIndex] = _lhs;

  uniform struct memblock aos2[programCount];
  aos2[programIndex] = _rhs;

  foreach_active(i) {
      err |= memblock_set(ctx,
      &aos1[i],
      &aos2[i],
      lhs_desc);
  }
  *lhs = aos1[programIndex];
  *rhs = aos2[programIndex];

  return err;
}

static uniform int memblock_set (uniform struct futhark_context * uniform ctx,
                                 varying struct memblock * uniform lhs,
                                 uniform struct memblock * uniform rhs,
                                 uniform const char * uniform lhs_desc) {
  uniform int err = 0;

  varying struct memblock _lhs = *lhs;
  uniform struct memblock aos1[programCount];
  aos1[programIndex] = _lhs;

  foreach_active(i) {
      err |= memblock_set(ctx,
      &aos1[i],
      rhs,
      lhs_desc);
  }
  *lhs = aos1[programIndex];

  return err;
}

// AOS <-> SOA memcpy functions
#define memmove_sized(dim)                                                                                      \
static inline void memmove_##dim(varying uint8 * uniform dst, uniform uint8 * varying src, uniform int64_t n) { \
    uniform uint##dim * varying srcp = (uniform uint##dim * varying) src;                                       \
    varying uint##dim * uniform dstp = (varying uint##dim * uniform) dst;                                       \
    for (uniform int64_t i = 0; i < n / (dim / 8); i++) {                                                       \
        dstp[i] = srcp[i];                                                                                      \
    }                                                                                                           \
}                                                                                                               \
static inline void memmove_##dim(uniform uint8 * varying dst, varying uint8 * uniform src, uniform int64_t n) { \
    varying uint##dim * uniform srcp = (varying uint##dim * uniform) src;                                       \
    uniform uint##dim * varying dstp = (uniform uint##dim * varying) dst;                                       \
    for (uniform int64_t i = 0; i < n / (dim / 8); i++) {                                                       \
        dstp[i] = srcp[i];                                                                                      \
    }                                                                                                           \
}                                                                                                               \
static inline void memmove_##dim(varying uint8 * uniform dst, varying uint8 * uniform src, uniform int64_t n) { \
    varying uint##dim * uniform srcp = (varying uint##dim * uniform) src;                                       \
    varying uint##dim * uniform dstp = (varying uint##dim * uniform) dst;                                       \
    for (uniform int64_t i = 0; i < n / (dim / 8); i++) {                                                       \
        dstp[i] = srcp[i];                                                                                      \
    }                                                                                                           \
}                                                                                                               \
static inline void memmove_##dim(varying uint8 * varying dst, uniform uint8 * varying src, uniform int64_t n) { \
    foreach_unique (ptr in dst) {                                                                               \
        memmove_##dim(ptr, src, n);                                                                             \
    }                                                                                                           \
}                                                                                                               \
static inline void memmove_##dim(uniform uint8 * varying dst, varying uint8 * varying src, uniform int64_t n) { \
    foreach_unique (ptr in src) {                                                                               \
        memmove_##dim(dst, ptr, n);                                                                             \
    }                                                                                                           \
}                                                                                                               \
static inline void memmove_##dim(varying uint8 * varying dst, varying uint8 * uniform src, uniform int64_t n) { \
    foreach_unique (ptr in dst) {                                                                               \
        memmove_##dim(ptr, src, n);                                                                             \
    }                                                                                                           \
}                                                                                                               \
static inline void memmove_##dim(varying uint8 * varying dst, varying uint8 * varying src, uniform int64_t n) { \
    if (reduce_equal((varying int64_t)dst)) {                                                                   \
        foreach_unique (ptr in src) {                                                                           \
            memmove_##dim(dst, ptr, n);                                                                         \
        }                                                                                                       \
    } else {                                                                                                    \
        foreach_unique (ptr in dst) {                                                                           \
            memmove_##dim(ptr, src, n);                                                                         \
        }                                                                                                       \
    }                                                                                                           \
}
memmove_sized(8)
memmove_sized(16)
memmove_sized(32)
memmove_sized(64)

// End of ispc_util.h.

struct futhark_mc_task_18448 {
    struct futhark_context *ctx;
    int64_t free_p_12353;
    int64_t free_q_12354;
    unsigned char *free_coefficientss_mem_17026;
    int64_t free_bytes_17028;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
};
struct futhark_mc_param_struct_18455 {
    struct futhark_context *ctx;
    int64_t free_p_12353;
    int64_t free_q_12354;
    unsigned char *free_coefficientss_mem_17026;
    int64_t free_bytes_17028;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18460();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18461();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18462();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18463();
struct futhark_mc_mem_struct_18464 {
    varying unsigned char *uniform mem_17038;
    varying size_t mem_17038_cached_sizze_18457;
    varying unsigned char *uniform mem_17041;
    varying size_t mem_17041_cached_sizze_18458;
    varying unsigned char *uniform mem_17044;
    varying size_t mem_17044_cached_sizze_18459;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18466();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18467();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18468();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18469();
static unmasked inline uniform int futhark_mc_inner_ispc_18465(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18455 *uniform futhark_mc_param_struct_18455_, uniform struct futhark_mc_mem_struct_18464 *uniform futhark_mc_mem_struct_18464_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18455_->ctx;
    uniform int64_t p_12353 = futhark_mc_param_struct_18455_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18455_->free_q_12354;
    uniform struct memblock coefficientss_mem_17026;
    
    coefficientss_mem_17026.desc = futhark_mc_strlit_shim_18466();
    coefficientss_mem_17026.mem = futhark_mc_param_struct_18455_->free_coefficientss_mem_17026;
    coefficientss_mem_17026.size = 0;
    coefficientss_mem_17026.references = NULL;
    
    uniform int64_t bytes_17028 = futhark_mc_param_struct_18455_->free_bytes_17028;
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18467();
    mem_17078.mem = futhark_mc_param_struct_18455_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18468();
    mem_17082.mem = futhark_mc_param_struct_18455_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18469();
    mem_17086.mem = futhark_mc_param_struct_18455_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    varying unsigned char *uniform mem_17038 = futhark_mc_mem_struct_18464_->mem_17038;
    size_t mem_17038_cached_sizze_18457 = futhark_mc_mem_struct_18464_->mem_17038_cached_sizze_18457;
    varying unsigned char *uniform mem_17041 = futhark_mc_mem_struct_18464_->mem_17041;
    size_t mem_17041_cached_sizze_18458 = futhark_mc_mem_struct_18464_->mem_17041_cached_sizze_18458;
    varying unsigned char *uniform mem_17044 = futhark_mc_mem_struct_18464_->mem_17044;
    size_t mem_17044_cached_sizze_18459 = futhark_mc_mem_struct_18464_->mem_17044_cached_sizze_18459;
    uniform int err = 0;
    uniform int64_t start_17173;
    uniform int64_t end_17174;
    
    start_17173 = start;
    end_17174 = end;
    
    uniform int64_t n_17175 = end_17174 - start_17173;
    
    if (mem_17038_cached_sizze_18457 < bytes_17028) {
        err = lexical_realloc(ctx, &mem_17038, &mem_17038_cached_sizze_18457, bytes_17028);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17041_cached_sizze_18458 < bytes_17028) {
        err = lexical_realloc(ctx, &mem_17041, &mem_17041_cached_sizze_18458, bytes_17028);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17044_cached_sizze_18459 < bytes_17028) {
        err = lexical_realloc(ctx, &mem_17044, &mem_17044_cached_sizze_18459, bytes_17028);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    foreach (SegMap_i_17176 = start_17173 ... start_17173 + n_17175)
    {
        uniform int64_t slice_17177 = p_12353;
        int64_t gtid_15977 = SegMap_i_17176;
        int64_t remnant_17178 = SegMap_i_17176 - gtid_15977;
        
        for (uniform int64_t i_17163 = 0; i_17163 < q_12354; i_17163++) {
            int64_t defunc_0_f_res_17167;
            
            defunc_0_f_res_17167 = ((int64_t *) coefficientss_mem_17026.mem)[gtid_15977 * ((int64_t) 3 * q_12354) + i_17163 * (int64_t) 3];
            
            int64_t defunc_0_f_res_17168;
            
            defunc_0_f_res_17168 = ((int64_t *) coefficientss_mem_17026.mem)[gtid_15977 * ((int64_t) 3 * q_12354) + i_17163 * (int64_t) 3 + (int64_t) 1];
            
            int64_t defunc_0_f_res_17169;
            
            defunc_0_f_res_17169 = ((int64_t *) coefficientss_mem_17026.mem)[gtid_15977 * ((int64_t) 3 * q_12354) + i_17163 * (int64_t) 3 + (int64_t) 2];
            ((varying int64_t *) mem_17038)[i_17163] = defunc_0_f_res_17167;
            ((varying int64_t *) mem_17041)[i_17163] = defunc_0_f_res_17168;
            ((varying int64_t *) mem_17044)[i_17163] = defunc_0_f_res_17169;
        }
        if (q_12354 * (int64_t) 8 > 0)
            memmove_64(mem_17078.mem + gtid_15977 * q_12354 * (int64_t) 8, mem_17038 + (int64_t) 0, extract(q_12354 * (int64_t) 8, 0));
        if (q_12354 * (int64_t) 8 > 0)
            memmove_64(mem_17082.mem + gtid_15977 * q_12354 * (int64_t) 8, mem_17041 + (int64_t) 0, extract(q_12354 * (int64_t) 8, 0));
        if (q_12354 * (int64_t) 8 > 0)
            memmove_64(mem_17086.mem + gtid_15977 * q_12354 * (int64_t) 8, mem_17044 + (int64_t) 0, extract(q_12354 * (int64_t) 8, 0));
    }
    futhark_mc_mem_struct_18464_->mem_17038 = mem_17038;
    futhark_mc_mem_struct_18464_->mem_17038_cached_sizze_18457 = mem_17038_cached_sizze_18457;
    futhark_mc_mem_struct_18464_->mem_17041 = mem_17041;
    futhark_mc_mem_struct_18464_->mem_17041_cached_sizze_18458 = mem_17041_cached_sizze_18458;
    futhark_mc_mem_struct_18464_->mem_17044 = mem_17044;
    futhark_mc_mem_struct_18464_->mem_17044_cached_sizze_18459 = mem_17044_cached_sizze_18459;
    return err;
}
export uniform int futhark_mc_loop_ispc_18456(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18455 *uniform futhark_mc_param_struct_18455_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18455_->ctx;
    uniform int64_t p_12353 = futhark_mc_param_struct_18455_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18455_->free_q_12354;
    uniform struct memblock coefficientss_mem_17026;
    
    coefficientss_mem_17026.desc = futhark_mc_strlit_shim_18460();
    coefficientss_mem_17026.mem = futhark_mc_param_struct_18455_->free_coefficientss_mem_17026;
    coefficientss_mem_17026.size = 0;
    coefficientss_mem_17026.references = NULL;
    
    uniform int64_t bytes_17028 = futhark_mc_param_struct_18455_->free_bytes_17028;
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18461();
    mem_17078.mem = futhark_mc_param_struct_18455_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18462();
    mem_17082.mem = futhark_mc_param_struct_18455_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18463();
    mem_17086.mem = futhark_mc_param_struct_18455_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    size_t mem_17038_cached_sizze_18457 = 0;
    varying unsigned char *uniform mem_17038 = NULL;
    size_t mem_17041_cached_sizze_18458 = 0;
    varying unsigned char *uniform mem_17041 = NULL;
    size_t mem_17044_cached_sizze_18459 = 0;
    varying unsigned char *uniform mem_17044 = NULL;
    uniform struct futhark_mc_mem_struct_18464 futhark_mc_mem_struct_18464_;
    
    futhark_mc_mem_struct_18464_.mem_17038 = mem_17038;
    futhark_mc_mem_struct_18464_.mem_17038_cached_sizze_18457 = mem_17038_cached_sizze_18457;
    futhark_mc_mem_struct_18464_.mem_17041 = mem_17041;
    futhark_mc_mem_struct_18464_.mem_17041_cached_sizze_18458 = mem_17041_cached_sizze_18458;
    futhark_mc_mem_struct_18464_.mem_17044 = mem_17044;
    futhark_mc_mem_struct_18464_.mem_17044_cached_sizze_18459 = mem_17044_cached_sizze_18459;
    
    uniform int err = futhark_mc_inner_ispc_18465(start, end, futhark_mc_param_struct_18455_, &futhark_mc_mem_struct_18464_);
    
    mem_17038 = futhark_mc_mem_struct_18464_.mem_17038;
    mem_17038_cached_sizze_18457 = futhark_mc_mem_struct_18464_.mem_17038_cached_sizze_18457;
    mem_17041 = futhark_mc_mem_struct_18464_.mem_17041;
    mem_17041_cached_sizze_18458 = futhark_mc_mem_struct_18464_.mem_17041_cached_sizze_18458;
    mem_17044 = futhark_mc_mem_struct_18464_.mem_17044;
    mem_17044_cached_sizze_18459 = futhark_mc_mem_struct_18464_.mem_17044_cached_sizze_18459;
    
  cleanup:
    {
        free(mem_17038);
        free(mem_17041);
        free(mem_17044);
    }
    return err;
}
struct futhark_mc_param_struct_18476 {
    struct futhark_context *ctx;
    int64_t free_p_12353;
    int64_t free_q_12354;
    unsigned char *free_coefficientss_mem_17026;
    int64_t free_bytes_17028;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18478();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18479();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18480();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18481();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18482();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18483();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18484();
struct futhark_mc_task_18485 {
    struct futhark_context *ctx;
    int64_t free_q_12354;
    int64_t free_gtid_15983;
    unsigned char *free_coefficientss_mem_17026;
    unsigned char *free_mem_17029;
    unsigned char *free_mem_17032;
    unsigned char *free_mem_17035;
};
struct futhark_mc_param_struct_18489 {
    struct futhark_context *ctx;
    int64_t free_q_12354;
    int64_t free_gtid_15983;
    unsigned char *free_coefficientss_mem_17026;
    unsigned char *free_mem_17029;
    unsigned char *free_mem_17032;
    unsigned char *free_mem_17035;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18491();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18492();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18493();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18494();
export uniform int futhark_mc_loop_ispc_18490(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18489 *uniform futhark_mc_param_struct_18489_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18489_->ctx;
    uniform int64_t q_12354 = futhark_mc_param_struct_18489_->free_q_12354;
    uniform int64_t gtid_15983 = futhark_mc_param_struct_18489_->free_gtid_15983;
    uniform struct memblock coefficientss_mem_17026;
    
    coefficientss_mem_17026.desc = futhark_mc_strlit_shim_18491();
    coefficientss_mem_17026.mem = futhark_mc_param_struct_18489_->free_coefficientss_mem_17026;
    coefficientss_mem_17026.size = 0;
    coefficientss_mem_17026.references = NULL;
    
    uniform struct memblock mem_17029;
    
    mem_17029.desc = futhark_mc_strlit_shim_18492();
    mem_17029.mem = futhark_mc_param_struct_18489_->free_mem_17029;
    mem_17029.size = 0;
    mem_17029.references = NULL;
    
    uniform struct memblock mem_17032;
    
    mem_17032.desc = futhark_mc_strlit_shim_18493();
    mem_17032.mem = futhark_mc_param_struct_18489_->free_mem_17032;
    mem_17032.size = 0;
    mem_17032.references = NULL;
    
    uniform struct memblock mem_17035;
    
    mem_17035.desc = futhark_mc_strlit_shim_18494();
    mem_17035.mem = futhark_mc_param_struct_18489_->free_mem_17035;
    mem_17035.size = 0;
    mem_17035.references = NULL;
    
    uniform int err = 0;
    uniform int64_t start_17195;
    uniform int64_t end_17196;
    
    start_17195 = start;
    end_17196 = end;
    
    uniform int64_t n_17197 = end_17196 - start_17195;
    
    foreach (SegMap_i_17198 = start_17195 ... start_17195 + n_17197)
    {
        uniform int64_t slice_17199 = q_12354;
        int64_t gtid_17184 = SegMap_i_17198;
        int64_t remnant_17200 = SegMap_i_17198 - gtid_17184;
        int64_t defunc_0_f_res_17185;
        
        defunc_0_f_res_17185 = ((int64_t *) coefficientss_mem_17026.mem)[gtid_15983 * ((int64_t) 3 * q_12354) + gtid_17184 * (int64_t) 3];
        
        int64_t defunc_0_f_res_17186;
        
        defunc_0_f_res_17186 = ((int64_t *) coefficientss_mem_17026.mem)[gtid_15983 * ((int64_t) 3 * q_12354) + gtid_17184 * (int64_t) 3 + (int64_t) 1];
        
        int64_t defunc_0_f_res_17187;
        
        defunc_0_f_res_17187 = ((int64_t *) coefficientss_mem_17026.mem)[gtid_15983 * ((int64_t) 3 * q_12354) + gtid_17184 * (int64_t) 3 + (int64_t) 2];
        ((int64_t *) mem_17029.mem)[gtid_17184] = defunc_0_f_res_17185;
        ((int64_t *) mem_17032.mem)[gtid_17184] = defunc_0_f_res_17186;
        ((int64_t *) mem_17035.mem)[gtid_17184] = defunc_0_f_res_17187;
    }
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18495(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18485 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18497 {
    varying struct memblock *uniform mem_17035;
    varying struct memblock *uniform mem_17032;
    varying struct memblock *uniform mem_17029;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18499();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18500();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18501();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18502();
static unmasked inline uniform int futhark_mc_inner_ispc_18498(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18476 *uniform futhark_mc_param_struct_18476_, uniform struct futhark_mc_mem_struct_18497 *uniform futhark_mc_mem_struct_18497_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18476_->ctx;
    uniform int64_t p_12353 = futhark_mc_param_struct_18476_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18476_->free_q_12354;
    uniform struct memblock coefficientss_mem_17026;
    
    coefficientss_mem_17026.desc = futhark_mc_strlit_shim_18499();
    coefficientss_mem_17026.mem = futhark_mc_param_struct_18476_->free_coefficientss_mem_17026;
    coefficientss_mem_17026.size = 0;
    coefficientss_mem_17026.references = NULL;
    
    uniform int64_t bytes_17028 = futhark_mc_param_struct_18476_->free_bytes_17028;
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18500();
    mem_17078.mem = futhark_mc_param_struct_18476_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18501();
    mem_17082.mem = futhark_mc_param_struct_18476_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18502();
    mem_17086.mem = futhark_mc_param_struct_18476_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    struct memblock mem_17035 = *futhark_mc_mem_struct_18497_->mem_17035;
    struct memblock mem_17032 = *futhark_mc_mem_struct_18497_->mem_17032;
    struct memblock mem_17029 = *futhark_mc_mem_struct_18497_->mem_17029;
    uniform int err = 0;
    uniform int64_t start_17188;
    uniform int64_t end_17189;
    
    start_17188 = start;
    end_17189 = end;
    
    uniform int64_t n_17190 = end_17189 - start_17188;
    
    if (memblock_alloc(ctx, &mem_17029, bytes_17028, futhark_mc_strlit_shim_18482()))
        unmasked { return 1; }
    if (memblock_alloc(ctx, &mem_17032, bytes_17028, futhark_mc_strlit_shim_18483()))
        unmasked { return 1; }
    if (memblock_alloc(ctx, &mem_17035, bytes_17028, futhark_mc_strlit_shim_18484()))
        unmasked { return 1; }
    for (uniform int64_t i = 0; i < (start_17188 + n_17190 - start_17188) / programCount; i++) {
        int64_t SegMap_i_17191 = start_17188 + programIndex + i * programCount;
        uniform int64_t slice_17192 = p_12353;
        int64_t gtid_15983 = SegMap_i_17191;
        int64_t remnant_17193 = SegMap_i_17191 - gtid_15983;
        uniform int64_t flat_tid_17183 = (int64_t) 0;
        struct futhark_mc_task_18485 futhark_mc_task_18485_;
        
        futhark_mc_task_18485_.ctx = ctx;
        futhark_mc_task_18485_.free_q_12354 = q_12354;
        futhark_mc_task_18485_.free_gtid_15983 = gtid_15983;
        futhark_mc_task_18485_.free_coefficientss_mem_17026 = coefficientss_mem_17026.mem;
        futhark_mc_task_18485_.free_mem_17029 = mem_17029.mem;
        futhark_mc_task_18485_.free_mem_17032 = mem_17032.mem;
        futhark_mc_task_18485_.free_mem_17035 = mem_17035.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18485 aos_18496[programCount];
        
        aos_18496[programIndex] = futhark_mc_task_18485_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18495(ctx, &aos_18496[i], extract(q_12354, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18495(ctx, &futhark_mc_task_18485_, q_12354);
        if (err != 0)
            goto cleanup;
        #endif
        if (q_12354 * (int64_t) 8 > 0)
            memmove(mem_17078.mem + gtid_15983 * q_12354 * (int64_t) 8, mem_17029.mem + (int64_t) 0, q_12354 * (int64_t) 8);
        if (q_12354 * (int64_t) 8 > 0)
            memmove(mem_17082.mem + gtid_15983 * q_12354 * (int64_t) 8, mem_17032.mem + (int64_t) 0, q_12354 * (int64_t) 8);
        if (q_12354 * (int64_t) 8 > 0)
            memmove(mem_17086.mem + gtid_15983 * q_12354 * (int64_t) 8, mem_17035.mem + (int64_t) 0, q_12354 * (int64_t) 8);
    }
    if (programIndex < (start_17188 + n_17190 - start_17188) % programCount) {
        int64_t SegMap_i_17191 = start_17188 + programIndex + (start_17188 + n_17190 - start_17188) / programCount * programCount;
        uniform int64_t slice_17192 = p_12353;
        int64_t gtid_15983 = SegMap_i_17191;
        int64_t remnant_17193 = SegMap_i_17191 - gtid_15983;
        uniform int64_t flat_tid_17183 = (int64_t) 0;
        struct futhark_mc_task_18485 futhark_mc_task_18485_;
        
        futhark_mc_task_18485_.ctx = ctx;
        futhark_mc_task_18485_.free_q_12354 = q_12354;
        futhark_mc_task_18485_.free_gtid_15983 = gtid_15983;
        futhark_mc_task_18485_.free_coefficientss_mem_17026 = coefficientss_mem_17026.mem;
        futhark_mc_task_18485_.free_mem_17029 = mem_17029.mem;
        futhark_mc_task_18485_.free_mem_17032 = mem_17032.mem;
        futhark_mc_task_18485_.free_mem_17035 = mem_17035.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18485 aos_18496[programCount];
        
        aos_18496[programIndex] = futhark_mc_task_18485_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18495(ctx, &aos_18496[i], extract(q_12354, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18495(ctx, &futhark_mc_task_18485_, q_12354);
        if (err != 0)
            goto cleanup;
        #endif
        if (q_12354 * (int64_t) 8 > 0)
            memmove(mem_17078.mem + gtid_15983 * q_12354 * (int64_t) 8, mem_17029.mem + (int64_t) 0, q_12354 * (int64_t) 8);
        if (q_12354 * (int64_t) 8 > 0)
            memmove(mem_17082.mem + gtid_15983 * q_12354 * (int64_t) 8, mem_17032.mem + (int64_t) 0, q_12354 * (int64_t) 8);
        if (q_12354 * (int64_t) 8 > 0)
            memmove(mem_17086.mem + gtid_15983 * q_12354 * (int64_t) 8, mem_17035.mem + (int64_t) 0, q_12354 * (int64_t) 8);
    }
    *futhark_mc_mem_struct_18497_->mem_17035 = mem_17035;
    *futhark_mc_mem_struct_18497_->mem_17032 = mem_17032;
    *futhark_mc_mem_struct_18497_->mem_17029 = mem_17029;
    return err;
}
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18503();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18504();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18505();
export uniform int futhark_mc_loop_ispc_18477(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18476 *uniform futhark_mc_param_struct_18476_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18476_->ctx;
    uniform int64_t p_12353 = futhark_mc_param_struct_18476_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18476_->free_q_12354;
    uniform struct memblock coefficientss_mem_17026;
    
    coefficientss_mem_17026.desc = futhark_mc_strlit_shim_18478();
    coefficientss_mem_17026.mem = futhark_mc_param_struct_18476_->free_coefficientss_mem_17026;
    coefficientss_mem_17026.size = 0;
    coefficientss_mem_17026.references = NULL;
    
    uniform int64_t bytes_17028 = futhark_mc_param_struct_18476_->free_bytes_17028;
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18479();
    mem_17078.mem = futhark_mc_param_struct_18476_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18480();
    mem_17082.mem = futhark_mc_param_struct_18476_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18481();
    mem_17086.mem = futhark_mc_param_struct_18476_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    struct memblock mem_17035;
    
    mem_17035.references = NULL;
    
    struct memblock mem_17032;
    
    mem_17032.references = NULL;
    
    struct memblock mem_17029;
    
    mem_17029.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18497 futhark_mc_mem_struct_18497_;
    
    futhark_mc_mem_struct_18497_.mem_17035 = &mem_17035;
    futhark_mc_mem_struct_18497_.mem_17032 = &mem_17032;
    futhark_mc_mem_struct_18497_.mem_17029 = &mem_17029;
    
    uniform int err = futhark_mc_inner_ispc_18498(start, end, futhark_mc_param_struct_18476_, &futhark_mc_mem_struct_18497_);
    
    mem_17035 = *futhark_mc_mem_struct_18497_.mem_17035;
    mem_17032 = *futhark_mc_mem_struct_18497_.mem_17032;
    mem_17029 = *futhark_mc_mem_struct_18497_.mem_17029;
    
  cleanup:
    {
        if (memblock_unref(ctx, &mem_17035, futhark_mc_strlit_shim_18503()) != 0)
            unmasked { return 1; }
        if (memblock_unref(ctx, &mem_17032, futhark_mc_strlit_shim_18504()) != 0)
            unmasked { return 1; }
        if (memblock_unref(ctx, &mem_17029, futhark_mc_strlit_shim_18505()) != 0)
            unmasked { return 1; }
    }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18506(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18448 *uniform args, uniform int iterations);
struct futhark_mc_task_18508 {
    struct futhark_context *ctx;
    int64_t free_n_12351;
    int64_t free_m_12352;
    int64_t free_p_12353;
    int64_t free_q_12354;
    unsigned char *free_zzinvs_mem_17023;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    int64_t free_bytes_17093;
    int64_t free_bytes_17096;
    unsigned char *free_mem_17160;
};
struct futhark_mc_param_struct_18517 {
    struct futhark_context *ctx;
    int64_t free_n_12351;
    int64_t free_m_12352;
    int64_t free_p_12353;
    int64_t free_q_12354;
    unsigned char *free_zzinvs_mem_17023;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    int64_t free_bytes_17093;
    int64_t free_bytes_17096;
    unsigned char *free_mem_17160;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18524();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18525();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18526();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18527();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18528();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18529();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18530();
struct futhark_mc_mem_struct_18534 {
    varying unsigned char *uniform mem_17097;
    varying size_t mem_17097_cached_sizze_18519;
    varying unsigned char *uniform mem_17100;
    varying size_t mem_17100_cached_sizze_18520;
    varying unsigned char *uniform mem_17103;
    varying size_t mem_17103_cached_sizze_18521;
    varying unsigned char *uniform mem_17137;
    varying size_t mem_17137_cached_sizze_18522;
    varying unsigned char *uniform mem_17147;
    varying size_t mem_17147_cached_sizze_18523;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18536();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18537();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18538();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18539();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18540();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18541();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18542();
static unmasked inline uniform int futhark_mc_inner_ispc_18535(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18517 *uniform futhark_mc_param_struct_18517_, uniform struct futhark_mc_mem_struct_18534 *uniform futhark_mc_mem_struct_18534_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18517_->ctx;
    uniform int64_t n_12351 = futhark_mc_param_struct_18517_->free_n_12351;
    uniform int64_t m_12352 = futhark_mc_param_struct_18517_->free_m_12352;
    uniform int64_t p_12353 = futhark_mc_param_struct_18517_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18517_->free_q_12354;
    uniform struct memblock zzinvs_mem_17023;
    
    zzinvs_mem_17023.desc = futhark_mc_strlit_shim_18536();
    zzinvs_mem_17023.mem = futhark_mc_param_struct_18517_->free_zzinvs_mem_17023;
    zzinvs_mem_17023.size = 0;
    zzinvs_mem_17023.references = NULL;
    
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18537();
    eps_mem_17024.mem = futhark_mc_param_struct_18517_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18538();
    expsss_mem_17025.mem = futhark_mc_param_struct_18517_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18539();
    mem_17078.mem = futhark_mc_param_struct_18517_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18540();
    mem_17082.mem = futhark_mc_param_struct_18517_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18541();
    mem_17086.mem = futhark_mc_param_struct_18517_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform int64_t bytes_17093 = futhark_mc_param_struct_18517_->free_bytes_17093;
    uniform int64_t bytes_17096 = futhark_mc_param_struct_18517_->free_bytes_17096;
    uniform struct memblock mem_17160;
    
    mem_17160.desc = futhark_mc_strlit_shim_18542();
    mem_17160.mem = futhark_mc_param_struct_18517_->free_mem_17160;
    mem_17160.size = 0;
    mem_17160.references = NULL;
    
    varying unsigned char *uniform mem_17097 = futhark_mc_mem_struct_18534_->mem_17097;
    size_t mem_17097_cached_sizze_18519 = futhark_mc_mem_struct_18534_->mem_17097_cached_sizze_18519;
    varying unsigned char *uniform mem_17100 = futhark_mc_mem_struct_18534_->mem_17100;
    size_t mem_17100_cached_sizze_18520 = futhark_mc_mem_struct_18534_->mem_17100_cached_sizze_18520;
    varying unsigned char *uniform mem_17103 = futhark_mc_mem_struct_18534_->mem_17103;
    size_t mem_17103_cached_sizze_18521 = futhark_mc_mem_struct_18534_->mem_17103_cached_sizze_18521;
    varying unsigned char *uniform mem_17137 = futhark_mc_mem_struct_18534_->mem_17137;
    size_t mem_17137_cached_sizze_18522 = futhark_mc_mem_struct_18534_->mem_17137_cached_sizze_18522;
    varying unsigned char *uniform mem_17147 = futhark_mc_mem_struct_18534_->mem_17147;
    size_t mem_17147_cached_sizze_18523 = futhark_mc_mem_struct_18534_->mem_17147_cached_sizze_18523;
    uniform int err = 0;
    uniform int64_t start_17374;
    uniform int64_t end_17375;
    
    start_17374 = start;
    end_17375 = end;
    
    uniform int64_t n_17376 = end_17375 - start_17374;
    
    if (mem_17097_cached_sizze_18519 < bytes_17096) {
        err = lexical_realloc(ctx, &mem_17097, &mem_17097_cached_sizze_18519, bytes_17096);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17100_cached_sizze_18520 < bytes_17096) {
        err = lexical_realloc(ctx, &mem_17100, &mem_17100_cached_sizze_18520, bytes_17096);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17103_cached_sizze_18521 < bytes_17096) {
        err = lexical_realloc(ctx, &mem_17103, &mem_17103_cached_sizze_18521, bytes_17096);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17137_cached_sizze_18522 < bytes_17093) {
        err = lexical_realloc(ctx, &mem_17137, &mem_17137_cached_sizze_18522, bytes_17093);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17147_cached_sizze_18523 < (int64_t) 24) {
        err = lexical_realloc(ctx, &mem_17147, &mem_17147_cached_sizze_18523, (int64_t) 24);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    foreach (SegMap_i_17377 = start_17374 ... start_17374 + n_17376)
    {
        uniform int64_t slice_17378 = n_12351;
        int64_t gtid_15995 = SegMap_i_17377;
        int64_t remnant_17379 = SegMap_i_17377 - gtid_15995;
        int64_t defunc_0_f_res_15098;
        
        defunc_0_f_res_15098 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_15995 * (int64_t) 3];
        
        int64_t defunc_0_f_res_15099;
        
        defunc_0_f_res_15099 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_15995 * (int64_t) 3 + (int64_t) 1];
        
        int64_t defunc_0_f_res_15100;
        
        defunc_0_f_res_15100 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_15995 * (int64_t) 3 + (int64_t) 2];
        for (uniform int64_t i_17202 = 0; i_17202 < m_12352; i_17202++) {
            int64_t defunc_0_f_res_17206;
            
            defunc_0_f_res_17206 = ((int64_t *) eps_mem_17024.mem)[gtid_15995 * ((int64_t) 3 * m_12352) + i_17202 * (int64_t) 3];
            
            int64_t defunc_0_f_res_17207;
            
            defunc_0_f_res_17207 = ((int64_t *) eps_mem_17024.mem)[gtid_15995 * ((int64_t) 3 * m_12352) + i_17202 * (int64_t) 3 + (int64_t) 1];
            
            int64_t defunc_0_f_res_17208;
            
            defunc_0_f_res_17208 = ((int64_t *) eps_mem_17024.mem)[gtid_15995 * ((int64_t) 3 * m_12352) + i_17202 * (int64_t) 3 + (int64_t) 2];
            ((varying int64_t *) mem_17097)[i_17202] = defunc_0_f_res_17206;
            ((varying int64_t *) mem_17100)[i_17202] = defunc_0_f_res_17207;
            ((varying int64_t *) mem_17103)[i_17202] = defunc_0_f_res_17208;
        }
        for (uniform int64_t i_17212 = 0; i_17212 < p_12353; i_17212++) {
            int64_t defunc_0_f_res_17214;
            int64_t defunc_0_f_res_17215;
            int64_t defunc_0_f_res_17216;
            int64_t redout_17218;
            int64_t redout_17219;
            int64_t redout_17220;
            
            redout_17218 = (int64_t) 0;
            redout_17219 = (int64_t) 0;
            redout_17220 = (int64_t) 0;
            for (uniform int64_t i_17217 = 0; i_17217 < q_12354; i_17217++) {
                uniform int64_t x_17221;
                
                x_17221 = ((int64_t *) mem_17078.mem)[i_17212 * q_12354 + i_17217];
                
                uniform int64_t x_17222;
                
                x_17222 = ((int64_t *) mem_17082.mem)[i_17212 * q_12354 + i_17217];
                
                uniform int64_t x_17223;
                
                x_17223 = ((int64_t *) mem_17086.mem)[i_17212 * q_12354 + i_17217];
                
                int64_t defunc_0_f_res_17224;
                int64_t defunc_0_f_res_17225;
                int64_t defunc_0_f_res_17226;
                int64_t redout_17228;
                int64_t redout_17229;
                int64_t redout_17230;
                
                redout_17228 = (int64_t) 1;
                redout_17229 = (int64_t) 0;
                redout_17230 = (int64_t) 0;
                for (uniform int64_t i_17227 = 0; i_17227 < m_12352; i_17227++) {
                    uniform int64_t x_17231;
                    
                    x_17231 = ((int64_t *) expsss_mem_17025.mem)[i_17212 * (m_12352 * q_12354) + i_17217 * m_12352 + i_17227];
                    
                    int64_t x_17232;
                    
                    x_17232 = ((varying int64_t *) mem_17097)[i_17227];
                    
                    int64_t x_17233;
                    
                    x_17233 = ((varying int64_t *) mem_17100)[i_17227];
                    
                    int64_t x_17234;
                    
                    x_17234 = ((varying int64_t *) mem_17103)[i_17227];
                    
                    uniform bool loop_cond_17235 = ult64((int64_t) 0, x_17231);
                    uniform bool mod_pow_u64_res_17236;
                    int64_t mod_pow_u64_res_17237;
                    int64_t mod_pow_u64_res_17238;
                    int64_t mod_pow_u64_res_17239;
                    uniform int64_t mod_pow_u64_res_17240;
                    int64_t mod_pow_u64_res_17241;
                    int64_t mod_pow_u64_res_17242;
                    int64_t mod_pow_u64_res_17243;
                    uniform bool loop_while_17244;
                    int64_t x_17245;
                    int64_t x_17246;
                    int64_t x_17247;
                    uniform int64_t i_17248;
                    int64_t result_17249;
                    int64_t result_17250;
                    int64_t result_17251;
                    
                    loop_while_17244 = loop_cond_17235;
                    x_17245 = x_17232;
                    x_17246 = x_17233;
                    x_17247 = x_17234;
                    i_17248 = x_17231;
                    result_17249 = (int64_t) 1;
                    result_17250 = (int64_t) 0;
                    result_17251 = (int64_t) 0;
                    while (loop_while_17244) {
                        uniform int64_t x_17252 = umod64(i_17248, (int64_t) 2);
                        uniform bool cond_17253 = x_17252 == (int64_t) 1;
                        int64_t loopres_17254;
                        int64_t loopres_17255;
                        int64_t loopres_17256;
                        uniform int64_t loopres_17257;
                        int64_t loopres_17258;
                        int64_t loopres_17259;
                        int64_t loopres_17260;
                        
                        if (cond_17253 == 1) {
                            int64_t x_17261 = mul64(x_17245, x_17245);
                            int64_t y_17262 = mul64(x_17246, x_17247);
                            int64_t x_17263 = sub64(x_17261, y_17262);
                            int64_t mul_res_17264 = sub64(x_17263, y_17262);
                            int64_t x_17265 = mul64(x_17245, x_17246);
                            int64_t x_17266 = add64(x_17265, x_17265);
                            int64_t y_17267 = mul64(x_17247, x_17247);
                            int64_t x_17268 = sub64(x_17266, y_17267);
                            int64_t x_17269 = add64(y_17262, x_17268);
                            int64_t mul_res_17270 = add64(y_17262, x_17269);
                            int64_t x_17271 = mul64(x_17245, x_17247);
                            int64_t y_17272 = mul64(x_17246, x_17246);
                            int64_t x_17273 = add64(x_17271, y_17272);
                            int64_t x_17274 = add64(x_17271, x_17273);
                            int64_t mul_res_17275 = add64(y_17267, x_17274);
                            uniform int64_t loopres_t_res_17276 = lshr64(i_17248, (int64_t) 1);
                            int64_t x_17277 = mul64(x_17245, result_17249);
                            int64_t y_17278 = mul64(x_17247, result_17250);
                            int64_t x_17279 = sub64(x_17277, y_17278);
                            int64_t y_17280 = mul64(x_17246, result_17251);
                            int64_t mul_res_17281 = sub64(x_17279, y_17280);
                            int64_t x_17282 = mul64(x_17246, result_17249);
                            int64_t y_17283 = mul64(x_17245, result_17250);
                            int64_t x_17284 = add64(x_17282, y_17283);
                            int64_t y_17285 = mul64(x_17247, result_17251);
                            int64_t x_17286 = sub64(x_17284, y_17285);
                            int64_t x_17287 = add64(y_17278, x_17286);
                            int64_t mul_res_17288 = add64(y_17280, x_17287);
                            int64_t x_17289 = mul64(x_17247, result_17249);
                            int64_t y_17290 = mul64(x_17246, result_17250);
                            int64_t x_17291 = add64(x_17289, y_17290);
                            int64_t y_17292 = mul64(x_17245, result_17251);
                            int64_t x_17293 = add64(x_17291, y_17292);
                            int64_t mul_res_17294 = add64(y_17285, x_17293);
                            
                            loopres_17254 = mul_res_17264;
                            loopres_17255 = mul_res_17270;
                            loopres_17256 = mul_res_17275;
                            loopres_17257 = loopres_t_res_17276;
                            loopres_17258 = mul_res_17281;
                            loopres_17259 = mul_res_17288;
                            loopres_17260 = mul_res_17294;
                        } else {
                            int64_t x_17295 = mul64(x_17245, x_17245);
                            int64_t y_17296 = mul64(x_17246, x_17247);
                            int64_t x_17297 = sub64(x_17295, y_17296);
                            int64_t mul_res_17298 = sub64(x_17297, y_17296);
                            int64_t x_17299 = mul64(x_17245, x_17246);
                            int64_t x_17300 = add64(x_17299, x_17299);
                            int64_t y_17301 = mul64(x_17247, x_17247);
                            int64_t x_17302 = sub64(x_17300, y_17301);
                            int64_t x_17303 = add64(y_17296, x_17302);
                            int64_t mul_res_17304 = add64(y_17296, x_17303);
                            int64_t x_17305 = mul64(x_17245, x_17247);
                            int64_t y_17306 = mul64(x_17246, x_17246);
                            int64_t x_17307 = add64(x_17305, y_17306);
                            int64_t x_17308 = add64(x_17305, x_17307);
                            int64_t mul_res_17309 = add64(y_17301, x_17308);
                            uniform int64_t loopres_f_res_17310 = lshr64(i_17248, (int64_t) 1);
                            
                            loopres_17254 = mul_res_17298;
                            loopres_17255 = mul_res_17304;
                            loopres_17256 = mul_res_17309;
                            loopres_17257 = loopres_f_res_17310;
                            loopres_17258 = result_17249;
                            loopres_17259 = result_17250;
                            loopres_17260 = result_17251;
                        }
                        
                        uniform bool loop_cond_17311 = ult64((int64_t) 0, loopres_17257);
                        uniform bool loop_while_tmp_17390 = loop_cond_17311;
                        int64_t x_tmp_17391 = loopres_17254;
                        int64_t x_tmp_17392 = loopres_17255;
                        int64_t x_tmp_17393 = loopres_17256;
                        uniform int64_t i_tmp_17394 = loopres_17257;
                        int64_t result_tmp_17395 = loopres_17258;
                        int64_t result_tmp_17396 = loopres_17259;
                        int64_t result_tmp_17397 = loopres_17260;
                        
                        loop_while_17244 = loop_while_tmp_17390;
                        x_17245 = x_tmp_17391;
                        x_17246 = x_tmp_17392;
                        x_17247 = x_tmp_17393;
                        i_17248 = i_tmp_17394;
                        result_17249 = result_tmp_17395;
                        result_17250 = result_tmp_17396;
                        result_17251 = result_tmp_17397;
                    }
                    mod_pow_u64_res_17236 = loop_while_17244;
                    mod_pow_u64_res_17237 = x_17245;
                    mod_pow_u64_res_17238 = x_17246;
                    mod_pow_u64_res_17239 = x_17247;
                    mod_pow_u64_res_17240 = i_17248;
                    mod_pow_u64_res_17241 = result_17249;
                    mod_pow_u64_res_17242 = result_17250;
                    mod_pow_u64_res_17243 = result_17251;
                    
                    int64_t x_17312 = mul64(mod_pow_u64_res_17241, redout_17228);
                    int64_t y_17313 = mul64(mod_pow_u64_res_17242, redout_17230);
                    int64_t x_17314 = sub64(x_17312, y_17313);
                    int64_t y_17315 = mul64(mod_pow_u64_res_17243, redout_17229);
                    int64_t defunc_1_op_res_17316 = sub64(x_17314, y_17315);
                    int64_t x_17317 = mul64(mod_pow_u64_res_17241, redout_17229);
                    int64_t y_17318 = mul64(mod_pow_u64_res_17242, redout_17228);
                    int64_t x_17319 = add64(x_17317, y_17318);
                    int64_t y_17320 = mul64(mod_pow_u64_res_17243, redout_17230);
                    int64_t x_17321 = sub64(x_17319, y_17320);
                    int64_t x_17322 = add64(y_17313, x_17321);
                    int64_t defunc_1_op_res_17323 = add64(y_17315, x_17322);
                    int64_t x_17324 = mul64(mod_pow_u64_res_17241, redout_17230);
                    int64_t y_17325 = mul64(mod_pow_u64_res_17242, redout_17229);
                    int64_t x_17326 = add64(x_17324, y_17325);
                    int64_t y_17327 = mul64(mod_pow_u64_res_17243, redout_17228);
                    int64_t x_17328 = add64(x_17326, y_17327);
                    int64_t defunc_1_op_res_17329 = add64(y_17320, x_17328);
                    int64_t redout_tmp_17387 = defunc_1_op_res_17316;
                    int64_t redout_tmp_17388 = defunc_1_op_res_17323;
                    int64_t redout_tmp_17389 = defunc_1_op_res_17329;
                    
                    redout_17228 = redout_tmp_17387;
                    redout_17229 = redout_tmp_17388;
                    redout_17230 = redout_tmp_17389;
                }
                defunc_0_f_res_17224 = redout_17228;
                defunc_0_f_res_17225 = redout_17229;
                defunc_0_f_res_17226 = redout_17230;
                
                int64_t x_17330 = mul64(x_17221, defunc_0_f_res_17224);
                int64_t y_17331 = mul64(x_17223, defunc_0_f_res_17225);
                int64_t x_17332 = sub64(x_17330, y_17331);
                int64_t y_17333 = mul64(x_17222, defunc_0_f_res_17226);
                int64_t mul_res_17334 = sub64(x_17332, y_17333);
                int64_t x_17335 = mul64(x_17222, defunc_0_f_res_17224);
                int64_t y_17336 = mul64(x_17221, defunc_0_f_res_17225);
                int64_t x_17337 = add64(x_17335, y_17336);
                int64_t y_17338 = mul64(x_17223, defunc_0_f_res_17226);
                int64_t x_17339 = sub64(x_17337, y_17338);
                int64_t x_17340 = add64(y_17331, x_17339);
                int64_t mul_res_17341 = add64(y_17333, x_17340);
                int64_t x_17342 = mul64(x_17223, defunc_0_f_res_17224);
                int64_t y_17343 = mul64(x_17222, defunc_0_f_res_17225);
                int64_t x_17344 = add64(x_17342, y_17343);
                int64_t y_17345 = mul64(x_17221, defunc_0_f_res_17226);
                int64_t x_17346 = add64(x_17344, y_17345);
                int64_t mul_res_17347 = add64(y_17338, x_17346);
                int64_t canonicalizze_arg_17348 = add64(mul_res_17334, redout_17218);
                int64_t canonicalizze_res_17349 = umod64(canonicalizze_arg_17348, (int64_t) -4294967295);
                int64_t canonicalizze_arg_17350 = add64(mul_res_17341, redout_17219);
                int64_t canonicalizze_res_17351 = umod64(canonicalizze_arg_17350, (int64_t) -4294967295);
                int64_t canonicalizze_arg_17352 = add64(mul_res_17347, redout_17220);
                int64_t canonicalizze_res_17353 = umod64(canonicalizze_arg_17352, (int64_t) -4294967295);
                int64_t redout_tmp_17384 = canonicalizze_res_17349;
                int64_t redout_tmp_17385 = canonicalizze_res_17351;
                int64_t redout_tmp_17386 = canonicalizze_res_17353;
                
                redout_17218 = redout_tmp_17384;
                redout_17219 = redout_tmp_17385;
                redout_17220 = redout_tmp_17386;
            }
            defunc_0_f_res_17214 = redout_17218;
            defunc_0_f_res_17215 = redout_17219;
            defunc_0_f_res_17216 = redout_17220;
            
            int64_t x_17354 = mul64(defunc_0_f_res_15098, defunc_0_f_res_17214);
            int64_t y_17355 = mul64(defunc_0_f_res_15100, defunc_0_f_res_17215);
            int64_t x_17356 = sub64(x_17354, y_17355);
            int64_t y_17357 = mul64(defunc_0_f_res_15099, defunc_0_f_res_17216);
            int64_t mul_res_17358 = sub64(x_17356, y_17357);
            int64_t x_17359 = mul64(defunc_0_f_res_15099, defunc_0_f_res_17214);
            int64_t y_17360 = mul64(defunc_0_f_res_15098, defunc_0_f_res_17215);
            int64_t x_17361 = add64(x_17359, y_17360);
            int64_t y_17362 = mul64(defunc_0_f_res_15100, defunc_0_f_res_17216);
            int64_t x_17363 = sub64(x_17361, y_17362);
            int64_t x_17364 = add64(y_17355, x_17363);
            int64_t mul_res_17365 = add64(y_17357, x_17364);
            int64_t x_17366 = mul64(defunc_0_f_res_15100, defunc_0_f_res_17214);
            int64_t y_17367 = mul64(defunc_0_f_res_15099, defunc_0_f_res_17215);
            int64_t x_17368 = add64(x_17366, y_17367);
            int64_t y_17369 = mul64(defunc_0_f_res_15098, defunc_0_f_res_17216);
            int64_t x_17370 = add64(x_17368, y_17369);
            int64_t mul_res_17371 = add64(y_17362, x_17370);
            uniform int64_t tmp_idx_18531 = (int64_t) 0;
            
            ((varying int64_t *) mem_17147)[tmp_idx_18531] = mul_res_17358;
            
            uniform int64_t tmp_idx_18532 = (int64_t) 1;
            
            ((varying int64_t *) mem_17147)[tmp_idx_18532] = mul_res_17365;
            
            uniform int64_t tmp_idx_18533 = (int64_t) 2;
            
            ((varying int64_t *) mem_17147)[tmp_idx_18533] = mul_res_17371;
            if ((int64_t) 24 > 0)
                memmove_64(mem_17137 + i_17212 * (int64_t) 3 * (int64_t) 8, mem_17147 + (int64_t) 0, extract((int64_t) 24, 0));
        }
        if (p_12353 * (int64_t) 3 * (int64_t) 8 > 0)
            memmove_64(mem_17160.mem + gtid_15995 * ((int64_t) 3 * p_12353) * (int64_t) 8, mem_17137 + (int64_t) 0, extract(p_12353 * (int64_t) 3 * (int64_t) 8, 0));
    }
    futhark_mc_mem_struct_18534_->mem_17097 = mem_17097;
    futhark_mc_mem_struct_18534_->mem_17097_cached_sizze_18519 = mem_17097_cached_sizze_18519;
    futhark_mc_mem_struct_18534_->mem_17100 = mem_17100;
    futhark_mc_mem_struct_18534_->mem_17100_cached_sizze_18520 = mem_17100_cached_sizze_18520;
    futhark_mc_mem_struct_18534_->mem_17103 = mem_17103;
    futhark_mc_mem_struct_18534_->mem_17103_cached_sizze_18521 = mem_17103_cached_sizze_18521;
    futhark_mc_mem_struct_18534_->mem_17137 = mem_17137;
    futhark_mc_mem_struct_18534_->mem_17137_cached_sizze_18522 = mem_17137_cached_sizze_18522;
    futhark_mc_mem_struct_18534_->mem_17147 = mem_17147;
    futhark_mc_mem_struct_18534_->mem_17147_cached_sizze_18523 = mem_17147_cached_sizze_18523;
    return err;
}
export uniform int futhark_mc_loop_ispc_18518(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18517 *uniform futhark_mc_param_struct_18517_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18517_->ctx;
    uniform int64_t n_12351 = futhark_mc_param_struct_18517_->free_n_12351;
    uniform int64_t m_12352 = futhark_mc_param_struct_18517_->free_m_12352;
    uniform int64_t p_12353 = futhark_mc_param_struct_18517_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18517_->free_q_12354;
    uniform struct memblock zzinvs_mem_17023;
    
    zzinvs_mem_17023.desc = futhark_mc_strlit_shim_18524();
    zzinvs_mem_17023.mem = futhark_mc_param_struct_18517_->free_zzinvs_mem_17023;
    zzinvs_mem_17023.size = 0;
    zzinvs_mem_17023.references = NULL;
    
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18525();
    eps_mem_17024.mem = futhark_mc_param_struct_18517_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18526();
    expsss_mem_17025.mem = futhark_mc_param_struct_18517_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18527();
    mem_17078.mem = futhark_mc_param_struct_18517_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18528();
    mem_17082.mem = futhark_mc_param_struct_18517_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18529();
    mem_17086.mem = futhark_mc_param_struct_18517_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform int64_t bytes_17093 = futhark_mc_param_struct_18517_->free_bytes_17093;
    uniform int64_t bytes_17096 = futhark_mc_param_struct_18517_->free_bytes_17096;
    uniform struct memblock mem_17160;
    
    mem_17160.desc = futhark_mc_strlit_shim_18530();
    mem_17160.mem = futhark_mc_param_struct_18517_->free_mem_17160;
    mem_17160.size = 0;
    mem_17160.references = NULL;
    
    size_t mem_17097_cached_sizze_18519 = 0;
    varying unsigned char *uniform mem_17097 = NULL;
    size_t mem_17100_cached_sizze_18520 = 0;
    varying unsigned char *uniform mem_17100 = NULL;
    size_t mem_17103_cached_sizze_18521 = 0;
    varying unsigned char *uniform mem_17103 = NULL;
    size_t mem_17137_cached_sizze_18522 = 0;
    varying unsigned char *uniform mem_17137 = NULL;
    size_t mem_17147_cached_sizze_18523 = 0;
    varying unsigned char *uniform mem_17147 = NULL;
    uniform struct futhark_mc_mem_struct_18534 futhark_mc_mem_struct_18534_;
    
    futhark_mc_mem_struct_18534_.mem_17097 = mem_17097;
    futhark_mc_mem_struct_18534_.mem_17097_cached_sizze_18519 = mem_17097_cached_sizze_18519;
    futhark_mc_mem_struct_18534_.mem_17100 = mem_17100;
    futhark_mc_mem_struct_18534_.mem_17100_cached_sizze_18520 = mem_17100_cached_sizze_18520;
    futhark_mc_mem_struct_18534_.mem_17103 = mem_17103;
    futhark_mc_mem_struct_18534_.mem_17103_cached_sizze_18521 = mem_17103_cached_sizze_18521;
    futhark_mc_mem_struct_18534_.mem_17137 = mem_17137;
    futhark_mc_mem_struct_18534_.mem_17137_cached_sizze_18522 = mem_17137_cached_sizze_18522;
    futhark_mc_mem_struct_18534_.mem_17147 = mem_17147;
    futhark_mc_mem_struct_18534_.mem_17147_cached_sizze_18523 = mem_17147_cached_sizze_18523;
    
    uniform int err = futhark_mc_inner_ispc_18535(start, end, futhark_mc_param_struct_18517_, &futhark_mc_mem_struct_18534_);
    
    mem_17097 = futhark_mc_mem_struct_18534_.mem_17097;
    mem_17097_cached_sizze_18519 = futhark_mc_mem_struct_18534_.mem_17097_cached_sizze_18519;
    mem_17100 = futhark_mc_mem_struct_18534_.mem_17100;
    mem_17100_cached_sizze_18520 = futhark_mc_mem_struct_18534_.mem_17100_cached_sizze_18520;
    mem_17103 = futhark_mc_mem_struct_18534_.mem_17103;
    mem_17103_cached_sizze_18521 = futhark_mc_mem_struct_18534_.mem_17103_cached_sizze_18521;
    mem_17137 = futhark_mc_mem_struct_18534_.mem_17137;
    mem_17137_cached_sizze_18522 = futhark_mc_mem_struct_18534_.mem_17137_cached_sizze_18522;
    mem_17147 = futhark_mc_mem_struct_18534_.mem_17147;
    mem_17147_cached_sizze_18523 = futhark_mc_mem_struct_18534_.mem_17147_cached_sizze_18523;
    
  cleanup:
    {
        free(mem_17097);
        free(mem_17100);
        free(mem_17103);
        free(mem_17137);
        free(mem_17147);
    }
    return err;
}
struct futhark_mc_param_struct_18547 {
    struct futhark_context *ctx;
    int64_t free_n_12351;
    int64_t free_m_12352;
    int64_t free_p_12353;
    int64_t free_q_12354;
    unsigned char *free_zzinvs_mem_17023;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    int64_t free_bytes_17093;
    unsigned char *free_mem_17160;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18549();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18550();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18551();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18552();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18553();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18554();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18555();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18556();
struct futhark_mc_task_18557 {
    struct futhark_context *ctx;
    int64_t free_m_12352;
    int64_t free_p_12353;
    int64_t free_q_12354;
    int64_t free_gtid_16475;
    int64_t free_defunc_0_f_res_16478;
    int64_t free_defunc_0_f_res_16479;
    int64_t free_defunc_0_f_res_16480;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    unsigned char *free_mem_17094;
};
struct futhark_mc_param_struct_18562 {
    struct futhark_context *ctx;
    int64_t free_m_12352;
    int64_t free_p_12353;
    int64_t free_q_12354;
    int64_t free_gtid_16475;
    int64_t free_defunc_0_f_res_16478;
    int64_t free_defunc_0_f_res_16479;
    int64_t free_defunc_0_f_res_16480;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    unsigned char *free_mem_17094;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18565();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18566();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18567();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18568();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18569();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18570();
struct futhark_mc_mem_struct_18574 {
    varying unsigned char *uniform mem_17870;
    varying size_t mem_17870_cached_sizze_18564;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18576();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18577();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18578();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18579();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18580();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18581();
static unmasked inline uniform int futhark_mc_inner_ispc_18575(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18562 *uniform futhark_mc_param_struct_18562_, uniform struct futhark_mc_mem_struct_18574 *uniform futhark_mc_mem_struct_18574_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18562_->ctx;
    uniform int64_t m_12352 = futhark_mc_param_struct_18562_->free_m_12352;
    uniform int64_t p_12353 = futhark_mc_param_struct_18562_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18562_->free_q_12354;
    uniform int64_t gtid_16475 = futhark_mc_param_struct_18562_->free_gtid_16475;
    uniform int64_t defunc_0_f_res_16478 = futhark_mc_param_struct_18562_->free_defunc_0_f_res_16478;
    uniform int64_t defunc_0_f_res_16479 = futhark_mc_param_struct_18562_->free_defunc_0_f_res_16479;
    uniform int64_t defunc_0_f_res_16480 = futhark_mc_param_struct_18562_->free_defunc_0_f_res_16480;
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18576();
    eps_mem_17024.mem = futhark_mc_param_struct_18562_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18577();
    expsss_mem_17025.mem = futhark_mc_param_struct_18562_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18578();
    mem_17078.mem = futhark_mc_param_struct_18562_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18579();
    mem_17082.mem = futhark_mc_param_struct_18562_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18580();
    mem_17086.mem = futhark_mc_param_struct_18562_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform struct memblock mem_17094;
    
    mem_17094.desc = futhark_mc_strlit_shim_18581();
    mem_17094.mem = futhark_mc_param_struct_18562_->free_mem_17094;
    mem_17094.size = 0;
    mem_17094.references = NULL;
    
    varying unsigned char *uniform mem_17870 = futhark_mc_mem_struct_18574_->mem_17870;
    size_t mem_17870_cached_sizze_18564 = futhark_mc_mem_struct_18574_->mem_17870_cached_sizze_18564;
    uniform int err = 0;
    uniform int64_t start_18016;
    uniform int64_t end_18017;
    
    start_18016 = start;
    end_18017 = end;
    
    uniform int64_t n_18018 = end_18017 - start_18016;
    
    if (mem_17870_cached_sizze_18564 < (int64_t) 24) {
        err = lexical_realloc(ctx, &mem_17870, &mem_17870_cached_sizze_18564, (int64_t) 24);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    foreach (SegMap_i_18019 = start_18016 ... start_18016 + n_18018)
    {
        uniform int64_t slice_18020 = p_12353;
        int64_t gtid_17711 = SegMap_i_18019;
        int64_t remnant_18021 = SegMap_i_18019 - gtid_17711;
        int64_t defunc_0_f_res_17712;
        int64_t defunc_0_f_res_17713;
        int64_t defunc_0_f_res_17714;
        int64_t redout_17880;
        int64_t redout_17881;
        int64_t redout_17882;
        
        redout_17880 = (int64_t) 0;
        redout_17881 = (int64_t) 0;
        redout_17882 = (int64_t) 0;
        for (uniform int64_t i_17879 = 0; i_17879 < q_12354; i_17879++) {
            int64_t x_17883;
            
            x_17883 = ((int64_t *) mem_17078.mem)[gtid_17711 * q_12354 + i_17879];
            
            int64_t x_17884;
            
            x_17884 = ((int64_t *) mem_17082.mem)[gtid_17711 * q_12354 + i_17879];
            
            int64_t x_17885;
            
            x_17885 = ((int64_t *) mem_17086.mem)[gtid_17711 * q_12354 + i_17879];
            
            int64_t defunc_0_f_res_17886;
            int64_t defunc_0_f_res_17887;
            int64_t defunc_0_f_res_17888;
            int64_t redout_17890;
            int64_t redout_17891;
            int64_t redout_17892;
            
            redout_17890 = (int64_t) 1;
            redout_17891 = (int64_t) 0;
            redout_17892 = (int64_t) 0;
            for (uniform int64_t i_17889 = 0; i_17889 < m_12352; i_17889++) {
                int64_t x_17893;
                
                x_17893 = ((int64_t *) expsss_mem_17025.mem)[gtid_17711 * (m_12352 * q_12354) + i_17879 * m_12352 + i_17889];
                
                uniform int64_t x_17894;
                
                x_17894 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + i_17889 * (int64_t) 3];
                
                uniform int64_t x_17895;
                
                x_17895 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + i_17889 * (int64_t) 3 + (int64_t) 1];
                
                uniform int64_t x_17896;
                
                x_17896 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + i_17889 * (int64_t) 3 + (int64_t) 2];
                
                bool loop_cond_17897 = ult64((int64_t) 0, x_17893);
                bool mod_pow_u64_res_17898;
                int64_t mod_pow_u64_res_17899;
                int64_t mod_pow_u64_res_17900;
                int64_t mod_pow_u64_res_17901;
                int64_t mod_pow_u64_res_17902;
                int64_t mod_pow_u64_res_17903;
                int64_t mod_pow_u64_res_17904;
                int64_t mod_pow_u64_res_17905;
                bool loop_while_17906;
                int64_t x_17907;
                int64_t x_17908;
                int64_t x_17909;
                int64_t i_17910;
                int64_t result_17911;
                int64_t result_17912;
                int64_t result_17913;
                
                loop_while_17906 = loop_cond_17897;
                x_17907 = x_17894;
                x_17908 = x_17895;
                x_17909 = x_17896;
                i_17910 = x_17893;
                result_17911 = (int64_t) 1;
                result_17912 = (int64_t) 0;
                result_17913 = (int64_t) 0;
                while (loop_while_17906) {
                    int64_t x_17914 = umod64(i_17910, (int64_t) 2);
                    bool cond_17915 = x_17914 == (int64_t) 1;
                    int64_t loopres_17916;
                    int64_t loopres_17917;
                    int64_t loopres_17918;
                    int64_t loopres_17919;
                    int64_t loopres_17920;
                    int64_t loopres_17921;
                    int64_t loopres_17922;
                    
                    if (cond_17915 == 1) {
                        int64_t x_17923 = mul64(x_17907, x_17907);
                        int64_t y_17924 = mul64(x_17908, x_17909);
                        int64_t x_17925 = sub64(x_17923, y_17924);
                        int64_t mul_res_17926 = sub64(x_17925, y_17924);
                        int64_t x_17927 = mul64(x_17907, x_17908);
                        int64_t x_17928 = add64(x_17927, x_17927);
                        int64_t y_17929 = mul64(x_17909, x_17909);
                        int64_t x_17930 = sub64(x_17928, y_17929);
                        int64_t x_17931 = add64(y_17924, x_17930);
                        int64_t mul_res_17932 = add64(y_17924, x_17931);
                        int64_t x_17933 = mul64(x_17907, x_17909);
                        int64_t y_17934 = mul64(x_17908, x_17908);
                        int64_t x_17935 = add64(x_17933, y_17934);
                        int64_t x_17936 = add64(x_17933, x_17935);
                        int64_t mul_res_17937 = add64(y_17929, x_17936);
                        int64_t loopres_t_res_17938 = lshr64(i_17910, (int64_t) 1);
                        int64_t x_17939 = mul64(x_17907, result_17911);
                        int64_t y_17940 = mul64(x_17909, result_17912);
                        int64_t x_17941 = sub64(x_17939, y_17940);
                        int64_t y_17942 = mul64(x_17908, result_17913);
                        int64_t mul_res_17943 = sub64(x_17941, y_17942);
                        int64_t x_17944 = mul64(x_17908, result_17911);
                        int64_t y_17945 = mul64(x_17907, result_17912);
                        int64_t x_17946 = add64(x_17944, y_17945);
                        int64_t y_17947 = mul64(x_17909, result_17913);
                        int64_t x_17948 = sub64(x_17946, y_17947);
                        int64_t x_17949 = add64(y_17940, x_17948);
                        int64_t mul_res_17950 = add64(y_17942, x_17949);
                        int64_t x_17951 = mul64(x_17909, result_17911);
                        int64_t y_17952 = mul64(x_17908, result_17912);
                        int64_t x_17953 = add64(x_17951, y_17952);
                        int64_t y_17954 = mul64(x_17907, result_17913);
                        int64_t x_17955 = add64(x_17953, y_17954);
                        int64_t mul_res_17956 = add64(y_17947, x_17955);
                        
                        loopres_17916 = mul_res_17926;
                        loopres_17917 = mul_res_17932;
                        loopres_17918 = mul_res_17937;
                        loopres_17919 = loopres_t_res_17938;
                        loopres_17920 = mul_res_17943;
                        loopres_17921 = mul_res_17950;
                        loopres_17922 = mul_res_17956;
                    } else {
                        int64_t x_17957 = mul64(x_17907, x_17907);
                        int64_t y_17958 = mul64(x_17908, x_17909);
                        int64_t x_17959 = sub64(x_17957, y_17958);
                        int64_t mul_res_17960 = sub64(x_17959, y_17958);
                        int64_t x_17961 = mul64(x_17907, x_17908);
                        int64_t x_17962 = add64(x_17961, x_17961);
                        int64_t y_17963 = mul64(x_17909, x_17909);
                        int64_t x_17964 = sub64(x_17962, y_17963);
                        int64_t x_17965 = add64(y_17958, x_17964);
                        int64_t mul_res_17966 = add64(y_17958, x_17965);
                        int64_t x_17967 = mul64(x_17907, x_17909);
                        int64_t y_17968 = mul64(x_17908, x_17908);
                        int64_t x_17969 = add64(x_17967, y_17968);
                        int64_t x_17970 = add64(x_17967, x_17969);
                        int64_t mul_res_17971 = add64(y_17963, x_17970);
                        int64_t loopres_f_res_17972 = lshr64(i_17910, (int64_t) 1);
                        
                        loopres_17916 = mul_res_17960;
                        loopres_17917 = mul_res_17966;
                        loopres_17918 = mul_res_17971;
                        loopres_17919 = loopres_f_res_17972;
                        loopres_17920 = result_17911;
                        loopres_17921 = result_17912;
                        loopres_17922 = result_17913;
                    }
                    
                    bool loop_cond_17973 = ult64((int64_t) 0, loopres_17919);
                    bool loop_while_tmp_18028 = loop_cond_17973;
                    int64_t x_tmp_18029 = loopres_17916;
                    int64_t x_tmp_18030 = loopres_17917;
                    int64_t x_tmp_18031 = loopres_17918;
                    int64_t i_tmp_18032 = loopres_17919;
                    int64_t result_tmp_18033 = loopres_17920;
                    int64_t result_tmp_18034 = loopres_17921;
                    int64_t result_tmp_18035 = loopres_17922;
                    
                    loop_while_17906 = loop_while_tmp_18028;
                    x_17907 = x_tmp_18029;
                    x_17908 = x_tmp_18030;
                    x_17909 = x_tmp_18031;
                    i_17910 = i_tmp_18032;
                    result_17911 = result_tmp_18033;
                    result_17912 = result_tmp_18034;
                    result_17913 = result_tmp_18035;
                }
                mod_pow_u64_res_17898 = loop_while_17906;
                mod_pow_u64_res_17899 = x_17907;
                mod_pow_u64_res_17900 = x_17908;
                mod_pow_u64_res_17901 = x_17909;
                mod_pow_u64_res_17902 = i_17910;
                mod_pow_u64_res_17903 = result_17911;
                mod_pow_u64_res_17904 = result_17912;
                mod_pow_u64_res_17905 = result_17913;
                
                int64_t x_17974 = mul64(mod_pow_u64_res_17903, redout_17890);
                int64_t y_17975 = mul64(mod_pow_u64_res_17904, redout_17892);
                int64_t x_17976 = sub64(x_17974, y_17975);
                int64_t y_17977 = mul64(mod_pow_u64_res_17905, redout_17891);
                int64_t defunc_1_op_res_17978 = sub64(x_17976, y_17977);
                int64_t x_17979 = mul64(mod_pow_u64_res_17903, redout_17891);
                int64_t y_17980 = mul64(mod_pow_u64_res_17904, redout_17890);
                int64_t x_17981 = add64(x_17979, y_17980);
                int64_t y_17982 = mul64(mod_pow_u64_res_17905, redout_17892);
                int64_t x_17983 = sub64(x_17981, y_17982);
                int64_t x_17984 = add64(y_17975, x_17983);
                int64_t defunc_1_op_res_17985 = add64(y_17977, x_17984);
                int64_t x_17986 = mul64(mod_pow_u64_res_17903, redout_17892);
                int64_t y_17987 = mul64(mod_pow_u64_res_17904, redout_17891);
                int64_t x_17988 = add64(x_17986, y_17987);
                int64_t y_17989 = mul64(mod_pow_u64_res_17905, redout_17890);
                int64_t x_17990 = add64(x_17988, y_17989);
                int64_t defunc_1_op_res_17991 = add64(y_17982, x_17990);
                int64_t redout_tmp_18025 = defunc_1_op_res_17978;
                int64_t redout_tmp_18026 = defunc_1_op_res_17985;
                int64_t redout_tmp_18027 = defunc_1_op_res_17991;
                
                redout_17890 = redout_tmp_18025;
                redout_17891 = redout_tmp_18026;
                redout_17892 = redout_tmp_18027;
            }
            defunc_0_f_res_17886 = redout_17890;
            defunc_0_f_res_17887 = redout_17891;
            defunc_0_f_res_17888 = redout_17892;
            
            int64_t x_17992 = mul64(x_17883, defunc_0_f_res_17886);
            int64_t y_17993 = mul64(x_17885, defunc_0_f_res_17887);
            int64_t x_17994 = sub64(x_17992, y_17993);
            int64_t y_17995 = mul64(x_17884, defunc_0_f_res_17888);
            int64_t mul_res_17996 = sub64(x_17994, y_17995);
            int64_t x_17997 = mul64(x_17884, defunc_0_f_res_17886);
            int64_t y_17998 = mul64(x_17883, defunc_0_f_res_17887);
            int64_t x_17999 = add64(x_17997, y_17998);
            int64_t y_18000 = mul64(x_17885, defunc_0_f_res_17888);
            int64_t x_18001 = sub64(x_17999, y_18000);
            int64_t x_18002 = add64(y_17993, x_18001);
            int64_t mul_res_18003 = add64(y_17995, x_18002);
            int64_t x_18004 = mul64(x_17885, defunc_0_f_res_17886);
            int64_t y_18005 = mul64(x_17884, defunc_0_f_res_17887);
            int64_t x_18006 = add64(x_18004, y_18005);
            int64_t y_18007 = mul64(x_17883, defunc_0_f_res_17888);
            int64_t x_18008 = add64(x_18006, y_18007);
            int64_t mul_res_18009 = add64(y_18000, x_18008);
            int64_t canonicalizze_arg_18010 = add64(mul_res_17996, redout_17880);
            int64_t canonicalizze_res_18011 = umod64(canonicalizze_arg_18010, (int64_t) -4294967295);
            int64_t canonicalizze_arg_18012 = add64(mul_res_18003, redout_17881);
            int64_t canonicalizze_res_18013 = umod64(canonicalizze_arg_18012, (int64_t) -4294967295);
            int64_t canonicalizze_arg_18014 = add64(mul_res_18009, redout_17882);
            int64_t canonicalizze_res_18015 = umod64(canonicalizze_arg_18014, (int64_t) -4294967295);
            int64_t redout_tmp_18022 = canonicalizze_res_18011;
            int64_t redout_tmp_18023 = canonicalizze_res_18013;
            int64_t redout_tmp_18024 = canonicalizze_res_18015;
            
            redout_17880 = redout_tmp_18022;
            redout_17881 = redout_tmp_18023;
            redout_17882 = redout_tmp_18024;
        }
        defunc_0_f_res_17712 = redout_17880;
        defunc_0_f_res_17713 = redout_17881;
        defunc_0_f_res_17714 = redout_17882;
        
        int64_t x_17852 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17712);
        int64_t y_17853 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17713);
        int64_t x_17854 = sub64(x_17852, y_17853);
        int64_t y_17855 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17714);
        int64_t mul_res_17856 = sub64(x_17854, y_17855);
        int64_t x_17857 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17712);
        int64_t y_17858 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17713);
        int64_t x_17859 = add64(x_17857, y_17858);
        int64_t y_17860 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17714);
        int64_t x_17861 = sub64(x_17859, y_17860);
        int64_t x_17862 = add64(y_17853, x_17861);
        int64_t mul_res_17863 = add64(y_17855, x_17862);
        int64_t x_17864 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17712);
        int64_t y_17865 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17713);
        int64_t x_17866 = add64(x_17864, y_17865);
        int64_t y_17867 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17714);
        int64_t x_17868 = add64(x_17866, y_17867);
        int64_t mul_res_17869 = add64(y_17860, x_17868);
        uniform int64_t tmp_idx_18571 = (int64_t) 0;
        
        ((varying int64_t *) mem_17870)[tmp_idx_18571] = mul_res_17856;
        
        uniform int64_t tmp_idx_18572 = (int64_t) 1;
        
        ((varying int64_t *) mem_17870)[tmp_idx_18572] = mul_res_17863;
        
        uniform int64_t tmp_idx_18573 = (int64_t) 2;
        
        ((varying int64_t *) mem_17870)[tmp_idx_18573] = mul_res_17869;
        if ((int64_t) 24 > 0)
            memmove_64(mem_17094.mem + gtid_17711 * (int64_t) 3 * (int64_t) 8, mem_17870 + (int64_t) 0, extract((int64_t) 24, 0));
    }
    futhark_mc_mem_struct_18574_->mem_17870 = mem_17870;
    futhark_mc_mem_struct_18574_->mem_17870_cached_sizze_18564 = mem_17870_cached_sizze_18564;
    return err;
}
export uniform int futhark_mc_loop_ispc_18563(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18562 *uniform futhark_mc_param_struct_18562_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18562_->ctx;
    uniform int64_t m_12352 = futhark_mc_param_struct_18562_->free_m_12352;
    uniform int64_t p_12353 = futhark_mc_param_struct_18562_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18562_->free_q_12354;
    uniform int64_t gtid_16475 = futhark_mc_param_struct_18562_->free_gtid_16475;
    uniform int64_t defunc_0_f_res_16478 = futhark_mc_param_struct_18562_->free_defunc_0_f_res_16478;
    uniform int64_t defunc_0_f_res_16479 = futhark_mc_param_struct_18562_->free_defunc_0_f_res_16479;
    uniform int64_t defunc_0_f_res_16480 = futhark_mc_param_struct_18562_->free_defunc_0_f_res_16480;
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18565();
    eps_mem_17024.mem = futhark_mc_param_struct_18562_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18566();
    expsss_mem_17025.mem = futhark_mc_param_struct_18562_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18567();
    mem_17078.mem = futhark_mc_param_struct_18562_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18568();
    mem_17082.mem = futhark_mc_param_struct_18562_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18569();
    mem_17086.mem = futhark_mc_param_struct_18562_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform struct memblock mem_17094;
    
    mem_17094.desc = futhark_mc_strlit_shim_18570();
    mem_17094.mem = futhark_mc_param_struct_18562_->free_mem_17094;
    mem_17094.size = 0;
    mem_17094.references = NULL;
    
    size_t mem_17870_cached_sizze_18564 = 0;
    varying unsigned char *uniform mem_17870 = NULL;
    uniform struct futhark_mc_mem_struct_18574 futhark_mc_mem_struct_18574_;
    
    futhark_mc_mem_struct_18574_.mem_17870 = mem_17870;
    futhark_mc_mem_struct_18574_.mem_17870_cached_sizze_18564 = mem_17870_cached_sizze_18564;
    
    uniform int err = futhark_mc_inner_ispc_18575(start, end, futhark_mc_param_struct_18562_, &futhark_mc_mem_struct_18574_);
    
    mem_17870 = futhark_mc_mem_struct_18574_.mem_17870;
    mem_17870_cached_sizze_18564 = futhark_mc_mem_struct_18574_.mem_17870_cached_sizze_18564;
    
  cleanup:
    {
        free(mem_17870);
    }
    return err;
}
struct futhark_mc_param_struct_18586 {
    struct futhark_context *ctx;
    int64_t free_m_12352;
    int64_t free_p_12353;
    int64_t free_q_12354;
    int64_t free_gtid_16475;
    int64_t free_defunc_0_f_res_16478;
    int64_t free_defunc_0_f_res_16479;
    int64_t free_defunc_0_f_res_16480;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    unsigned char *free_mem_17094;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18589();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18590();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18591();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18592();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18593();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18594();
struct futhark_mc_task_18595 {
    struct futhark_context *ctx;
    int64_t free_m_12352;
    int64_t free_q_12354;
    int64_t free_gtid_16475;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    int64_t free_gtid_17400;
    int64_t free_flat_tid_18037;
    int64_t free_flat_tid_18182;
    int64_t *retval_defunc_0_f_res_17401;
    int64_t *retval_defunc_0_f_res_17402;
    int64_t *retval_defunc_0_f_res_17403;
};
struct futhark_mc_param_struct_18602 {
    struct futhark_context *ctx;
    int64_t free_m_12352;
    int64_t free_q_12354;
    int64_t free_gtid_16475;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    int64_t free_gtid_17400;
    int64_t free_flat_tid_18182;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18330;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18332;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18334;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18604();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18605();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18606();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18607();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18608();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18609();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18610();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18611();
export uniform int futhark_mc_loop_ispc_18603(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18602 *uniform futhark_mc_param_struct_18602_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18602_->ctx;
    uniform int64_t m_12352 = futhark_mc_param_struct_18602_->free_m_12352;
    uniform int64_t q_12354 = futhark_mc_param_struct_18602_->free_q_12354;
    uniform int64_t gtid_16475 = futhark_mc_param_struct_18602_->free_gtid_16475;
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18604();
    eps_mem_17024.mem = futhark_mc_param_struct_18602_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18605();
    expsss_mem_17025.mem = futhark_mc_param_struct_18602_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18606();
    mem_17078.mem = futhark_mc_param_struct_18602_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18607();
    mem_17082.mem = futhark_mc_param_struct_18602_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18608();
    mem_17086.mem = futhark_mc_param_struct_18602_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform int64_t gtid_17400 = futhark_mc_param_struct_18602_->free_gtid_17400;
    uniform int64_t flat_tid_18182 = futhark_mc_param_struct_18602_->free_flat_tid_18182;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18330;
    
    reduce_stage_1_tid_res_arr_mem_18330.desc = futhark_mc_strlit_shim_18609();
    reduce_stage_1_tid_res_arr_mem_18330.mem = futhark_mc_param_struct_18602_->free_reduce_stage_1_tid_res_arr_mem_18330;
    reduce_stage_1_tid_res_arr_mem_18330.size = 0;
    reduce_stage_1_tid_res_arr_mem_18330.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18332;
    
    reduce_stage_1_tid_res_arr_mem_18332.desc = futhark_mc_strlit_shim_18610();
    reduce_stage_1_tid_res_arr_mem_18332.mem = futhark_mc_param_struct_18602_->free_reduce_stage_1_tid_res_arr_mem_18332;
    reduce_stage_1_tid_res_arr_mem_18332.size = 0;
    reduce_stage_1_tid_res_arr_mem_18332.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18334;
    
    reduce_stage_1_tid_res_arr_mem_18334.desc = futhark_mc_strlit_shim_18611();
    reduce_stage_1_tid_res_arr_mem_18334.mem = futhark_mc_param_struct_18602_->free_reduce_stage_1_tid_res_arr_mem_18334;
    reduce_stage_1_tid_res_arr_mem_18334.size = 0;
    reduce_stage_1_tid_res_arr_mem_18334.references = NULL;
    
    uniform int err = 0;
    uniform int64_t x_18184;
    uniform int64_t x_18185;
    uniform int64_t x_18186;
    uniform int64_t x_18187;
    uniform int64_t x_18188;
    uniform int64_t x_18189;
    uniform int64_t local_acc_18336 = (int64_t) 0;
    uniform int64_t local_acc_18337 = (int64_t) 0;
    uniform int64_t local_acc_18338 = (int64_t) 0;
    uniform int64_t start_18339;
    uniform int64_t end_18340;
    
    start_18339 = start;
    end_18340 = end;
    
    uniform int64_t n_18341 = end_18340 - start_18339;
    
    foreach (SegRed_i_18342 = start_18339 ... start_18339 + n_18341)
    {
        int64_t gtid_18183 = SegRed_i_18342;
        int64_t x_18196;
        
        x_18196 = ((int64_t *) mem_17078.mem)[gtid_17400 * q_12354 + gtid_18183];
        
        int64_t x_18197;
        
        x_18197 = ((int64_t *) mem_17082.mem)[gtid_17400 * q_12354 + gtid_18183];
        
        int64_t x_18198;
        
        x_18198 = ((int64_t *) mem_17086.mem)[gtid_17400 * q_12354 + gtid_18183];
        
        int64_t defunc_0_f_res_18199;
        int64_t defunc_0_f_res_18200;
        int64_t defunc_0_f_res_18201;
        int64_t redout_18203;
        int64_t redout_18204;
        int64_t redout_18205;
        
        redout_18203 = (int64_t) 1;
        redout_18204 = (int64_t) 0;
        redout_18205 = (int64_t) 0;
        for (uniform int64_t i_18202 = 0; i_18202 < m_12352; i_18202++) {
            int64_t x_18206;
            
            x_18206 = ((int64_t *) expsss_mem_17025.mem)[gtid_17400 * (m_12352 * q_12354) + gtid_18183 * m_12352 + i_18202];
            
            uniform int64_t x_18207;
            
            x_18207 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + i_18202 * (int64_t) 3];
            
            uniform int64_t x_18208;
            
            x_18208 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + i_18202 * (int64_t) 3 + (int64_t) 1];
            
            uniform int64_t x_18209;
            
            x_18209 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + i_18202 * (int64_t) 3 + (int64_t) 2];
            
            bool loop_cond_18210 = ult64((int64_t) 0, x_18206);
            bool mod_pow_u64_res_18211;
            int64_t mod_pow_u64_res_18212;
            int64_t mod_pow_u64_res_18213;
            int64_t mod_pow_u64_res_18214;
            int64_t mod_pow_u64_res_18215;
            int64_t mod_pow_u64_res_18216;
            int64_t mod_pow_u64_res_18217;
            int64_t mod_pow_u64_res_18218;
            bool loop_while_18219;
            int64_t x_18220;
            int64_t x_18221;
            int64_t x_18222;
            int64_t i_18223;
            int64_t result_18224;
            int64_t result_18225;
            int64_t result_18226;
            
            loop_while_18219 = loop_cond_18210;
            x_18220 = x_18207;
            x_18221 = x_18208;
            x_18222 = x_18209;
            i_18223 = x_18206;
            result_18224 = (int64_t) 1;
            result_18225 = (int64_t) 0;
            result_18226 = (int64_t) 0;
            while (loop_while_18219) {
                int64_t x_18227 = umod64(i_18223, (int64_t) 2);
                bool cond_18228 = x_18227 == (int64_t) 1;
                int64_t loopres_18229;
                int64_t loopres_18230;
                int64_t loopres_18231;
                int64_t loopres_18232;
                int64_t loopres_18233;
                int64_t loopres_18234;
                int64_t loopres_18235;
                
                if (cond_18228 == 1) {
                    int64_t x_18236 = mul64(x_18220, x_18220);
                    int64_t y_18237 = mul64(x_18221, x_18222);
                    int64_t x_18238 = sub64(x_18236, y_18237);
                    int64_t mul_res_18239 = sub64(x_18238, y_18237);
                    int64_t x_18240 = mul64(x_18220, x_18221);
                    int64_t x_18241 = add64(x_18240, x_18240);
                    int64_t y_18242 = mul64(x_18222, x_18222);
                    int64_t x_18243 = sub64(x_18241, y_18242);
                    int64_t x_18244 = add64(y_18237, x_18243);
                    int64_t mul_res_18245 = add64(y_18237, x_18244);
                    int64_t x_18246 = mul64(x_18220, x_18222);
                    int64_t y_18247 = mul64(x_18221, x_18221);
                    int64_t x_18248 = add64(x_18246, y_18247);
                    int64_t x_18249 = add64(x_18246, x_18248);
                    int64_t mul_res_18250 = add64(y_18242, x_18249);
                    int64_t loopres_t_res_18251 = lshr64(i_18223, (int64_t) 1);
                    int64_t x_18252 = mul64(x_18220, result_18224);
                    int64_t y_18253 = mul64(x_18222, result_18225);
                    int64_t x_18254 = sub64(x_18252, y_18253);
                    int64_t y_18255 = mul64(x_18221, result_18226);
                    int64_t mul_res_18256 = sub64(x_18254, y_18255);
                    int64_t x_18257 = mul64(x_18221, result_18224);
                    int64_t y_18258 = mul64(x_18220, result_18225);
                    int64_t x_18259 = add64(x_18257, y_18258);
                    int64_t y_18260 = mul64(x_18222, result_18226);
                    int64_t x_18261 = sub64(x_18259, y_18260);
                    int64_t x_18262 = add64(y_18253, x_18261);
                    int64_t mul_res_18263 = add64(y_18255, x_18262);
                    int64_t x_18264 = mul64(x_18222, result_18224);
                    int64_t y_18265 = mul64(x_18221, result_18225);
                    int64_t x_18266 = add64(x_18264, y_18265);
                    int64_t y_18267 = mul64(x_18220, result_18226);
                    int64_t x_18268 = add64(x_18266, y_18267);
                    int64_t mul_res_18269 = add64(y_18260, x_18268);
                    
                    loopres_18229 = mul_res_18239;
                    loopres_18230 = mul_res_18245;
                    loopres_18231 = mul_res_18250;
                    loopres_18232 = loopres_t_res_18251;
                    loopres_18233 = mul_res_18256;
                    loopres_18234 = mul_res_18263;
                    loopres_18235 = mul_res_18269;
                } else {
                    int64_t x_18270 = mul64(x_18220, x_18220);
                    int64_t y_18271 = mul64(x_18221, x_18222);
                    int64_t x_18272 = sub64(x_18270, y_18271);
                    int64_t mul_res_18273 = sub64(x_18272, y_18271);
                    int64_t x_18274 = mul64(x_18220, x_18221);
                    int64_t x_18275 = add64(x_18274, x_18274);
                    int64_t y_18276 = mul64(x_18222, x_18222);
                    int64_t x_18277 = sub64(x_18275, y_18276);
                    int64_t x_18278 = add64(y_18271, x_18277);
                    int64_t mul_res_18279 = add64(y_18271, x_18278);
                    int64_t x_18280 = mul64(x_18220, x_18222);
                    int64_t y_18281 = mul64(x_18221, x_18221);
                    int64_t x_18282 = add64(x_18280, y_18281);
                    int64_t x_18283 = add64(x_18280, x_18282);
                    int64_t mul_res_18284 = add64(y_18276, x_18283);
                    int64_t loopres_f_res_18285 = lshr64(i_18223, (int64_t) 1);
                    
                    loopres_18229 = mul_res_18273;
                    loopres_18230 = mul_res_18279;
                    loopres_18231 = mul_res_18284;
                    loopres_18232 = loopres_f_res_18285;
                    loopres_18233 = result_18224;
                    loopres_18234 = result_18225;
                    loopres_18235 = result_18226;
                }
                
                bool loop_cond_18286 = ult64((int64_t) 0, loopres_18232);
                bool loop_while_tmp_18346 = loop_cond_18286;
                int64_t x_tmp_18347 = loopres_18229;
                int64_t x_tmp_18348 = loopres_18230;
                int64_t x_tmp_18349 = loopres_18231;
                int64_t i_tmp_18350 = loopres_18232;
                int64_t result_tmp_18351 = loopres_18233;
                int64_t result_tmp_18352 = loopres_18234;
                int64_t result_tmp_18353 = loopres_18235;
                
                loop_while_18219 = loop_while_tmp_18346;
                x_18220 = x_tmp_18347;
                x_18221 = x_tmp_18348;
                x_18222 = x_tmp_18349;
                i_18223 = i_tmp_18350;
                result_18224 = result_tmp_18351;
                result_18225 = result_tmp_18352;
                result_18226 = result_tmp_18353;
            }
            mod_pow_u64_res_18211 = loop_while_18219;
            mod_pow_u64_res_18212 = x_18220;
            mod_pow_u64_res_18213 = x_18221;
            mod_pow_u64_res_18214 = x_18222;
            mod_pow_u64_res_18215 = i_18223;
            mod_pow_u64_res_18216 = result_18224;
            mod_pow_u64_res_18217 = result_18225;
            mod_pow_u64_res_18218 = result_18226;
            
            int64_t x_18287 = mul64(mod_pow_u64_res_18216, redout_18203);
            int64_t y_18288 = mul64(mod_pow_u64_res_18217, redout_18205);
            int64_t x_18289 = sub64(x_18287, y_18288);
            int64_t y_18290 = mul64(mod_pow_u64_res_18218, redout_18204);
            int64_t defunc_1_op_res_18291 = sub64(x_18289, y_18290);
            int64_t x_18292 = mul64(mod_pow_u64_res_18216, redout_18204);
            int64_t y_18293 = mul64(mod_pow_u64_res_18217, redout_18203);
            int64_t x_18294 = add64(x_18292, y_18293);
            int64_t y_18295 = mul64(mod_pow_u64_res_18218, redout_18205);
            int64_t x_18296 = sub64(x_18294, y_18295);
            int64_t x_18297 = add64(y_18288, x_18296);
            int64_t defunc_1_op_res_18298 = add64(y_18290, x_18297);
            int64_t x_18299 = mul64(mod_pow_u64_res_18216, redout_18205);
            int64_t y_18300 = mul64(mod_pow_u64_res_18217, redout_18204);
            int64_t x_18301 = add64(x_18299, y_18300);
            int64_t y_18302 = mul64(mod_pow_u64_res_18218, redout_18203);
            int64_t x_18303 = add64(x_18301, y_18302);
            int64_t defunc_1_op_res_18304 = add64(y_18295, x_18303);
            int64_t redout_tmp_18343 = defunc_1_op_res_18291;
            int64_t redout_tmp_18344 = defunc_1_op_res_18298;
            int64_t redout_tmp_18345 = defunc_1_op_res_18304;
            
            redout_18203 = redout_tmp_18343;
            redout_18204 = redout_tmp_18344;
            redout_18205 = redout_tmp_18345;
        }
        defunc_0_f_res_18199 = redout_18203;
        defunc_0_f_res_18200 = redout_18204;
        defunc_0_f_res_18201 = redout_18205;
        
        int64_t x_18305 = mul64(x_18196, defunc_0_f_res_18199);
        int64_t y_18306 = mul64(x_18198, defunc_0_f_res_18200);
        int64_t x_18307 = sub64(x_18305, y_18306);
        int64_t y_18308 = mul64(x_18197, defunc_0_f_res_18201);
        int64_t mul_res_18309 = sub64(x_18307, y_18308);
        int64_t x_18310 = mul64(x_18197, defunc_0_f_res_18199);
        int64_t y_18311 = mul64(x_18196, defunc_0_f_res_18200);
        int64_t x_18312 = add64(x_18310, y_18311);
        int64_t y_18313 = mul64(x_18198, defunc_0_f_res_18201);
        int64_t x_18314 = sub64(x_18312, y_18313);
        int64_t x_18315 = add64(y_18306, x_18314);
        int64_t mul_res_18316 = add64(y_18308, x_18315);
        int64_t x_18317 = mul64(x_18198, defunc_0_f_res_18199);
        int64_t y_18318 = mul64(x_18197, defunc_0_f_res_18200);
        int64_t x_18319 = add64(x_18317, y_18318);
        int64_t y_18320 = mul64(x_18196, defunc_0_f_res_18201);
        int64_t x_18321 = add64(x_18319, y_18320);
        int64_t mul_res_18322 = add64(y_18313, x_18321);
        
        // save map-out results
        { }
        for (uniform unsigned int uni_i_18354 = 0; uni_i_18354 < programCount; uni_i_18354++) {
            if (programIndex == uni_i_18354) {
                // Load accum params
                {
                    x_18184 = local_acc_18336;
                    x_18185 = local_acc_18337;
                    x_18186 = local_acc_18338;
                }
                // Load next params
                {
                    x_18187 = extract(mul_res_18309, uni_i_18354);
                    x_18188 = extract(mul_res_18316, uni_i_18354);
                    x_18189 = extract(mul_res_18322, uni_i_18354);
                }
                // SegRed body
                {
                    uniform int64_t canonicalizze_arg_18190 = add64(x_18184, x_18187);
                    uniform int64_t canonicalizze_res_18191 = umod64(canonicalizze_arg_18190, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18192 = add64(x_18185, x_18188);
                    uniform int64_t canonicalizze_res_18193 = umod64(canonicalizze_arg_18192, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18194 = add64(x_18186, x_18189);
                    uniform int64_t canonicalizze_res_18195 = umod64(canonicalizze_arg_18194, (int64_t) -4294967295);
                    
                    local_acc_18336 = canonicalizze_res_18191;
                    local_acc_18337 = canonicalizze_res_18193;
                    local_acc_18338 = canonicalizze_res_18195;
                }
            }
        }
    }
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18330.mem)[flat_tid_18182] = local_acc_18336;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18332.mem)[flat_tid_18182] = local_acc_18337;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18334.mem)[flat_tid_18182] = local_acc_18338;
    
  cleanup:
    { }
    return err;
}
struct futhark_mc_param_struct_18618 {
    struct futhark_context *ctx;
    int64_t free_m_12352;
    int64_t free_q_12354;
    int64_t free_gtid_16475;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    unsigned char *free_mem_17078;
    unsigned char *free_mem_17082;
    unsigned char *free_mem_17086;
    int64_t free_gtid_17400;
    int64_t free_flat_tid_18037;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18369;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18371;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18373;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18620();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18621();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18622();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18623();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18624();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18625();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18626();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18627();
struct futhark_mc_task_18628 {
    struct futhark_context *ctx;
    int64_t free_m_12352;
    int64_t free_q_12354;
    int64_t free_gtid_16475;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    int64_t free_gtid_17400;
    int64_t free_gtid_18038;
    int64_t free_flat_tid_18057;
    int64_t *retval_defunc_0_f_res_18054;
    int64_t *retval_defunc_0_f_res_18055;
    int64_t *retval_defunc_0_f_res_18056;
};
struct futhark_mc_param_struct_18635 {
    struct futhark_context *ctx;
    int64_t free_m_12352;
    int64_t free_q_12354;
    int64_t free_gtid_16475;
    unsigned char *free_eps_mem_17024;
    unsigned char *free_expsss_mem_17025;
    int64_t free_gtid_17400;
    int64_t free_gtid_18038;
    int64_t free_flat_tid_18057;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18383;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18385;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18387;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18637();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18638();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18639();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18640();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18641();
export uniform int futhark_mc_loop_ispc_18636(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18635 *uniform futhark_mc_param_struct_18635_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18635_->ctx;
    uniform int64_t m_12352 = futhark_mc_param_struct_18635_->free_m_12352;
    uniform int64_t q_12354 = futhark_mc_param_struct_18635_->free_q_12354;
    uniform int64_t gtid_16475 = futhark_mc_param_struct_18635_->free_gtid_16475;
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18637();
    eps_mem_17024.mem = futhark_mc_param_struct_18635_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18638();
    expsss_mem_17025.mem = futhark_mc_param_struct_18635_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform int64_t gtid_17400 = futhark_mc_param_struct_18635_->free_gtid_17400;
    uniform int64_t gtid_18038 = futhark_mc_param_struct_18635_->free_gtid_18038;
    uniform int64_t flat_tid_18057 = futhark_mc_param_struct_18635_->free_flat_tid_18057;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18383;
    
    reduce_stage_1_tid_res_arr_mem_18383.desc = futhark_mc_strlit_shim_18639();
    reduce_stage_1_tid_res_arr_mem_18383.mem = futhark_mc_param_struct_18635_->free_reduce_stage_1_tid_res_arr_mem_18383;
    reduce_stage_1_tid_res_arr_mem_18383.size = 0;
    reduce_stage_1_tid_res_arr_mem_18383.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18385;
    
    reduce_stage_1_tid_res_arr_mem_18385.desc = futhark_mc_strlit_shim_18640();
    reduce_stage_1_tid_res_arr_mem_18385.mem = futhark_mc_param_struct_18635_->free_reduce_stage_1_tid_res_arr_mem_18385;
    reduce_stage_1_tid_res_arr_mem_18385.size = 0;
    reduce_stage_1_tid_res_arr_mem_18385.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18387;
    
    reduce_stage_1_tid_res_arr_mem_18387.desc = futhark_mc_strlit_shim_18641();
    reduce_stage_1_tid_res_arr_mem_18387.mem = futhark_mc_param_struct_18635_->free_reduce_stage_1_tid_res_arr_mem_18387;
    reduce_stage_1_tid_res_arr_mem_18387.size = 0;
    reduce_stage_1_tid_res_arr_mem_18387.references = NULL;
    
    uniform int err = 0;
    uniform int64_t x_18059;
    uniform int64_t x_18060;
    uniform int64_t x_18061;
    uniform int64_t x_18062;
    uniform int64_t x_18063;
    uniform int64_t x_18064;
    uniform int64_t local_acc_18389 = (int64_t) 1;
    uniform int64_t local_acc_18390 = (int64_t) 0;
    uniform int64_t local_acc_18391 = (int64_t) 0;
    uniform int64_t start_18392;
    uniform int64_t end_18393;
    
    start_18392 = start;
    end_18393 = end;
    
    uniform int64_t n_18394 = end_18393 - start_18392;
    
    foreach (SegRed_i_18395 = start_18392 ... start_18392 + n_18394)
    {
        int64_t gtid_18058 = SegRed_i_18395;
        int64_t x_18083;
        
        x_18083 = ((int64_t *) expsss_mem_17025.mem)[gtid_17400 * (m_12352 * q_12354) + gtid_18038 * m_12352 + gtid_18058];
        
        int64_t x_18084;
        
        x_18084 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + gtid_18058 * (int64_t) 3];
        
        int64_t x_18085;
        
        x_18085 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + gtid_18058 * (int64_t) 3 + (int64_t) 1];
        
        int64_t x_18086;
        
        x_18086 = ((int64_t *) eps_mem_17024.mem)[gtid_16475 * ((int64_t) 3 * m_12352) + gtid_18058 * (int64_t) 3 + (int64_t) 2];
        
        bool loop_cond_18087 = ult64((int64_t) 0, x_18083);
        bool mod_pow_u64_res_18088;
        int64_t mod_pow_u64_res_18089;
        int64_t mod_pow_u64_res_18090;
        int64_t mod_pow_u64_res_18091;
        int64_t mod_pow_u64_res_18092;
        int64_t mod_pow_u64_res_18093;
        int64_t mod_pow_u64_res_18094;
        int64_t mod_pow_u64_res_18095;
        bool loop_while_18096;
        int64_t x_18097;
        int64_t x_18098;
        int64_t x_18099;
        int64_t i_18100;
        int64_t result_18101;
        int64_t result_18102;
        int64_t result_18103;
        
        loop_while_18096 = loop_cond_18087;
        x_18097 = x_18084;
        x_18098 = x_18085;
        x_18099 = x_18086;
        i_18100 = x_18083;
        result_18101 = (int64_t) 1;
        result_18102 = (int64_t) 0;
        result_18103 = (int64_t) 0;
        while (loop_while_18096) {
            int64_t x_18104 = umod64(i_18100, (int64_t) 2);
            bool cond_18105 = x_18104 == (int64_t) 1;
            int64_t loopres_18106;
            int64_t loopres_18107;
            int64_t loopres_18108;
            int64_t loopres_18109;
            int64_t loopres_18110;
            int64_t loopres_18111;
            int64_t loopres_18112;
            
            if (cond_18105 == 1) {
                int64_t x_18113 = mul64(x_18097, x_18097);
                int64_t y_18114 = mul64(x_18098, x_18099);
                int64_t x_18115 = sub64(x_18113, y_18114);
                int64_t mul_res_18116 = sub64(x_18115, y_18114);
                int64_t x_18117 = mul64(x_18097, x_18098);
                int64_t x_18118 = add64(x_18117, x_18117);
                int64_t y_18119 = mul64(x_18099, x_18099);
                int64_t x_18120 = sub64(x_18118, y_18119);
                int64_t x_18121 = add64(y_18114, x_18120);
                int64_t mul_res_18122 = add64(y_18114, x_18121);
                int64_t x_18123 = mul64(x_18097, x_18099);
                int64_t y_18124 = mul64(x_18098, x_18098);
                int64_t x_18125 = add64(x_18123, y_18124);
                int64_t x_18126 = add64(x_18123, x_18125);
                int64_t mul_res_18127 = add64(y_18119, x_18126);
                int64_t loopres_t_res_18128 = lshr64(i_18100, (int64_t) 1);
                int64_t x_18129 = mul64(x_18097, result_18101);
                int64_t y_18130 = mul64(x_18099, result_18102);
                int64_t x_18131 = sub64(x_18129, y_18130);
                int64_t y_18132 = mul64(x_18098, result_18103);
                int64_t mul_res_18133 = sub64(x_18131, y_18132);
                int64_t x_18134 = mul64(x_18098, result_18101);
                int64_t y_18135 = mul64(x_18097, result_18102);
                int64_t x_18136 = add64(x_18134, y_18135);
                int64_t y_18137 = mul64(x_18099, result_18103);
                int64_t x_18138 = sub64(x_18136, y_18137);
                int64_t x_18139 = add64(y_18130, x_18138);
                int64_t mul_res_18140 = add64(y_18132, x_18139);
                int64_t x_18141 = mul64(x_18099, result_18101);
                int64_t y_18142 = mul64(x_18098, result_18102);
                int64_t x_18143 = add64(x_18141, y_18142);
                int64_t y_18144 = mul64(x_18097, result_18103);
                int64_t x_18145 = add64(x_18143, y_18144);
                int64_t mul_res_18146 = add64(y_18137, x_18145);
                
                loopres_18106 = mul_res_18116;
                loopres_18107 = mul_res_18122;
                loopres_18108 = mul_res_18127;
                loopres_18109 = loopres_t_res_18128;
                loopres_18110 = mul_res_18133;
                loopres_18111 = mul_res_18140;
                loopres_18112 = mul_res_18146;
            } else {
                int64_t x_18147 = mul64(x_18097, x_18097);
                int64_t y_18148 = mul64(x_18098, x_18099);
                int64_t x_18149 = sub64(x_18147, y_18148);
                int64_t mul_res_18150 = sub64(x_18149, y_18148);
                int64_t x_18151 = mul64(x_18097, x_18098);
                int64_t x_18152 = add64(x_18151, x_18151);
                int64_t y_18153 = mul64(x_18099, x_18099);
                int64_t x_18154 = sub64(x_18152, y_18153);
                int64_t x_18155 = add64(y_18148, x_18154);
                int64_t mul_res_18156 = add64(y_18148, x_18155);
                int64_t x_18157 = mul64(x_18097, x_18099);
                int64_t y_18158 = mul64(x_18098, x_18098);
                int64_t x_18159 = add64(x_18157, y_18158);
                int64_t x_18160 = add64(x_18157, x_18159);
                int64_t mul_res_18161 = add64(y_18153, x_18160);
                int64_t loopres_f_res_18162 = lshr64(i_18100, (int64_t) 1);
                
                loopres_18106 = mul_res_18150;
                loopres_18107 = mul_res_18156;
                loopres_18108 = mul_res_18161;
                loopres_18109 = loopres_f_res_18162;
                loopres_18110 = result_18101;
                loopres_18111 = result_18102;
                loopres_18112 = result_18103;
            }
            
            bool loop_cond_18163 = ult64((int64_t) 0, loopres_18109);
            bool loop_while_tmp_18396 = loop_cond_18163;
            int64_t x_tmp_18397 = loopres_18106;
            int64_t x_tmp_18398 = loopres_18107;
            int64_t x_tmp_18399 = loopres_18108;
            int64_t i_tmp_18400 = loopres_18109;
            int64_t result_tmp_18401 = loopres_18110;
            int64_t result_tmp_18402 = loopres_18111;
            int64_t result_tmp_18403 = loopres_18112;
            
            loop_while_18096 = loop_while_tmp_18396;
            x_18097 = x_tmp_18397;
            x_18098 = x_tmp_18398;
            x_18099 = x_tmp_18399;
            i_18100 = i_tmp_18400;
            result_18101 = result_tmp_18401;
            result_18102 = result_tmp_18402;
            result_18103 = result_tmp_18403;
        }
        mod_pow_u64_res_18088 = loop_while_18096;
        mod_pow_u64_res_18089 = x_18097;
        mod_pow_u64_res_18090 = x_18098;
        mod_pow_u64_res_18091 = x_18099;
        mod_pow_u64_res_18092 = i_18100;
        mod_pow_u64_res_18093 = result_18101;
        mod_pow_u64_res_18094 = result_18102;
        mod_pow_u64_res_18095 = result_18103;
        // save map-out results
        { }
        for (uniform unsigned int uni_i_18404 = 0; uni_i_18404 < programCount; uni_i_18404++) {
            if (programIndex == uni_i_18404) {
                // Load accum params
                {
                    x_18059 = local_acc_18389;
                    x_18060 = local_acc_18390;
                    x_18061 = local_acc_18391;
                }
                // Load next params
                {
                    x_18062 = extract(mod_pow_u64_res_18093, uni_i_18404);
                    x_18063 = extract(mod_pow_u64_res_18094, uni_i_18404);
                    x_18064 = extract(mod_pow_u64_res_18095, uni_i_18404);
                }
                // SegRed body
                {
                    uniform int64_t x_18065 = mul64(x_18059, x_18062);
                    uniform int64_t y_18066 = mul64(x_18061, x_18063);
                    uniform int64_t x_18067 = sub64(x_18065, y_18066);
                    uniform int64_t y_18068 = mul64(x_18060, x_18064);
                    uniform int64_t defunc_1_op_res_18069 = sub64(x_18067, y_18068);
                    uniform int64_t x_18070 = mul64(x_18060, x_18062);
                    uniform int64_t y_18071 = mul64(x_18059, x_18063);
                    uniform int64_t x_18072 = add64(x_18070, y_18071);
                    uniform int64_t y_18073 = mul64(x_18061, x_18064);
                    uniform int64_t x_18074 = sub64(x_18072, y_18073);
                    uniform int64_t x_18075 = add64(y_18066, x_18074);
                    uniform int64_t defunc_1_op_res_18076 = add64(y_18068, x_18075);
                    uniform int64_t x_18077 = mul64(x_18061, x_18062);
                    uniform int64_t y_18078 = mul64(x_18060, x_18063);
                    uniform int64_t x_18079 = add64(x_18077, y_18078);
                    uniform int64_t y_18080 = mul64(x_18059, x_18064);
                    uniform int64_t x_18081 = add64(x_18079, y_18080);
                    uniform int64_t defunc_1_op_res_18082 = add64(y_18073, x_18081);
                    
                    local_acc_18389 = defunc_1_op_res_18069;
                    local_acc_18390 = defunc_1_op_res_18076;
                    local_acc_18391 = defunc_1_op_res_18082;
                }
            }
        }
    }
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18383.mem)[flat_tid_18057] = local_acc_18389;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18385.mem)[flat_tid_18057] = local_acc_18390;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18387.mem)[flat_tid_18057] = local_acc_18391;
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18642(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18628 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18644 { };
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18646();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18647();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18648();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18649();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18650();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18651();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18652();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18653();
static unmasked inline uniform int futhark_mc_inner_ispc_18645(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18618 *uniform futhark_mc_param_struct_18618_, uniform struct futhark_mc_mem_struct_18644 *uniform futhark_mc_mem_struct_18644_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18618_->ctx;
    uniform int64_t m_12352 = futhark_mc_param_struct_18618_->free_m_12352;
    uniform int64_t q_12354 = futhark_mc_param_struct_18618_->free_q_12354;
    uniform int64_t gtid_16475 = futhark_mc_param_struct_18618_->free_gtid_16475;
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18646();
    eps_mem_17024.mem = futhark_mc_param_struct_18618_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18647();
    expsss_mem_17025.mem = futhark_mc_param_struct_18618_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18648();
    mem_17078.mem = futhark_mc_param_struct_18618_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18649();
    mem_17082.mem = futhark_mc_param_struct_18618_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18650();
    mem_17086.mem = futhark_mc_param_struct_18618_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform int64_t gtid_17400 = futhark_mc_param_struct_18618_->free_gtid_17400;
    uniform int64_t flat_tid_18037 = futhark_mc_param_struct_18618_->free_flat_tid_18037;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18369;
    
    reduce_stage_1_tid_res_arr_mem_18369.desc = futhark_mc_strlit_shim_18651();
    reduce_stage_1_tid_res_arr_mem_18369.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18369;
    reduce_stage_1_tid_res_arr_mem_18369.size = 0;
    reduce_stage_1_tid_res_arr_mem_18369.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18371;
    
    reduce_stage_1_tid_res_arr_mem_18371.desc = futhark_mc_strlit_shim_18652();
    reduce_stage_1_tid_res_arr_mem_18371.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18371;
    reduce_stage_1_tid_res_arr_mem_18371.size = 0;
    reduce_stage_1_tid_res_arr_mem_18371.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18373;
    
    reduce_stage_1_tid_res_arr_mem_18373.desc = futhark_mc_strlit_shim_18653();
    reduce_stage_1_tid_res_arr_mem_18373.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18373;
    reduce_stage_1_tid_res_arr_mem_18373.size = 0;
    reduce_stage_1_tid_res_arr_mem_18373.references = NULL;
    
    uniform int err = 0;
    uniform int64_t x_18039;
    uniform int64_t x_18040;
    uniform int64_t x_18041;
    uniform int64_t x_18042;
    uniform int64_t x_18043;
    uniform int64_t x_18044;
    uniform int64_t local_acc_18375 = (int64_t) 0;
    uniform int64_t local_acc_18376 = (int64_t) 0;
    uniform int64_t local_acc_18377 = (int64_t) 0;
    uniform int64_t start_18378;
    uniform int64_t end_18379;
    
    start_18378 = start;
    end_18379 = end;
    
    uniform int64_t n_18380 = end_18379 - start_18378;
    
    for (uniform int64_t i = 0; i < (start_18378 + n_18380 - start_18378) / programCount; i++) {
        int64_t SegRed_i_18381 = start_18378 + programIndex + i * programCount;
        int64_t gtid_18038 = SegRed_i_18381;
        int64_t x_18051;
        
        x_18051 = ((int64_t *) mem_17078.mem)[gtid_17400 * q_12354 + gtid_18038];
        
        int64_t x_18052;
        
        x_18052 = ((int64_t *) mem_17082.mem)[gtid_17400 * q_12354 + gtid_18038];
        
        int64_t x_18053;
        
        x_18053 = ((int64_t *) mem_17086.mem)[gtid_17400 * q_12354 + gtid_18038];
        
        int64_t defunc_0_f_res_18054;
        int64_t defunc_0_f_res_18055;
        int64_t defunc_0_f_res_18056;
        uniform int64_t flat_tid_18057 = (int64_t) 0;
        
        defunc_0_f_res_18054 = (int64_t) 0;
        defunc_0_f_res_18055 = (int64_t) 0;
        defunc_0_f_res_18056 = (int64_t) 0;
        
        struct futhark_mc_task_18628 futhark_mc_task_18628_;
        
        futhark_mc_task_18628_.ctx = ctx;
        futhark_mc_task_18628_.free_m_12352 = m_12352;
        futhark_mc_task_18628_.free_q_12354 = q_12354;
        futhark_mc_task_18628_.free_gtid_16475 = gtid_16475;
        futhark_mc_task_18628_.free_eps_mem_17024 = eps_mem_17024.mem;
        futhark_mc_task_18628_.free_expsss_mem_17025 = expsss_mem_17025.mem;
        futhark_mc_task_18628_.free_gtid_17400 = gtid_17400;
        futhark_mc_task_18628_.free_gtid_18038 = gtid_18038;
        futhark_mc_task_18628_.free_flat_tid_18057 = flat_tid_18057;
        futhark_mc_task_18628_.retval_defunc_0_f_res_18054 = (int64_t *) &defunc_0_f_res_18054;
        #if ISPC
        futhark_mc_task_18628_.retval_defunc_0_f_res_18054 += programIndex;
        #endif
        futhark_mc_task_18628_.retval_defunc_0_f_res_18055 = (int64_t *) &defunc_0_f_res_18055;
        #if ISPC
        futhark_mc_task_18628_.retval_defunc_0_f_res_18055 += programIndex;
        #endif
        futhark_mc_task_18628_.retval_defunc_0_f_res_18056 = (int64_t *) &defunc_0_f_res_18056;
        #if ISPC
        futhark_mc_task_18628_.retval_defunc_0_f_res_18056 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18628 aos_18643[programCount];
        
        aos_18643[programIndex] = futhark_mc_task_18628_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18642(ctx, &aos_18643[i], extract(m_12352, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18642(ctx, &futhark_mc_task_18628_, m_12352);
        if (err != 0)
            goto cleanup;
        #endif
        
        int64_t x_18164 = mul64(x_18051, defunc_0_f_res_18054);
        int64_t y_18165 = mul64(x_18053, defunc_0_f_res_18055);
        int64_t x_18166 = sub64(x_18164, y_18165);
        int64_t y_18167 = mul64(x_18052, defunc_0_f_res_18056);
        int64_t mul_res_18168 = sub64(x_18166, y_18167);
        int64_t x_18169 = mul64(x_18052, defunc_0_f_res_18054);
        int64_t y_18170 = mul64(x_18051, defunc_0_f_res_18055);
        int64_t x_18171 = add64(x_18169, y_18170);
        int64_t y_18172 = mul64(x_18053, defunc_0_f_res_18056);
        int64_t x_18173 = sub64(x_18171, y_18172);
        int64_t x_18174 = add64(y_18165, x_18173);
        int64_t mul_res_18175 = add64(y_18167, x_18174);
        int64_t x_18176 = mul64(x_18053, defunc_0_f_res_18054);
        int64_t y_18177 = mul64(x_18052, defunc_0_f_res_18055);
        int64_t x_18178 = add64(x_18176, y_18177);
        int64_t y_18179 = mul64(x_18051, defunc_0_f_res_18056);
        int64_t x_18180 = add64(x_18178, y_18179);
        int64_t mul_res_18181 = add64(y_18172, x_18180);
        
        // save map-out results
        { }
        for (uniform unsigned int uni_i_18430 = 0; uni_i_18430 < programCount; uni_i_18430++) {
            if (programIndex == uni_i_18430) {
                // Load accum params
                {
                    x_18039 = local_acc_18375;
                    x_18040 = local_acc_18376;
                    x_18041 = local_acc_18377;
                }
                // Load next params
                {
                    x_18042 = extract(mul_res_18168, uni_i_18430);
                    x_18043 = extract(mul_res_18175, uni_i_18430);
                    x_18044 = extract(mul_res_18181, uni_i_18430);
                }
                // SegRed body
                {
                    uniform int64_t canonicalizze_arg_18045 = add64(x_18039, x_18042);
                    uniform int64_t canonicalizze_res_18046 = umod64(canonicalizze_arg_18045, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18047 = add64(x_18040, x_18043);
                    uniform int64_t canonicalizze_res_18048 = umod64(canonicalizze_arg_18047, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18049 = add64(x_18041, x_18044);
                    uniform int64_t canonicalizze_res_18050 = umod64(canonicalizze_arg_18049, (int64_t) -4294967295);
                    
                    local_acc_18375 = canonicalizze_res_18046;
                    local_acc_18376 = canonicalizze_res_18048;
                    local_acc_18377 = canonicalizze_res_18050;
                }
            }
        }
    }
    if (programIndex < (start_18378 + n_18380 - start_18378) % programCount) {
        int64_t SegRed_i_18381 = start_18378 + programIndex + (start_18378 + n_18380 - start_18378) / programCount * programCount;
        int64_t gtid_18038 = SegRed_i_18381;
        int64_t x_18051;
        
        x_18051 = ((int64_t *) mem_17078.mem)[gtid_17400 * q_12354 + gtid_18038];
        
        int64_t x_18052;
        
        x_18052 = ((int64_t *) mem_17082.mem)[gtid_17400 * q_12354 + gtid_18038];
        
        int64_t x_18053;
        
        x_18053 = ((int64_t *) mem_17086.mem)[gtid_17400 * q_12354 + gtid_18038];
        
        int64_t defunc_0_f_res_18054;
        int64_t defunc_0_f_res_18055;
        int64_t defunc_0_f_res_18056;
        uniform int64_t flat_tid_18057 = (int64_t) 0;
        
        defunc_0_f_res_18054 = (int64_t) 0;
        defunc_0_f_res_18055 = (int64_t) 0;
        defunc_0_f_res_18056 = (int64_t) 0;
        
        struct futhark_mc_task_18628 futhark_mc_task_18628_;
        
        futhark_mc_task_18628_.ctx = ctx;
        futhark_mc_task_18628_.free_m_12352 = m_12352;
        futhark_mc_task_18628_.free_q_12354 = q_12354;
        futhark_mc_task_18628_.free_gtid_16475 = gtid_16475;
        futhark_mc_task_18628_.free_eps_mem_17024 = eps_mem_17024.mem;
        futhark_mc_task_18628_.free_expsss_mem_17025 = expsss_mem_17025.mem;
        futhark_mc_task_18628_.free_gtid_17400 = gtid_17400;
        futhark_mc_task_18628_.free_gtid_18038 = gtid_18038;
        futhark_mc_task_18628_.free_flat_tid_18057 = flat_tid_18057;
        futhark_mc_task_18628_.retval_defunc_0_f_res_18054 = (int64_t *) &defunc_0_f_res_18054;
        #if ISPC
        futhark_mc_task_18628_.retval_defunc_0_f_res_18054 += programIndex;
        #endif
        futhark_mc_task_18628_.retval_defunc_0_f_res_18055 = (int64_t *) &defunc_0_f_res_18055;
        #if ISPC
        futhark_mc_task_18628_.retval_defunc_0_f_res_18055 += programIndex;
        #endif
        futhark_mc_task_18628_.retval_defunc_0_f_res_18056 = (int64_t *) &defunc_0_f_res_18056;
        #if ISPC
        futhark_mc_task_18628_.retval_defunc_0_f_res_18056 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18628 aos_18643[programCount];
        
        aos_18643[programIndex] = futhark_mc_task_18628_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18642(ctx, &aos_18643[i], extract(m_12352, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18642(ctx, &futhark_mc_task_18628_, m_12352);
        if (err != 0)
            goto cleanup;
        #endif
        
        int64_t x_18164 = mul64(x_18051, defunc_0_f_res_18054);
        int64_t y_18165 = mul64(x_18053, defunc_0_f_res_18055);
        int64_t x_18166 = sub64(x_18164, y_18165);
        int64_t y_18167 = mul64(x_18052, defunc_0_f_res_18056);
        int64_t mul_res_18168 = sub64(x_18166, y_18167);
        int64_t x_18169 = mul64(x_18052, defunc_0_f_res_18054);
        int64_t y_18170 = mul64(x_18051, defunc_0_f_res_18055);
        int64_t x_18171 = add64(x_18169, y_18170);
        int64_t y_18172 = mul64(x_18053, defunc_0_f_res_18056);
        int64_t x_18173 = sub64(x_18171, y_18172);
        int64_t x_18174 = add64(y_18165, x_18173);
        int64_t mul_res_18175 = add64(y_18167, x_18174);
        int64_t x_18176 = mul64(x_18053, defunc_0_f_res_18054);
        int64_t y_18177 = mul64(x_18052, defunc_0_f_res_18055);
        int64_t x_18178 = add64(x_18176, y_18177);
        int64_t y_18179 = mul64(x_18051, defunc_0_f_res_18056);
        int64_t x_18180 = add64(x_18178, y_18179);
        int64_t mul_res_18181 = add64(y_18172, x_18180);
        
        // save map-out results
        { }
        for (uniform unsigned int uni_i_18430 = 0; uni_i_18430 < programCount; uni_i_18430++) {
            if (programIndex == uni_i_18430) {
                // Load accum params
                {
                    x_18039 = local_acc_18375;
                    x_18040 = local_acc_18376;
                    x_18041 = local_acc_18377;
                }
                // Load next params
                {
                    x_18042 = extract(mul_res_18168, uni_i_18430);
                    x_18043 = extract(mul_res_18175, uni_i_18430);
                    x_18044 = extract(mul_res_18181, uni_i_18430);
                }
                // SegRed body
                {
                    uniform int64_t canonicalizze_arg_18045 = add64(x_18039, x_18042);
                    uniform int64_t canonicalizze_res_18046 = umod64(canonicalizze_arg_18045, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18047 = add64(x_18040, x_18043);
                    uniform int64_t canonicalizze_res_18048 = umod64(canonicalizze_arg_18047, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18049 = add64(x_18041, x_18044);
                    uniform int64_t canonicalizze_res_18050 = umod64(canonicalizze_arg_18049, (int64_t) -4294967295);
                    
                    local_acc_18375 = canonicalizze_res_18046;
                    local_acc_18376 = canonicalizze_res_18048;
                    local_acc_18377 = canonicalizze_res_18050;
                }
            }
        }
    }
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18369.mem)[flat_tid_18037] = local_acc_18375;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18371.mem)[flat_tid_18037] = local_acc_18376;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18373.mem)[flat_tid_18037] = local_acc_18377;
    return err;
}
export uniform int futhark_mc_loop_ispc_18619(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18618 *uniform futhark_mc_param_struct_18618_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18618_->ctx;
    uniform int64_t m_12352 = futhark_mc_param_struct_18618_->free_m_12352;
    uniform int64_t q_12354 = futhark_mc_param_struct_18618_->free_q_12354;
    uniform int64_t gtid_16475 = futhark_mc_param_struct_18618_->free_gtid_16475;
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18620();
    eps_mem_17024.mem = futhark_mc_param_struct_18618_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18621();
    expsss_mem_17025.mem = futhark_mc_param_struct_18618_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18622();
    mem_17078.mem = futhark_mc_param_struct_18618_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18623();
    mem_17082.mem = futhark_mc_param_struct_18618_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18624();
    mem_17086.mem = futhark_mc_param_struct_18618_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform int64_t gtid_17400 = futhark_mc_param_struct_18618_->free_gtid_17400;
    uniform int64_t flat_tid_18037 = futhark_mc_param_struct_18618_->free_flat_tid_18037;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18369;
    
    reduce_stage_1_tid_res_arr_mem_18369.desc = futhark_mc_strlit_shim_18625();
    reduce_stage_1_tid_res_arr_mem_18369.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18369;
    reduce_stage_1_tid_res_arr_mem_18369.size = 0;
    reduce_stage_1_tid_res_arr_mem_18369.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18371;
    
    reduce_stage_1_tid_res_arr_mem_18371.desc = futhark_mc_strlit_shim_18626();
    reduce_stage_1_tid_res_arr_mem_18371.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18371;
    reduce_stage_1_tid_res_arr_mem_18371.size = 0;
    reduce_stage_1_tid_res_arr_mem_18371.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18373;
    
    reduce_stage_1_tid_res_arr_mem_18373.desc = futhark_mc_strlit_shim_18627();
    reduce_stage_1_tid_res_arr_mem_18373.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18373;
    reduce_stage_1_tid_res_arr_mem_18373.size = 0;
    reduce_stage_1_tid_res_arr_mem_18373.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18644 futhark_mc_mem_struct_18644_;
    uniform int err = futhark_mc_inner_ispc_18645(start, end, futhark_mc_param_struct_18618_, &futhark_mc_mem_struct_18644_);
    
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18654(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18595 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18659 {
    varying unsigned char *uniform mem_17708;
    varying size_t mem_17708_cached_sizze_18588;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18661();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18662();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18663();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18664();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18665();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18666();
static unmasked inline uniform int futhark_mc_inner_ispc_18660(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18586 *uniform futhark_mc_param_struct_18586_, uniform struct futhark_mc_mem_struct_18659 *uniform futhark_mc_mem_struct_18659_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18586_->ctx;
    uniform int64_t m_12352 = futhark_mc_param_struct_18586_->free_m_12352;
    uniform int64_t p_12353 = futhark_mc_param_struct_18586_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18586_->free_q_12354;
    uniform int64_t gtid_16475 = futhark_mc_param_struct_18586_->free_gtid_16475;
    uniform int64_t defunc_0_f_res_16478 = futhark_mc_param_struct_18586_->free_defunc_0_f_res_16478;
    uniform int64_t defunc_0_f_res_16479 = futhark_mc_param_struct_18586_->free_defunc_0_f_res_16479;
    uniform int64_t defunc_0_f_res_16480 = futhark_mc_param_struct_18586_->free_defunc_0_f_res_16480;
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18661();
    eps_mem_17024.mem = futhark_mc_param_struct_18586_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18662();
    expsss_mem_17025.mem = futhark_mc_param_struct_18586_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18663();
    mem_17078.mem = futhark_mc_param_struct_18586_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18664();
    mem_17082.mem = futhark_mc_param_struct_18586_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18665();
    mem_17086.mem = futhark_mc_param_struct_18586_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform struct memblock mem_17094;
    
    mem_17094.desc = futhark_mc_strlit_shim_18666();
    mem_17094.mem = futhark_mc_param_struct_18586_->free_mem_17094;
    mem_17094.size = 0;
    mem_17094.references = NULL;
    
    varying unsigned char *uniform mem_17708 = futhark_mc_mem_struct_18659_->mem_17708;
    size_t mem_17708_cached_sizze_18588 = futhark_mc_mem_struct_18659_->mem_17708_cached_sizze_18588;
    uniform int err = 0;
    uniform int64_t start_18323;
    uniform int64_t end_18324;
    
    start_18323 = start;
    end_18324 = end;
    
    uniform int64_t n_18325 = end_18324 - start_18323;
    
    if (mem_17708_cached_sizze_18588 < (int64_t) 24) {
        err = lexical_realloc(ctx, &mem_17708, &mem_17708_cached_sizze_18588, (int64_t) 24);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    for (uniform int64_t i = 0; i < (start_18323 + n_18325 - start_18323) / programCount; i++) {
        int64_t SegMap_i_18326 = start_18323 + programIndex + i * programCount;
        uniform int64_t slice_18327 = p_12353;
        int64_t gtid_17400 = SegMap_i_18326;
        int64_t remnant_18328 = SegMap_i_18326 - gtid_17400;
        int64_t defunc_0_f_res_17401;
        int64_t defunc_0_f_res_17402;
        int64_t defunc_0_f_res_17403;
        uniform int64_t flat_tid_18182 = (int64_t) 0;
        
        defunc_0_f_res_17401 = (int64_t) 0;
        defunc_0_f_res_17402 = (int64_t) 0;
        defunc_0_f_res_17403 = (int64_t) 0;
        
        uniform int64_t flat_tid_18037 = (int64_t) 0;
        struct futhark_mc_task_18595 futhark_mc_task_18595_;
        
        futhark_mc_task_18595_.ctx = ctx;
        futhark_mc_task_18595_.free_m_12352 = m_12352;
        futhark_mc_task_18595_.free_q_12354 = q_12354;
        futhark_mc_task_18595_.free_gtid_16475 = gtid_16475;
        futhark_mc_task_18595_.free_eps_mem_17024 = eps_mem_17024.mem;
        futhark_mc_task_18595_.free_expsss_mem_17025 = expsss_mem_17025.mem;
        futhark_mc_task_18595_.free_mem_17078 = mem_17078.mem;
        futhark_mc_task_18595_.free_mem_17082 = mem_17082.mem;
        futhark_mc_task_18595_.free_mem_17086 = mem_17086.mem;
        futhark_mc_task_18595_.free_gtid_17400 = gtid_17400;
        futhark_mc_task_18595_.free_flat_tid_18037 = flat_tid_18037;
        futhark_mc_task_18595_.free_flat_tid_18182 = flat_tid_18182;
        futhark_mc_task_18595_.retval_defunc_0_f_res_17401 = (int64_t *) &defunc_0_f_res_17401;
        #if ISPC
        futhark_mc_task_18595_.retval_defunc_0_f_res_17401 += programIndex;
        #endif
        futhark_mc_task_18595_.retval_defunc_0_f_res_17402 = (int64_t *) &defunc_0_f_res_17402;
        #if ISPC
        futhark_mc_task_18595_.retval_defunc_0_f_res_17402 += programIndex;
        #endif
        futhark_mc_task_18595_.retval_defunc_0_f_res_17403 = (int64_t *) &defunc_0_f_res_17403;
        #if ISPC
        futhark_mc_task_18595_.retval_defunc_0_f_res_17403 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18595 aos_18655[programCount];
        
        aos_18655[programIndex] = futhark_mc_task_18595_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18654(ctx, &aos_18655[i], extract(q_12354, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18654(ctx, &futhark_mc_task_18595_, q_12354);
        if (err != 0)
            goto cleanup;
        #endif
        
        int64_t x_17690 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17401);
        int64_t y_17691 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17402);
        int64_t x_17692 = sub64(x_17690, y_17691);
        int64_t y_17693 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17403);
        int64_t mul_res_17694 = sub64(x_17692, y_17693);
        int64_t x_17695 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17401);
        int64_t y_17696 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17402);
        int64_t x_17697 = add64(x_17695, y_17696);
        int64_t y_17698 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17403);
        int64_t x_17699 = sub64(x_17697, y_17698);
        int64_t x_17700 = add64(y_17691, x_17699);
        int64_t mul_res_17701 = add64(y_17693, x_17700);
        int64_t x_17702 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17401);
        int64_t y_17703 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17402);
        int64_t x_17704 = add64(x_17702, y_17703);
        int64_t y_17705 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17403);
        int64_t x_17706 = add64(x_17704, y_17705);
        int64_t mul_res_17707 = add64(y_17698, x_17706);
        uniform int64_t tmp_idx_18656 = (int64_t) 0;
        
        ((varying int64_t *) mem_17708)[tmp_idx_18656] = mul_res_17694;
        
        uniform int64_t tmp_idx_18657 = (int64_t) 1;
        
        ((varying int64_t *) mem_17708)[tmp_idx_18657] = mul_res_17701;
        
        uniform int64_t tmp_idx_18658 = (int64_t) 2;
        
        ((varying int64_t *) mem_17708)[tmp_idx_18658] = mul_res_17707;
        if ((int64_t) 24 > 0)
            memmove_64(mem_17094.mem + gtid_17400 * (int64_t) 3 * (int64_t) 8, mem_17708 + (int64_t) 0, extract((int64_t) 24, 0));
    }
    if (programIndex < (start_18323 + n_18325 - start_18323) % programCount) {
        int64_t SegMap_i_18326 = start_18323 + programIndex + (start_18323 + n_18325 - start_18323) / programCount * programCount;
        uniform int64_t slice_18327 = p_12353;
        int64_t gtid_17400 = SegMap_i_18326;
        int64_t remnant_18328 = SegMap_i_18326 - gtid_17400;
        int64_t defunc_0_f_res_17401;
        int64_t defunc_0_f_res_17402;
        int64_t defunc_0_f_res_17403;
        uniform int64_t flat_tid_18182 = (int64_t) 0;
        
        defunc_0_f_res_17401 = (int64_t) 0;
        defunc_0_f_res_17402 = (int64_t) 0;
        defunc_0_f_res_17403 = (int64_t) 0;
        
        uniform int64_t flat_tid_18037 = (int64_t) 0;
        struct futhark_mc_task_18595 futhark_mc_task_18595_;
        
        futhark_mc_task_18595_.ctx = ctx;
        futhark_mc_task_18595_.free_m_12352 = m_12352;
        futhark_mc_task_18595_.free_q_12354 = q_12354;
        futhark_mc_task_18595_.free_gtid_16475 = gtid_16475;
        futhark_mc_task_18595_.free_eps_mem_17024 = eps_mem_17024.mem;
        futhark_mc_task_18595_.free_expsss_mem_17025 = expsss_mem_17025.mem;
        futhark_mc_task_18595_.free_mem_17078 = mem_17078.mem;
        futhark_mc_task_18595_.free_mem_17082 = mem_17082.mem;
        futhark_mc_task_18595_.free_mem_17086 = mem_17086.mem;
        futhark_mc_task_18595_.free_gtid_17400 = gtid_17400;
        futhark_mc_task_18595_.free_flat_tid_18037 = flat_tid_18037;
        futhark_mc_task_18595_.free_flat_tid_18182 = flat_tid_18182;
        futhark_mc_task_18595_.retval_defunc_0_f_res_17401 = (int64_t *) &defunc_0_f_res_17401;
        #if ISPC
        futhark_mc_task_18595_.retval_defunc_0_f_res_17401 += programIndex;
        #endif
        futhark_mc_task_18595_.retval_defunc_0_f_res_17402 = (int64_t *) &defunc_0_f_res_17402;
        #if ISPC
        futhark_mc_task_18595_.retval_defunc_0_f_res_17402 += programIndex;
        #endif
        futhark_mc_task_18595_.retval_defunc_0_f_res_17403 = (int64_t *) &defunc_0_f_res_17403;
        #if ISPC
        futhark_mc_task_18595_.retval_defunc_0_f_res_17403 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18595 aos_18655[programCount];
        
        aos_18655[programIndex] = futhark_mc_task_18595_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18654(ctx, &aos_18655[i], extract(q_12354, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18654(ctx, &futhark_mc_task_18595_, q_12354);
        if (err != 0)
            goto cleanup;
        #endif
        
        int64_t x_17690 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17401);
        int64_t y_17691 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17402);
        int64_t x_17692 = sub64(x_17690, y_17691);
        int64_t y_17693 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17403);
        int64_t mul_res_17694 = sub64(x_17692, y_17693);
        int64_t x_17695 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17401);
        int64_t y_17696 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17402);
        int64_t x_17697 = add64(x_17695, y_17696);
        int64_t y_17698 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17403);
        int64_t x_17699 = sub64(x_17697, y_17698);
        int64_t x_17700 = add64(y_17691, x_17699);
        int64_t mul_res_17701 = add64(y_17693, x_17700);
        int64_t x_17702 = mul64(defunc_0_f_res_16480, defunc_0_f_res_17401);
        int64_t y_17703 = mul64(defunc_0_f_res_16479, defunc_0_f_res_17402);
        int64_t x_17704 = add64(x_17702, y_17703);
        int64_t y_17705 = mul64(defunc_0_f_res_16478, defunc_0_f_res_17403);
        int64_t x_17706 = add64(x_17704, y_17705);
        int64_t mul_res_17707 = add64(y_17698, x_17706);
        uniform int64_t tmp_idx_18656 = (int64_t) 0;
        
        ((varying int64_t *) mem_17708)[tmp_idx_18656] = mul_res_17694;
        
        uniform int64_t tmp_idx_18657 = (int64_t) 1;
        
        ((varying int64_t *) mem_17708)[tmp_idx_18657] = mul_res_17701;
        
        uniform int64_t tmp_idx_18658 = (int64_t) 2;
        
        ((varying int64_t *) mem_17708)[tmp_idx_18658] = mul_res_17707;
        if ((int64_t) 24 > 0)
            memmove_64(mem_17094.mem + gtid_17400 * (int64_t) 3 * (int64_t) 8, mem_17708 + (int64_t) 0, extract((int64_t) 24, 0));
    }
    futhark_mc_mem_struct_18659_->mem_17708 = mem_17708;
    futhark_mc_mem_struct_18659_->mem_17708_cached_sizze_18588 = mem_17708_cached_sizze_18588;
    return err;
}
export uniform int futhark_mc_loop_ispc_18587(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18586 *uniform futhark_mc_param_struct_18586_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18586_->ctx;
    uniform int64_t m_12352 = futhark_mc_param_struct_18586_->free_m_12352;
    uniform int64_t p_12353 = futhark_mc_param_struct_18586_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18586_->free_q_12354;
    uniform int64_t gtid_16475 = futhark_mc_param_struct_18586_->free_gtid_16475;
    uniform int64_t defunc_0_f_res_16478 = futhark_mc_param_struct_18586_->free_defunc_0_f_res_16478;
    uniform int64_t defunc_0_f_res_16479 = futhark_mc_param_struct_18586_->free_defunc_0_f_res_16479;
    uniform int64_t defunc_0_f_res_16480 = futhark_mc_param_struct_18586_->free_defunc_0_f_res_16480;
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18589();
    eps_mem_17024.mem = futhark_mc_param_struct_18586_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18590();
    expsss_mem_17025.mem = futhark_mc_param_struct_18586_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18591();
    mem_17078.mem = futhark_mc_param_struct_18586_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18592();
    mem_17082.mem = futhark_mc_param_struct_18586_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18593();
    mem_17086.mem = futhark_mc_param_struct_18586_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform struct memblock mem_17094;
    
    mem_17094.desc = futhark_mc_strlit_shim_18594();
    mem_17094.mem = futhark_mc_param_struct_18586_->free_mem_17094;
    mem_17094.size = 0;
    mem_17094.references = NULL;
    
    size_t mem_17708_cached_sizze_18588 = 0;
    varying unsigned char *uniform mem_17708 = NULL;
    uniform struct futhark_mc_mem_struct_18659 futhark_mc_mem_struct_18659_;
    
    futhark_mc_mem_struct_18659_.mem_17708 = mem_17708;
    futhark_mc_mem_struct_18659_.mem_17708_cached_sizze_18588 = mem_17708_cached_sizze_18588;
    
    uniform int err = futhark_mc_inner_ispc_18660(start, end, futhark_mc_param_struct_18586_, &futhark_mc_mem_struct_18659_);
    
    mem_17708 = futhark_mc_mem_struct_18659_.mem_17708;
    mem_17708_cached_sizze_18588 = futhark_mc_mem_struct_18659_.mem_17708_cached_sizze_18588;
    
  cleanup:
    {
        free(mem_17708);
    }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18667(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18557 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18669 {
    varying struct memblock *uniform mem_17094;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18671();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18672();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18673();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18674();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18675();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18676();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18677();
static unmasked inline uniform int futhark_mc_inner_ispc_18670(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18547 *uniform futhark_mc_param_struct_18547_, uniform struct futhark_mc_mem_struct_18669 *uniform futhark_mc_mem_struct_18669_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18547_->ctx;
    uniform int64_t n_12351 = futhark_mc_param_struct_18547_->free_n_12351;
    uniform int64_t m_12352 = futhark_mc_param_struct_18547_->free_m_12352;
    uniform int64_t p_12353 = futhark_mc_param_struct_18547_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18547_->free_q_12354;
    uniform struct memblock zzinvs_mem_17023;
    
    zzinvs_mem_17023.desc = futhark_mc_strlit_shim_18671();
    zzinvs_mem_17023.mem = futhark_mc_param_struct_18547_->free_zzinvs_mem_17023;
    zzinvs_mem_17023.size = 0;
    zzinvs_mem_17023.references = NULL;
    
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18672();
    eps_mem_17024.mem = futhark_mc_param_struct_18547_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18673();
    expsss_mem_17025.mem = futhark_mc_param_struct_18547_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18674();
    mem_17078.mem = futhark_mc_param_struct_18547_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18675();
    mem_17082.mem = futhark_mc_param_struct_18547_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18676();
    mem_17086.mem = futhark_mc_param_struct_18547_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform int64_t bytes_17093 = futhark_mc_param_struct_18547_->free_bytes_17093;
    uniform struct memblock mem_17160;
    
    mem_17160.desc = futhark_mc_strlit_shim_18677();
    mem_17160.mem = futhark_mc_param_struct_18547_->free_mem_17160;
    mem_17160.size = 0;
    mem_17160.references = NULL;
    
    struct memblock mem_17094 = *futhark_mc_mem_struct_18669_->mem_17094;
    uniform int err = 0;
    uniform int64_t start_17872;
    uniform int64_t end_17873;
    
    start_17872 = start;
    end_17873 = end;
    
    uniform int64_t n_17874 = end_17873 - start_17872;
    
    if (memblock_alloc(ctx, &mem_17094, bytes_17093, futhark_mc_strlit_shim_18556()))
        unmasked { return 1; }
    for (uniform int64_t i = 0; i < (start_17872 + n_17874 - start_17872) / programCount; i++) {
        int64_t SegMap_i_17875 = start_17872 + programIndex + i * programCount;
        uniform int64_t slice_17876 = n_12351;
        int64_t gtid_16475 = SegMap_i_17875;
        int64_t remnant_17877 = SegMap_i_17875 - gtid_16475;
        int64_t defunc_0_f_res_16478;
        
        defunc_0_f_res_16478 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_16475 * (int64_t) 3];
        
        int64_t defunc_0_f_res_16479;
        
        defunc_0_f_res_16479 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_16475 * (int64_t) 3 + (int64_t) 1];
        
        int64_t defunc_0_f_res_16480;
        
        defunc_0_f_res_16480 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_16475 * (int64_t) 3 + (int64_t) 2];
        
        uniform int64_t flat_tid_17710 = (int64_t) 0;
        uniform int64_t flat_tid_17399 = (int64_t) 0;
        struct futhark_mc_task_18557 futhark_mc_task_18557_;
        
        futhark_mc_task_18557_.ctx = ctx;
        futhark_mc_task_18557_.free_m_12352 = m_12352;
        futhark_mc_task_18557_.free_p_12353 = p_12353;
        futhark_mc_task_18557_.free_q_12354 = q_12354;
        futhark_mc_task_18557_.free_gtid_16475 = gtid_16475;
        futhark_mc_task_18557_.free_defunc_0_f_res_16478 = defunc_0_f_res_16478;
        futhark_mc_task_18557_.free_defunc_0_f_res_16479 = defunc_0_f_res_16479;
        futhark_mc_task_18557_.free_defunc_0_f_res_16480 = defunc_0_f_res_16480;
        futhark_mc_task_18557_.free_eps_mem_17024 = eps_mem_17024.mem;
        futhark_mc_task_18557_.free_expsss_mem_17025 = expsss_mem_17025.mem;
        futhark_mc_task_18557_.free_mem_17078 = mem_17078.mem;
        futhark_mc_task_18557_.free_mem_17082 = mem_17082.mem;
        futhark_mc_task_18557_.free_mem_17086 = mem_17086.mem;
        futhark_mc_task_18557_.free_mem_17094 = mem_17094.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18557 aos_18668[programCount];
        
        aos_18668[programIndex] = futhark_mc_task_18557_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18667(ctx, &aos_18668[i], extract(p_12353, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18667(ctx, &futhark_mc_task_18557_, p_12353);
        if (err != 0)
            goto cleanup;
        #endif
        if (p_12353 * (int64_t) 3 * (int64_t) 8 > 0)
            memmove(mem_17160.mem + gtid_16475 * ((int64_t) 3 * p_12353) * (int64_t) 8, mem_17094.mem + (int64_t) 0, p_12353 * (int64_t) 3 * (int64_t) 8);
    }
    if (programIndex < (start_17872 + n_17874 - start_17872) % programCount) {
        int64_t SegMap_i_17875 = start_17872 + programIndex + (start_17872 + n_17874 - start_17872) / programCount * programCount;
        uniform int64_t slice_17876 = n_12351;
        int64_t gtid_16475 = SegMap_i_17875;
        int64_t remnant_17877 = SegMap_i_17875 - gtid_16475;
        int64_t defunc_0_f_res_16478;
        
        defunc_0_f_res_16478 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_16475 * (int64_t) 3];
        
        int64_t defunc_0_f_res_16479;
        
        defunc_0_f_res_16479 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_16475 * (int64_t) 3 + (int64_t) 1];
        
        int64_t defunc_0_f_res_16480;
        
        defunc_0_f_res_16480 = ((int64_t *) zzinvs_mem_17023.mem)[gtid_16475 * (int64_t) 3 + (int64_t) 2];
        
        uniform int64_t flat_tid_17710 = (int64_t) 0;
        uniform int64_t flat_tid_17399 = (int64_t) 0;
        struct futhark_mc_task_18557 futhark_mc_task_18557_;
        
        futhark_mc_task_18557_.ctx = ctx;
        futhark_mc_task_18557_.free_m_12352 = m_12352;
        futhark_mc_task_18557_.free_p_12353 = p_12353;
        futhark_mc_task_18557_.free_q_12354 = q_12354;
        futhark_mc_task_18557_.free_gtid_16475 = gtid_16475;
        futhark_mc_task_18557_.free_defunc_0_f_res_16478 = defunc_0_f_res_16478;
        futhark_mc_task_18557_.free_defunc_0_f_res_16479 = defunc_0_f_res_16479;
        futhark_mc_task_18557_.free_defunc_0_f_res_16480 = defunc_0_f_res_16480;
        futhark_mc_task_18557_.free_eps_mem_17024 = eps_mem_17024.mem;
        futhark_mc_task_18557_.free_expsss_mem_17025 = expsss_mem_17025.mem;
        futhark_mc_task_18557_.free_mem_17078 = mem_17078.mem;
        futhark_mc_task_18557_.free_mem_17082 = mem_17082.mem;
        futhark_mc_task_18557_.free_mem_17086 = mem_17086.mem;
        futhark_mc_task_18557_.free_mem_17094 = mem_17094.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18557 aos_18668[programCount];
        
        aos_18668[programIndex] = futhark_mc_task_18557_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18667(ctx, &aos_18668[i], extract(p_12353, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18667(ctx, &futhark_mc_task_18557_, p_12353);
        if (err != 0)
            goto cleanup;
        #endif
        if (p_12353 * (int64_t) 3 * (int64_t) 8 > 0)
            memmove(mem_17160.mem + gtid_16475 * ((int64_t) 3 * p_12353) * (int64_t) 8, mem_17094.mem + (int64_t) 0, p_12353 * (int64_t) 3 * (int64_t) 8);
    }
    *futhark_mc_mem_struct_18669_->mem_17094 = mem_17094;
    return err;
}
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18678();
export uniform int futhark_mc_loop_ispc_18548(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18547 *uniform futhark_mc_param_struct_18547_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18547_->ctx;
    uniform int64_t n_12351 = futhark_mc_param_struct_18547_->free_n_12351;
    uniform int64_t m_12352 = futhark_mc_param_struct_18547_->free_m_12352;
    uniform int64_t p_12353 = futhark_mc_param_struct_18547_->free_p_12353;
    uniform int64_t q_12354 = futhark_mc_param_struct_18547_->free_q_12354;
    uniform struct memblock zzinvs_mem_17023;
    
    zzinvs_mem_17023.desc = futhark_mc_strlit_shim_18549();
    zzinvs_mem_17023.mem = futhark_mc_param_struct_18547_->free_zzinvs_mem_17023;
    zzinvs_mem_17023.size = 0;
    zzinvs_mem_17023.references = NULL;
    
    uniform struct memblock eps_mem_17024;
    
    eps_mem_17024.desc = futhark_mc_strlit_shim_18550();
    eps_mem_17024.mem = futhark_mc_param_struct_18547_->free_eps_mem_17024;
    eps_mem_17024.size = 0;
    eps_mem_17024.references = NULL;
    
    uniform struct memblock expsss_mem_17025;
    
    expsss_mem_17025.desc = futhark_mc_strlit_shim_18551();
    expsss_mem_17025.mem = futhark_mc_param_struct_18547_->free_expsss_mem_17025;
    expsss_mem_17025.size = 0;
    expsss_mem_17025.references = NULL;
    
    uniform struct memblock mem_17078;
    
    mem_17078.desc = futhark_mc_strlit_shim_18552();
    mem_17078.mem = futhark_mc_param_struct_18547_->free_mem_17078;
    mem_17078.size = 0;
    mem_17078.references = NULL;
    
    uniform struct memblock mem_17082;
    
    mem_17082.desc = futhark_mc_strlit_shim_18553();
    mem_17082.mem = futhark_mc_param_struct_18547_->free_mem_17082;
    mem_17082.size = 0;
    mem_17082.references = NULL;
    
    uniform struct memblock mem_17086;
    
    mem_17086.desc = futhark_mc_strlit_shim_18554();
    mem_17086.mem = futhark_mc_param_struct_18547_->free_mem_17086;
    mem_17086.size = 0;
    mem_17086.references = NULL;
    
    uniform int64_t bytes_17093 = futhark_mc_param_struct_18547_->free_bytes_17093;
    uniform struct memblock mem_17160;
    
    mem_17160.desc = futhark_mc_strlit_shim_18555();
    mem_17160.mem = futhark_mc_param_struct_18547_->free_mem_17160;
    mem_17160.size = 0;
    mem_17160.references = NULL;
    
    struct memblock mem_17094;
    
    mem_17094.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18669 futhark_mc_mem_struct_18669_;
    
    futhark_mc_mem_struct_18669_.mem_17094 = &mem_17094;
    
    uniform int err = futhark_mc_inner_ispc_18670(start, end, futhark_mc_param_struct_18547_, &futhark_mc_mem_struct_18669_);
    
    mem_17094 = *futhark_mc_mem_struct_18669_.mem_17094;
    
  cleanup:
    {
        if (memblock_unref(ctx, &mem_17094, futhark_mc_strlit_shim_18678()) != 0)
            unmasked { return 1; }
    }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18679(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18508 *uniform args, uniform int iterations);
struct futhark_mc_task_18682 {
    struct futhark_context *ctx;
    int64_t free_nz2080U_9828;
    int64_t free_pz2081U_9829;
    int64_t free_mz2082U_9830;
    unsigned char *free_xss_mem_17023;
    unsigned char *free_yss_mem_17024;
    int64_t free_bytes_17026;
    unsigned char *free_mem_17044;
};
struct futhark_mc_param_struct_18687 {
    struct futhark_context *ctx;
    int64_t free_nz2080U_9828;
    int64_t free_pz2081U_9829;
    int64_t free_mz2082U_9830;
    unsigned char *free_xss_mem_17023;
    unsigned char *free_yss_mem_17024;
    int64_t free_bytes_17026;
    unsigned char *free_mem_17044;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18690();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18691();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18692();
struct futhark_mc_mem_struct_18693 {
    varying unsigned char *uniform mem_17030;
    varying size_t mem_17030_cached_sizze_18689;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18695();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18696();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18697();
static unmasked inline uniform int futhark_mc_inner_ispc_18694(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18687 *uniform futhark_mc_param_struct_18687_, uniform struct futhark_mc_mem_struct_18693 *uniform futhark_mc_mem_struct_18693_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18687_->ctx;
    uniform int64_t nz2080U_9828 = futhark_mc_param_struct_18687_->free_nz2080U_9828;
    uniform int64_t pz2081U_9829 = futhark_mc_param_struct_18687_->free_pz2081U_9829;
    uniform int64_t mz2082U_9830 = futhark_mc_param_struct_18687_->free_mz2082U_9830;
    uniform struct memblock xss_mem_17023;
    
    xss_mem_17023.desc = futhark_mc_strlit_shim_18695();
    xss_mem_17023.mem = futhark_mc_param_struct_18687_->free_xss_mem_17023;
    xss_mem_17023.size = 0;
    xss_mem_17023.references = NULL;
    
    uniform struct memblock yss_mem_17024;
    
    yss_mem_17024.desc = futhark_mc_strlit_shim_18696();
    yss_mem_17024.mem = futhark_mc_param_struct_18687_->free_yss_mem_17024;
    yss_mem_17024.size = 0;
    yss_mem_17024.references = NULL;
    
    uniform int64_t bytes_17026 = futhark_mc_param_struct_18687_->free_bytes_17026;
    uniform struct memblock mem_17044;
    
    mem_17044.desc = futhark_mc_strlit_shim_18697();
    mem_17044.mem = futhark_mc_param_struct_18687_->free_mem_17044;
    mem_17044.size = 0;
    mem_17044.references = NULL;
    
    varying unsigned char *uniform mem_17030 = futhark_mc_mem_struct_18693_->mem_17030;
    size_t mem_17030_cached_sizze_18689 = futhark_mc_mem_struct_18693_->mem_17030_cached_sizze_18689;
    uniform int err = 0;
    uniform int64_t start_17173;
    uniform int64_t end_17174;
    
    start_17173 = start;
    end_17174 = end;
    
    uniform int64_t n_17175 = end_17174 - start_17173;
    
    if (mem_17030_cached_sizze_18689 < bytes_17026) {
        err = lexical_realloc(ctx, &mem_17030, &mem_17030_cached_sizze_18689, bytes_17026);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    foreach (SegMap_i_17176 = start_17173 ... start_17173 + n_17175)
    {
        uniform int64_t slice_17177 = nz2080U_9828;
        int64_t gtid_15929 = SegMap_i_17176;
        int64_t remnant_17178 = SegMap_i_17176 - gtid_15929;
        
        for (uniform int64_t i_17163 = 0; i_17163 < mz2082U_9830; i_17163++) {
            int32_t defunc_2_reduce_res_17165;
            int32_t redout_17167 = 0;
            
            for (uniform int64_t i_17166 = 0; i_17166 < pz2081U_9829; i_17166++) {
                int32_t x_17168;
                
                x_17168 = ((int32_t *) xss_mem_17023.mem)[gtid_15929 * pz2081U_9829 + i_17166];
                
                uniform int32_t x_17169;
                
                x_17169 = ((int32_t *) yss_mem_17024.mem)[i_17166 * mz2082U_9830 + i_17163];
                
                int32_t defunc_1_f_res_17170 = mul32(x_17168, x_17169);
                int32_t defunc_1_op_res_17171 = add32(defunc_1_f_res_17170, redout_17167);
                int32_t redout_tmp_17180 = defunc_1_op_res_17171;
                
                redout_17167 = redout_tmp_17180;
            }
            defunc_2_reduce_res_17165 = redout_17167;
            ((varying int32_t *) mem_17030)[i_17163] = defunc_2_reduce_res_17165;
        }
        if (mz2082U_9830 * (int64_t) 4 > 0)
            memmove_32(mem_17044.mem + gtid_15929 * mz2082U_9830 * (int64_t) 4, mem_17030 + (int64_t) 0, extract(mz2082U_9830 * (int64_t) 4, 0));
    }
    futhark_mc_mem_struct_18693_->mem_17030 = mem_17030;
    futhark_mc_mem_struct_18693_->mem_17030_cached_sizze_18689 = mem_17030_cached_sizze_18689;
    return err;
}
export uniform int futhark_mc_loop_ispc_18688(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18687 *uniform futhark_mc_param_struct_18687_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18687_->ctx;
    uniform int64_t nz2080U_9828 = futhark_mc_param_struct_18687_->free_nz2080U_9828;
    uniform int64_t pz2081U_9829 = futhark_mc_param_struct_18687_->free_pz2081U_9829;
    uniform int64_t mz2082U_9830 = futhark_mc_param_struct_18687_->free_mz2082U_9830;
    uniform struct memblock xss_mem_17023;
    
    xss_mem_17023.desc = futhark_mc_strlit_shim_18690();
    xss_mem_17023.mem = futhark_mc_param_struct_18687_->free_xss_mem_17023;
    xss_mem_17023.size = 0;
    xss_mem_17023.references = NULL;
    
    uniform struct memblock yss_mem_17024;
    
    yss_mem_17024.desc = futhark_mc_strlit_shim_18691();
    yss_mem_17024.mem = futhark_mc_param_struct_18687_->free_yss_mem_17024;
    yss_mem_17024.size = 0;
    yss_mem_17024.references = NULL;
    
    uniform int64_t bytes_17026 = futhark_mc_param_struct_18687_->free_bytes_17026;
    uniform struct memblock mem_17044;
    
    mem_17044.desc = futhark_mc_strlit_shim_18692();
    mem_17044.mem = futhark_mc_param_struct_18687_->free_mem_17044;
    mem_17044.size = 0;
    mem_17044.references = NULL;
    
    size_t mem_17030_cached_sizze_18689 = 0;
    varying unsigned char *uniform mem_17030 = NULL;
    uniform struct futhark_mc_mem_struct_18693 futhark_mc_mem_struct_18693_;
    
    futhark_mc_mem_struct_18693_.mem_17030 = mem_17030;
    futhark_mc_mem_struct_18693_.mem_17030_cached_sizze_18689 = mem_17030_cached_sizze_18689;
    
    uniform int err = futhark_mc_inner_ispc_18694(start, end, futhark_mc_param_struct_18687_, &futhark_mc_mem_struct_18693_);
    
    mem_17030 = futhark_mc_mem_struct_18693_.mem_17030;
    mem_17030_cached_sizze_18689 = futhark_mc_mem_struct_18693_.mem_17030_cached_sizze_18689;
    
  cleanup:
    {
        free(mem_17030);
    }
    return err;
}
struct futhark_mc_param_struct_18702 {
    struct futhark_context *ctx;
    int64_t free_nz2080U_9828;
    int64_t free_pz2081U_9829;
    int64_t free_mz2082U_9830;
    unsigned char *free_xss_mem_17023;
    unsigned char *free_yss_mem_17024;
    int64_t free_bytes_17026;
    unsigned char *free_mem_17044;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18704();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18705();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18706();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18707();
struct futhark_mc_task_18708 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9829;
    int64_t free_mz2082U_9830;
    int64_t free_gtid_15951;
    unsigned char *free_xss_mem_17023;
    unsigned char *free_yss_mem_17024;
    unsigned char *free_mem_17027;
};
struct futhark_mc_param_struct_18712 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9829;
    int64_t free_mz2082U_9830;
    int64_t free_gtid_15951;
    unsigned char *free_xss_mem_17023;
    unsigned char *free_yss_mem_17024;
    unsigned char *free_mem_17027;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18714();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18715();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18716();
export uniform int futhark_mc_loop_ispc_18713(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18712 *uniform futhark_mc_param_struct_18712_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18712_->ctx;
    uniform int64_t pz2081U_9829 = futhark_mc_param_struct_18712_->free_pz2081U_9829;
    uniform int64_t mz2082U_9830 = futhark_mc_param_struct_18712_->free_mz2082U_9830;
    uniform int64_t gtid_15951 = futhark_mc_param_struct_18712_->free_gtid_15951;
    uniform struct memblock xss_mem_17023;
    
    xss_mem_17023.desc = futhark_mc_strlit_shim_18714();
    xss_mem_17023.mem = futhark_mc_param_struct_18712_->free_xss_mem_17023;
    xss_mem_17023.size = 0;
    xss_mem_17023.references = NULL;
    
    uniform struct memblock yss_mem_17024;
    
    yss_mem_17024.desc = futhark_mc_strlit_shim_18715();
    yss_mem_17024.mem = futhark_mc_param_struct_18712_->free_yss_mem_17024;
    yss_mem_17024.size = 0;
    yss_mem_17024.references = NULL;
    
    uniform struct memblock mem_17027;
    
    mem_17027.desc = futhark_mc_strlit_shim_18716();
    mem_17027.mem = futhark_mc_param_struct_18712_->free_mem_17027;
    mem_17027.size = 0;
    mem_17027.references = NULL;
    
    uniform int err = 0;
    uniform int64_t start_17215;
    uniform int64_t end_17216;
    
    start_17215 = start;
    end_17216 = end;
    
    uniform int64_t n_17217 = end_17216 - start_17215;
    
    foreach (SegMap_i_17218 = start_17215 ... start_17215 + n_17217)
    {
        uniform int64_t slice_17219 = mz2082U_9830;
        int64_t gtid_17194 = SegMap_i_17218;
        int64_t remnant_17220 = SegMap_i_17218 - gtid_17194;
        int32_t defunc_2_reduce_res_17195;
        int32_t redout_17210 = 0;
        
        for (uniform int64_t i_17209 = 0; i_17209 < pz2081U_9829; i_17209++) {
            uniform int32_t x_17211;
            
            x_17211 = ((int32_t *) xss_mem_17023.mem)[gtid_15951 * pz2081U_9829 + i_17209];
            
            int32_t x_17212;
            
            x_17212 = ((int32_t *) yss_mem_17024.mem)[i_17209 * mz2082U_9830 + gtid_17194];
            
            int32_t defunc_1_f_res_17213 = mul32(x_17211, x_17212);
            int32_t defunc_1_op_res_17214 = add32(defunc_1_f_res_17213, redout_17210);
            int32_t redout_tmp_17221 = defunc_1_op_res_17214;
            
            redout_17210 = redout_tmp_17221;
        }
        defunc_2_reduce_res_17195 = redout_17210;
        ((int32_t *) mem_17027.mem)[gtid_17194] = defunc_2_reduce_res_17195;
    }
    
  cleanup:
    { }
    return err;
}
struct futhark_mc_param_struct_18720 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9829;
    int64_t free_mz2082U_9830;
    int64_t free_gtid_15951;
    unsigned char *free_xss_mem_17023;
    unsigned char *free_yss_mem_17024;
    unsigned char *free_mem_17027;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18722();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18723();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18724();
struct futhark_mc_task_18725 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9829;
    int64_t free_mz2082U_9830;
    int64_t free_gtid_15951;
    unsigned char *free_xss_mem_17023;
    unsigned char *free_yss_mem_17024;
    int64_t free_gtid_17183;
    int64_t free_flat_tid_17223;
    int32_t *retval_defunc_2_reduce_res_17184;
};
struct futhark_mc_param_struct_18730 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9829;
    int64_t free_mz2082U_9830;
    int64_t free_gtid_15951;
    unsigned char *free_xss_mem_17023;
    unsigned char *free_yss_mem_17024;
    int64_t free_gtid_17183;
    int64_t free_flat_tid_17223;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_17238;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18732();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18733();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18734();
export uniform int futhark_mc_loop_ispc_18731(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18730 *uniform futhark_mc_param_struct_18730_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18730_->ctx;
    uniform int64_t pz2081U_9829 = futhark_mc_param_struct_18730_->free_pz2081U_9829;
    uniform int64_t mz2082U_9830 = futhark_mc_param_struct_18730_->free_mz2082U_9830;
    uniform int64_t gtid_15951 = futhark_mc_param_struct_18730_->free_gtid_15951;
    uniform struct memblock xss_mem_17023;
    
    xss_mem_17023.desc = futhark_mc_strlit_shim_18732();
    xss_mem_17023.mem = futhark_mc_param_struct_18730_->free_xss_mem_17023;
    xss_mem_17023.size = 0;
    xss_mem_17023.references = NULL;
    
    uniform struct memblock yss_mem_17024;
    
    yss_mem_17024.desc = futhark_mc_strlit_shim_18733();
    yss_mem_17024.mem = futhark_mc_param_struct_18730_->free_yss_mem_17024;
    yss_mem_17024.size = 0;
    yss_mem_17024.references = NULL;
    
    uniform int64_t gtid_17183 = futhark_mc_param_struct_18730_->free_gtid_17183;
    uniform int64_t flat_tid_17223 = futhark_mc_param_struct_18730_->free_flat_tid_17223;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_17238;
    
    reduce_stage_1_tid_res_arr_mem_17238.desc = futhark_mc_strlit_shim_18734();
    reduce_stage_1_tid_res_arr_mem_17238.mem = futhark_mc_param_struct_18730_->free_reduce_stage_1_tid_res_arr_mem_17238;
    reduce_stage_1_tid_res_arr_mem_17238.size = 0;
    reduce_stage_1_tid_res_arr_mem_17238.references = NULL;
    
    uniform int err = 0;
    uniform int32_t x_17240;
    uniform int32_t x_17241;
    uniform int32_t local_acc_17243 = 0;
    int32_t x_17225;
    int32_t x_17226;
    int32_t local_acc_17244 = 0;
    uniform int64_t start_17245;
    uniform int64_t end_17246;
    
    start_17245 = start;
    end_17246 = end;
    
    uniform int64_t n_17247 = end_17246 - start_17245;
    
    foreach (SegRed_i_17248 = start_17245 ... start_17245 + n_17247)
    {
        int64_t gtid_17224 = SegRed_i_17248;
        int32_t x_17228;
        
        x_17228 = ((int32_t *) xss_mem_17023.mem)[gtid_15951 * pz2081U_9829 + gtid_17224];
        
        int32_t x_17229;
        
        x_17229 = ((int32_t *) yss_mem_17024.mem)[gtid_17224 * mz2082U_9830 + gtid_17183];
        
        int32_t defunc_1_f_res_17230 = mul32(x_17228, x_17229);
        
        // save map-out results
        { }
        // Load accum params
        {
            x_17225 = local_acc_17244;
        }
        // Load next params
        {
            x_17226 = defunc_1_f_res_17230;
        }
        // SegRed body
        {
            int32_t defunc_1_op_res_17227 = add32(x_17225, x_17226);
            
            local_acc_17244 = defunc_1_op_res_17227;
        }
    }
    for (uniform unsigned int uni_i_17249 = 0; uni_i_17249 < programCount; uni_i_17249++) {
        if (programIndex == uni_i_17249) {
            int64_t gtid_17224 = uni_i_17249;
            
            // Load accum params
            {
                x_17240 = local_acc_17243;
            }
            // Load next params
            {
                x_17241 = extract(local_acc_17244, uni_i_17249);
            }
            // SegRed body
            {
                uniform int32_t defunc_1_op_res_17242 = add32(x_17240, x_17241);
                
                local_acc_17243 = defunc_1_op_res_17242;
            }
        }
    }
    ((int32_t *) reduce_stage_1_tid_res_arr_mem_17238.mem)[flat_tid_17223] = local_acc_17243;
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18735(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18725 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18737 { };
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18739();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18740();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18741();
static unmasked inline uniform int futhark_mc_inner_ispc_18738(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18720 *uniform futhark_mc_param_struct_18720_, uniform struct futhark_mc_mem_struct_18737 *uniform futhark_mc_mem_struct_18737_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18720_->ctx;
    uniform int64_t pz2081U_9829 = futhark_mc_param_struct_18720_->free_pz2081U_9829;
    uniform int64_t mz2082U_9830 = futhark_mc_param_struct_18720_->free_mz2082U_9830;
    uniform int64_t gtid_15951 = futhark_mc_param_struct_18720_->free_gtid_15951;
    uniform struct memblock xss_mem_17023;
    
    xss_mem_17023.desc = futhark_mc_strlit_shim_18739();
    xss_mem_17023.mem = futhark_mc_param_struct_18720_->free_xss_mem_17023;
    xss_mem_17023.size = 0;
    xss_mem_17023.references = NULL;
    
    uniform struct memblock yss_mem_17024;
    
    yss_mem_17024.desc = futhark_mc_strlit_shim_18740();
    yss_mem_17024.mem = futhark_mc_param_struct_18720_->free_yss_mem_17024;
    yss_mem_17024.size = 0;
    yss_mem_17024.references = NULL;
    
    uniform struct memblock mem_17027;
    
    mem_17027.desc = futhark_mc_strlit_shim_18741();
    mem_17027.mem = futhark_mc_param_struct_18720_->free_mem_17027;
    mem_17027.size = 0;
    mem_17027.references = NULL;
    
    uniform int err = 0;
    uniform int64_t start_17231;
    uniform int64_t end_17232;
    
    start_17231 = start;
    end_17232 = end;
    
    uniform int64_t n_17233 = end_17232 - start_17231;
    
    for (uniform int64_t i = 0; i < (start_17231 + n_17233 - start_17231) / programCount; i++) {
        int64_t SegMap_i_17234 = start_17231 + programIndex + i * programCount;
        uniform int64_t slice_17235 = mz2082U_9830;
        int64_t gtid_17183 = SegMap_i_17234;
        int64_t remnant_17236 = SegMap_i_17234 - gtid_17183;
        int32_t defunc_2_reduce_res_17184;
        uniform int64_t flat_tid_17223 = (int64_t) 0;
        
        defunc_2_reduce_res_17184 = 0;
        
        struct futhark_mc_task_18725 futhark_mc_task_18725_;
        
        futhark_mc_task_18725_.ctx = ctx;
        futhark_mc_task_18725_.free_pz2081U_9829 = pz2081U_9829;
        futhark_mc_task_18725_.free_mz2082U_9830 = mz2082U_9830;
        futhark_mc_task_18725_.free_gtid_15951 = gtid_15951;
        futhark_mc_task_18725_.free_xss_mem_17023 = xss_mem_17023.mem;
        futhark_mc_task_18725_.free_yss_mem_17024 = yss_mem_17024.mem;
        futhark_mc_task_18725_.free_gtid_17183 = gtid_17183;
        futhark_mc_task_18725_.free_flat_tid_17223 = flat_tid_17223;
        futhark_mc_task_18725_.retval_defunc_2_reduce_res_17184 = (int32_t *) &defunc_2_reduce_res_17184;
        #if ISPC
        futhark_mc_task_18725_.retval_defunc_2_reduce_res_17184 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18725 aos_18736[programCount];
        
        aos_18736[programIndex] = futhark_mc_task_18725_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18735(ctx, &aos_18736[i], extract(pz2081U_9829, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18735(ctx, &futhark_mc_task_18725_, pz2081U_9829);
        if (err != 0)
            goto cleanup;
        #endif
        ((int32_t *) mem_17027.mem)[gtid_17183] = defunc_2_reduce_res_17184;
    }
    if (programIndex < (start_17231 + n_17233 - start_17231) % programCount) {
        int64_t SegMap_i_17234 = start_17231 + programIndex + (start_17231 + n_17233 - start_17231) / programCount * programCount;
        uniform int64_t slice_17235 = mz2082U_9830;
        int64_t gtid_17183 = SegMap_i_17234;
        int64_t remnant_17236 = SegMap_i_17234 - gtid_17183;
        int32_t defunc_2_reduce_res_17184;
        uniform int64_t flat_tid_17223 = (int64_t) 0;
        
        defunc_2_reduce_res_17184 = 0;
        
        struct futhark_mc_task_18725 futhark_mc_task_18725_;
        
        futhark_mc_task_18725_.ctx = ctx;
        futhark_mc_task_18725_.free_pz2081U_9829 = pz2081U_9829;
        futhark_mc_task_18725_.free_mz2082U_9830 = mz2082U_9830;
        futhark_mc_task_18725_.free_gtid_15951 = gtid_15951;
        futhark_mc_task_18725_.free_xss_mem_17023 = xss_mem_17023.mem;
        futhark_mc_task_18725_.free_yss_mem_17024 = yss_mem_17024.mem;
        futhark_mc_task_18725_.free_gtid_17183 = gtid_17183;
        futhark_mc_task_18725_.free_flat_tid_17223 = flat_tid_17223;
        futhark_mc_task_18725_.retval_defunc_2_reduce_res_17184 = (int32_t *) &defunc_2_reduce_res_17184;
        #if ISPC
        futhark_mc_task_18725_.retval_defunc_2_reduce_res_17184 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18725 aos_18736[programCount];
        
        aos_18736[programIndex] = futhark_mc_task_18725_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18735(ctx, &aos_18736[i], extract(pz2081U_9829, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18735(ctx, &futhark_mc_task_18725_, pz2081U_9829);
        if (err != 0)
            goto cleanup;
        #endif
        ((int32_t *) mem_17027.mem)[gtid_17183] = defunc_2_reduce_res_17184;
    }
    return err;
}
export uniform int futhark_mc_loop_ispc_18721(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18720 *uniform futhark_mc_param_struct_18720_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18720_->ctx;
    uniform int64_t pz2081U_9829 = futhark_mc_param_struct_18720_->free_pz2081U_9829;
    uniform int64_t mz2082U_9830 = futhark_mc_param_struct_18720_->free_mz2082U_9830;
    uniform int64_t gtid_15951 = futhark_mc_param_struct_18720_->free_gtid_15951;
    uniform struct memblock xss_mem_17023;
    
    xss_mem_17023.desc = futhark_mc_strlit_shim_18722();
    xss_mem_17023.mem = futhark_mc_param_struct_18720_->free_xss_mem_17023;
    xss_mem_17023.size = 0;
    xss_mem_17023.references = NULL;
    
    uniform struct memblock yss_mem_17024;
    
    yss_mem_17024.desc = futhark_mc_strlit_shim_18723();
    yss_mem_17024.mem = futhark_mc_param_struct_18720_->free_yss_mem_17024;
    yss_mem_17024.size = 0;
    yss_mem_17024.references = NULL;
    
    uniform struct memblock mem_17027;
    
    mem_17027.desc = futhark_mc_strlit_shim_18724();
    mem_17027.mem = futhark_mc_param_struct_18720_->free_mem_17027;
    mem_17027.size = 0;
    mem_17027.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18737 futhark_mc_mem_struct_18737_;
    uniform int err = futhark_mc_inner_ispc_18738(start, end, futhark_mc_param_struct_18720_, &futhark_mc_mem_struct_18737_);
    
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18742(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18708 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18744 {
    varying struct memblock *uniform mem_17027;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18746();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18747();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18748();
static unmasked inline uniform int futhark_mc_inner_ispc_18745(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18702 *uniform futhark_mc_param_struct_18702_, uniform struct futhark_mc_mem_struct_18744 *uniform futhark_mc_mem_struct_18744_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18702_->ctx;
    uniform int64_t nz2080U_9828 = futhark_mc_param_struct_18702_->free_nz2080U_9828;
    uniform int64_t pz2081U_9829 = futhark_mc_param_struct_18702_->free_pz2081U_9829;
    uniform int64_t mz2082U_9830 = futhark_mc_param_struct_18702_->free_mz2082U_9830;
    uniform struct memblock xss_mem_17023;
    
    xss_mem_17023.desc = futhark_mc_strlit_shim_18746();
    xss_mem_17023.mem = futhark_mc_param_struct_18702_->free_xss_mem_17023;
    xss_mem_17023.size = 0;
    xss_mem_17023.references = NULL;
    
    uniform struct memblock yss_mem_17024;
    
    yss_mem_17024.desc = futhark_mc_strlit_shim_18747();
    yss_mem_17024.mem = futhark_mc_param_struct_18702_->free_yss_mem_17024;
    yss_mem_17024.size = 0;
    yss_mem_17024.references = NULL;
    
    uniform int64_t bytes_17026 = futhark_mc_param_struct_18702_->free_bytes_17026;
    uniform struct memblock mem_17044;
    
    mem_17044.desc = futhark_mc_strlit_shim_18748();
    mem_17044.mem = futhark_mc_param_struct_18702_->free_mem_17044;
    mem_17044.size = 0;
    mem_17044.references = NULL;
    
    struct memblock mem_17027 = *futhark_mc_mem_struct_18744_->mem_17027;
    uniform int err = 0;
    uniform int64_t start_17202;
    uniform int64_t end_17203;
    
    start_17202 = start;
    end_17203 = end;
    
    uniform int64_t n_17204 = end_17203 - start_17202;
    
    if (memblock_alloc(ctx, &mem_17027, bytes_17026, futhark_mc_strlit_shim_18707()))
        unmasked { return 1; }
    for (uniform int64_t i = 0; i < (start_17202 + n_17204 - start_17202) / programCount; i++) {
        int64_t SegMap_i_17205 = start_17202 + programIndex + i * programCount;
        uniform int64_t slice_17206 = nz2080U_9828;
        int64_t gtid_15951 = SegMap_i_17205;
        int64_t remnant_17207 = SegMap_i_17205 - gtid_15951;
        uniform int64_t flat_tid_17193 = (int64_t) 0;
        uniform int64_t flat_tid_17182 = (int64_t) 0;
        struct futhark_mc_task_18708 futhark_mc_task_18708_;
        
        futhark_mc_task_18708_.ctx = ctx;
        futhark_mc_task_18708_.free_pz2081U_9829 = pz2081U_9829;
        futhark_mc_task_18708_.free_mz2082U_9830 = mz2082U_9830;
        futhark_mc_task_18708_.free_gtid_15951 = gtid_15951;
        futhark_mc_task_18708_.free_xss_mem_17023 = xss_mem_17023.mem;
        futhark_mc_task_18708_.free_yss_mem_17024 = yss_mem_17024.mem;
        futhark_mc_task_18708_.free_mem_17027 = mem_17027.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18708 aos_18743[programCount];
        
        aos_18743[programIndex] = futhark_mc_task_18708_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18742(ctx, &aos_18743[i], extract(mz2082U_9830, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18742(ctx, &futhark_mc_task_18708_, mz2082U_9830);
        if (err != 0)
            goto cleanup;
        #endif
        if (mz2082U_9830 * (int64_t) 4 > 0)
            memmove(mem_17044.mem + gtid_15951 * mz2082U_9830 * (int64_t) 4, mem_17027.mem + (int64_t) 0, mz2082U_9830 * (int64_t) 4);
    }
    if (programIndex < (start_17202 + n_17204 - start_17202) % programCount) {
        int64_t SegMap_i_17205 = start_17202 + programIndex + (start_17202 + n_17204 - start_17202) / programCount * programCount;
        uniform int64_t slice_17206 = nz2080U_9828;
        int64_t gtid_15951 = SegMap_i_17205;
        int64_t remnant_17207 = SegMap_i_17205 - gtid_15951;
        uniform int64_t flat_tid_17193 = (int64_t) 0;
        uniform int64_t flat_tid_17182 = (int64_t) 0;
        struct futhark_mc_task_18708 futhark_mc_task_18708_;
        
        futhark_mc_task_18708_.ctx = ctx;
        futhark_mc_task_18708_.free_pz2081U_9829 = pz2081U_9829;
        futhark_mc_task_18708_.free_mz2082U_9830 = mz2082U_9830;
        futhark_mc_task_18708_.free_gtid_15951 = gtid_15951;
        futhark_mc_task_18708_.free_xss_mem_17023 = xss_mem_17023.mem;
        futhark_mc_task_18708_.free_yss_mem_17024 = yss_mem_17024.mem;
        futhark_mc_task_18708_.free_mem_17027 = mem_17027.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18708 aos_18743[programCount];
        
        aos_18743[programIndex] = futhark_mc_task_18708_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18742(ctx, &aos_18743[i], extract(mz2082U_9830, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18742(ctx, &futhark_mc_task_18708_, mz2082U_9830);
        if (err != 0)
            goto cleanup;
        #endif
        if (mz2082U_9830 * (int64_t) 4 > 0)
            memmove(mem_17044.mem + gtid_15951 * mz2082U_9830 * (int64_t) 4, mem_17027.mem + (int64_t) 0, mz2082U_9830 * (int64_t) 4);
    }
    *futhark_mc_mem_struct_18744_->mem_17027 = mem_17027;
    return err;
}
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18749();
export uniform int futhark_mc_loop_ispc_18703(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18702 *uniform futhark_mc_param_struct_18702_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18702_->ctx;
    uniform int64_t nz2080U_9828 = futhark_mc_param_struct_18702_->free_nz2080U_9828;
    uniform int64_t pz2081U_9829 = futhark_mc_param_struct_18702_->free_pz2081U_9829;
    uniform int64_t mz2082U_9830 = futhark_mc_param_struct_18702_->free_mz2082U_9830;
    uniform struct memblock xss_mem_17023;
    
    xss_mem_17023.desc = futhark_mc_strlit_shim_18704();
    xss_mem_17023.mem = futhark_mc_param_struct_18702_->free_xss_mem_17023;
    xss_mem_17023.size = 0;
    xss_mem_17023.references = NULL;
    
    uniform struct memblock yss_mem_17024;
    
    yss_mem_17024.desc = futhark_mc_strlit_shim_18705();
    yss_mem_17024.mem = futhark_mc_param_struct_18702_->free_yss_mem_17024;
    yss_mem_17024.size = 0;
    yss_mem_17024.references = NULL;
    
    uniform int64_t bytes_17026 = futhark_mc_param_struct_18702_->free_bytes_17026;
    uniform struct memblock mem_17044;
    
    mem_17044.desc = futhark_mc_strlit_shim_18706();
    mem_17044.mem = futhark_mc_param_struct_18702_->free_mem_17044;
    mem_17044.size = 0;
    mem_17044.references = NULL;
    
    struct memblock mem_17027;
    
    mem_17027.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18744 futhark_mc_mem_struct_18744_;
    
    futhark_mc_mem_struct_18744_.mem_17027 = &mem_17027;
    
    uniform int err = futhark_mc_inner_ispc_18745(start, end, futhark_mc_param_struct_18702_, &futhark_mc_mem_struct_18744_);
    
    mem_17027 = *futhark_mc_mem_struct_18744_.mem_17027;
    
  cleanup:
    {
        if (memblock_unref(ctx, &mem_17027, futhark_mc_strlit_shim_18749()) != 0)
            unmasked { return 1; }
    }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18750(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18682 *uniform args, uniform int iterations);
