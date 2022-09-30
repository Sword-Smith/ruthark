
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

struct futhark_mc_task_18431 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    unsigned char *free_coefficientss_mem_17009;
    int64_t free_bytes_17011;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
};
struct futhark_mc_param_struct_18438 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    unsigned char *free_coefficientss_mem_17009;
    int64_t free_bytes_17011;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18443();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18444();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18445();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18446();
struct futhark_mc_mem_struct_18447 {
    varying unsigned char *uniform mem_17021;
    varying size_t mem_17021_cached_sizze_18440;
    varying unsigned char *uniform mem_17024;
    varying size_t mem_17024_cached_sizze_18441;
    varying unsigned char *uniform mem_17027;
    varying size_t mem_17027_cached_sizze_18442;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18449();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18450();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18451();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18452();
static unmasked inline uniform int futhark_mc_inner_ispc_18448(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18438 *uniform futhark_mc_param_struct_18438_, uniform struct futhark_mc_mem_struct_18447 *uniform futhark_mc_mem_struct_18447_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18438_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18438_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18438_->free_p_12335;
    uniform struct memblock coefficientss_mem_17009;
    
    coefficientss_mem_17009.desc = futhark_mc_strlit_shim_18449();
    coefficientss_mem_17009.mem = futhark_mc_param_struct_18438_->free_coefficientss_mem_17009;
    coefficientss_mem_17009.size = 0;
    coefficientss_mem_17009.references = NULL;
    
    uniform int64_t bytes_17011 = futhark_mc_param_struct_18438_->free_bytes_17011;
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18450();
    mem_17061.mem = futhark_mc_param_struct_18438_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18451();
    mem_17065.mem = futhark_mc_param_struct_18438_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18452();
    mem_17069.mem = futhark_mc_param_struct_18438_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    varying unsigned char *uniform mem_17021 = futhark_mc_mem_struct_18447_->mem_17021;
    size_t mem_17021_cached_sizze_18440 = futhark_mc_mem_struct_18447_->mem_17021_cached_sizze_18440;
    varying unsigned char *uniform mem_17024 = futhark_mc_mem_struct_18447_->mem_17024;
    size_t mem_17024_cached_sizze_18441 = futhark_mc_mem_struct_18447_->mem_17024_cached_sizze_18441;
    varying unsigned char *uniform mem_17027 = futhark_mc_mem_struct_18447_->mem_17027;
    size_t mem_17027_cached_sizze_18442 = futhark_mc_mem_struct_18447_->mem_17027_cached_sizze_18442;
    uniform int err = 0;
    uniform int64_t start_17156;
    uniform int64_t end_17157;
    
    start_17156 = start;
    end_17157 = end;
    
    uniform int64_t n_17158 = end_17157 - start_17156;
    
    if (mem_17021_cached_sizze_18440 < bytes_17011) {
        err = lexical_realloc(ctx, &mem_17021, &mem_17021_cached_sizze_18440, bytes_17011);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17024_cached_sizze_18441 < bytes_17011) {
        err = lexical_realloc(ctx, &mem_17024, &mem_17024_cached_sizze_18441, bytes_17011);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17027_cached_sizze_18442 < bytes_17011) {
        err = lexical_realloc(ctx, &mem_17027, &mem_17027_cached_sizze_18442, bytes_17011);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    foreach (SegMap_i_17159 = start_17156 ... start_17156 + n_17158)
    {
        uniform int64_t slice_17160 = m_12334;
        int64_t gtid_15960 = SegMap_i_17159;
        int64_t remnant_17161 = SegMap_i_17159 - gtid_15960;
        
        for (uniform int64_t i_17146 = 0; i_17146 < p_12335; i_17146++) {
            int64_t defunc_0_f_res_17150;
            
            defunc_0_f_res_17150 = ((int64_t *) coefficientss_mem_17009.mem)[gtid_15960 * ((int64_t) 3 * p_12335) + i_17146 * (int64_t) 3];
            
            int64_t defunc_0_f_res_17151;
            
            defunc_0_f_res_17151 = ((int64_t *) coefficientss_mem_17009.mem)[gtid_15960 * ((int64_t) 3 * p_12335) + i_17146 * (int64_t) 3 + (int64_t) 1];
            
            int64_t defunc_0_f_res_17152;
            
            defunc_0_f_res_17152 = ((int64_t *) coefficientss_mem_17009.mem)[gtid_15960 * ((int64_t) 3 * p_12335) + i_17146 * (int64_t) 3 + (int64_t) 2];
            ((varying int64_t *) mem_17021)[i_17146] = defunc_0_f_res_17150;
            ((varying int64_t *) mem_17024)[i_17146] = defunc_0_f_res_17151;
            ((varying int64_t *) mem_17027)[i_17146] = defunc_0_f_res_17152;
        }
        if (p_12335 * (int64_t) 8 > 0)
            memmove_64(mem_17061.mem + gtid_15960 * p_12335 * (int64_t) 8, mem_17021 + (int64_t) 0, extract(p_12335 * (int64_t) 8, 0));
        if (p_12335 * (int64_t) 8 > 0)
            memmove_64(mem_17065.mem + gtid_15960 * p_12335 * (int64_t) 8, mem_17024 + (int64_t) 0, extract(p_12335 * (int64_t) 8, 0));
        if (p_12335 * (int64_t) 8 > 0)
            memmove_64(mem_17069.mem + gtid_15960 * p_12335 * (int64_t) 8, mem_17027 + (int64_t) 0, extract(p_12335 * (int64_t) 8, 0));
    }
    futhark_mc_mem_struct_18447_->mem_17021 = mem_17021;
    futhark_mc_mem_struct_18447_->mem_17021_cached_sizze_18440 = mem_17021_cached_sizze_18440;
    futhark_mc_mem_struct_18447_->mem_17024 = mem_17024;
    futhark_mc_mem_struct_18447_->mem_17024_cached_sizze_18441 = mem_17024_cached_sizze_18441;
    futhark_mc_mem_struct_18447_->mem_17027 = mem_17027;
    futhark_mc_mem_struct_18447_->mem_17027_cached_sizze_18442 = mem_17027_cached_sizze_18442;
    return err;
}
export uniform int futhark_mc_loop_ispc_18439(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18438 *uniform futhark_mc_param_struct_18438_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18438_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18438_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18438_->free_p_12335;
    uniform struct memblock coefficientss_mem_17009;
    
    coefficientss_mem_17009.desc = futhark_mc_strlit_shim_18443();
    coefficientss_mem_17009.mem = futhark_mc_param_struct_18438_->free_coefficientss_mem_17009;
    coefficientss_mem_17009.size = 0;
    coefficientss_mem_17009.references = NULL;
    
    uniform int64_t bytes_17011 = futhark_mc_param_struct_18438_->free_bytes_17011;
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18444();
    mem_17061.mem = futhark_mc_param_struct_18438_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18445();
    mem_17065.mem = futhark_mc_param_struct_18438_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18446();
    mem_17069.mem = futhark_mc_param_struct_18438_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    size_t mem_17021_cached_sizze_18440 = 0;
    varying unsigned char *uniform mem_17021 = NULL;
    size_t mem_17024_cached_sizze_18441 = 0;
    varying unsigned char *uniform mem_17024 = NULL;
    size_t mem_17027_cached_sizze_18442 = 0;
    varying unsigned char *uniform mem_17027 = NULL;
    uniform struct futhark_mc_mem_struct_18447 futhark_mc_mem_struct_18447_;
    
    futhark_mc_mem_struct_18447_.mem_17021 = mem_17021;
    futhark_mc_mem_struct_18447_.mem_17021_cached_sizze_18440 = mem_17021_cached_sizze_18440;
    futhark_mc_mem_struct_18447_.mem_17024 = mem_17024;
    futhark_mc_mem_struct_18447_.mem_17024_cached_sizze_18441 = mem_17024_cached_sizze_18441;
    futhark_mc_mem_struct_18447_.mem_17027 = mem_17027;
    futhark_mc_mem_struct_18447_.mem_17027_cached_sizze_18442 = mem_17027_cached_sizze_18442;
    
    uniform int err = futhark_mc_inner_ispc_18448(start, end, futhark_mc_param_struct_18438_, &futhark_mc_mem_struct_18447_);
    
    mem_17021 = futhark_mc_mem_struct_18447_.mem_17021;
    mem_17021_cached_sizze_18440 = futhark_mc_mem_struct_18447_.mem_17021_cached_sizze_18440;
    mem_17024 = futhark_mc_mem_struct_18447_.mem_17024;
    mem_17024_cached_sizze_18441 = futhark_mc_mem_struct_18447_.mem_17024_cached_sizze_18441;
    mem_17027 = futhark_mc_mem_struct_18447_.mem_17027;
    mem_17027_cached_sizze_18442 = futhark_mc_mem_struct_18447_.mem_17027_cached_sizze_18442;
    
  cleanup:
    {
        free(mem_17021);
        free(mem_17024);
        free(mem_17027);
    }
    return err;
}
struct futhark_mc_param_struct_18459 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    unsigned char *free_coefficientss_mem_17009;
    int64_t free_bytes_17011;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18461();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18462();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18463();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18464();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18465();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18466();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18467();
struct futhark_mc_task_18468 {
    struct futhark_context *ctx;
    int64_t free_p_12335;
    int64_t free_gtid_15966;
    unsigned char *free_coefficientss_mem_17009;
    unsigned char *free_mem_17012;
    unsigned char *free_mem_17015;
    unsigned char *free_mem_17018;
};
struct futhark_mc_param_struct_18472 {
    struct futhark_context *ctx;
    int64_t free_p_12335;
    int64_t free_gtid_15966;
    unsigned char *free_coefficientss_mem_17009;
    unsigned char *free_mem_17012;
    unsigned char *free_mem_17015;
    unsigned char *free_mem_17018;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18474();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18475();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18476();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18477();
export uniform int futhark_mc_loop_ispc_18473(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18472 *uniform futhark_mc_param_struct_18472_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18472_->ctx;
    uniform int64_t p_12335 = futhark_mc_param_struct_18472_->free_p_12335;
    uniform int64_t gtid_15966 = futhark_mc_param_struct_18472_->free_gtid_15966;
    uniform struct memblock coefficientss_mem_17009;
    
    coefficientss_mem_17009.desc = futhark_mc_strlit_shim_18474();
    coefficientss_mem_17009.mem = futhark_mc_param_struct_18472_->free_coefficientss_mem_17009;
    coefficientss_mem_17009.size = 0;
    coefficientss_mem_17009.references = NULL;
    
    uniform struct memblock mem_17012;
    
    mem_17012.desc = futhark_mc_strlit_shim_18475();
    mem_17012.mem = futhark_mc_param_struct_18472_->free_mem_17012;
    mem_17012.size = 0;
    mem_17012.references = NULL;
    
    uniform struct memblock mem_17015;
    
    mem_17015.desc = futhark_mc_strlit_shim_18476();
    mem_17015.mem = futhark_mc_param_struct_18472_->free_mem_17015;
    mem_17015.size = 0;
    mem_17015.references = NULL;
    
    uniform struct memblock mem_17018;
    
    mem_17018.desc = futhark_mc_strlit_shim_18477();
    mem_17018.mem = futhark_mc_param_struct_18472_->free_mem_17018;
    mem_17018.size = 0;
    mem_17018.references = NULL;
    
    uniform int err = 0;
    uniform int64_t start_17178;
    uniform int64_t end_17179;
    
    start_17178 = start;
    end_17179 = end;
    
    uniform int64_t n_17180 = end_17179 - start_17178;
    
    foreach (SegMap_i_17181 = start_17178 ... start_17178 + n_17180)
    {
        uniform int64_t slice_17182 = p_12335;
        int64_t gtid_17167 = SegMap_i_17181;
        int64_t remnant_17183 = SegMap_i_17181 - gtid_17167;
        int64_t defunc_0_f_res_17168;
        
        defunc_0_f_res_17168 = ((int64_t *) coefficientss_mem_17009.mem)[gtid_15966 * ((int64_t) 3 * p_12335) + gtid_17167 * (int64_t) 3];
        
        int64_t defunc_0_f_res_17169;
        
        defunc_0_f_res_17169 = ((int64_t *) coefficientss_mem_17009.mem)[gtid_15966 * ((int64_t) 3 * p_12335) + gtid_17167 * (int64_t) 3 + (int64_t) 1];
        
        int64_t defunc_0_f_res_17170;
        
        defunc_0_f_res_17170 = ((int64_t *) coefficientss_mem_17009.mem)[gtid_15966 * ((int64_t) 3 * p_12335) + gtid_17167 * (int64_t) 3 + (int64_t) 2];
        ((int64_t *) mem_17012.mem)[gtid_17167] = defunc_0_f_res_17168;
        ((int64_t *) mem_17015.mem)[gtid_17167] = defunc_0_f_res_17169;
        ((int64_t *) mem_17018.mem)[gtid_17167] = defunc_0_f_res_17170;
    }
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18478(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18468 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18480 {
    varying struct memblock *uniform mem_17018;
    varying struct memblock *uniform mem_17015;
    varying struct memblock *uniform mem_17012;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18482();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18483();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18484();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18485();
static unmasked inline uniform int futhark_mc_inner_ispc_18481(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18459 *uniform futhark_mc_param_struct_18459_, uniform struct futhark_mc_mem_struct_18480 *uniform futhark_mc_mem_struct_18480_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18459_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18459_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18459_->free_p_12335;
    uniform struct memblock coefficientss_mem_17009;
    
    coefficientss_mem_17009.desc = futhark_mc_strlit_shim_18482();
    coefficientss_mem_17009.mem = futhark_mc_param_struct_18459_->free_coefficientss_mem_17009;
    coefficientss_mem_17009.size = 0;
    coefficientss_mem_17009.references = NULL;
    
    uniform int64_t bytes_17011 = futhark_mc_param_struct_18459_->free_bytes_17011;
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18483();
    mem_17061.mem = futhark_mc_param_struct_18459_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18484();
    mem_17065.mem = futhark_mc_param_struct_18459_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18485();
    mem_17069.mem = futhark_mc_param_struct_18459_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    struct memblock mem_17018 = *futhark_mc_mem_struct_18480_->mem_17018;
    struct memblock mem_17015 = *futhark_mc_mem_struct_18480_->mem_17015;
    struct memblock mem_17012 = *futhark_mc_mem_struct_18480_->mem_17012;
    uniform int err = 0;
    uniform int64_t start_17171;
    uniform int64_t end_17172;
    
    start_17171 = start;
    end_17172 = end;
    
    uniform int64_t n_17173 = end_17172 - start_17171;
    
    if (memblock_alloc(ctx, &mem_17012, bytes_17011, futhark_mc_strlit_shim_18465()))
        unmasked { return 1; }
    if (memblock_alloc(ctx, &mem_17015, bytes_17011, futhark_mc_strlit_shim_18466()))
        unmasked { return 1; }
    if (memblock_alloc(ctx, &mem_17018, bytes_17011, futhark_mc_strlit_shim_18467()))
        unmasked { return 1; }
    for (uniform int64_t i = 0; i < (start_17171 + n_17173 - start_17171) / programCount; i++) {
        int64_t SegMap_i_17174 = start_17171 + programIndex + i * programCount;
        uniform int64_t slice_17175 = m_12334;
        int64_t gtid_15966 = SegMap_i_17174;
        int64_t remnant_17176 = SegMap_i_17174 - gtid_15966;
        uniform int64_t flat_tid_17166 = (int64_t) 0;
        struct futhark_mc_task_18468 futhark_mc_task_18468_;
        
        futhark_mc_task_18468_.ctx = ctx;
        futhark_mc_task_18468_.free_p_12335 = p_12335;
        futhark_mc_task_18468_.free_gtid_15966 = gtid_15966;
        futhark_mc_task_18468_.free_coefficientss_mem_17009 = coefficientss_mem_17009.mem;
        futhark_mc_task_18468_.free_mem_17012 = mem_17012.mem;
        futhark_mc_task_18468_.free_mem_17015 = mem_17015.mem;
        futhark_mc_task_18468_.free_mem_17018 = mem_17018.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18468 aos_18479[programCount];
        
        aos_18479[programIndex] = futhark_mc_task_18468_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18478(ctx, &aos_18479[i], extract(p_12335, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18478(ctx, &futhark_mc_task_18468_, p_12335);
        if (err != 0)
            goto cleanup;
        #endif
        if (p_12335 * (int64_t) 8 > 0)
            memmove(mem_17061.mem + gtid_15966 * p_12335 * (int64_t) 8, mem_17012.mem + (int64_t) 0, p_12335 * (int64_t) 8);
        if (p_12335 * (int64_t) 8 > 0)
            memmove(mem_17065.mem + gtid_15966 * p_12335 * (int64_t) 8, mem_17015.mem + (int64_t) 0, p_12335 * (int64_t) 8);
        if (p_12335 * (int64_t) 8 > 0)
            memmove(mem_17069.mem + gtid_15966 * p_12335 * (int64_t) 8, mem_17018.mem + (int64_t) 0, p_12335 * (int64_t) 8);
    }
    if (programIndex < (start_17171 + n_17173 - start_17171) % programCount) {
        int64_t SegMap_i_17174 = start_17171 + programIndex + (start_17171 + n_17173 - start_17171) / programCount * programCount;
        uniform int64_t slice_17175 = m_12334;
        int64_t gtid_15966 = SegMap_i_17174;
        int64_t remnant_17176 = SegMap_i_17174 - gtid_15966;
        uniform int64_t flat_tid_17166 = (int64_t) 0;
        struct futhark_mc_task_18468 futhark_mc_task_18468_;
        
        futhark_mc_task_18468_.ctx = ctx;
        futhark_mc_task_18468_.free_p_12335 = p_12335;
        futhark_mc_task_18468_.free_gtid_15966 = gtid_15966;
        futhark_mc_task_18468_.free_coefficientss_mem_17009 = coefficientss_mem_17009.mem;
        futhark_mc_task_18468_.free_mem_17012 = mem_17012.mem;
        futhark_mc_task_18468_.free_mem_17015 = mem_17015.mem;
        futhark_mc_task_18468_.free_mem_17018 = mem_17018.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18468 aos_18479[programCount];
        
        aos_18479[programIndex] = futhark_mc_task_18468_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18478(ctx, &aos_18479[i], extract(p_12335, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18478(ctx, &futhark_mc_task_18468_, p_12335);
        if (err != 0)
            goto cleanup;
        #endif
        if (p_12335 * (int64_t) 8 > 0)
            memmove(mem_17061.mem + gtid_15966 * p_12335 * (int64_t) 8, mem_17012.mem + (int64_t) 0, p_12335 * (int64_t) 8);
        if (p_12335 * (int64_t) 8 > 0)
            memmove(mem_17065.mem + gtid_15966 * p_12335 * (int64_t) 8, mem_17015.mem + (int64_t) 0, p_12335 * (int64_t) 8);
        if (p_12335 * (int64_t) 8 > 0)
            memmove(mem_17069.mem + gtid_15966 * p_12335 * (int64_t) 8, mem_17018.mem + (int64_t) 0, p_12335 * (int64_t) 8);
    }
    *futhark_mc_mem_struct_18480_->mem_17018 = mem_17018;
    *futhark_mc_mem_struct_18480_->mem_17015 = mem_17015;
    *futhark_mc_mem_struct_18480_->mem_17012 = mem_17012;
    return err;
}
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18486();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18487();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18488();
export uniform int futhark_mc_loop_ispc_18460(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18459 *uniform futhark_mc_param_struct_18459_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18459_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18459_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18459_->free_p_12335;
    uniform struct memblock coefficientss_mem_17009;
    
    coefficientss_mem_17009.desc = futhark_mc_strlit_shim_18461();
    coefficientss_mem_17009.mem = futhark_mc_param_struct_18459_->free_coefficientss_mem_17009;
    coefficientss_mem_17009.size = 0;
    coefficientss_mem_17009.references = NULL;
    
    uniform int64_t bytes_17011 = futhark_mc_param_struct_18459_->free_bytes_17011;
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18462();
    mem_17061.mem = futhark_mc_param_struct_18459_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18463();
    mem_17065.mem = futhark_mc_param_struct_18459_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18464();
    mem_17069.mem = futhark_mc_param_struct_18459_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    struct memblock mem_17018;
    
    mem_17018.references = NULL;
    
    struct memblock mem_17015;
    
    mem_17015.references = NULL;
    
    struct memblock mem_17012;
    
    mem_17012.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18480 futhark_mc_mem_struct_18480_;
    
    futhark_mc_mem_struct_18480_.mem_17018 = &mem_17018;
    futhark_mc_mem_struct_18480_.mem_17015 = &mem_17015;
    futhark_mc_mem_struct_18480_.mem_17012 = &mem_17012;
    
    uniform int err = futhark_mc_inner_ispc_18481(start, end, futhark_mc_param_struct_18459_, &futhark_mc_mem_struct_18480_);
    
    mem_17018 = *futhark_mc_mem_struct_18480_.mem_17018;
    mem_17015 = *futhark_mc_mem_struct_18480_.mem_17015;
    mem_17012 = *futhark_mc_mem_struct_18480_.mem_17012;
    
  cleanup:
    {
        if (memblock_unref(ctx, &mem_17018, futhark_mc_strlit_shim_18486()) != 0)
            unmasked { return 1; }
        if (memblock_unref(ctx, &mem_17015, futhark_mc_strlit_shim_18487()) != 0)
            unmasked { return 1; }
        if (memblock_unref(ctx, &mem_17012, futhark_mc_strlit_shim_18488()) != 0)
            unmasked { return 1; }
    }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18489(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18431 *uniform args, uniform int iterations);
struct futhark_mc_task_18491 {
    struct futhark_context *ctx;
    int64_t free_n_12333;
    int64_t free_m_12334;
    int64_t free_p_12335;
    unsigned char *free_zzinvs_mem_17006;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    int64_t free_bytes_17076;
    int64_t free_bytes_17079;
    unsigned char *free_mem_17143;
};
struct futhark_mc_param_struct_18500 {
    struct futhark_context *ctx;
    int64_t free_n_12333;
    int64_t free_m_12334;
    int64_t free_p_12335;
    unsigned char *free_zzinvs_mem_17006;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    int64_t free_bytes_17076;
    int64_t free_bytes_17079;
    unsigned char *free_mem_17143;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18507();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18508();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18509();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18510();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18511();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18512();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18513();
struct futhark_mc_mem_struct_18517 {
    varying unsigned char *uniform mem_17080;
    varying size_t mem_17080_cached_sizze_18502;
    varying unsigned char *uniform mem_17083;
    varying size_t mem_17083_cached_sizze_18503;
    varying unsigned char *uniform mem_17086;
    varying size_t mem_17086_cached_sizze_18504;
    varying unsigned char *uniform mem_17120;
    varying size_t mem_17120_cached_sizze_18505;
    varying unsigned char *uniform mem_17130;
    varying size_t mem_17130_cached_sizze_18506;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18519();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18520();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18521();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18522();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18523();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18524();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18525();
static unmasked inline uniform int futhark_mc_inner_ispc_18518(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18500 *uniform futhark_mc_param_struct_18500_, uniform struct futhark_mc_mem_struct_18517 *uniform futhark_mc_mem_struct_18517_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18500_->ctx;
    uniform int64_t n_12333 = futhark_mc_param_struct_18500_->free_n_12333;
    uniform int64_t m_12334 = futhark_mc_param_struct_18500_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18500_->free_p_12335;
    uniform struct memblock zzinvs_mem_17006;
    
    zzinvs_mem_17006.desc = futhark_mc_strlit_shim_18519();
    zzinvs_mem_17006.mem = futhark_mc_param_struct_18500_->free_zzinvs_mem_17006;
    zzinvs_mem_17006.size = 0;
    zzinvs_mem_17006.references = NULL;
    
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18520();
    eps_mem_17007.mem = futhark_mc_param_struct_18500_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18521();
    expsss_mem_17008.mem = futhark_mc_param_struct_18500_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18522();
    mem_17061.mem = futhark_mc_param_struct_18500_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18523();
    mem_17065.mem = futhark_mc_param_struct_18500_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18524();
    mem_17069.mem = futhark_mc_param_struct_18500_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform int64_t bytes_17076 = futhark_mc_param_struct_18500_->free_bytes_17076;
    uniform int64_t bytes_17079 = futhark_mc_param_struct_18500_->free_bytes_17079;
    uniform struct memblock mem_17143;
    
    mem_17143.desc = futhark_mc_strlit_shim_18525();
    mem_17143.mem = futhark_mc_param_struct_18500_->free_mem_17143;
    mem_17143.size = 0;
    mem_17143.references = NULL;
    
    varying unsigned char *uniform mem_17080 = futhark_mc_mem_struct_18517_->mem_17080;
    size_t mem_17080_cached_sizze_18502 = futhark_mc_mem_struct_18517_->mem_17080_cached_sizze_18502;
    varying unsigned char *uniform mem_17083 = futhark_mc_mem_struct_18517_->mem_17083;
    size_t mem_17083_cached_sizze_18503 = futhark_mc_mem_struct_18517_->mem_17083_cached_sizze_18503;
    varying unsigned char *uniform mem_17086 = futhark_mc_mem_struct_18517_->mem_17086;
    size_t mem_17086_cached_sizze_18504 = futhark_mc_mem_struct_18517_->mem_17086_cached_sizze_18504;
    varying unsigned char *uniform mem_17120 = futhark_mc_mem_struct_18517_->mem_17120;
    size_t mem_17120_cached_sizze_18505 = futhark_mc_mem_struct_18517_->mem_17120_cached_sizze_18505;
    varying unsigned char *uniform mem_17130 = futhark_mc_mem_struct_18517_->mem_17130;
    size_t mem_17130_cached_sizze_18506 = futhark_mc_mem_struct_18517_->mem_17130_cached_sizze_18506;
    uniform int err = 0;
    uniform int64_t start_17357;
    uniform int64_t end_17358;
    
    start_17357 = start;
    end_17358 = end;
    
    uniform int64_t n_17359 = end_17358 - start_17357;
    
    if (mem_17080_cached_sizze_18502 < bytes_17079) {
        err = lexical_realloc(ctx, &mem_17080, &mem_17080_cached_sizze_18502, bytes_17079);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17083_cached_sizze_18503 < bytes_17079) {
        err = lexical_realloc(ctx, &mem_17083, &mem_17083_cached_sizze_18503, bytes_17079);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17086_cached_sizze_18504 < bytes_17079) {
        err = lexical_realloc(ctx, &mem_17086, &mem_17086_cached_sizze_18504, bytes_17079);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17120_cached_sizze_18505 < bytes_17076) {
        err = lexical_realloc(ctx, &mem_17120, &mem_17120_cached_sizze_18505, bytes_17076);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    if (mem_17130_cached_sizze_18506 < (int64_t) 24) {
        err = lexical_realloc(ctx, &mem_17130, &mem_17130_cached_sizze_18506, (int64_t) 24);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    foreach (SegMap_i_17360 = start_17357 ... start_17357 + n_17359)
    {
        uniform int64_t slice_17361 = n_12333;
        int64_t gtid_15978 = SegMap_i_17360;
        int64_t remnant_17362 = SegMap_i_17360 - gtid_15978;
        int64_t defunc_0_f_res_15081;
        
        defunc_0_f_res_15081 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_15978 * (int64_t) 3];
        
        int64_t defunc_0_f_res_15082;
        
        defunc_0_f_res_15082 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_15978 * (int64_t) 3 + (int64_t) 1];
        
        int64_t defunc_0_f_res_15083;
        
        defunc_0_f_res_15083 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_15978 * (int64_t) 3 + (int64_t) 2];
        for (uniform int64_t i_17185 = 0; i_17185 < m_12334; i_17185++) {
            int64_t defunc_0_f_res_17189;
            
            defunc_0_f_res_17189 = ((int64_t *) eps_mem_17007.mem)[gtid_15978 * ((int64_t) 3 * m_12334) + i_17185 * (int64_t) 3];
            
            int64_t defunc_0_f_res_17190;
            
            defunc_0_f_res_17190 = ((int64_t *) eps_mem_17007.mem)[gtid_15978 * ((int64_t) 3 * m_12334) + i_17185 * (int64_t) 3 + (int64_t) 1];
            
            int64_t defunc_0_f_res_17191;
            
            defunc_0_f_res_17191 = ((int64_t *) eps_mem_17007.mem)[gtid_15978 * ((int64_t) 3 * m_12334) + i_17185 * (int64_t) 3 + (int64_t) 2];
            ((varying int64_t *) mem_17080)[i_17185] = defunc_0_f_res_17189;
            ((varying int64_t *) mem_17083)[i_17185] = defunc_0_f_res_17190;
            ((varying int64_t *) mem_17086)[i_17185] = defunc_0_f_res_17191;
        }
        for (uniform int64_t i_17195 = 0; i_17195 < m_12334; i_17195++) {
            int64_t defunc_0_f_res_17197;
            int64_t defunc_0_f_res_17198;
            int64_t defunc_0_f_res_17199;
            int64_t redout_17201;
            int64_t redout_17202;
            int64_t redout_17203;
            
            redout_17201 = (int64_t) 0;
            redout_17202 = (int64_t) 0;
            redout_17203 = (int64_t) 0;
            for (uniform int64_t i_17200 = 0; i_17200 < p_12335; i_17200++) {
                uniform int64_t x_17204;
                
                x_17204 = ((int64_t *) mem_17061.mem)[i_17195 * p_12335 + i_17200];
                
                uniform int64_t x_17205;
                
                x_17205 = ((int64_t *) mem_17065.mem)[i_17195 * p_12335 + i_17200];
                
                uniform int64_t x_17206;
                
                x_17206 = ((int64_t *) mem_17069.mem)[i_17195 * p_12335 + i_17200];
                
                int64_t defunc_0_f_res_17207;
                int64_t defunc_0_f_res_17208;
                int64_t defunc_0_f_res_17209;
                int64_t redout_17211;
                int64_t redout_17212;
                int64_t redout_17213;
                
                redout_17211 = (int64_t) 1;
                redout_17212 = (int64_t) 0;
                redout_17213 = (int64_t) 0;
                for (uniform int64_t i_17210 = 0; i_17210 < m_12334; i_17210++) {
                    uniform int64_t x_17214;
                    
                    x_17214 = ((int64_t *) expsss_mem_17008.mem)[i_17195 * (m_12334 * p_12335) + i_17200 * m_12334 + i_17210];
                    
                    int64_t x_17215;
                    
                    x_17215 = ((varying int64_t *) mem_17080)[i_17210];
                    
                    int64_t x_17216;
                    
                    x_17216 = ((varying int64_t *) mem_17083)[i_17210];
                    
                    int64_t x_17217;
                    
                    x_17217 = ((varying int64_t *) mem_17086)[i_17210];
                    
                    uniform bool loop_cond_17218 = ult64((int64_t) 0, x_17214);
                    uniform bool mod_pow_u64_res_17219;
                    int64_t mod_pow_u64_res_17220;
                    int64_t mod_pow_u64_res_17221;
                    int64_t mod_pow_u64_res_17222;
                    uniform int64_t mod_pow_u64_res_17223;
                    int64_t mod_pow_u64_res_17224;
                    int64_t mod_pow_u64_res_17225;
                    int64_t mod_pow_u64_res_17226;
                    uniform bool loop_while_17227;
                    int64_t x_17228;
                    int64_t x_17229;
                    int64_t x_17230;
                    uniform int64_t i_17231;
                    int64_t result_17232;
                    int64_t result_17233;
                    int64_t result_17234;
                    
                    loop_while_17227 = loop_cond_17218;
                    x_17228 = x_17215;
                    x_17229 = x_17216;
                    x_17230 = x_17217;
                    i_17231 = x_17214;
                    result_17232 = (int64_t) 1;
                    result_17233 = (int64_t) 0;
                    result_17234 = (int64_t) 0;
                    while (loop_while_17227) {
                        uniform int64_t x_17235 = umod64(i_17231, (int64_t) 2);
                        uniform bool cond_17236 = x_17235 == (int64_t) 1;
                        int64_t loopres_17237;
                        int64_t loopres_17238;
                        int64_t loopres_17239;
                        uniform int64_t loopres_17240;
                        int64_t loopres_17241;
                        int64_t loopres_17242;
                        int64_t loopres_17243;
                        
                        if (cond_17236 == 1) {
                            int64_t x_17244 = mul64(x_17228, x_17228);
                            int64_t y_17245 = mul64(x_17229, x_17230);
                            int64_t x_17246 = sub64(x_17244, y_17245);
                            int64_t mul_res_17247 = sub64(x_17246, y_17245);
                            int64_t x_17248 = mul64(x_17228, x_17229);
                            int64_t x_17249 = add64(x_17248, x_17248);
                            int64_t y_17250 = mul64(x_17230, x_17230);
                            int64_t x_17251 = sub64(x_17249, y_17250);
                            int64_t x_17252 = add64(y_17245, x_17251);
                            int64_t mul_res_17253 = add64(y_17245, x_17252);
                            int64_t x_17254 = mul64(x_17228, x_17230);
                            int64_t y_17255 = mul64(x_17229, x_17229);
                            int64_t x_17256 = add64(x_17254, y_17255);
                            int64_t x_17257 = add64(x_17254, x_17256);
                            int64_t mul_res_17258 = add64(y_17250, x_17257);
                            uniform int64_t loopres_t_res_17259 = lshr64(i_17231, (int64_t) 1);
                            int64_t x_17260 = mul64(x_17228, result_17232);
                            int64_t y_17261 = mul64(x_17230, result_17233);
                            int64_t x_17262 = sub64(x_17260, y_17261);
                            int64_t y_17263 = mul64(x_17229, result_17234);
                            int64_t mul_res_17264 = sub64(x_17262, y_17263);
                            int64_t x_17265 = mul64(x_17229, result_17232);
                            int64_t y_17266 = mul64(x_17228, result_17233);
                            int64_t x_17267 = add64(x_17265, y_17266);
                            int64_t y_17268 = mul64(x_17230, result_17234);
                            int64_t x_17269 = sub64(x_17267, y_17268);
                            int64_t x_17270 = add64(y_17261, x_17269);
                            int64_t mul_res_17271 = add64(y_17263, x_17270);
                            int64_t x_17272 = mul64(x_17230, result_17232);
                            int64_t y_17273 = mul64(x_17229, result_17233);
                            int64_t x_17274 = add64(x_17272, y_17273);
                            int64_t y_17275 = mul64(x_17228, result_17234);
                            int64_t x_17276 = add64(x_17274, y_17275);
                            int64_t mul_res_17277 = add64(y_17268, x_17276);
                            
                            loopres_17237 = mul_res_17247;
                            loopres_17238 = mul_res_17253;
                            loopres_17239 = mul_res_17258;
                            loopres_17240 = loopres_t_res_17259;
                            loopres_17241 = mul_res_17264;
                            loopres_17242 = mul_res_17271;
                            loopres_17243 = mul_res_17277;
                        } else {
                            int64_t x_17278 = mul64(x_17228, x_17228);
                            int64_t y_17279 = mul64(x_17229, x_17230);
                            int64_t x_17280 = sub64(x_17278, y_17279);
                            int64_t mul_res_17281 = sub64(x_17280, y_17279);
                            int64_t x_17282 = mul64(x_17228, x_17229);
                            int64_t x_17283 = add64(x_17282, x_17282);
                            int64_t y_17284 = mul64(x_17230, x_17230);
                            int64_t x_17285 = sub64(x_17283, y_17284);
                            int64_t x_17286 = add64(y_17279, x_17285);
                            int64_t mul_res_17287 = add64(y_17279, x_17286);
                            int64_t x_17288 = mul64(x_17228, x_17230);
                            int64_t y_17289 = mul64(x_17229, x_17229);
                            int64_t x_17290 = add64(x_17288, y_17289);
                            int64_t x_17291 = add64(x_17288, x_17290);
                            int64_t mul_res_17292 = add64(y_17284, x_17291);
                            uniform int64_t loopres_f_res_17293 = lshr64(i_17231, (int64_t) 1);
                            
                            loopres_17237 = mul_res_17281;
                            loopres_17238 = mul_res_17287;
                            loopres_17239 = mul_res_17292;
                            loopres_17240 = loopres_f_res_17293;
                            loopres_17241 = result_17232;
                            loopres_17242 = result_17233;
                            loopres_17243 = result_17234;
                        }
                        
                        uniform bool loop_cond_17294 = ult64((int64_t) 0, loopres_17240);
                        uniform bool loop_while_tmp_17373 = loop_cond_17294;
                        int64_t x_tmp_17374 = loopres_17237;
                        int64_t x_tmp_17375 = loopres_17238;
                        int64_t x_tmp_17376 = loopres_17239;
                        uniform int64_t i_tmp_17377 = loopres_17240;
                        int64_t result_tmp_17378 = loopres_17241;
                        int64_t result_tmp_17379 = loopres_17242;
                        int64_t result_tmp_17380 = loopres_17243;
                        
                        loop_while_17227 = loop_while_tmp_17373;
                        x_17228 = x_tmp_17374;
                        x_17229 = x_tmp_17375;
                        x_17230 = x_tmp_17376;
                        i_17231 = i_tmp_17377;
                        result_17232 = result_tmp_17378;
                        result_17233 = result_tmp_17379;
                        result_17234 = result_tmp_17380;
                    }
                    mod_pow_u64_res_17219 = loop_while_17227;
                    mod_pow_u64_res_17220 = x_17228;
                    mod_pow_u64_res_17221 = x_17229;
                    mod_pow_u64_res_17222 = x_17230;
                    mod_pow_u64_res_17223 = i_17231;
                    mod_pow_u64_res_17224 = result_17232;
                    mod_pow_u64_res_17225 = result_17233;
                    mod_pow_u64_res_17226 = result_17234;
                    
                    int64_t x_17295 = mul64(mod_pow_u64_res_17224, redout_17211);
                    int64_t y_17296 = mul64(mod_pow_u64_res_17225, redout_17213);
                    int64_t x_17297 = sub64(x_17295, y_17296);
                    int64_t y_17298 = mul64(mod_pow_u64_res_17226, redout_17212);
                    int64_t defunc_1_op_res_17299 = sub64(x_17297, y_17298);
                    int64_t x_17300 = mul64(mod_pow_u64_res_17224, redout_17212);
                    int64_t y_17301 = mul64(mod_pow_u64_res_17225, redout_17211);
                    int64_t x_17302 = add64(x_17300, y_17301);
                    int64_t y_17303 = mul64(mod_pow_u64_res_17226, redout_17213);
                    int64_t x_17304 = sub64(x_17302, y_17303);
                    int64_t x_17305 = add64(y_17296, x_17304);
                    int64_t defunc_1_op_res_17306 = add64(y_17298, x_17305);
                    int64_t x_17307 = mul64(mod_pow_u64_res_17224, redout_17213);
                    int64_t y_17308 = mul64(mod_pow_u64_res_17225, redout_17212);
                    int64_t x_17309 = add64(x_17307, y_17308);
                    int64_t y_17310 = mul64(mod_pow_u64_res_17226, redout_17211);
                    int64_t x_17311 = add64(x_17309, y_17310);
                    int64_t defunc_1_op_res_17312 = add64(y_17303, x_17311);
                    int64_t redout_tmp_17370 = defunc_1_op_res_17299;
                    int64_t redout_tmp_17371 = defunc_1_op_res_17306;
                    int64_t redout_tmp_17372 = defunc_1_op_res_17312;
                    
                    redout_17211 = redout_tmp_17370;
                    redout_17212 = redout_tmp_17371;
                    redout_17213 = redout_tmp_17372;
                }
                defunc_0_f_res_17207 = redout_17211;
                defunc_0_f_res_17208 = redout_17212;
                defunc_0_f_res_17209 = redout_17213;
                
                int64_t x_17313 = mul64(x_17204, defunc_0_f_res_17207);
                int64_t y_17314 = mul64(x_17206, defunc_0_f_res_17208);
                int64_t x_17315 = sub64(x_17313, y_17314);
                int64_t y_17316 = mul64(x_17205, defunc_0_f_res_17209);
                int64_t mul_res_17317 = sub64(x_17315, y_17316);
                int64_t x_17318 = mul64(x_17205, defunc_0_f_res_17207);
                int64_t y_17319 = mul64(x_17204, defunc_0_f_res_17208);
                int64_t x_17320 = add64(x_17318, y_17319);
                int64_t y_17321 = mul64(x_17206, defunc_0_f_res_17209);
                int64_t x_17322 = sub64(x_17320, y_17321);
                int64_t x_17323 = add64(y_17314, x_17322);
                int64_t mul_res_17324 = add64(y_17316, x_17323);
                int64_t x_17325 = mul64(x_17206, defunc_0_f_res_17207);
                int64_t y_17326 = mul64(x_17205, defunc_0_f_res_17208);
                int64_t x_17327 = add64(x_17325, y_17326);
                int64_t y_17328 = mul64(x_17204, defunc_0_f_res_17209);
                int64_t x_17329 = add64(x_17327, y_17328);
                int64_t mul_res_17330 = add64(y_17321, x_17329);
                int64_t canonicalizze_arg_17331 = add64(mul_res_17317, redout_17201);
                int64_t canonicalizze_res_17332 = umod64(canonicalizze_arg_17331, (int64_t) -4294967295);
                int64_t canonicalizze_arg_17333 = add64(mul_res_17324, redout_17202);
                int64_t canonicalizze_res_17334 = umod64(canonicalizze_arg_17333, (int64_t) -4294967295);
                int64_t canonicalizze_arg_17335 = add64(mul_res_17330, redout_17203);
                int64_t canonicalizze_res_17336 = umod64(canonicalizze_arg_17335, (int64_t) -4294967295);
                int64_t redout_tmp_17367 = canonicalizze_res_17332;
                int64_t redout_tmp_17368 = canonicalizze_res_17334;
                int64_t redout_tmp_17369 = canonicalizze_res_17336;
                
                redout_17201 = redout_tmp_17367;
                redout_17202 = redout_tmp_17368;
                redout_17203 = redout_tmp_17369;
            }
            defunc_0_f_res_17197 = redout_17201;
            defunc_0_f_res_17198 = redout_17202;
            defunc_0_f_res_17199 = redout_17203;
            
            int64_t x_17337 = mul64(defunc_0_f_res_15081, defunc_0_f_res_17197);
            int64_t y_17338 = mul64(defunc_0_f_res_15083, defunc_0_f_res_17198);
            int64_t x_17339 = sub64(x_17337, y_17338);
            int64_t y_17340 = mul64(defunc_0_f_res_15082, defunc_0_f_res_17199);
            int64_t mul_res_17341 = sub64(x_17339, y_17340);
            int64_t x_17342 = mul64(defunc_0_f_res_15082, defunc_0_f_res_17197);
            int64_t y_17343 = mul64(defunc_0_f_res_15081, defunc_0_f_res_17198);
            int64_t x_17344 = add64(x_17342, y_17343);
            int64_t y_17345 = mul64(defunc_0_f_res_15083, defunc_0_f_res_17199);
            int64_t x_17346 = sub64(x_17344, y_17345);
            int64_t x_17347 = add64(y_17338, x_17346);
            int64_t mul_res_17348 = add64(y_17340, x_17347);
            int64_t x_17349 = mul64(defunc_0_f_res_15083, defunc_0_f_res_17197);
            int64_t y_17350 = mul64(defunc_0_f_res_15082, defunc_0_f_res_17198);
            int64_t x_17351 = add64(x_17349, y_17350);
            int64_t y_17352 = mul64(defunc_0_f_res_15081, defunc_0_f_res_17199);
            int64_t x_17353 = add64(x_17351, y_17352);
            int64_t mul_res_17354 = add64(y_17345, x_17353);
            uniform int64_t tmp_idx_18514 = (int64_t) 0;
            
            ((varying int64_t *) mem_17130)[tmp_idx_18514] = mul_res_17341;
            
            uniform int64_t tmp_idx_18515 = (int64_t) 1;
            
            ((varying int64_t *) mem_17130)[tmp_idx_18515] = mul_res_17348;
            
            uniform int64_t tmp_idx_18516 = (int64_t) 2;
            
            ((varying int64_t *) mem_17130)[tmp_idx_18516] = mul_res_17354;
            if ((int64_t) 24 > 0)
                memmove_64(mem_17120 + i_17195 * (int64_t) 3 * (int64_t) 8, mem_17130 + (int64_t) 0, extract((int64_t) 24, 0));
        }
        if (m_12334 * (int64_t) 3 * (int64_t) 8 > 0)
            memmove_64(mem_17143.mem + gtid_15978 * ((int64_t) 3 * m_12334) * (int64_t) 8, mem_17120 + (int64_t) 0, extract(m_12334 * (int64_t) 3 * (int64_t) 8, 0));
    }
    futhark_mc_mem_struct_18517_->mem_17080 = mem_17080;
    futhark_mc_mem_struct_18517_->mem_17080_cached_sizze_18502 = mem_17080_cached_sizze_18502;
    futhark_mc_mem_struct_18517_->mem_17083 = mem_17083;
    futhark_mc_mem_struct_18517_->mem_17083_cached_sizze_18503 = mem_17083_cached_sizze_18503;
    futhark_mc_mem_struct_18517_->mem_17086 = mem_17086;
    futhark_mc_mem_struct_18517_->mem_17086_cached_sizze_18504 = mem_17086_cached_sizze_18504;
    futhark_mc_mem_struct_18517_->mem_17120 = mem_17120;
    futhark_mc_mem_struct_18517_->mem_17120_cached_sizze_18505 = mem_17120_cached_sizze_18505;
    futhark_mc_mem_struct_18517_->mem_17130 = mem_17130;
    futhark_mc_mem_struct_18517_->mem_17130_cached_sizze_18506 = mem_17130_cached_sizze_18506;
    return err;
}
export uniform int futhark_mc_loop_ispc_18501(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18500 *uniform futhark_mc_param_struct_18500_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18500_->ctx;
    uniform int64_t n_12333 = futhark_mc_param_struct_18500_->free_n_12333;
    uniform int64_t m_12334 = futhark_mc_param_struct_18500_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18500_->free_p_12335;
    uniform struct memblock zzinvs_mem_17006;
    
    zzinvs_mem_17006.desc = futhark_mc_strlit_shim_18507();
    zzinvs_mem_17006.mem = futhark_mc_param_struct_18500_->free_zzinvs_mem_17006;
    zzinvs_mem_17006.size = 0;
    zzinvs_mem_17006.references = NULL;
    
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18508();
    eps_mem_17007.mem = futhark_mc_param_struct_18500_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18509();
    expsss_mem_17008.mem = futhark_mc_param_struct_18500_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18510();
    mem_17061.mem = futhark_mc_param_struct_18500_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18511();
    mem_17065.mem = futhark_mc_param_struct_18500_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18512();
    mem_17069.mem = futhark_mc_param_struct_18500_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform int64_t bytes_17076 = futhark_mc_param_struct_18500_->free_bytes_17076;
    uniform int64_t bytes_17079 = futhark_mc_param_struct_18500_->free_bytes_17079;
    uniform struct memblock mem_17143;
    
    mem_17143.desc = futhark_mc_strlit_shim_18513();
    mem_17143.mem = futhark_mc_param_struct_18500_->free_mem_17143;
    mem_17143.size = 0;
    mem_17143.references = NULL;
    
    size_t mem_17080_cached_sizze_18502 = 0;
    varying unsigned char *uniform mem_17080 = NULL;
    size_t mem_17083_cached_sizze_18503 = 0;
    varying unsigned char *uniform mem_17083 = NULL;
    size_t mem_17086_cached_sizze_18504 = 0;
    varying unsigned char *uniform mem_17086 = NULL;
    size_t mem_17120_cached_sizze_18505 = 0;
    varying unsigned char *uniform mem_17120 = NULL;
    size_t mem_17130_cached_sizze_18506 = 0;
    varying unsigned char *uniform mem_17130 = NULL;
    uniform struct futhark_mc_mem_struct_18517 futhark_mc_mem_struct_18517_;
    
    futhark_mc_mem_struct_18517_.mem_17080 = mem_17080;
    futhark_mc_mem_struct_18517_.mem_17080_cached_sizze_18502 = mem_17080_cached_sizze_18502;
    futhark_mc_mem_struct_18517_.mem_17083 = mem_17083;
    futhark_mc_mem_struct_18517_.mem_17083_cached_sizze_18503 = mem_17083_cached_sizze_18503;
    futhark_mc_mem_struct_18517_.mem_17086 = mem_17086;
    futhark_mc_mem_struct_18517_.mem_17086_cached_sizze_18504 = mem_17086_cached_sizze_18504;
    futhark_mc_mem_struct_18517_.mem_17120 = mem_17120;
    futhark_mc_mem_struct_18517_.mem_17120_cached_sizze_18505 = mem_17120_cached_sizze_18505;
    futhark_mc_mem_struct_18517_.mem_17130 = mem_17130;
    futhark_mc_mem_struct_18517_.mem_17130_cached_sizze_18506 = mem_17130_cached_sizze_18506;
    
    uniform int err = futhark_mc_inner_ispc_18518(start, end, futhark_mc_param_struct_18500_, &futhark_mc_mem_struct_18517_);
    
    mem_17080 = futhark_mc_mem_struct_18517_.mem_17080;
    mem_17080_cached_sizze_18502 = futhark_mc_mem_struct_18517_.mem_17080_cached_sizze_18502;
    mem_17083 = futhark_mc_mem_struct_18517_.mem_17083;
    mem_17083_cached_sizze_18503 = futhark_mc_mem_struct_18517_.mem_17083_cached_sizze_18503;
    mem_17086 = futhark_mc_mem_struct_18517_.mem_17086;
    mem_17086_cached_sizze_18504 = futhark_mc_mem_struct_18517_.mem_17086_cached_sizze_18504;
    mem_17120 = futhark_mc_mem_struct_18517_.mem_17120;
    mem_17120_cached_sizze_18505 = futhark_mc_mem_struct_18517_.mem_17120_cached_sizze_18505;
    mem_17130 = futhark_mc_mem_struct_18517_.mem_17130;
    mem_17130_cached_sizze_18506 = futhark_mc_mem_struct_18517_.mem_17130_cached_sizze_18506;
    
  cleanup:
    {
        free(mem_17080);
        free(mem_17083);
        free(mem_17086);
        free(mem_17120);
        free(mem_17130);
    }
    return err;
}
struct futhark_mc_param_struct_18530 {
    struct futhark_context *ctx;
    int64_t free_n_12333;
    int64_t free_m_12334;
    int64_t free_p_12335;
    unsigned char *free_zzinvs_mem_17006;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    int64_t free_bytes_17076;
    unsigned char *free_mem_17143;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18532();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18533();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18534();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18535();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18536();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18537();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18538();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18539();
struct futhark_mc_task_18540 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    int64_t free_gtid_16458;
    int64_t free_defunc_0_f_res_16461;
    int64_t free_defunc_0_f_res_16462;
    int64_t free_defunc_0_f_res_16463;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    unsigned char *free_mem_17077;
};
struct futhark_mc_param_struct_18545 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    int64_t free_gtid_16458;
    int64_t free_defunc_0_f_res_16461;
    int64_t free_defunc_0_f_res_16462;
    int64_t free_defunc_0_f_res_16463;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    unsigned char *free_mem_17077;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18548();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18549();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18550();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18551();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18552();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18553();
struct futhark_mc_mem_struct_18557 {
    varying unsigned char *uniform mem_17853;
    varying size_t mem_17853_cached_sizze_18547;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18559();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18560();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18561();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18562();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18563();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18564();
static unmasked inline uniform int futhark_mc_inner_ispc_18558(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18545 *uniform futhark_mc_param_struct_18545_, uniform struct futhark_mc_mem_struct_18557 *uniform futhark_mc_mem_struct_18557_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18545_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18545_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18545_->free_p_12335;
    uniform int64_t gtid_16458 = futhark_mc_param_struct_18545_->free_gtid_16458;
    uniform int64_t defunc_0_f_res_16461 = futhark_mc_param_struct_18545_->free_defunc_0_f_res_16461;
    uniform int64_t defunc_0_f_res_16462 = futhark_mc_param_struct_18545_->free_defunc_0_f_res_16462;
    uniform int64_t defunc_0_f_res_16463 = futhark_mc_param_struct_18545_->free_defunc_0_f_res_16463;
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18559();
    eps_mem_17007.mem = futhark_mc_param_struct_18545_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18560();
    expsss_mem_17008.mem = futhark_mc_param_struct_18545_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18561();
    mem_17061.mem = futhark_mc_param_struct_18545_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18562();
    mem_17065.mem = futhark_mc_param_struct_18545_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18563();
    mem_17069.mem = futhark_mc_param_struct_18545_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform struct memblock mem_17077;
    
    mem_17077.desc = futhark_mc_strlit_shim_18564();
    mem_17077.mem = futhark_mc_param_struct_18545_->free_mem_17077;
    mem_17077.size = 0;
    mem_17077.references = NULL;
    
    varying unsigned char *uniform mem_17853 = futhark_mc_mem_struct_18557_->mem_17853;
    size_t mem_17853_cached_sizze_18547 = futhark_mc_mem_struct_18557_->mem_17853_cached_sizze_18547;
    uniform int err = 0;
    uniform int64_t start_17999;
    uniform int64_t end_18000;
    
    start_17999 = start;
    end_18000 = end;
    
    uniform int64_t n_18001 = end_18000 - start_17999;
    
    if (mem_17853_cached_sizze_18547 < (int64_t) 24) {
        err = lexical_realloc(ctx, &mem_17853, &mem_17853_cached_sizze_18547, (int64_t) 24);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    foreach (SegMap_i_18002 = start_17999 ... start_17999 + n_18001)
    {
        uniform int64_t slice_18003 = m_12334;
        int64_t gtid_17694 = SegMap_i_18002;
        int64_t remnant_18004 = SegMap_i_18002 - gtid_17694;
        int64_t defunc_0_f_res_17695;
        int64_t defunc_0_f_res_17696;
        int64_t defunc_0_f_res_17697;
        int64_t redout_17863;
        int64_t redout_17864;
        int64_t redout_17865;
        
        redout_17863 = (int64_t) 0;
        redout_17864 = (int64_t) 0;
        redout_17865 = (int64_t) 0;
        for (uniform int64_t i_17862 = 0; i_17862 < p_12335; i_17862++) {
            int64_t x_17866;
            
            x_17866 = ((int64_t *) mem_17061.mem)[gtid_17694 * p_12335 + i_17862];
            
            int64_t x_17867;
            
            x_17867 = ((int64_t *) mem_17065.mem)[gtid_17694 * p_12335 + i_17862];
            
            int64_t x_17868;
            
            x_17868 = ((int64_t *) mem_17069.mem)[gtid_17694 * p_12335 + i_17862];
            
            int64_t defunc_0_f_res_17869;
            int64_t defunc_0_f_res_17870;
            int64_t defunc_0_f_res_17871;
            int64_t redout_17873;
            int64_t redout_17874;
            int64_t redout_17875;
            
            redout_17873 = (int64_t) 1;
            redout_17874 = (int64_t) 0;
            redout_17875 = (int64_t) 0;
            for (uniform int64_t i_17872 = 0; i_17872 < m_12334; i_17872++) {
                int64_t x_17876;
                
                x_17876 = ((int64_t *) expsss_mem_17008.mem)[gtid_17694 * (m_12334 * p_12335) + i_17862 * m_12334 + i_17872];
                
                uniform int64_t x_17877;
                
                x_17877 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + i_17872 * (int64_t) 3];
                
                uniform int64_t x_17878;
                
                x_17878 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + i_17872 * (int64_t) 3 + (int64_t) 1];
                
                uniform int64_t x_17879;
                
                x_17879 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + i_17872 * (int64_t) 3 + (int64_t) 2];
                
                bool loop_cond_17880 = ult64((int64_t) 0, x_17876);
                bool mod_pow_u64_res_17881;
                int64_t mod_pow_u64_res_17882;
                int64_t mod_pow_u64_res_17883;
                int64_t mod_pow_u64_res_17884;
                int64_t mod_pow_u64_res_17885;
                int64_t mod_pow_u64_res_17886;
                int64_t mod_pow_u64_res_17887;
                int64_t mod_pow_u64_res_17888;
                bool loop_while_17889;
                int64_t x_17890;
                int64_t x_17891;
                int64_t x_17892;
                int64_t i_17893;
                int64_t result_17894;
                int64_t result_17895;
                int64_t result_17896;
                
                loop_while_17889 = loop_cond_17880;
                x_17890 = x_17877;
                x_17891 = x_17878;
                x_17892 = x_17879;
                i_17893 = x_17876;
                result_17894 = (int64_t) 1;
                result_17895 = (int64_t) 0;
                result_17896 = (int64_t) 0;
                while (loop_while_17889) {
                    int64_t x_17897 = umod64(i_17893, (int64_t) 2);
                    bool cond_17898 = x_17897 == (int64_t) 1;
                    int64_t loopres_17899;
                    int64_t loopres_17900;
                    int64_t loopres_17901;
                    int64_t loopres_17902;
                    int64_t loopres_17903;
                    int64_t loopres_17904;
                    int64_t loopres_17905;
                    
                    if (cond_17898 == 1) {
                        int64_t x_17906 = mul64(x_17890, x_17890);
                        int64_t y_17907 = mul64(x_17891, x_17892);
                        int64_t x_17908 = sub64(x_17906, y_17907);
                        int64_t mul_res_17909 = sub64(x_17908, y_17907);
                        int64_t x_17910 = mul64(x_17890, x_17891);
                        int64_t x_17911 = add64(x_17910, x_17910);
                        int64_t y_17912 = mul64(x_17892, x_17892);
                        int64_t x_17913 = sub64(x_17911, y_17912);
                        int64_t x_17914 = add64(y_17907, x_17913);
                        int64_t mul_res_17915 = add64(y_17907, x_17914);
                        int64_t x_17916 = mul64(x_17890, x_17892);
                        int64_t y_17917 = mul64(x_17891, x_17891);
                        int64_t x_17918 = add64(x_17916, y_17917);
                        int64_t x_17919 = add64(x_17916, x_17918);
                        int64_t mul_res_17920 = add64(y_17912, x_17919);
                        int64_t loopres_t_res_17921 = lshr64(i_17893, (int64_t) 1);
                        int64_t x_17922 = mul64(x_17890, result_17894);
                        int64_t y_17923 = mul64(x_17892, result_17895);
                        int64_t x_17924 = sub64(x_17922, y_17923);
                        int64_t y_17925 = mul64(x_17891, result_17896);
                        int64_t mul_res_17926 = sub64(x_17924, y_17925);
                        int64_t x_17927 = mul64(x_17891, result_17894);
                        int64_t y_17928 = mul64(x_17890, result_17895);
                        int64_t x_17929 = add64(x_17927, y_17928);
                        int64_t y_17930 = mul64(x_17892, result_17896);
                        int64_t x_17931 = sub64(x_17929, y_17930);
                        int64_t x_17932 = add64(y_17923, x_17931);
                        int64_t mul_res_17933 = add64(y_17925, x_17932);
                        int64_t x_17934 = mul64(x_17892, result_17894);
                        int64_t y_17935 = mul64(x_17891, result_17895);
                        int64_t x_17936 = add64(x_17934, y_17935);
                        int64_t y_17937 = mul64(x_17890, result_17896);
                        int64_t x_17938 = add64(x_17936, y_17937);
                        int64_t mul_res_17939 = add64(y_17930, x_17938);
                        
                        loopres_17899 = mul_res_17909;
                        loopres_17900 = mul_res_17915;
                        loopres_17901 = mul_res_17920;
                        loopres_17902 = loopres_t_res_17921;
                        loopres_17903 = mul_res_17926;
                        loopres_17904 = mul_res_17933;
                        loopres_17905 = mul_res_17939;
                    } else {
                        int64_t x_17940 = mul64(x_17890, x_17890);
                        int64_t y_17941 = mul64(x_17891, x_17892);
                        int64_t x_17942 = sub64(x_17940, y_17941);
                        int64_t mul_res_17943 = sub64(x_17942, y_17941);
                        int64_t x_17944 = mul64(x_17890, x_17891);
                        int64_t x_17945 = add64(x_17944, x_17944);
                        int64_t y_17946 = mul64(x_17892, x_17892);
                        int64_t x_17947 = sub64(x_17945, y_17946);
                        int64_t x_17948 = add64(y_17941, x_17947);
                        int64_t mul_res_17949 = add64(y_17941, x_17948);
                        int64_t x_17950 = mul64(x_17890, x_17892);
                        int64_t y_17951 = mul64(x_17891, x_17891);
                        int64_t x_17952 = add64(x_17950, y_17951);
                        int64_t x_17953 = add64(x_17950, x_17952);
                        int64_t mul_res_17954 = add64(y_17946, x_17953);
                        int64_t loopres_f_res_17955 = lshr64(i_17893, (int64_t) 1);
                        
                        loopres_17899 = mul_res_17943;
                        loopres_17900 = mul_res_17949;
                        loopres_17901 = mul_res_17954;
                        loopres_17902 = loopres_f_res_17955;
                        loopres_17903 = result_17894;
                        loopres_17904 = result_17895;
                        loopres_17905 = result_17896;
                    }
                    
                    bool loop_cond_17956 = ult64((int64_t) 0, loopres_17902);
                    bool loop_while_tmp_18011 = loop_cond_17956;
                    int64_t x_tmp_18012 = loopres_17899;
                    int64_t x_tmp_18013 = loopres_17900;
                    int64_t x_tmp_18014 = loopres_17901;
                    int64_t i_tmp_18015 = loopres_17902;
                    int64_t result_tmp_18016 = loopres_17903;
                    int64_t result_tmp_18017 = loopres_17904;
                    int64_t result_tmp_18018 = loopres_17905;
                    
                    loop_while_17889 = loop_while_tmp_18011;
                    x_17890 = x_tmp_18012;
                    x_17891 = x_tmp_18013;
                    x_17892 = x_tmp_18014;
                    i_17893 = i_tmp_18015;
                    result_17894 = result_tmp_18016;
                    result_17895 = result_tmp_18017;
                    result_17896 = result_tmp_18018;
                }
                mod_pow_u64_res_17881 = loop_while_17889;
                mod_pow_u64_res_17882 = x_17890;
                mod_pow_u64_res_17883 = x_17891;
                mod_pow_u64_res_17884 = x_17892;
                mod_pow_u64_res_17885 = i_17893;
                mod_pow_u64_res_17886 = result_17894;
                mod_pow_u64_res_17887 = result_17895;
                mod_pow_u64_res_17888 = result_17896;
                
                int64_t x_17957 = mul64(mod_pow_u64_res_17886, redout_17873);
                int64_t y_17958 = mul64(mod_pow_u64_res_17887, redout_17875);
                int64_t x_17959 = sub64(x_17957, y_17958);
                int64_t y_17960 = mul64(mod_pow_u64_res_17888, redout_17874);
                int64_t defunc_1_op_res_17961 = sub64(x_17959, y_17960);
                int64_t x_17962 = mul64(mod_pow_u64_res_17886, redout_17874);
                int64_t y_17963 = mul64(mod_pow_u64_res_17887, redout_17873);
                int64_t x_17964 = add64(x_17962, y_17963);
                int64_t y_17965 = mul64(mod_pow_u64_res_17888, redout_17875);
                int64_t x_17966 = sub64(x_17964, y_17965);
                int64_t x_17967 = add64(y_17958, x_17966);
                int64_t defunc_1_op_res_17968 = add64(y_17960, x_17967);
                int64_t x_17969 = mul64(mod_pow_u64_res_17886, redout_17875);
                int64_t y_17970 = mul64(mod_pow_u64_res_17887, redout_17874);
                int64_t x_17971 = add64(x_17969, y_17970);
                int64_t y_17972 = mul64(mod_pow_u64_res_17888, redout_17873);
                int64_t x_17973 = add64(x_17971, y_17972);
                int64_t defunc_1_op_res_17974 = add64(y_17965, x_17973);
                int64_t redout_tmp_18008 = defunc_1_op_res_17961;
                int64_t redout_tmp_18009 = defunc_1_op_res_17968;
                int64_t redout_tmp_18010 = defunc_1_op_res_17974;
                
                redout_17873 = redout_tmp_18008;
                redout_17874 = redout_tmp_18009;
                redout_17875 = redout_tmp_18010;
            }
            defunc_0_f_res_17869 = redout_17873;
            defunc_0_f_res_17870 = redout_17874;
            defunc_0_f_res_17871 = redout_17875;
            
            int64_t x_17975 = mul64(x_17866, defunc_0_f_res_17869);
            int64_t y_17976 = mul64(x_17868, defunc_0_f_res_17870);
            int64_t x_17977 = sub64(x_17975, y_17976);
            int64_t y_17978 = mul64(x_17867, defunc_0_f_res_17871);
            int64_t mul_res_17979 = sub64(x_17977, y_17978);
            int64_t x_17980 = mul64(x_17867, defunc_0_f_res_17869);
            int64_t y_17981 = mul64(x_17866, defunc_0_f_res_17870);
            int64_t x_17982 = add64(x_17980, y_17981);
            int64_t y_17983 = mul64(x_17868, defunc_0_f_res_17871);
            int64_t x_17984 = sub64(x_17982, y_17983);
            int64_t x_17985 = add64(y_17976, x_17984);
            int64_t mul_res_17986 = add64(y_17978, x_17985);
            int64_t x_17987 = mul64(x_17868, defunc_0_f_res_17869);
            int64_t y_17988 = mul64(x_17867, defunc_0_f_res_17870);
            int64_t x_17989 = add64(x_17987, y_17988);
            int64_t y_17990 = mul64(x_17866, defunc_0_f_res_17871);
            int64_t x_17991 = add64(x_17989, y_17990);
            int64_t mul_res_17992 = add64(y_17983, x_17991);
            int64_t canonicalizze_arg_17993 = add64(mul_res_17979, redout_17863);
            int64_t canonicalizze_res_17994 = umod64(canonicalizze_arg_17993, (int64_t) -4294967295);
            int64_t canonicalizze_arg_17995 = add64(mul_res_17986, redout_17864);
            int64_t canonicalizze_res_17996 = umod64(canonicalizze_arg_17995, (int64_t) -4294967295);
            int64_t canonicalizze_arg_17997 = add64(mul_res_17992, redout_17865);
            int64_t canonicalizze_res_17998 = umod64(canonicalizze_arg_17997, (int64_t) -4294967295);
            int64_t redout_tmp_18005 = canonicalizze_res_17994;
            int64_t redout_tmp_18006 = canonicalizze_res_17996;
            int64_t redout_tmp_18007 = canonicalizze_res_17998;
            
            redout_17863 = redout_tmp_18005;
            redout_17864 = redout_tmp_18006;
            redout_17865 = redout_tmp_18007;
        }
        defunc_0_f_res_17695 = redout_17863;
        defunc_0_f_res_17696 = redout_17864;
        defunc_0_f_res_17697 = redout_17865;
        
        int64_t x_17835 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17695);
        int64_t y_17836 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17696);
        int64_t x_17837 = sub64(x_17835, y_17836);
        int64_t y_17838 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17697);
        int64_t mul_res_17839 = sub64(x_17837, y_17838);
        int64_t x_17840 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17695);
        int64_t y_17841 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17696);
        int64_t x_17842 = add64(x_17840, y_17841);
        int64_t y_17843 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17697);
        int64_t x_17844 = sub64(x_17842, y_17843);
        int64_t x_17845 = add64(y_17836, x_17844);
        int64_t mul_res_17846 = add64(y_17838, x_17845);
        int64_t x_17847 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17695);
        int64_t y_17848 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17696);
        int64_t x_17849 = add64(x_17847, y_17848);
        int64_t y_17850 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17697);
        int64_t x_17851 = add64(x_17849, y_17850);
        int64_t mul_res_17852 = add64(y_17843, x_17851);
        uniform int64_t tmp_idx_18554 = (int64_t) 0;
        
        ((varying int64_t *) mem_17853)[tmp_idx_18554] = mul_res_17839;
        
        uniform int64_t tmp_idx_18555 = (int64_t) 1;
        
        ((varying int64_t *) mem_17853)[tmp_idx_18555] = mul_res_17846;
        
        uniform int64_t tmp_idx_18556 = (int64_t) 2;
        
        ((varying int64_t *) mem_17853)[tmp_idx_18556] = mul_res_17852;
        if ((int64_t) 24 > 0)
            memmove_64(mem_17077.mem + gtid_17694 * (int64_t) 3 * (int64_t) 8, mem_17853 + (int64_t) 0, extract((int64_t) 24, 0));
    }
    futhark_mc_mem_struct_18557_->mem_17853 = mem_17853;
    futhark_mc_mem_struct_18557_->mem_17853_cached_sizze_18547 = mem_17853_cached_sizze_18547;
    return err;
}
export uniform int futhark_mc_loop_ispc_18546(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18545 *uniform futhark_mc_param_struct_18545_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18545_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18545_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18545_->free_p_12335;
    uniform int64_t gtid_16458 = futhark_mc_param_struct_18545_->free_gtid_16458;
    uniform int64_t defunc_0_f_res_16461 = futhark_mc_param_struct_18545_->free_defunc_0_f_res_16461;
    uniform int64_t defunc_0_f_res_16462 = futhark_mc_param_struct_18545_->free_defunc_0_f_res_16462;
    uniform int64_t defunc_0_f_res_16463 = futhark_mc_param_struct_18545_->free_defunc_0_f_res_16463;
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18548();
    eps_mem_17007.mem = futhark_mc_param_struct_18545_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18549();
    expsss_mem_17008.mem = futhark_mc_param_struct_18545_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18550();
    mem_17061.mem = futhark_mc_param_struct_18545_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18551();
    mem_17065.mem = futhark_mc_param_struct_18545_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18552();
    mem_17069.mem = futhark_mc_param_struct_18545_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform struct memblock mem_17077;
    
    mem_17077.desc = futhark_mc_strlit_shim_18553();
    mem_17077.mem = futhark_mc_param_struct_18545_->free_mem_17077;
    mem_17077.size = 0;
    mem_17077.references = NULL;
    
    size_t mem_17853_cached_sizze_18547 = 0;
    varying unsigned char *uniform mem_17853 = NULL;
    uniform struct futhark_mc_mem_struct_18557 futhark_mc_mem_struct_18557_;
    
    futhark_mc_mem_struct_18557_.mem_17853 = mem_17853;
    futhark_mc_mem_struct_18557_.mem_17853_cached_sizze_18547 = mem_17853_cached_sizze_18547;
    
    uniform int err = futhark_mc_inner_ispc_18558(start, end, futhark_mc_param_struct_18545_, &futhark_mc_mem_struct_18557_);
    
    mem_17853 = futhark_mc_mem_struct_18557_.mem_17853;
    mem_17853_cached_sizze_18547 = futhark_mc_mem_struct_18557_.mem_17853_cached_sizze_18547;
    
  cleanup:
    {
        free(mem_17853);
    }
    return err;
}
struct futhark_mc_param_struct_18569 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    int64_t free_gtid_16458;
    int64_t free_defunc_0_f_res_16461;
    int64_t free_defunc_0_f_res_16462;
    int64_t free_defunc_0_f_res_16463;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    unsigned char *free_mem_17077;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18572();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18573();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18574();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18575();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18576();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18577();
struct futhark_mc_task_18578 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    int64_t free_gtid_16458;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    int64_t free_gtid_17383;
    int64_t free_flat_tid_18020;
    int64_t free_flat_tid_18165;
    int64_t *retval_defunc_0_f_res_17384;
    int64_t *retval_defunc_0_f_res_17385;
    int64_t *retval_defunc_0_f_res_17386;
};
struct futhark_mc_param_struct_18585 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    int64_t free_gtid_16458;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    int64_t free_gtid_17383;
    int64_t free_flat_tid_18165;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18313;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18315;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18317;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18587();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18588();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18589();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18590();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18591();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18592();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18593();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18594();
export uniform int futhark_mc_loop_ispc_18586(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18585 *uniform futhark_mc_param_struct_18585_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18585_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18585_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18585_->free_p_12335;
    uniform int64_t gtid_16458 = futhark_mc_param_struct_18585_->free_gtid_16458;
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18587();
    eps_mem_17007.mem = futhark_mc_param_struct_18585_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18588();
    expsss_mem_17008.mem = futhark_mc_param_struct_18585_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18589();
    mem_17061.mem = futhark_mc_param_struct_18585_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18590();
    mem_17065.mem = futhark_mc_param_struct_18585_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18591();
    mem_17069.mem = futhark_mc_param_struct_18585_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform int64_t gtid_17383 = futhark_mc_param_struct_18585_->free_gtid_17383;
    uniform int64_t flat_tid_18165 = futhark_mc_param_struct_18585_->free_flat_tid_18165;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18313;
    
    reduce_stage_1_tid_res_arr_mem_18313.desc = futhark_mc_strlit_shim_18592();
    reduce_stage_1_tid_res_arr_mem_18313.mem = futhark_mc_param_struct_18585_->free_reduce_stage_1_tid_res_arr_mem_18313;
    reduce_stage_1_tid_res_arr_mem_18313.size = 0;
    reduce_stage_1_tid_res_arr_mem_18313.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18315;
    
    reduce_stage_1_tid_res_arr_mem_18315.desc = futhark_mc_strlit_shim_18593();
    reduce_stage_1_tid_res_arr_mem_18315.mem = futhark_mc_param_struct_18585_->free_reduce_stage_1_tid_res_arr_mem_18315;
    reduce_stage_1_tid_res_arr_mem_18315.size = 0;
    reduce_stage_1_tid_res_arr_mem_18315.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18317;
    
    reduce_stage_1_tid_res_arr_mem_18317.desc = futhark_mc_strlit_shim_18594();
    reduce_stage_1_tid_res_arr_mem_18317.mem = futhark_mc_param_struct_18585_->free_reduce_stage_1_tid_res_arr_mem_18317;
    reduce_stage_1_tid_res_arr_mem_18317.size = 0;
    reduce_stage_1_tid_res_arr_mem_18317.references = NULL;
    
    uniform int err = 0;
    uniform int64_t x_18167;
    uniform int64_t x_18168;
    uniform int64_t x_18169;
    uniform int64_t x_18170;
    uniform int64_t x_18171;
    uniform int64_t x_18172;
    uniform int64_t local_acc_18319 = (int64_t) 0;
    uniform int64_t local_acc_18320 = (int64_t) 0;
    uniform int64_t local_acc_18321 = (int64_t) 0;
    uniform int64_t start_18322;
    uniform int64_t end_18323;
    
    start_18322 = start;
    end_18323 = end;
    
    uniform int64_t n_18324 = end_18323 - start_18322;
    
    foreach (SegRed_i_18325 = start_18322 ... start_18322 + n_18324)
    {
        int64_t gtid_18166 = SegRed_i_18325;
        int64_t x_18179;
        
        x_18179 = ((int64_t *) mem_17061.mem)[gtid_17383 * p_12335 + gtid_18166];
        
        int64_t x_18180;
        
        x_18180 = ((int64_t *) mem_17065.mem)[gtid_17383 * p_12335 + gtid_18166];
        
        int64_t x_18181;
        
        x_18181 = ((int64_t *) mem_17069.mem)[gtid_17383 * p_12335 + gtid_18166];
        
        int64_t defunc_0_f_res_18182;
        int64_t defunc_0_f_res_18183;
        int64_t defunc_0_f_res_18184;
        int64_t redout_18186;
        int64_t redout_18187;
        int64_t redout_18188;
        
        redout_18186 = (int64_t) 1;
        redout_18187 = (int64_t) 0;
        redout_18188 = (int64_t) 0;
        for (uniform int64_t i_18185 = 0; i_18185 < m_12334; i_18185++) {
            int64_t x_18189;
            
            x_18189 = ((int64_t *) expsss_mem_17008.mem)[gtid_17383 * (m_12334 * p_12335) + gtid_18166 * m_12334 + i_18185];
            
            uniform int64_t x_18190;
            
            x_18190 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + i_18185 * (int64_t) 3];
            
            uniform int64_t x_18191;
            
            x_18191 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + i_18185 * (int64_t) 3 + (int64_t) 1];
            
            uniform int64_t x_18192;
            
            x_18192 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + i_18185 * (int64_t) 3 + (int64_t) 2];
            
            bool loop_cond_18193 = ult64((int64_t) 0, x_18189);
            bool mod_pow_u64_res_18194;
            int64_t mod_pow_u64_res_18195;
            int64_t mod_pow_u64_res_18196;
            int64_t mod_pow_u64_res_18197;
            int64_t mod_pow_u64_res_18198;
            int64_t mod_pow_u64_res_18199;
            int64_t mod_pow_u64_res_18200;
            int64_t mod_pow_u64_res_18201;
            bool loop_while_18202;
            int64_t x_18203;
            int64_t x_18204;
            int64_t x_18205;
            int64_t i_18206;
            int64_t result_18207;
            int64_t result_18208;
            int64_t result_18209;
            
            loop_while_18202 = loop_cond_18193;
            x_18203 = x_18190;
            x_18204 = x_18191;
            x_18205 = x_18192;
            i_18206 = x_18189;
            result_18207 = (int64_t) 1;
            result_18208 = (int64_t) 0;
            result_18209 = (int64_t) 0;
            while (loop_while_18202) {
                int64_t x_18210 = umod64(i_18206, (int64_t) 2);
                bool cond_18211 = x_18210 == (int64_t) 1;
                int64_t loopres_18212;
                int64_t loopres_18213;
                int64_t loopres_18214;
                int64_t loopres_18215;
                int64_t loopres_18216;
                int64_t loopres_18217;
                int64_t loopres_18218;
                
                if (cond_18211 == 1) {
                    int64_t x_18219 = mul64(x_18203, x_18203);
                    int64_t y_18220 = mul64(x_18204, x_18205);
                    int64_t x_18221 = sub64(x_18219, y_18220);
                    int64_t mul_res_18222 = sub64(x_18221, y_18220);
                    int64_t x_18223 = mul64(x_18203, x_18204);
                    int64_t x_18224 = add64(x_18223, x_18223);
                    int64_t y_18225 = mul64(x_18205, x_18205);
                    int64_t x_18226 = sub64(x_18224, y_18225);
                    int64_t x_18227 = add64(y_18220, x_18226);
                    int64_t mul_res_18228 = add64(y_18220, x_18227);
                    int64_t x_18229 = mul64(x_18203, x_18205);
                    int64_t y_18230 = mul64(x_18204, x_18204);
                    int64_t x_18231 = add64(x_18229, y_18230);
                    int64_t x_18232 = add64(x_18229, x_18231);
                    int64_t mul_res_18233 = add64(y_18225, x_18232);
                    int64_t loopres_t_res_18234 = lshr64(i_18206, (int64_t) 1);
                    int64_t x_18235 = mul64(x_18203, result_18207);
                    int64_t y_18236 = mul64(x_18205, result_18208);
                    int64_t x_18237 = sub64(x_18235, y_18236);
                    int64_t y_18238 = mul64(x_18204, result_18209);
                    int64_t mul_res_18239 = sub64(x_18237, y_18238);
                    int64_t x_18240 = mul64(x_18204, result_18207);
                    int64_t y_18241 = mul64(x_18203, result_18208);
                    int64_t x_18242 = add64(x_18240, y_18241);
                    int64_t y_18243 = mul64(x_18205, result_18209);
                    int64_t x_18244 = sub64(x_18242, y_18243);
                    int64_t x_18245 = add64(y_18236, x_18244);
                    int64_t mul_res_18246 = add64(y_18238, x_18245);
                    int64_t x_18247 = mul64(x_18205, result_18207);
                    int64_t y_18248 = mul64(x_18204, result_18208);
                    int64_t x_18249 = add64(x_18247, y_18248);
                    int64_t y_18250 = mul64(x_18203, result_18209);
                    int64_t x_18251 = add64(x_18249, y_18250);
                    int64_t mul_res_18252 = add64(y_18243, x_18251);
                    
                    loopres_18212 = mul_res_18222;
                    loopres_18213 = mul_res_18228;
                    loopres_18214 = mul_res_18233;
                    loopres_18215 = loopres_t_res_18234;
                    loopres_18216 = mul_res_18239;
                    loopres_18217 = mul_res_18246;
                    loopres_18218 = mul_res_18252;
                } else {
                    int64_t x_18253 = mul64(x_18203, x_18203);
                    int64_t y_18254 = mul64(x_18204, x_18205);
                    int64_t x_18255 = sub64(x_18253, y_18254);
                    int64_t mul_res_18256 = sub64(x_18255, y_18254);
                    int64_t x_18257 = mul64(x_18203, x_18204);
                    int64_t x_18258 = add64(x_18257, x_18257);
                    int64_t y_18259 = mul64(x_18205, x_18205);
                    int64_t x_18260 = sub64(x_18258, y_18259);
                    int64_t x_18261 = add64(y_18254, x_18260);
                    int64_t mul_res_18262 = add64(y_18254, x_18261);
                    int64_t x_18263 = mul64(x_18203, x_18205);
                    int64_t y_18264 = mul64(x_18204, x_18204);
                    int64_t x_18265 = add64(x_18263, y_18264);
                    int64_t x_18266 = add64(x_18263, x_18265);
                    int64_t mul_res_18267 = add64(y_18259, x_18266);
                    int64_t loopres_f_res_18268 = lshr64(i_18206, (int64_t) 1);
                    
                    loopres_18212 = mul_res_18256;
                    loopres_18213 = mul_res_18262;
                    loopres_18214 = mul_res_18267;
                    loopres_18215 = loopres_f_res_18268;
                    loopres_18216 = result_18207;
                    loopres_18217 = result_18208;
                    loopres_18218 = result_18209;
                }
                
                bool loop_cond_18269 = ult64((int64_t) 0, loopres_18215);
                bool loop_while_tmp_18329 = loop_cond_18269;
                int64_t x_tmp_18330 = loopres_18212;
                int64_t x_tmp_18331 = loopres_18213;
                int64_t x_tmp_18332 = loopres_18214;
                int64_t i_tmp_18333 = loopres_18215;
                int64_t result_tmp_18334 = loopres_18216;
                int64_t result_tmp_18335 = loopres_18217;
                int64_t result_tmp_18336 = loopres_18218;
                
                loop_while_18202 = loop_while_tmp_18329;
                x_18203 = x_tmp_18330;
                x_18204 = x_tmp_18331;
                x_18205 = x_tmp_18332;
                i_18206 = i_tmp_18333;
                result_18207 = result_tmp_18334;
                result_18208 = result_tmp_18335;
                result_18209 = result_tmp_18336;
            }
            mod_pow_u64_res_18194 = loop_while_18202;
            mod_pow_u64_res_18195 = x_18203;
            mod_pow_u64_res_18196 = x_18204;
            mod_pow_u64_res_18197 = x_18205;
            mod_pow_u64_res_18198 = i_18206;
            mod_pow_u64_res_18199 = result_18207;
            mod_pow_u64_res_18200 = result_18208;
            mod_pow_u64_res_18201 = result_18209;
            
            int64_t x_18270 = mul64(mod_pow_u64_res_18199, redout_18186);
            int64_t y_18271 = mul64(mod_pow_u64_res_18200, redout_18188);
            int64_t x_18272 = sub64(x_18270, y_18271);
            int64_t y_18273 = mul64(mod_pow_u64_res_18201, redout_18187);
            int64_t defunc_1_op_res_18274 = sub64(x_18272, y_18273);
            int64_t x_18275 = mul64(mod_pow_u64_res_18199, redout_18187);
            int64_t y_18276 = mul64(mod_pow_u64_res_18200, redout_18186);
            int64_t x_18277 = add64(x_18275, y_18276);
            int64_t y_18278 = mul64(mod_pow_u64_res_18201, redout_18188);
            int64_t x_18279 = sub64(x_18277, y_18278);
            int64_t x_18280 = add64(y_18271, x_18279);
            int64_t defunc_1_op_res_18281 = add64(y_18273, x_18280);
            int64_t x_18282 = mul64(mod_pow_u64_res_18199, redout_18188);
            int64_t y_18283 = mul64(mod_pow_u64_res_18200, redout_18187);
            int64_t x_18284 = add64(x_18282, y_18283);
            int64_t y_18285 = mul64(mod_pow_u64_res_18201, redout_18186);
            int64_t x_18286 = add64(x_18284, y_18285);
            int64_t defunc_1_op_res_18287 = add64(y_18278, x_18286);
            int64_t redout_tmp_18326 = defunc_1_op_res_18274;
            int64_t redout_tmp_18327 = defunc_1_op_res_18281;
            int64_t redout_tmp_18328 = defunc_1_op_res_18287;
            
            redout_18186 = redout_tmp_18326;
            redout_18187 = redout_tmp_18327;
            redout_18188 = redout_tmp_18328;
        }
        defunc_0_f_res_18182 = redout_18186;
        defunc_0_f_res_18183 = redout_18187;
        defunc_0_f_res_18184 = redout_18188;
        
        int64_t x_18288 = mul64(x_18179, defunc_0_f_res_18182);
        int64_t y_18289 = mul64(x_18181, defunc_0_f_res_18183);
        int64_t x_18290 = sub64(x_18288, y_18289);
        int64_t y_18291 = mul64(x_18180, defunc_0_f_res_18184);
        int64_t mul_res_18292 = sub64(x_18290, y_18291);
        int64_t x_18293 = mul64(x_18180, defunc_0_f_res_18182);
        int64_t y_18294 = mul64(x_18179, defunc_0_f_res_18183);
        int64_t x_18295 = add64(x_18293, y_18294);
        int64_t y_18296 = mul64(x_18181, defunc_0_f_res_18184);
        int64_t x_18297 = sub64(x_18295, y_18296);
        int64_t x_18298 = add64(y_18289, x_18297);
        int64_t mul_res_18299 = add64(y_18291, x_18298);
        int64_t x_18300 = mul64(x_18181, defunc_0_f_res_18182);
        int64_t y_18301 = mul64(x_18180, defunc_0_f_res_18183);
        int64_t x_18302 = add64(x_18300, y_18301);
        int64_t y_18303 = mul64(x_18179, defunc_0_f_res_18184);
        int64_t x_18304 = add64(x_18302, y_18303);
        int64_t mul_res_18305 = add64(y_18296, x_18304);
        
        // save map-out results
        { }
        for (uniform unsigned int uni_i_18337 = 0; uni_i_18337 < programCount; uni_i_18337++) {
            if (programIndex == uni_i_18337) {
                // Load accum params
                {
                    x_18167 = local_acc_18319;
                    x_18168 = local_acc_18320;
                    x_18169 = local_acc_18321;
                }
                // Load next params
                {
                    x_18170 = extract(mul_res_18292, uni_i_18337);
                    x_18171 = extract(mul_res_18299, uni_i_18337);
                    x_18172 = extract(mul_res_18305, uni_i_18337);
                }
                // SegRed body
                {
                    uniform int64_t canonicalizze_arg_18173 = add64(x_18167, x_18170);
                    uniform int64_t canonicalizze_res_18174 = umod64(canonicalizze_arg_18173, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18175 = add64(x_18168, x_18171);
                    uniform int64_t canonicalizze_res_18176 = umod64(canonicalizze_arg_18175, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18177 = add64(x_18169, x_18172);
                    uniform int64_t canonicalizze_res_18178 = umod64(canonicalizze_arg_18177, (int64_t) -4294967295);
                    
                    local_acc_18319 = canonicalizze_res_18174;
                    local_acc_18320 = canonicalizze_res_18176;
                    local_acc_18321 = canonicalizze_res_18178;
                }
            }
        }
    }
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18313.mem)[flat_tid_18165] = local_acc_18319;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18315.mem)[flat_tid_18165] = local_acc_18320;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18317.mem)[flat_tid_18165] = local_acc_18321;
    
  cleanup:
    { }
    return err;
}
struct futhark_mc_param_struct_18601 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    int64_t free_gtid_16458;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    unsigned char *free_mem_17061;
    unsigned char *free_mem_17065;
    unsigned char *free_mem_17069;
    int64_t free_gtid_17383;
    int64_t free_flat_tid_18020;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18352;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18354;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18356;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18603();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18604();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18605();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18606();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18607();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18608();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18609();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18610();
struct futhark_mc_task_18611 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    int64_t free_gtid_16458;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    int64_t free_gtid_17383;
    int64_t free_gtid_18021;
    int64_t free_flat_tid_18040;
    int64_t *retval_defunc_0_f_res_18037;
    int64_t *retval_defunc_0_f_res_18038;
    int64_t *retval_defunc_0_f_res_18039;
};
struct futhark_mc_param_struct_18618 {
    struct futhark_context *ctx;
    int64_t free_m_12334;
    int64_t free_p_12335;
    int64_t free_gtid_16458;
    unsigned char *free_eps_mem_17007;
    unsigned char *free_expsss_mem_17008;
    int64_t free_gtid_17383;
    int64_t free_gtid_18021;
    int64_t free_flat_tid_18040;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18366;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18368;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_18370;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18620();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18621();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18622();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18623();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18624();
export uniform int futhark_mc_loop_ispc_18619(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18618 *uniform futhark_mc_param_struct_18618_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18618_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18618_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18618_->free_p_12335;
    uniform int64_t gtid_16458 = futhark_mc_param_struct_18618_->free_gtid_16458;
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18620();
    eps_mem_17007.mem = futhark_mc_param_struct_18618_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18621();
    expsss_mem_17008.mem = futhark_mc_param_struct_18618_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform int64_t gtid_17383 = futhark_mc_param_struct_18618_->free_gtid_17383;
    uniform int64_t gtid_18021 = futhark_mc_param_struct_18618_->free_gtid_18021;
    uniform int64_t flat_tid_18040 = futhark_mc_param_struct_18618_->free_flat_tid_18040;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18366;
    
    reduce_stage_1_tid_res_arr_mem_18366.desc = futhark_mc_strlit_shim_18622();
    reduce_stage_1_tid_res_arr_mem_18366.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18366;
    reduce_stage_1_tid_res_arr_mem_18366.size = 0;
    reduce_stage_1_tid_res_arr_mem_18366.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18368;
    
    reduce_stage_1_tid_res_arr_mem_18368.desc = futhark_mc_strlit_shim_18623();
    reduce_stage_1_tid_res_arr_mem_18368.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18368;
    reduce_stage_1_tid_res_arr_mem_18368.size = 0;
    reduce_stage_1_tid_res_arr_mem_18368.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18370;
    
    reduce_stage_1_tid_res_arr_mem_18370.desc = futhark_mc_strlit_shim_18624();
    reduce_stage_1_tid_res_arr_mem_18370.mem = futhark_mc_param_struct_18618_->free_reduce_stage_1_tid_res_arr_mem_18370;
    reduce_stage_1_tid_res_arr_mem_18370.size = 0;
    reduce_stage_1_tid_res_arr_mem_18370.references = NULL;
    
    uniform int err = 0;
    uniform int64_t x_18042;
    uniform int64_t x_18043;
    uniform int64_t x_18044;
    uniform int64_t x_18045;
    uniform int64_t x_18046;
    uniform int64_t x_18047;
    uniform int64_t local_acc_18372 = (int64_t) 1;
    uniform int64_t local_acc_18373 = (int64_t) 0;
    uniform int64_t local_acc_18374 = (int64_t) 0;
    uniform int64_t start_18375;
    uniform int64_t end_18376;
    
    start_18375 = start;
    end_18376 = end;
    
    uniform int64_t n_18377 = end_18376 - start_18375;
    
    foreach (SegRed_i_18378 = start_18375 ... start_18375 + n_18377)
    {
        int64_t gtid_18041 = SegRed_i_18378;
        int64_t x_18066;
        
        x_18066 = ((int64_t *) expsss_mem_17008.mem)[gtid_17383 * (m_12334 * p_12335) + gtid_18021 * m_12334 + gtid_18041];
        
        int64_t x_18067;
        
        x_18067 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + gtid_18041 * (int64_t) 3];
        
        int64_t x_18068;
        
        x_18068 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + gtid_18041 * (int64_t) 3 + (int64_t) 1];
        
        int64_t x_18069;
        
        x_18069 = ((int64_t *) eps_mem_17007.mem)[gtid_16458 * ((int64_t) 3 * m_12334) + gtid_18041 * (int64_t) 3 + (int64_t) 2];
        
        bool loop_cond_18070 = ult64((int64_t) 0, x_18066);
        bool mod_pow_u64_res_18071;
        int64_t mod_pow_u64_res_18072;
        int64_t mod_pow_u64_res_18073;
        int64_t mod_pow_u64_res_18074;
        int64_t mod_pow_u64_res_18075;
        int64_t mod_pow_u64_res_18076;
        int64_t mod_pow_u64_res_18077;
        int64_t mod_pow_u64_res_18078;
        bool loop_while_18079;
        int64_t x_18080;
        int64_t x_18081;
        int64_t x_18082;
        int64_t i_18083;
        int64_t result_18084;
        int64_t result_18085;
        int64_t result_18086;
        
        loop_while_18079 = loop_cond_18070;
        x_18080 = x_18067;
        x_18081 = x_18068;
        x_18082 = x_18069;
        i_18083 = x_18066;
        result_18084 = (int64_t) 1;
        result_18085 = (int64_t) 0;
        result_18086 = (int64_t) 0;
        while (loop_while_18079) {
            int64_t x_18087 = umod64(i_18083, (int64_t) 2);
            bool cond_18088 = x_18087 == (int64_t) 1;
            int64_t loopres_18089;
            int64_t loopres_18090;
            int64_t loopres_18091;
            int64_t loopres_18092;
            int64_t loopres_18093;
            int64_t loopres_18094;
            int64_t loopres_18095;
            
            if (cond_18088 == 1) {
                int64_t x_18096 = mul64(x_18080, x_18080);
                int64_t y_18097 = mul64(x_18081, x_18082);
                int64_t x_18098 = sub64(x_18096, y_18097);
                int64_t mul_res_18099 = sub64(x_18098, y_18097);
                int64_t x_18100 = mul64(x_18080, x_18081);
                int64_t x_18101 = add64(x_18100, x_18100);
                int64_t y_18102 = mul64(x_18082, x_18082);
                int64_t x_18103 = sub64(x_18101, y_18102);
                int64_t x_18104 = add64(y_18097, x_18103);
                int64_t mul_res_18105 = add64(y_18097, x_18104);
                int64_t x_18106 = mul64(x_18080, x_18082);
                int64_t y_18107 = mul64(x_18081, x_18081);
                int64_t x_18108 = add64(x_18106, y_18107);
                int64_t x_18109 = add64(x_18106, x_18108);
                int64_t mul_res_18110 = add64(y_18102, x_18109);
                int64_t loopres_t_res_18111 = lshr64(i_18083, (int64_t) 1);
                int64_t x_18112 = mul64(x_18080, result_18084);
                int64_t y_18113 = mul64(x_18082, result_18085);
                int64_t x_18114 = sub64(x_18112, y_18113);
                int64_t y_18115 = mul64(x_18081, result_18086);
                int64_t mul_res_18116 = sub64(x_18114, y_18115);
                int64_t x_18117 = mul64(x_18081, result_18084);
                int64_t y_18118 = mul64(x_18080, result_18085);
                int64_t x_18119 = add64(x_18117, y_18118);
                int64_t y_18120 = mul64(x_18082, result_18086);
                int64_t x_18121 = sub64(x_18119, y_18120);
                int64_t x_18122 = add64(y_18113, x_18121);
                int64_t mul_res_18123 = add64(y_18115, x_18122);
                int64_t x_18124 = mul64(x_18082, result_18084);
                int64_t y_18125 = mul64(x_18081, result_18085);
                int64_t x_18126 = add64(x_18124, y_18125);
                int64_t y_18127 = mul64(x_18080, result_18086);
                int64_t x_18128 = add64(x_18126, y_18127);
                int64_t mul_res_18129 = add64(y_18120, x_18128);
                
                loopres_18089 = mul_res_18099;
                loopres_18090 = mul_res_18105;
                loopres_18091 = mul_res_18110;
                loopres_18092 = loopres_t_res_18111;
                loopres_18093 = mul_res_18116;
                loopres_18094 = mul_res_18123;
                loopres_18095 = mul_res_18129;
            } else {
                int64_t x_18130 = mul64(x_18080, x_18080);
                int64_t y_18131 = mul64(x_18081, x_18082);
                int64_t x_18132 = sub64(x_18130, y_18131);
                int64_t mul_res_18133 = sub64(x_18132, y_18131);
                int64_t x_18134 = mul64(x_18080, x_18081);
                int64_t x_18135 = add64(x_18134, x_18134);
                int64_t y_18136 = mul64(x_18082, x_18082);
                int64_t x_18137 = sub64(x_18135, y_18136);
                int64_t x_18138 = add64(y_18131, x_18137);
                int64_t mul_res_18139 = add64(y_18131, x_18138);
                int64_t x_18140 = mul64(x_18080, x_18082);
                int64_t y_18141 = mul64(x_18081, x_18081);
                int64_t x_18142 = add64(x_18140, y_18141);
                int64_t x_18143 = add64(x_18140, x_18142);
                int64_t mul_res_18144 = add64(y_18136, x_18143);
                int64_t loopres_f_res_18145 = lshr64(i_18083, (int64_t) 1);
                
                loopres_18089 = mul_res_18133;
                loopres_18090 = mul_res_18139;
                loopres_18091 = mul_res_18144;
                loopres_18092 = loopres_f_res_18145;
                loopres_18093 = result_18084;
                loopres_18094 = result_18085;
                loopres_18095 = result_18086;
            }
            
            bool loop_cond_18146 = ult64((int64_t) 0, loopres_18092);
            bool loop_while_tmp_18379 = loop_cond_18146;
            int64_t x_tmp_18380 = loopres_18089;
            int64_t x_tmp_18381 = loopres_18090;
            int64_t x_tmp_18382 = loopres_18091;
            int64_t i_tmp_18383 = loopres_18092;
            int64_t result_tmp_18384 = loopres_18093;
            int64_t result_tmp_18385 = loopres_18094;
            int64_t result_tmp_18386 = loopres_18095;
            
            loop_while_18079 = loop_while_tmp_18379;
            x_18080 = x_tmp_18380;
            x_18081 = x_tmp_18381;
            x_18082 = x_tmp_18382;
            i_18083 = i_tmp_18383;
            result_18084 = result_tmp_18384;
            result_18085 = result_tmp_18385;
            result_18086 = result_tmp_18386;
        }
        mod_pow_u64_res_18071 = loop_while_18079;
        mod_pow_u64_res_18072 = x_18080;
        mod_pow_u64_res_18073 = x_18081;
        mod_pow_u64_res_18074 = x_18082;
        mod_pow_u64_res_18075 = i_18083;
        mod_pow_u64_res_18076 = result_18084;
        mod_pow_u64_res_18077 = result_18085;
        mod_pow_u64_res_18078 = result_18086;
        // save map-out results
        { }
        for (uniform unsigned int uni_i_18387 = 0; uni_i_18387 < programCount; uni_i_18387++) {
            if (programIndex == uni_i_18387) {
                // Load accum params
                {
                    x_18042 = local_acc_18372;
                    x_18043 = local_acc_18373;
                    x_18044 = local_acc_18374;
                }
                // Load next params
                {
                    x_18045 = extract(mod_pow_u64_res_18076, uni_i_18387);
                    x_18046 = extract(mod_pow_u64_res_18077, uni_i_18387);
                    x_18047 = extract(mod_pow_u64_res_18078, uni_i_18387);
                }
                // SegRed body
                {
                    uniform int64_t x_18048 = mul64(x_18042, x_18045);
                    uniform int64_t y_18049 = mul64(x_18044, x_18046);
                    uniform int64_t x_18050 = sub64(x_18048, y_18049);
                    uniform int64_t y_18051 = mul64(x_18043, x_18047);
                    uniform int64_t defunc_1_op_res_18052 = sub64(x_18050, y_18051);
                    uniform int64_t x_18053 = mul64(x_18043, x_18045);
                    uniform int64_t y_18054 = mul64(x_18042, x_18046);
                    uniform int64_t x_18055 = add64(x_18053, y_18054);
                    uniform int64_t y_18056 = mul64(x_18044, x_18047);
                    uniform int64_t x_18057 = sub64(x_18055, y_18056);
                    uniform int64_t x_18058 = add64(y_18049, x_18057);
                    uniform int64_t defunc_1_op_res_18059 = add64(y_18051, x_18058);
                    uniform int64_t x_18060 = mul64(x_18044, x_18045);
                    uniform int64_t y_18061 = mul64(x_18043, x_18046);
                    uniform int64_t x_18062 = add64(x_18060, y_18061);
                    uniform int64_t y_18063 = mul64(x_18042, x_18047);
                    uniform int64_t x_18064 = add64(x_18062, y_18063);
                    uniform int64_t defunc_1_op_res_18065 = add64(y_18056, x_18064);
                    
                    local_acc_18372 = defunc_1_op_res_18052;
                    local_acc_18373 = defunc_1_op_res_18059;
                    local_acc_18374 = defunc_1_op_res_18065;
                }
            }
        }
    }
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18366.mem)[flat_tid_18040] = local_acc_18372;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18368.mem)[flat_tid_18040] = local_acc_18373;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18370.mem)[flat_tid_18040] = local_acc_18374;
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18625(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18611 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18627 { };
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18629();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18630();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18631();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18632();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18633();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18634();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18635();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18636();
static unmasked inline uniform int futhark_mc_inner_ispc_18628(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18601 *uniform futhark_mc_param_struct_18601_, uniform struct futhark_mc_mem_struct_18627 *uniform futhark_mc_mem_struct_18627_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18601_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18601_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18601_->free_p_12335;
    uniform int64_t gtid_16458 = futhark_mc_param_struct_18601_->free_gtid_16458;
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18629();
    eps_mem_17007.mem = futhark_mc_param_struct_18601_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18630();
    expsss_mem_17008.mem = futhark_mc_param_struct_18601_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18631();
    mem_17061.mem = futhark_mc_param_struct_18601_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18632();
    mem_17065.mem = futhark_mc_param_struct_18601_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18633();
    mem_17069.mem = futhark_mc_param_struct_18601_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform int64_t gtid_17383 = futhark_mc_param_struct_18601_->free_gtid_17383;
    uniform int64_t flat_tid_18020 = futhark_mc_param_struct_18601_->free_flat_tid_18020;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18352;
    
    reduce_stage_1_tid_res_arr_mem_18352.desc = futhark_mc_strlit_shim_18634();
    reduce_stage_1_tid_res_arr_mem_18352.mem = futhark_mc_param_struct_18601_->free_reduce_stage_1_tid_res_arr_mem_18352;
    reduce_stage_1_tid_res_arr_mem_18352.size = 0;
    reduce_stage_1_tid_res_arr_mem_18352.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18354;
    
    reduce_stage_1_tid_res_arr_mem_18354.desc = futhark_mc_strlit_shim_18635();
    reduce_stage_1_tid_res_arr_mem_18354.mem = futhark_mc_param_struct_18601_->free_reduce_stage_1_tid_res_arr_mem_18354;
    reduce_stage_1_tid_res_arr_mem_18354.size = 0;
    reduce_stage_1_tid_res_arr_mem_18354.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18356;
    
    reduce_stage_1_tid_res_arr_mem_18356.desc = futhark_mc_strlit_shim_18636();
    reduce_stage_1_tid_res_arr_mem_18356.mem = futhark_mc_param_struct_18601_->free_reduce_stage_1_tid_res_arr_mem_18356;
    reduce_stage_1_tid_res_arr_mem_18356.size = 0;
    reduce_stage_1_tid_res_arr_mem_18356.references = NULL;
    
    uniform int err = 0;
    uniform int64_t x_18022;
    uniform int64_t x_18023;
    uniform int64_t x_18024;
    uniform int64_t x_18025;
    uniform int64_t x_18026;
    uniform int64_t x_18027;
    uniform int64_t local_acc_18358 = (int64_t) 0;
    uniform int64_t local_acc_18359 = (int64_t) 0;
    uniform int64_t local_acc_18360 = (int64_t) 0;
    uniform int64_t start_18361;
    uniform int64_t end_18362;
    
    start_18361 = start;
    end_18362 = end;
    
    uniform int64_t n_18363 = end_18362 - start_18361;
    
    for (uniform int64_t i = 0; i < (start_18361 + n_18363 - start_18361) / programCount; i++) {
        int64_t SegRed_i_18364 = start_18361 + programIndex + i * programCount;
        int64_t gtid_18021 = SegRed_i_18364;
        int64_t x_18034;
        
        x_18034 = ((int64_t *) mem_17061.mem)[gtid_17383 * p_12335 + gtid_18021];
        
        int64_t x_18035;
        
        x_18035 = ((int64_t *) mem_17065.mem)[gtid_17383 * p_12335 + gtid_18021];
        
        int64_t x_18036;
        
        x_18036 = ((int64_t *) mem_17069.mem)[gtid_17383 * p_12335 + gtid_18021];
        
        int64_t defunc_0_f_res_18037;
        int64_t defunc_0_f_res_18038;
        int64_t defunc_0_f_res_18039;
        uniform int64_t flat_tid_18040 = (int64_t) 0;
        
        defunc_0_f_res_18037 = (int64_t) 0;
        defunc_0_f_res_18038 = (int64_t) 0;
        defunc_0_f_res_18039 = (int64_t) 0;
        
        struct futhark_mc_task_18611 futhark_mc_task_18611_;
        
        futhark_mc_task_18611_.ctx = ctx;
        futhark_mc_task_18611_.free_m_12334 = m_12334;
        futhark_mc_task_18611_.free_p_12335 = p_12335;
        futhark_mc_task_18611_.free_gtid_16458 = gtid_16458;
        futhark_mc_task_18611_.free_eps_mem_17007 = eps_mem_17007.mem;
        futhark_mc_task_18611_.free_expsss_mem_17008 = expsss_mem_17008.mem;
        futhark_mc_task_18611_.free_gtid_17383 = gtid_17383;
        futhark_mc_task_18611_.free_gtid_18021 = gtid_18021;
        futhark_mc_task_18611_.free_flat_tid_18040 = flat_tid_18040;
        futhark_mc_task_18611_.retval_defunc_0_f_res_18037 = (int64_t *) &defunc_0_f_res_18037;
        #if ISPC
        futhark_mc_task_18611_.retval_defunc_0_f_res_18037 += programIndex;
        #endif
        futhark_mc_task_18611_.retval_defunc_0_f_res_18038 = (int64_t *) &defunc_0_f_res_18038;
        #if ISPC
        futhark_mc_task_18611_.retval_defunc_0_f_res_18038 += programIndex;
        #endif
        futhark_mc_task_18611_.retval_defunc_0_f_res_18039 = (int64_t *) &defunc_0_f_res_18039;
        #if ISPC
        futhark_mc_task_18611_.retval_defunc_0_f_res_18039 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18611 aos_18626[programCount];
        
        aos_18626[programIndex] = futhark_mc_task_18611_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18625(ctx, &aos_18626[i], extract(m_12334, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18625(ctx, &futhark_mc_task_18611_, m_12334);
        if (err != 0)
            goto cleanup;
        #endif
        
        int64_t x_18147 = mul64(x_18034, defunc_0_f_res_18037);
        int64_t y_18148 = mul64(x_18036, defunc_0_f_res_18038);
        int64_t x_18149 = sub64(x_18147, y_18148);
        int64_t y_18150 = mul64(x_18035, defunc_0_f_res_18039);
        int64_t mul_res_18151 = sub64(x_18149, y_18150);
        int64_t x_18152 = mul64(x_18035, defunc_0_f_res_18037);
        int64_t y_18153 = mul64(x_18034, defunc_0_f_res_18038);
        int64_t x_18154 = add64(x_18152, y_18153);
        int64_t y_18155 = mul64(x_18036, defunc_0_f_res_18039);
        int64_t x_18156 = sub64(x_18154, y_18155);
        int64_t x_18157 = add64(y_18148, x_18156);
        int64_t mul_res_18158 = add64(y_18150, x_18157);
        int64_t x_18159 = mul64(x_18036, defunc_0_f_res_18037);
        int64_t y_18160 = mul64(x_18035, defunc_0_f_res_18038);
        int64_t x_18161 = add64(x_18159, y_18160);
        int64_t y_18162 = mul64(x_18034, defunc_0_f_res_18039);
        int64_t x_18163 = add64(x_18161, y_18162);
        int64_t mul_res_18164 = add64(y_18155, x_18163);
        
        // save map-out results
        { }
        for (uniform unsigned int uni_i_18413 = 0; uni_i_18413 < programCount; uni_i_18413++) {
            if (programIndex == uni_i_18413) {
                // Load accum params
                {
                    x_18022 = local_acc_18358;
                    x_18023 = local_acc_18359;
                    x_18024 = local_acc_18360;
                }
                // Load next params
                {
                    x_18025 = extract(mul_res_18151, uni_i_18413);
                    x_18026 = extract(mul_res_18158, uni_i_18413);
                    x_18027 = extract(mul_res_18164, uni_i_18413);
                }
                // SegRed body
                {
                    uniform int64_t canonicalizze_arg_18028 = add64(x_18022, x_18025);
                    uniform int64_t canonicalizze_res_18029 = umod64(canonicalizze_arg_18028, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18030 = add64(x_18023, x_18026);
                    uniform int64_t canonicalizze_res_18031 = umod64(canonicalizze_arg_18030, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18032 = add64(x_18024, x_18027);
                    uniform int64_t canonicalizze_res_18033 = umod64(canonicalizze_arg_18032, (int64_t) -4294967295);
                    
                    local_acc_18358 = canonicalizze_res_18029;
                    local_acc_18359 = canonicalizze_res_18031;
                    local_acc_18360 = canonicalizze_res_18033;
                }
            }
        }
    }
    if (programIndex < (start_18361 + n_18363 - start_18361) % programCount) {
        int64_t SegRed_i_18364 = start_18361 + programIndex + (start_18361 + n_18363 - start_18361) / programCount * programCount;
        int64_t gtid_18021 = SegRed_i_18364;
        int64_t x_18034;
        
        x_18034 = ((int64_t *) mem_17061.mem)[gtid_17383 * p_12335 + gtid_18021];
        
        int64_t x_18035;
        
        x_18035 = ((int64_t *) mem_17065.mem)[gtid_17383 * p_12335 + gtid_18021];
        
        int64_t x_18036;
        
        x_18036 = ((int64_t *) mem_17069.mem)[gtid_17383 * p_12335 + gtid_18021];
        
        int64_t defunc_0_f_res_18037;
        int64_t defunc_0_f_res_18038;
        int64_t defunc_0_f_res_18039;
        uniform int64_t flat_tid_18040 = (int64_t) 0;
        
        defunc_0_f_res_18037 = (int64_t) 0;
        defunc_0_f_res_18038 = (int64_t) 0;
        defunc_0_f_res_18039 = (int64_t) 0;
        
        struct futhark_mc_task_18611 futhark_mc_task_18611_;
        
        futhark_mc_task_18611_.ctx = ctx;
        futhark_mc_task_18611_.free_m_12334 = m_12334;
        futhark_mc_task_18611_.free_p_12335 = p_12335;
        futhark_mc_task_18611_.free_gtid_16458 = gtid_16458;
        futhark_mc_task_18611_.free_eps_mem_17007 = eps_mem_17007.mem;
        futhark_mc_task_18611_.free_expsss_mem_17008 = expsss_mem_17008.mem;
        futhark_mc_task_18611_.free_gtid_17383 = gtid_17383;
        futhark_mc_task_18611_.free_gtid_18021 = gtid_18021;
        futhark_mc_task_18611_.free_flat_tid_18040 = flat_tid_18040;
        futhark_mc_task_18611_.retval_defunc_0_f_res_18037 = (int64_t *) &defunc_0_f_res_18037;
        #if ISPC
        futhark_mc_task_18611_.retval_defunc_0_f_res_18037 += programIndex;
        #endif
        futhark_mc_task_18611_.retval_defunc_0_f_res_18038 = (int64_t *) &defunc_0_f_res_18038;
        #if ISPC
        futhark_mc_task_18611_.retval_defunc_0_f_res_18038 += programIndex;
        #endif
        futhark_mc_task_18611_.retval_defunc_0_f_res_18039 = (int64_t *) &defunc_0_f_res_18039;
        #if ISPC
        futhark_mc_task_18611_.retval_defunc_0_f_res_18039 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18611 aos_18626[programCount];
        
        aos_18626[programIndex] = futhark_mc_task_18611_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18625(ctx, &aos_18626[i], extract(m_12334, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18625(ctx, &futhark_mc_task_18611_, m_12334);
        if (err != 0)
            goto cleanup;
        #endif
        
        int64_t x_18147 = mul64(x_18034, defunc_0_f_res_18037);
        int64_t y_18148 = mul64(x_18036, defunc_0_f_res_18038);
        int64_t x_18149 = sub64(x_18147, y_18148);
        int64_t y_18150 = mul64(x_18035, defunc_0_f_res_18039);
        int64_t mul_res_18151 = sub64(x_18149, y_18150);
        int64_t x_18152 = mul64(x_18035, defunc_0_f_res_18037);
        int64_t y_18153 = mul64(x_18034, defunc_0_f_res_18038);
        int64_t x_18154 = add64(x_18152, y_18153);
        int64_t y_18155 = mul64(x_18036, defunc_0_f_res_18039);
        int64_t x_18156 = sub64(x_18154, y_18155);
        int64_t x_18157 = add64(y_18148, x_18156);
        int64_t mul_res_18158 = add64(y_18150, x_18157);
        int64_t x_18159 = mul64(x_18036, defunc_0_f_res_18037);
        int64_t y_18160 = mul64(x_18035, defunc_0_f_res_18038);
        int64_t x_18161 = add64(x_18159, y_18160);
        int64_t y_18162 = mul64(x_18034, defunc_0_f_res_18039);
        int64_t x_18163 = add64(x_18161, y_18162);
        int64_t mul_res_18164 = add64(y_18155, x_18163);
        
        // save map-out results
        { }
        for (uniform unsigned int uni_i_18413 = 0; uni_i_18413 < programCount; uni_i_18413++) {
            if (programIndex == uni_i_18413) {
                // Load accum params
                {
                    x_18022 = local_acc_18358;
                    x_18023 = local_acc_18359;
                    x_18024 = local_acc_18360;
                }
                // Load next params
                {
                    x_18025 = extract(mul_res_18151, uni_i_18413);
                    x_18026 = extract(mul_res_18158, uni_i_18413);
                    x_18027 = extract(mul_res_18164, uni_i_18413);
                }
                // SegRed body
                {
                    uniform int64_t canonicalizze_arg_18028 = add64(x_18022, x_18025);
                    uniform int64_t canonicalizze_res_18029 = umod64(canonicalizze_arg_18028, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18030 = add64(x_18023, x_18026);
                    uniform int64_t canonicalizze_res_18031 = umod64(canonicalizze_arg_18030, (int64_t) -4294967295);
                    uniform int64_t canonicalizze_arg_18032 = add64(x_18024, x_18027);
                    uniform int64_t canonicalizze_res_18033 = umod64(canonicalizze_arg_18032, (int64_t) -4294967295);
                    
                    local_acc_18358 = canonicalizze_res_18029;
                    local_acc_18359 = canonicalizze_res_18031;
                    local_acc_18360 = canonicalizze_res_18033;
                }
            }
        }
    }
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18352.mem)[flat_tid_18020] = local_acc_18358;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18354.mem)[flat_tid_18020] = local_acc_18359;
    ((int64_t *) reduce_stage_1_tid_res_arr_mem_18356.mem)[flat_tid_18020] = local_acc_18360;
    return err;
}
export uniform int futhark_mc_loop_ispc_18602(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18601 *uniform futhark_mc_param_struct_18601_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18601_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18601_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18601_->free_p_12335;
    uniform int64_t gtid_16458 = futhark_mc_param_struct_18601_->free_gtid_16458;
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18603();
    eps_mem_17007.mem = futhark_mc_param_struct_18601_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18604();
    expsss_mem_17008.mem = futhark_mc_param_struct_18601_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18605();
    mem_17061.mem = futhark_mc_param_struct_18601_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18606();
    mem_17065.mem = futhark_mc_param_struct_18601_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18607();
    mem_17069.mem = futhark_mc_param_struct_18601_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform int64_t gtid_17383 = futhark_mc_param_struct_18601_->free_gtid_17383;
    uniform int64_t flat_tid_18020 = futhark_mc_param_struct_18601_->free_flat_tid_18020;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18352;
    
    reduce_stage_1_tid_res_arr_mem_18352.desc = futhark_mc_strlit_shim_18608();
    reduce_stage_1_tid_res_arr_mem_18352.mem = futhark_mc_param_struct_18601_->free_reduce_stage_1_tid_res_arr_mem_18352;
    reduce_stage_1_tid_res_arr_mem_18352.size = 0;
    reduce_stage_1_tid_res_arr_mem_18352.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18354;
    
    reduce_stage_1_tid_res_arr_mem_18354.desc = futhark_mc_strlit_shim_18609();
    reduce_stage_1_tid_res_arr_mem_18354.mem = futhark_mc_param_struct_18601_->free_reduce_stage_1_tid_res_arr_mem_18354;
    reduce_stage_1_tid_res_arr_mem_18354.size = 0;
    reduce_stage_1_tid_res_arr_mem_18354.references = NULL;
    
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_18356;
    
    reduce_stage_1_tid_res_arr_mem_18356.desc = futhark_mc_strlit_shim_18610();
    reduce_stage_1_tid_res_arr_mem_18356.mem = futhark_mc_param_struct_18601_->free_reduce_stage_1_tid_res_arr_mem_18356;
    reduce_stage_1_tid_res_arr_mem_18356.size = 0;
    reduce_stage_1_tid_res_arr_mem_18356.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18627 futhark_mc_mem_struct_18627_;
    uniform int err = futhark_mc_inner_ispc_18628(start, end, futhark_mc_param_struct_18601_, &futhark_mc_mem_struct_18627_);
    
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18637(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18578 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18642 {
    varying unsigned char *uniform mem_17691;
    varying size_t mem_17691_cached_sizze_18571;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18644();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18645();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18646();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18647();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18648();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18649();
static unmasked inline uniform int futhark_mc_inner_ispc_18643(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18569 *uniform futhark_mc_param_struct_18569_, uniform struct futhark_mc_mem_struct_18642 *uniform futhark_mc_mem_struct_18642_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18569_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18569_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18569_->free_p_12335;
    uniform int64_t gtid_16458 = futhark_mc_param_struct_18569_->free_gtid_16458;
    uniform int64_t defunc_0_f_res_16461 = futhark_mc_param_struct_18569_->free_defunc_0_f_res_16461;
    uniform int64_t defunc_0_f_res_16462 = futhark_mc_param_struct_18569_->free_defunc_0_f_res_16462;
    uniform int64_t defunc_0_f_res_16463 = futhark_mc_param_struct_18569_->free_defunc_0_f_res_16463;
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18644();
    eps_mem_17007.mem = futhark_mc_param_struct_18569_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18645();
    expsss_mem_17008.mem = futhark_mc_param_struct_18569_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18646();
    mem_17061.mem = futhark_mc_param_struct_18569_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18647();
    mem_17065.mem = futhark_mc_param_struct_18569_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18648();
    mem_17069.mem = futhark_mc_param_struct_18569_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform struct memblock mem_17077;
    
    mem_17077.desc = futhark_mc_strlit_shim_18649();
    mem_17077.mem = futhark_mc_param_struct_18569_->free_mem_17077;
    mem_17077.size = 0;
    mem_17077.references = NULL;
    
    varying unsigned char *uniform mem_17691 = futhark_mc_mem_struct_18642_->mem_17691;
    size_t mem_17691_cached_sizze_18571 = futhark_mc_mem_struct_18642_->mem_17691_cached_sizze_18571;
    uniform int err = 0;
    uniform int64_t start_18306;
    uniform int64_t end_18307;
    
    start_18306 = start;
    end_18307 = end;
    
    uniform int64_t n_18308 = end_18307 - start_18306;
    
    if (mem_17691_cached_sizze_18571 < (int64_t) 24) {
        err = lexical_realloc(ctx, &mem_17691, &mem_17691_cached_sizze_18571, (int64_t) 24);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    for (uniform int64_t i = 0; i < (start_18306 + n_18308 - start_18306) / programCount; i++) {
        int64_t SegMap_i_18309 = start_18306 + programIndex + i * programCount;
        uniform int64_t slice_18310 = m_12334;
        int64_t gtid_17383 = SegMap_i_18309;
        int64_t remnant_18311 = SegMap_i_18309 - gtid_17383;
        int64_t defunc_0_f_res_17384;
        int64_t defunc_0_f_res_17385;
        int64_t defunc_0_f_res_17386;
        uniform int64_t flat_tid_18165 = (int64_t) 0;
        
        defunc_0_f_res_17384 = (int64_t) 0;
        defunc_0_f_res_17385 = (int64_t) 0;
        defunc_0_f_res_17386 = (int64_t) 0;
        
        uniform int64_t flat_tid_18020 = (int64_t) 0;
        struct futhark_mc_task_18578 futhark_mc_task_18578_;
        
        futhark_mc_task_18578_.ctx = ctx;
        futhark_mc_task_18578_.free_m_12334 = m_12334;
        futhark_mc_task_18578_.free_p_12335 = p_12335;
        futhark_mc_task_18578_.free_gtid_16458 = gtid_16458;
        futhark_mc_task_18578_.free_eps_mem_17007 = eps_mem_17007.mem;
        futhark_mc_task_18578_.free_expsss_mem_17008 = expsss_mem_17008.mem;
        futhark_mc_task_18578_.free_mem_17061 = mem_17061.mem;
        futhark_mc_task_18578_.free_mem_17065 = mem_17065.mem;
        futhark_mc_task_18578_.free_mem_17069 = mem_17069.mem;
        futhark_mc_task_18578_.free_gtid_17383 = gtid_17383;
        futhark_mc_task_18578_.free_flat_tid_18020 = flat_tid_18020;
        futhark_mc_task_18578_.free_flat_tid_18165 = flat_tid_18165;
        futhark_mc_task_18578_.retval_defunc_0_f_res_17384 = (int64_t *) &defunc_0_f_res_17384;
        #if ISPC
        futhark_mc_task_18578_.retval_defunc_0_f_res_17384 += programIndex;
        #endif
        futhark_mc_task_18578_.retval_defunc_0_f_res_17385 = (int64_t *) &defunc_0_f_res_17385;
        #if ISPC
        futhark_mc_task_18578_.retval_defunc_0_f_res_17385 += programIndex;
        #endif
        futhark_mc_task_18578_.retval_defunc_0_f_res_17386 = (int64_t *) &defunc_0_f_res_17386;
        #if ISPC
        futhark_mc_task_18578_.retval_defunc_0_f_res_17386 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18578 aos_18638[programCount];
        
        aos_18638[programIndex] = futhark_mc_task_18578_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18637(ctx, &aos_18638[i], extract(p_12335, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18637(ctx, &futhark_mc_task_18578_, p_12335);
        if (err != 0)
            goto cleanup;
        #endif
        
        int64_t x_17673 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17384);
        int64_t y_17674 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17385);
        int64_t x_17675 = sub64(x_17673, y_17674);
        int64_t y_17676 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17386);
        int64_t mul_res_17677 = sub64(x_17675, y_17676);
        int64_t x_17678 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17384);
        int64_t y_17679 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17385);
        int64_t x_17680 = add64(x_17678, y_17679);
        int64_t y_17681 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17386);
        int64_t x_17682 = sub64(x_17680, y_17681);
        int64_t x_17683 = add64(y_17674, x_17682);
        int64_t mul_res_17684 = add64(y_17676, x_17683);
        int64_t x_17685 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17384);
        int64_t y_17686 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17385);
        int64_t x_17687 = add64(x_17685, y_17686);
        int64_t y_17688 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17386);
        int64_t x_17689 = add64(x_17687, y_17688);
        int64_t mul_res_17690 = add64(y_17681, x_17689);
        uniform int64_t tmp_idx_18639 = (int64_t) 0;
        
        ((varying int64_t *) mem_17691)[tmp_idx_18639] = mul_res_17677;
        
        uniform int64_t tmp_idx_18640 = (int64_t) 1;
        
        ((varying int64_t *) mem_17691)[tmp_idx_18640] = mul_res_17684;
        
        uniform int64_t tmp_idx_18641 = (int64_t) 2;
        
        ((varying int64_t *) mem_17691)[tmp_idx_18641] = mul_res_17690;
        if ((int64_t) 24 > 0)
            memmove_64(mem_17077.mem + gtid_17383 * (int64_t) 3 * (int64_t) 8, mem_17691 + (int64_t) 0, extract((int64_t) 24, 0));
    }
    if (programIndex < (start_18306 + n_18308 - start_18306) % programCount) {
        int64_t SegMap_i_18309 = start_18306 + programIndex + (start_18306 + n_18308 - start_18306) / programCount * programCount;
        uniform int64_t slice_18310 = m_12334;
        int64_t gtid_17383 = SegMap_i_18309;
        int64_t remnant_18311 = SegMap_i_18309 - gtid_17383;
        int64_t defunc_0_f_res_17384;
        int64_t defunc_0_f_res_17385;
        int64_t defunc_0_f_res_17386;
        uniform int64_t flat_tid_18165 = (int64_t) 0;
        
        defunc_0_f_res_17384 = (int64_t) 0;
        defunc_0_f_res_17385 = (int64_t) 0;
        defunc_0_f_res_17386 = (int64_t) 0;
        
        uniform int64_t flat_tid_18020 = (int64_t) 0;
        struct futhark_mc_task_18578 futhark_mc_task_18578_;
        
        futhark_mc_task_18578_.ctx = ctx;
        futhark_mc_task_18578_.free_m_12334 = m_12334;
        futhark_mc_task_18578_.free_p_12335 = p_12335;
        futhark_mc_task_18578_.free_gtid_16458 = gtid_16458;
        futhark_mc_task_18578_.free_eps_mem_17007 = eps_mem_17007.mem;
        futhark_mc_task_18578_.free_expsss_mem_17008 = expsss_mem_17008.mem;
        futhark_mc_task_18578_.free_mem_17061 = mem_17061.mem;
        futhark_mc_task_18578_.free_mem_17065 = mem_17065.mem;
        futhark_mc_task_18578_.free_mem_17069 = mem_17069.mem;
        futhark_mc_task_18578_.free_gtid_17383 = gtid_17383;
        futhark_mc_task_18578_.free_flat_tid_18020 = flat_tid_18020;
        futhark_mc_task_18578_.free_flat_tid_18165 = flat_tid_18165;
        futhark_mc_task_18578_.retval_defunc_0_f_res_17384 = (int64_t *) &defunc_0_f_res_17384;
        #if ISPC
        futhark_mc_task_18578_.retval_defunc_0_f_res_17384 += programIndex;
        #endif
        futhark_mc_task_18578_.retval_defunc_0_f_res_17385 = (int64_t *) &defunc_0_f_res_17385;
        #if ISPC
        futhark_mc_task_18578_.retval_defunc_0_f_res_17385 += programIndex;
        #endif
        futhark_mc_task_18578_.retval_defunc_0_f_res_17386 = (int64_t *) &defunc_0_f_res_17386;
        #if ISPC
        futhark_mc_task_18578_.retval_defunc_0_f_res_17386 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18578 aos_18638[programCount];
        
        aos_18638[programIndex] = futhark_mc_task_18578_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18637(ctx, &aos_18638[i], extract(p_12335, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18637(ctx, &futhark_mc_task_18578_, p_12335);
        if (err != 0)
            goto cleanup;
        #endif
        
        int64_t x_17673 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17384);
        int64_t y_17674 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17385);
        int64_t x_17675 = sub64(x_17673, y_17674);
        int64_t y_17676 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17386);
        int64_t mul_res_17677 = sub64(x_17675, y_17676);
        int64_t x_17678 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17384);
        int64_t y_17679 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17385);
        int64_t x_17680 = add64(x_17678, y_17679);
        int64_t y_17681 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17386);
        int64_t x_17682 = sub64(x_17680, y_17681);
        int64_t x_17683 = add64(y_17674, x_17682);
        int64_t mul_res_17684 = add64(y_17676, x_17683);
        int64_t x_17685 = mul64(defunc_0_f_res_16463, defunc_0_f_res_17384);
        int64_t y_17686 = mul64(defunc_0_f_res_16462, defunc_0_f_res_17385);
        int64_t x_17687 = add64(x_17685, y_17686);
        int64_t y_17688 = mul64(defunc_0_f_res_16461, defunc_0_f_res_17386);
        int64_t x_17689 = add64(x_17687, y_17688);
        int64_t mul_res_17690 = add64(y_17681, x_17689);
        uniform int64_t tmp_idx_18639 = (int64_t) 0;
        
        ((varying int64_t *) mem_17691)[tmp_idx_18639] = mul_res_17677;
        
        uniform int64_t tmp_idx_18640 = (int64_t) 1;
        
        ((varying int64_t *) mem_17691)[tmp_idx_18640] = mul_res_17684;
        
        uniform int64_t tmp_idx_18641 = (int64_t) 2;
        
        ((varying int64_t *) mem_17691)[tmp_idx_18641] = mul_res_17690;
        if ((int64_t) 24 > 0)
            memmove_64(mem_17077.mem + gtid_17383 * (int64_t) 3 * (int64_t) 8, mem_17691 + (int64_t) 0, extract((int64_t) 24, 0));
    }
    futhark_mc_mem_struct_18642_->mem_17691 = mem_17691;
    futhark_mc_mem_struct_18642_->mem_17691_cached_sizze_18571 = mem_17691_cached_sizze_18571;
    return err;
}
export uniform int futhark_mc_loop_ispc_18570(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18569 *uniform futhark_mc_param_struct_18569_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18569_->ctx;
    uniform int64_t m_12334 = futhark_mc_param_struct_18569_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18569_->free_p_12335;
    uniform int64_t gtid_16458 = futhark_mc_param_struct_18569_->free_gtid_16458;
    uniform int64_t defunc_0_f_res_16461 = futhark_mc_param_struct_18569_->free_defunc_0_f_res_16461;
    uniform int64_t defunc_0_f_res_16462 = futhark_mc_param_struct_18569_->free_defunc_0_f_res_16462;
    uniform int64_t defunc_0_f_res_16463 = futhark_mc_param_struct_18569_->free_defunc_0_f_res_16463;
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18572();
    eps_mem_17007.mem = futhark_mc_param_struct_18569_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18573();
    expsss_mem_17008.mem = futhark_mc_param_struct_18569_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18574();
    mem_17061.mem = futhark_mc_param_struct_18569_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18575();
    mem_17065.mem = futhark_mc_param_struct_18569_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18576();
    mem_17069.mem = futhark_mc_param_struct_18569_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform struct memblock mem_17077;
    
    mem_17077.desc = futhark_mc_strlit_shim_18577();
    mem_17077.mem = futhark_mc_param_struct_18569_->free_mem_17077;
    mem_17077.size = 0;
    mem_17077.references = NULL;
    
    size_t mem_17691_cached_sizze_18571 = 0;
    varying unsigned char *uniform mem_17691 = NULL;
    uniform struct futhark_mc_mem_struct_18642 futhark_mc_mem_struct_18642_;
    
    futhark_mc_mem_struct_18642_.mem_17691 = mem_17691;
    futhark_mc_mem_struct_18642_.mem_17691_cached_sizze_18571 = mem_17691_cached_sizze_18571;
    
    uniform int err = futhark_mc_inner_ispc_18643(start, end, futhark_mc_param_struct_18569_, &futhark_mc_mem_struct_18642_);
    
    mem_17691 = futhark_mc_mem_struct_18642_.mem_17691;
    mem_17691_cached_sizze_18571 = futhark_mc_mem_struct_18642_.mem_17691_cached_sizze_18571;
    
  cleanup:
    {
        free(mem_17691);
    }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18650(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18540 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18652 {
    varying struct memblock *uniform mem_17077;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18654();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18655();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18656();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18657();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18658();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18659();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18660();
static unmasked inline uniform int futhark_mc_inner_ispc_18653(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18530 *uniform futhark_mc_param_struct_18530_, uniform struct futhark_mc_mem_struct_18652 *uniform futhark_mc_mem_struct_18652_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18530_->ctx;
    uniform int64_t n_12333 = futhark_mc_param_struct_18530_->free_n_12333;
    uniform int64_t m_12334 = futhark_mc_param_struct_18530_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18530_->free_p_12335;
    uniform struct memblock zzinvs_mem_17006;
    
    zzinvs_mem_17006.desc = futhark_mc_strlit_shim_18654();
    zzinvs_mem_17006.mem = futhark_mc_param_struct_18530_->free_zzinvs_mem_17006;
    zzinvs_mem_17006.size = 0;
    zzinvs_mem_17006.references = NULL;
    
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18655();
    eps_mem_17007.mem = futhark_mc_param_struct_18530_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18656();
    expsss_mem_17008.mem = futhark_mc_param_struct_18530_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18657();
    mem_17061.mem = futhark_mc_param_struct_18530_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18658();
    mem_17065.mem = futhark_mc_param_struct_18530_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18659();
    mem_17069.mem = futhark_mc_param_struct_18530_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform int64_t bytes_17076 = futhark_mc_param_struct_18530_->free_bytes_17076;
    uniform struct memblock mem_17143;
    
    mem_17143.desc = futhark_mc_strlit_shim_18660();
    mem_17143.mem = futhark_mc_param_struct_18530_->free_mem_17143;
    mem_17143.size = 0;
    mem_17143.references = NULL;
    
    struct memblock mem_17077 = *futhark_mc_mem_struct_18652_->mem_17077;
    uniform int err = 0;
    uniform int64_t start_17855;
    uniform int64_t end_17856;
    
    start_17855 = start;
    end_17856 = end;
    
    uniform int64_t n_17857 = end_17856 - start_17855;
    
    if (memblock_alloc(ctx, &mem_17077, bytes_17076, futhark_mc_strlit_shim_18539()))
        unmasked { return 1; }
    for (uniform int64_t i = 0; i < (start_17855 + n_17857 - start_17855) / programCount; i++) {
        int64_t SegMap_i_17858 = start_17855 + programIndex + i * programCount;
        uniform int64_t slice_17859 = n_12333;
        int64_t gtid_16458 = SegMap_i_17858;
        int64_t remnant_17860 = SegMap_i_17858 - gtid_16458;
        int64_t defunc_0_f_res_16461;
        
        defunc_0_f_res_16461 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_16458 * (int64_t) 3];
        
        int64_t defunc_0_f_res_16462;
        
        defunc_0_f_res_16462 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_16458 * (int64_t) 3 + (int64_t) 1];
        
        int64_t defunc_0_f_res_16463;
        
        defunc_0_f_res_16463 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_16458 * (int64_t) 3 + (int64_t) 2];
        
        uniform int64_t flat_tid_17693 = (int64_t) 0;
        uniform int64_t flat_tid_17382 = (int64_t) 0;
        struct futhark_mc_task_18540 futhark_mc_task_18540_;
        
        futhark_mc_task_18540_.ctx = ctx;
        futhark_mc_task_18540_.free_m_12334 = m_12334;
        futhark_mc_task_18540_.free_p_12335 = p_12335;
        futhark_mc_task_18540_.free_gtid_16458 = gtid_16458;
        futhark_mc_task_18540_.free_defunc_0_f_res_16461 = defunc_0_f_res_16461;
        futhark_mc_task_18540_.free_defunc_0_f_res_16462 = defunc_0_f_res_16462;
        futhark_mc_task_18540_.free_defunc_0_f_res_16463 = defunc_0_f_res_16463;
        futhark_mc_task_18540_.free_eps_mem_17007 = eps_mem_17007.mem;
        futhark_mc_task_18540_.free_expsss_mem_17008 = expsss_mem_17008.mem;
        futhark_mc_task_18540_.free_mem_17061 = mem_17061.mem;
        futhark_mc_task_18540_.free_mem_17065 = mem_17065.mem;
        futhark_mc_task_18540_.free_mem_17069 = mem_17069.mem;
        futhark_mc_task_18540_.free_mem_17077 = mem_17077.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18540 aos_18651[programCount];
        
        aos_18651[programIndex] = futhark_mc_task_18540_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18650(ctx, &aos_18651[i], extract(m_12334, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18650(ctx, &futhark_mc_task_18540_, m_12334);
        if (err != 0)
            goto cleanup;
        #endif
        if (m_12334 * (int64_t) 3 * (int64_t) 8 > 0)
            memmove(mem_17143.mem + gtid_16458 * ((int64_t) 3 * m_12334) * (int64_t) 8, mem_17077.mem + (int64_t) 0, m_12334 * (int64_t) 3 * (int64_t) 8);
    }
    if (programIndex < (start_17855 + n_17857 - start_17855) % programCount) {
        int64_t SegMap_i_17858 = start_17855 + programIndex + (start_17855 + n_17857 - start_17855) / programCount * programCount;
        uniform int64_t slice_17859 = n_12333;
        int64_t gtid_16458 = SegMap_i_17858;
        int64_t remnant_17860 = SegMap_i_17858 - gtid_16458;
        int64_t defunc_0_f_res_16461;
        
        defunc_0_f_res_16461 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_16458 * (int64_t) 3];
        
        int64_t defunc_0_f_res_16462;
        
        defunc_0_f_res_16462 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_16458 * (int64_t) 3 + (int64_t) 1];
        
        int64_t defunc_0_f_res_16463;
        
        defunc_0_f_res_16463 = ((int64_t *) zzinvs_mem_17006.mem)[gtid_16458 * (int64_t) 3 + (int64_t) 2];
        
        uniform int64_t flat_tid_17693 = (int64_t) 0;
        uniform int64_t flat_tid_17382 = (int64_t) 0;
        struct futhark_mc_task_18540 futhark_mc_task_18540_;
        
        futhark_mc_task_18540_.ctx = ctx;
        futhark_mc_task_18540_.free_m_12334 = m_12334;
        futhark_mc_task_18540_.free_p_12335 = p_12335;
        futhark_mc_task_18540_.free_gtid_16458 = gtid_16458;
        futhark_mc_task_18540_.free_defunc_0_f_res_16461 = defunc_0_f_res_16461;
        futhark_mc_task_18540_.free_defunc_0_f_res_16462 = defunc_0_f_res_16462;
        futhark_mc_task_18540_.free_defunc_0_f_res_16463 = defunc_0_f_res_16463;
        futhark_mc_task_18540_.free_eps_mem_17007 = eps_mem_17007.mem;
        futhark_mc_task_18540_.free_expsss_mem_17008 = expsss_mem_17008.mem;
        futhark_mc_task_18540_.free_mem_17061 = mem_17061.mem;
        futhark_mc_task_18540_.free_mem_17065 = mem_17065.mem;
        futhark_mc_task_18540_.free_mem_17069 = mem_17069.mem;
        futhark_mc_task_18540_.free_mem_17077 = mem_17077.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18540 aos_18651[programCount];
        
        aos_18651[programIndex] = futhark_mc_task_18540_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18650(ctx, &aos_18651[i], extract(m_12334, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18650(ctx, &futhark_mc_task_18540_, m_12334);
        if (err != 0)
            goto cleanup;
        #endif
        if (m_12334 * (int64_t) 3 * (int64_t) 8 > 0)
            memmove(mem_17143.mem + gtid_16458 * ((int64_t) 3 * m_12334) * (int64_t) 8, mem_17077.mem + (int64_t) 0, m_12334 * (int64_t) 3 * (int64_t) 8);
    }
    *futhark_mc_mem_struct_18652_->mem_17077 = mem_17077;
    return err;
}
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18661();
export uniform int futhark_mc_loop_ispc_18531(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18530 *uniform futhark_mc_param_struct_18530_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18530_->ctx;
    uniform int64_t n_12333 = futhark_mc_param_struct_18530_->free_n_12333;
    uniform int64_t m_12334 = futhark_mc_param_struct_18530_->free_m_12334;
    uniform int64_t p_12335 = futhark_mc_param_struct_18530_->free_p_12335;
    uniform struct memblock zzinvs_mem_17006;
    
    zzinvs_mem_17006.desc = futhark_mc_strlit_shim_18532();
    zzinvs_mem_17006.mem = futhark_mc_param_struct_18530_->free_zzinvs_mem_17006;
    zzinvs_mem_17006.size = 0;
    zzinvs_mem_17006.references = NULL;
    
    uniform struct memblock eps_mem_17007;
    
    eps_mem_17007.desc = futhark_mc_strlit_shim_18533();
    eps_mem_17007.mem = futhark_mc_param_struct_18530_->free_eps_mem_17007;
    eps_mem_17007.size = 0;
    eps_mem_17007.references = NULL;
    
    uniform struct memblock expsss_mem_17008;
    
    expsss_mem_17008.desc = futhark_mc_strlit_shim_18534();
    expsss_mem_17008.mem = futhark_mc_param_struct_18530_->free_expsss_mem_17008;
    expsss_mem_17008.size = 0;
    expsss_mem_17008.references = NULL;
    
    uniform struct memblock mem_17061;
    
    mem_17061.desc = futhark_mc_strlit_shim_18535();
    mem_17061.mem = futhark_mc_param_struct_18530_->free_mem_17061;
    mem_17061.size = 0;
    mem_17061.references = NULL;
    
    uniform struct memblock mem_17065;
    
    mem_17065.desc = futhark_mc_strlit_shim_18536();
    mem_17065.mem = futhark_mc_param_struct_18530_->free_mem_17065;
    mem_17065.size = 0;
    mem_17065.references = NULL;
    
    uniform struct memblock mem_17069;
    
    mem_17069.desc = futhark_mc_strlit_shim_18537();
    mem_17069.mem = futhark_mc_param_struct_18530_->free_mem_17069;
    mem_17069.size = 0;
    mem_17069.references = NULL;
    
    uniform int64_t bytes_17076 = futhark_mc_param_struct_18530_->free_bytes_17076;
    uniform struct memblock mem_17143;
    
    mem_17143.desc = futhark_mc_strlit_shim_18538();
    mem_17143.mem = futhark_mc_param_struct_18530_->free_mem_17143;
    mem_17143.size = 0;
    mem_17143.references = NULL;
    
    struct memblock mem_17077;
    
    mem_17077.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18652 futhark_mc_mem_struct_18652_;
    
    futhark_mc_mem_struct_18652_.mem_17077 = &mem_17077;
    
    uniform int err = futhark_mc_inner_ispc_18653(start, end, futhark_mc_param_struct_18530_, &futhark_mc_mem_struct_18652_);
    
    mem_17077 = *futhark_mc_mem_struct_18652_.mem_17077;
    
  cleanup:
    {
        if (memblock_unref(ctx, &mem_17077, futhark_mc_strlit_shim_18661()) != 0)
            unmasked { return 1; }
    }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18662(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18491 *uniform args, uniform int iterations);
struct futhark_mc_task_18665 {
    struct futhark_context *ctx;
    int64_t free_nz2080U_9823;
    int64_t free_pz2081U_9824;
    int64_t free_mz2082U_9825;
    unsigned char *free_xss_mem_17006;
    unsigned char *free_yss_mem_17007;
    int64_t free_bytes_17009;
    unsigned char *free_mem_17027;
};
struct futhark_mc_param_struct_18670 {
    struct futhark_context *ctx;
    int64_t free_nz2080U_9823;
    int64_t free_pz2081U_9824;
    int64_t free_mz2082U_9825;
    unsigned char *free_xss_mem_17006;
    unsigned char *free_yss_mem_17007;
    int64_t free_bytes_17009;
    unsigned char *free_mem_17027;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18673();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18674();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18675();
struct futhark_mc_mem_struct_18676 {
    varying unsigned char *uniform mem_17013;
    varying size_t mem_17013_cached_sizze_18672;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18678();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18679();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18680();
static unmasked inline uniform int futhark_mc_inner_ispc_18677(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18670 *uniform futhark_mc_param_struct_18670_, uniform struct futhark_mc_mem_struct_18676 *uniform futhark_mc_mem_struct_18676_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18670_->ctx;
    uniform int64_t nz2080U_9823 = futhark_mc_param_struct_18670_->free_nz2080U_9823;
    uniform int64_t pz2081U_9824 = futhark_mc_param_struct_18670_->free_pz2081U_9824;
    uniform int64_t mz2082U_9825 = futhark_mc_param_struct_18670_->free_mz2082U_9825;
    uniform struct memblock xss_mem_17006;
    
    xss_mem_17006.desc = futhark_mc_strlit_shim_18678();
    xss_mem_17006.mem = futhark_mc_param_struct_18670_->free_xss_mem_17006;
    xss_mem_17006.size = 0;
    xss_mem_17006.references = NULL;
    
    uniform struct memblock yss_mem_17007;
    
    yss_mem_17007.desc = futhark_mc_strlit_shim_18679();
    yss_mem_17007.mem = futhark_mc_param_struct_18670_->free_yss_mem_17007;
    yss_mem_17007.size = 0;
    yss_mem_17007.references = NULL;
    
    uniform int64_t bytes_17009 = futhark_mc_param_struct_18670_->free_bytes_17009;
    uniform struct memblock mem_17027;
    
    mem_17027.desc = futhark_mc_strlit_shim_18680();
    mem_17027.mem = futhark_mc_param_struct_18670_->free_mem_17027;
    mem_17027.size = 0;
    mem_17027.references = NULL;
    
    varying unsigned char *uniform mem_17013 = futhark_mc_mem_struct_18676_->mem_17013;
    size_t mem_17013_cached_sizze_18672 = futhark_mc_mem_struct_18676_->mem_17013_cached_sizze_18672;
    uniform int err = 0;
    uniform int64_t start_17156;
    uniform int64_t end_17157;
    
    start_17156 = start;
    end_17157 = end;
    
    uniform int64_t n_17158 = end_17157 - start_17156;
    
    if (mem_17013_cached_sizze_18672 < bytes_17009) {
        err = lexical_realloc(ctx, &mem_17013, &mem_17013_cached_sizze_18672, bytes_17009);
        if (err != FUTHARK_SUCCESS)
            unmasked { return err; }
    }
    foreach (SegMap_i_17159 = start_17156 ... start_17156 + n_17158)
    {
        uniform int64_t slice_17160 = nz2080U_9823;
        int64_t gtid_15912 = SegMap_i_17159;
        int64_t remnant_17161 = SegMap_i_17159 - gtid_15912;
        
        for (uniform int64_t i_17146 = 0; i_17146 < mz2082U_9825; i_17146++) {
            int32_t defunc_2_reduce_res_17148;
            int32_t redout_17150 = 0;
            
            for (uniform int64_t i_17149 = 0; i_17149 < pz2081U_9824; i_17149++) {
                int32_t x_17151;
                
                x_17151 = ((int32_t *) xss_mem_17006.mem)[gtid_15912 * pz2081U_9824 + i_17149];
                
                uniform int32_t x_17152;
                
                x_17152 = ((int32_t *) yss_mem_17007.mem)[i_17149 * mz2082U_9825 + i_17146];
                
                int32_t defunc_1_f_res_17153 = mul32(x_17151, x_17152);
                int32_t defunc_1_op_res_17154 = add32(defunc_1_f_res_17153, redout_17150);
                int32_t redout_tmp_17163 = defunc_1_op_res_17154;
                
                redout_17150 = redout_tmp_17163;
            }
            defunc_2_reduce_res_17148 = redout_17150;
            ((varying int32_t *) mem_17013)[i_17146] = defunc_2_reduce_res_17148;
        }
        if (mz2082U_9825 * (int64_t) 4 > 0)
            memmove_32(mem_17027.mem + gtid_15912 * mz2082U_9825 * (int64_t) 4, mem_17013 + (int64_t) 0, extract(mz2082U_9825 * (int64_t) 4, 0));
    }
    futhark_mc_mem_struct_18676_->mem_17013 = mem_17013;
    futhark_mc_mem_struct_18676_->mem_17013_cached_sizze_18672 = mem_17013_cached_sizze_18672;
    return err;
}
export uniform int futhark_mc_loop_ispc_18671(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18670 *uniform futhark_mc_param_struct_18670_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18670_->ctx;
    uniform int64_t nz2080U_9823 = futhark_mc_param_struct_18670_->free_nz2080U_9823;
    uniform int64_t pz2081U_9824 = futhark_mc_param_struct_18670_->free_pz2081U_9824;
    uniform int64_t mz2082U_9825 = futhark_mc_param_struct_18670_->free_mz2082U_9825;
    uniform struct memblock xss_mem_17006;
    
    xss_mem_17006.desc = futhark_mc_strlit_shim_18673();
    xss_mem_17006.mem = futhark_mc_param_struct_18670_->free_xss_mem_17006;
    xss_mem_17006.size = 0;
    xss_mem_17006.references = NULL;
    
    uniform struct memblock yss_mem_17007;
    
    yss_mem_17007.desc = futhark_mc_strlit_shim_18674();
    yss_mem_17007.mem = futhark_mc_param_struct_18670_->free_yss_mem_17007;
    yss_mem_17007.size = 0;
    yss_mem_17007.references = NULL;
    
    uniform int64_t bytes_17009 = futhark_mc_param_struct_18670_->free_bytes_17009;
    uniform struct memblock mem_17027;
    
    mem_17027.desc = futhark_mc_strlit_shim_18675();
    mem_17027.mem = futhark_mc_param_struct_18670_->free_mem_17027;
    mem_17027.size = 0;
    mem_17027.references = NULL;
    
    size_t mem_17013_cached_sizze_18672 = 0;
    varying unsigned char *uniform mem_17013 = NULL;
    uniform struct futhark_mc_mem_struct_18676 futhark_mc_mem_struct_18676_;
    
    futhark_mc_mem_struct_18676_.mem_17013 = mem_17013;
    futhark_mc_mem_struct_18676_.mem_17013_cached_sizze_18672 = mem_17013_cached_sizze_18672;
    
    uniform int err = futhark_mc_inner_ispc_18677(start, end, futhark_mc_param_struct_18670_, &futhark_mc_mem_struct_18676_);
    
    mem_17013 = futhark_mc_mem_struct_18676_.mem_17013;
    mem_17013_cached_sizze_18672 = futhark_mc_mem_struct_18676_.mem_17013_cached_sizze_18672;
    
  cleanup:
    {
        free(mem_17013);
    }
    return err;
}
struct futhark_mc_param_struct_18685 {
    struct futhark_context *ctx;
    int64_t free_nz2080U_9823;
    int64_t free_pz2081U_9824;
    int64_t free_mz2082U_9825;
    unsigned char *free_xss_mem_17006;
    unsigned char *free_yss_mem_17007;
    int64_t free_bytes_17009;
    unsigned char *free_mem_17027;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18687();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18688();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18689();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18690();
struct futhark_mc_task_18691 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9824;
    int64_t free_mz2082U_9825;
    int64_t free_gtid_15934;
    unsigned char *free_xss_mem_17006;
    unsigned char *free_yss_mem_17007;
    unsigned char *free_mem_17010;
};
struct futhark_mc_param_struct_18695 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9824;
    int64_t free_mz2082U_9825;
    int64_t free_gtid_15934;
    unsigned char *free_xss_mem_17006;
    unsigned char *free_yss_mem_17007;
    unsigned char *free_mem_17010;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18697();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18698();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18699();
export uniform int futhark_mc_loop_ispc_18696(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18695 *uniform futhark_mc_param_struct_18695_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18695_->ctx;
    uniform int64_t pz2081U_9824 = futhark_mc_param_struct_18695_->free_pz2081U_9824;
    uniform int64_t mz2082U_9825 = futhark_mc_param_struct_18695_->free_mz2082U_9825;
    uniform int64_t gtid_15934 = futhark_mc_param_struct_18695_->free_gtid_15934;
    uniform struct memblock xss_mem_17006;
    
    xss_mem_17006.desc = futhark_mc_strlit_shim_18697();
    xss_mem_17006.mem = futhark_mc_param_struct_18695_->free_xss_mem_17006;
    xss_mem_17006.size = 0;
    xss_mem_17006.references = NULL;
    
    uniform struct memblock yss_mem_17007;
    
    yss_mem_17007.desc = futhark_mc_strlit_shim_18698();
    yss_mem_17007.mem = futhark_mc_param_struct_18695_->free_yss_mem_17007;
    yss_mem_17007.size = 0;
    yss_mem_17007.references = NULL;
    
    uniform struct memblock mem_17010;
    
    mem_17010.desc = futhark_mc_strlit_shim_18699();
    mem_17010.mem = futhark_mc_param_struct_18695_->free_mem_17010;
    mem_17010.size = 0;
    mem_17010.references = NULL;
    
    uniform int err = 0;
    uniform int64_t start_17198;
    uniform int64_t end_17199;
    
    start_17198 = start;
    end_17199 = end;
    
    uniform int64_t n_17200 = end_17199 - start_17198;
    
    foreach (SegMap_i_17201 = start_17198 ... start_17198 + n_17200)
    {
        uniform int64_t slice_17202 = mz2082U_9825;
        int64_t gtid_17177 = SegMap_i_17201;
        int64_t remnant_17203 = SegMap_i_17201 - gtid_17177;
        int32_t defunc_2_reduce_res_17178;
        int32_t redout_17193 = 0;
        
        for (uniform int64_t i_17192 = 0; i_17192 < pz2081U_9824; i_17192++) {
            uniform int32_t x_17194;
            
            x_17194 = ((int32_t *) xss_mem_17006.mem)[gtid_15934 * pz2081U_9824 + i_17192];
            
            int32_t x_17195;
            
            x_17195 = ((int32_t *) yss_mem_17007.mem)[i_17192 * mz2082U_9825 + gtid_17177];
            
            int32_t defunc_1_f_res_17196 = mul32(x_17194, x_17195);
            int32_t defunc_1_op_res_17197 = add32(defunc_1_f_res_17196, redout_17193);
            int32_t redout_tmp_17204 = defunc_1_op_res_17197;
            
            redout_17193 = redout_tmp_17204;
        }
        defunc_2_reduce_res_17178 = redout_17193;
        ((int32_t *) mem_17010.mem)[gtid_17177] = defunc_2_reduce_res_17178;
    }
    
  cleanup:
    { }
    return err;
}
struct futhark_mc_param_struct_18703 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9824;
    int64_t free_mz2082U_9825;
    int64_t free_gtid_15934;
    unsigned char *free_xss_mem_17006;
    unsigned char *free_yss_mem_17007;
    unsigned char *free_mem_17010;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18705();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18706();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18707();
struct futhark_mc_task_18708 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9824;
    int64_t free_mz2082U_9825;
    int64_t free_gtid_15934;
    unsigned char *free_xss_mem_17006;
    unsigned char *free_yss_mem_17007;
    int64_t free_gtid_17166;
    int64_t free_flat_tid_17206;
    int32_t *retval_defunc_2_reduce_res_17167;
};
struct futhark_mc_param_struct_18713 {
    struct futhark_context *ctx;
    int64_t free_pz2081U_9824;
    int64_t free_mz2082U_9825;
    int64_t free_gtid_15934;
    unsigned char *free_xss_mem_17006;
    unsigned char *free_yss_mem_17007;
    int64_t free_gtid_17166;
    int64_t free_flat_tid_17206;
    unsigned char *free_reduce_stage_1_tid_res_arr_mem_17221;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18715();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18716();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18717();
export uniform int futhark_mc_loop_ispc_18714(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18713 *uniform futhark_mc_param_struct_18713_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18713_->ctx;
    uniform int64_t pz2081U_9824 = futhark_mc_param_struct_18713_->free_pz2081U_9824;
    uniform int64_t mz2082U_9825 = futhark_mc_param_struct_18713_->free_mz2082U_9825;
    uniform int64_t gtid_15934 = futhark_mc_param_struct_18713_->free_gtid_15934;
    uniform struct memblock xss_mem_17006;
    
    xss_mem_17006.desc = futhark_mc_strlit_shim_18715();
    xss_mem_17006.mem = futhark_mc_param_struct_18713_->free_xss_mem_17006;
    xss_mem_17006.size = 0;
    xss_mem_17006.references = NULL;
    
    uniform struct memblock yss_mem_17007;
    
    yss_mem_17007.desc = futhark_mc_strlit_shim_18716();
    yss_mem_17007.mem = futhark_mc_param_struct_18713_->free_yss_mem_17007;
    yss_mem_17007.size = 0;
    yss_mem_17007.references = NULL;
    
    uniform int64_t gtid_17166 = futhark_mc_param_struct_18713_->free_gtid_17166;
    uniform int64_t flat_tid_17206 = futhark_mc_param_struct_18713_->free_flat_tid_17206;
    uniform struct memblock reduce_stage_1_tid_res_arr_mem_17221;
    
    reduce_stage_1_tid_res_arr_mem_17221.desc = futhark_mc_strlit_shim_18717();
    reduce_stage_1_tid_res_arr_mem_17221.mem = futhark_mc_param_struct_18713_->free_reduce_stage_1_tid_res_arr_mem_17221;
    reduce_stage_1_tid_res_arr_mem_17221.size = 0;
    reduce_stage_1_tid_res_arr_mem_17221.references = NULL;
    
    uniform int err = 0;
    uniform int32_t x_17223;
    uniform int32_t x_17224;
    uniform int32_t local_acc_17226 = 0;
    int32_t x_17208;
    int32_t x_17209;
    int32_t local_acc_17227 = 0;
    uniform int64_t start_17228;
    uniform int64_t end_17229;
    
    start_17228 = start;
    end_17229 = end;
    
    uniform int64_t n_17230 = end_17229 - start_17228;
    
    foreach (SegRed_i_17231 = start_17228 ... start_17228 + n_17230)
    {
        int64_t gtid_17207 = SegRed_i_17231;
        int32_t x_17211;
        
        x_17211 = ((int32_t *) xss_mem_17006.mem)[gtid_15934 * pz2081U_9824 + gtid_17207];
        
        int32_t x_17212;
        
        x_17212 = ((int32_t *) yss_mem_17007.mem)[gtid_17207 * mz2082U_9825 + gtid_17166];
        
        int32_t defunc_1_f_res_17213 = mul32(x_17211, x_17212);
        
        // save map-out results
        { }
        // Load accum params
        {
            x_17208 = local_acc_17227;
        }
        // Load next params
        {
            x_17209 = defunc_1_f_res_17213;
        }
        // SegRed body
        {
            int32_t defunc_1_op_res_17210 = add32(x_17208, x_17209);
            
            local_acc_17227 = defunc_1_op_res_17210;
        }
    }
    for (uniform unsigned int uni_i_17232 = 0; uni_i_17232 < programCount; uni_i_17232++) {
        if (programIndex == uni_i_17232) {
            int64_t gtid_17207 = uni_i_17232;
            
            // Load accum params
            {
                x_17223 = local_acc_17226;
            }
            // Load next params
            {
                x_17224 = extract(local_acc_17227, uni_i_17232);
            }
            // SegRed body
            {
                uniform int32_t defunc_1_op_res_17225 = add32(x_17223, x_17224);
                
                local_acc_17226 = defunc_1_op_res_17225;
            }
        }
    }
    ((int32_t *) reduce_stage_1_tid_res_arr_mem_17221.mem)[flat_tid_17206] = local_acc_17226;
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18718(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18708 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18720 { };
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18722();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18723();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18724();
static unmasked inline uniform int futhark_mc_inner_ispc_18721(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18703 *uniform futhark_mc_param_struct_18703_, uniform struct futhark_mc_mem_struct_18720 *uniform futhark_mc_mem_struct_18720_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18703_->ctx;
    uniform int64_t pz2081U_9824 = futhark_mc_param_struct_18703_->free_pz2081U_9824;
    uniform int64_t mz2082U_9825 = futhark_mc_param_struct_18703_->free_mz2082U_9825;
    uniform int64_t gtid_15934 = futhark_mc_param_struct_18703_->free_gtid_15934;
    uniform struct memblock xss_mem_17006;
    
    xss_mem_17006.desc = futhark_mc_strlit_shim_18722();
    xss_mem_17006.mem = futhark_mc_param_struct_18703_->free_xss_mem_17006;
    xss_mem_17006.size = 0;
    xss_mem_17006.references = NULL;
    
    uniform struct memblock yss_mem_17007;
    
    yss_mem_17007.desc = futhark_mc_strlit_shim_18723();
    yss_mem_17007.mem = futhark_mc_param_struct_18703_->free_yss_mem_17007;
    yss_mem_17007.size = 0;
    yss_mem_17007.references = NULL;
    
    uniform struct memblock mem_17010;
    
    mem_17010.desc = futhark_mc_strlit_shim_18724();
    mem_17010.mem = futhark_mc_param_struct_18703_->free_mem_17010;
    mem_17010.size = 0;
    mem_17010.references = NULL;
    
    uniform int err = 0;
    uniform int64_t start_17214;
    uniform int64_t end_17215;
    
    start_17214 = start;
    end_17215 = end;
    
    uniform int64_t n_17216 = end_17215 - start_17214;
    
    for (uniform int64_t i = 0; i < (start_17214 + n_17216 - start_17214) / programCount; i++) {
        int64_t SegMap_i_17217 = start_17214 + programIndex + i * programCount;
        uniform int64_t slice_17218 = mz2082U_9825;
        int64_t gtid_17166 = SegMap_i_17217;
        int64_t remnant_17219 = SegMap_i_17217 - gtid_17166;
        int32_t defunc_2_reduce_res_17167;
        uniform int64_t flat_tid_17206 = (int64_t) 0;
        
        defunc_2_reduce_res_17167 = 0;
        
        struct futhark_mc_task_18708 futhark_mc_task_18708_;
        
        futhark_mc_task_18708_.ctx = ctx;
        futhark_mc_task_18708_.free_pz2081U_9824 = pz2081U_9824;
        futhark_mc_task_18708_.free_mz2082U_9825 = mz2082U_9825;
        futhark_mc_task_18708_.free_gtid_15934 = gtid_15934;
        futhark_mc_task_18708_.free_xss_mem_17006 = xss_mem_17006.mem;
        futhark_mc_task_18708_.free_yss_mem_17007 = yss_mem_17007.mem;
        futhark_mc_task_18708_.free_gtid_17166 = gtid_17166;
        futhark_mc_task_18708_.free_flat_tid_17206 = flat_tid_17206;
        futhark_mc_task_18708_.retval_defunc_2_reduce_res_17167 = (int32_t *) &defunc_2_reduce_res_17167;
        #if ISPC
        futhark_mc_task_18708_.retval_defunc_2_reduce_res_17167 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18708 aos_18719[programCount];
        
        aos_18719[programIndex] = futhark_mc_task_18708_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18718(ctx, &aos_18719[i], extract(pz2081U_9824, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18718(ctx, &futhark_mc_task_18708_, pz2081U_9824);
        if (err != 0)
            goto cleanup;
        #endif
        ((int32_t *) mem_17010.mem)[gtid_17166] = defunc_2_reduce_res_17167;
    }
    if (programIndex < (start_17214 + n_17216 - start_17214) % programCount) {
        int64_t SegMap_i_17217 = start_17214 + programIndex + (start_17214 + n_17216 - start_17214) / programCount * programCount;
        uniform int64_t slice_17218 = mz2082U_9825;
        int64_t gtid_17166 = SegMap_i_17217;
        int64_t remnant_17219 = SegMap_i_17217 - gtid_17166;
        int32_t defunc_2_reduce_res_17167;
        uniform int64_t flat_tid_17206 = (int64_t) 0;
        
        defunc_2_reduce_res_17167 = 0;
        
        struct futhark_mc_task_18708 futhark_mc_task_18708_;
        
        futhark_mc_task_18708_.ctx = ctx;
        futhark_mc_task_18708_.free_pz2081U_9824 = pz2081U_9824;
        futhark_mc_task_18708_.free_mz2082U_9825 = mz2082U_9825;
        futhark_mc_task_18708_.free_gtid_15934 = gtid_15934;
        futhark_mc_task_18708_.free_xss_mem_17006 = xss_mem_17006.mem;
        futhark_mc_task_18708_.free_yss_mem_17007 = yss_mem_17007.mem;
        futhark_mc_task_18708_.free_gtid_17166 = gtid_17166;
        futhark_mc_task_18708_.free_flat_tid_17206 = flat_tid_17206;
        futhark_mc_task_18708_.retval_defunc_2_reduce_res_17167 = (int32_t *) &defunc_2_reduce_res_17167;
        #if ISPC
        futhark_mc_task_18708_.retval_defunc_2_reduce_res_17167 += programIndex;
        #endif
        #if ISPC
        
        uniform struct futhark_mc_task_18708 aos_18719[programCount];
        
        aos_18719[programIndex] = futhark_mc_task_18708_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18718(ctx, &aos_18719[i], extract(pz2081U_9824, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18718(ctx, &futhark_mc_task_18708_, pz2081U_9824);
        if (err != 0)
            goto cleanup;
        #endif
        ((int32_t *) mem_17010.mem)[gtid_17166] = defunc_2_reduce_res_17167;
    }
    return err;
}
export uniform int futhark_mc_loop_ispc_18704(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18703 *uniform futhark_mc_param_struct_18703_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18703_->ctx;
    uniform int64_t pz2081U_9824 = futhark_mc_param_struct_18703_->free_pz2081U_9824;
    uniform int64_t mz2082U_9825 = futhark_mc_param_struct_18703_->free_mz2082U_9825;
    uniform int64_t gtid_15934 = futhark_mc_param_struct_18703_->free_gtid_15934;
    uniform struct memblock xss_mem_17006;
    
    xss_mem_17006.desc = futhark_mc_strlit_shim_18705();
    xss_mem_17006.mem = futhark_mc_param_struct_18703_->free_xss_mem_17006;
    xss_mem_17006.size = 0;
    xss_mem_17006.references = NULL;
    
    uniform struct memblock yss_mem_17007;
    
    yss_mem_17007.desc = futhark_mc_strlit_shim_18706();
    yss_mem_17007.mem = futhark_mc_param_struct_18703_->free_yss_mem_17007;
    yss_mem_17007.size = 0;
    yss_mem_17007.references = NULL;
    
    uniform struct memblock mem_17010;
    
    mem_17010.desc = futhark_mc_strlit_shim_18707();
    mem_17010.mem = futhark_mc_param_struct_18703_->free_mem_17010;
    mem_17010.size = 0;
    mem_17010.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18720 futhark_mc_mem_struct_18720_;
    uniform int err = futhark_mc_inner_ispc_18721(start, end, futhark_mc_param_struct_18703_, &futhark_mc_mem_struct_18720_);
    
    
  cleanup:
    { }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18725(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18691 *uniform args, uniform int iterations);
struct futhark_mc_mem_struct_18727 {
    varying struct memblock *uniform mem_17010;
};
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18729();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18730();
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18731();
static unmasked inline uniform int futhark_mc_inner_ispc_18728(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18685 *uniform futhark_mc_param_struct_18685_, uniform struct futhark_mc_mem_struct_18727 *uniform futhark_mc_mem_struct_18727_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18685_->ctx;
    uniform int64_t nz2080U_9823 = futhark_mc_param_struct_18685_->free_nz2080U_9823;
    uniform int64_t pz2081U_9824 = futhark_mc_param_struct_18685_->free_pz2081U_9824;
    uniform int64_t mz2082U_9825 = futhark_mc_param_struct_18685_->free_mz2082U_9825;
    uniform struct memblock xss_mem_17006;
    
    xss_mem_17006.desc = futhark_mc_strlit_shim_18729();
    xss_mem_17006.mem = futhark_mc_param_struct_18685_->free_xss_mem_17006;
    xss_mem_17006.size = 0;
    xss_mem_17006.references = NULL;
    
    uniform struct memblock yss_mem_17007;
    
    yss_mem_17007.desc = futhark_mc_strlit_shim_18730();
    yss_mem_17007.mem = futhark_mc_param_struct_18685_->free_yss_mem_17007;
    yss_mem_17007.size = 0;
    yss_mem_17007.references = NULL;
    
    uniform int64_t bytes_17009 = futhark_mc_param_struct_18685_->free_bytes_17009;
    uniform struct memblock mem_17027;
    
    mem_17027.desc = futhark_mc_strlit_shim_18731();
    mem_17027.mem = futhark_mc_param_struct_18685_->free_mem_17027;
    mem_17027.size = 0;
    mem_17027.references = NULL;
    
    struct memblock mem_17010 = *futhark_mc_mem_struct_18727_->mem_17010;
    uniform int err = 0;
    uniform int64_t start_17185;
    uniform int64_t end_17186;
    
    start_17185 = start;
    end_17186 = end;
    
    uniform int64_t n_17187 = end_17186 - start_17185;
    
    if (memblock_alloc(ctx, &mem_17010, bytes_17009, futhark_mc_strlit_shim_18690()))
        unmasked { return 1; }
    for (uniform int64_t i = 0; i < (start_17185 + n_17187 - start_17185) / programCount; i++) {
        int64_t SegMap_i_17188 = start_17185 + programIndex + i * programCount;
        uniform int64_t slice_17189 = nz2080U_9823;
        int64_t gtid_15934 = SegMap_i_17188;
        int64_t remnant_17190 = SegMap_i_17188 - gtid_15934;
        uniform int64_t flat_tid_17176 = (int64_t) 0;
        uniform int64_t flat_tid_17165 = (int64_t) 0;
        struct futhark_mc_task_18691 futhark_mc_task_18691_;
        
        futhark_mc_task_18691_.ctx = ctx;
        futhark_mc_task_18691_.free_pz2081U_9824 = pz2081U_9824;
        futhark_mc_task_18691_.free_mz2082U_9825 = mz2082U_9825;
        futhark_mc_task_18691_.free_gtid_15934 = gtid_15934;
        futhark_mc_task_18691_.free_xss_mem_17006 = xss_mem_17006.mem;
        futhark_mc_task_18691_.free_yss_mem_17007 = yss_mem_17007.mem;
        futhark_mc_task_18691_.free_mem_17010 = mem_17010.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18691 aos_18726[programCount];
        
        aos_18726[programIndex] = futhark_mc_task_18691_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18725(ctx, &aos_18726[i], extract(mz2082U_9825, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18725(ctx, &futhark_mc_task_18691_, mz2082U_9825);
        if (err != 0)
            goto cleanup;
        #endif
        if (mz2082U_9825 * (int64_t) 4 > 0)
            memmove(mem_17027.mem + gtid_15934 * mz2082U_9825 * (int64_t) 4, mem_17010.mem + (int64_t) 0, mz2082U_9825 * (int64_t) 4);
    }
    if (programIndex < (start_17185 + n_17187 - start_17185) % programCount) {
        int64_t SegMap_i_17188 = start_17185 + programIndex + (start_17185 + n_17187 - start_17185) / programCount * programCount;
        uniform int64_t slice_17189 = nz2080U_9823;
        int64_t gtid_15934 = SegMap_i_17188;
        int64_t remnant_17190 = SegMap_i_17188 - gtid_15934;
        uniform int64_t flat_tid_17176 = (int64_t) 0;
        uniform int64_t flat_tid_17165 = (int64_t) 0;
        struct futhark_mc_task_18691 futhark_mc_task_18691_;
        
        futhark_mc_task_18691_.ctx = ctx;
        futhark_mc_task_18691_.free_pz2081U_9824 = pz2081U_9824;
        futhark_mc_task_18691_.free_mz2082U_9825 = mz2082U_9825;
        futhark_mc_task_18691_.free_gtid_15934 = gtid_15934;
        futhark_mc_task_18691_.free_xss_mem_17006 = xss_mem_17006.mem;
        futhark_mc_task_18691_.free_yss_mem_17007 = yss_mem_17007.mem;
        futhark_mc_task_18691_.free_mem_17010 = mem_17010.mem;
        #if ISPC
        
        uniform struct futhark_mc_task_18691 aos_18726[programCount];
        
        aos_18726[programIndex] = futhark_mc_task_18691_;
        foreach_active (i)
        if (err == 0)
            err = futhark_mc_schedule_shim_18725(ctx, &aos_18726[i], extract(mz2082U_9825, i));
        if (err != 0)
            unmasked { return err; }
        #else
        err = futhark_mc_schedule_shim_18725(ctx, &futhark_mc_task_18691_, mz2082U_9825);
        if (err != 0)
            goto cleanup;
        #endif
        if (mz2082U_9825 * (int64_t) 4 > 0)
            memmove(mem_17027.mem + gtid_15934 * mz2082U_9825 * (int64_t) 4, mem_17010.mem + (int64_t) 0, mz2082U_9825 * (int64_t) 4);
    }
    *futhark_mc_mem_struct_18727_->mem_17010 = mem_17010;
    return err;
}
extern "C" unmasked uniform char *uniform futhark_mc_strlit_shim_18732();
export uniform int futhark_mc_loop_ispc_18686(uniform int64_t start, uniform int64_t end, uniform struct futhark_mc_param_struct_18685 *uniform futhark_mc_param_struct_18685_)
{
    uniform struct futhark_context *uniform ctx = futhark_mc_param_struct_18685_->ctx;
    uniform int64_t nz2080U_9823 = futhark_mc_param_struct_18685_->free_nz2080U_9823;
    uniform int64_t pz2081U_9824 = futhark_mc_param_struct_18685_->free_pz2081U_9824;
    uniform int64_t mz2082U_9825 = futhark_mc_param_struct_18685_->free_mz2082U_9825;
    uniform struct memblock xss_mem_17006;
    
    xss_mem_17006.desc = futhark_mc_strlit_shim_18687();
    xss_mem_17006.mem = futhark_mc_param_struct_18685_->free_xss_mem_17006;
    xss_mem_17006.size = 0;
    xss_mem_17006.references = NULL;
    
    uniform struct memblock yss_mem_17007;
    
    yss_mem_17007.desc = futhark_mc_strlit_shim_18688();
    yss_mem_17007.mem = futhark_mc_param_struct_18685_->free_yss_mem_17007;
    yss_mem_17007.size = 0;
    yss_mem_17007.references = NULL;
    
    uniform int64_t bytes_17009 = futhark_mc_param_struct_18685_->free_bytes_17009;
    uniform struct memblock mem_17027;
    
    mem_17027.desc = futhark_mc_strlit_shim_18689();
    mem_17027.mem = futhark_mc_param_struct_18685_->free_mem_17027;
    mem_17027.size = 0;
    mem_17027.references = NULL;
    
    struct memblock mem_17010;
    
    mem_17010.references = NULL;
    
    uniform struct futhark_mc_mem_struct_18727 futhark_mc_mem_struct_18727_;
    
    futhark_mc_mem_struct_18727_.mem_17010 = &mem_17010;
    
    uniform int err = futhark_mc_inner_ispc_18728(start, end, futhark_mc_param_struct_18685_, &futhark_mc_mem_struct_18727_);
    
    mem_17010 = *futhark_mc_mem_struct_18727_.mem_17010;
    
  cleanup:
    {
        if (memblock_unref(ctx, &mem_17010, futhark_mc_strlit_shim_18732()) != 0)
            unmasked { return 1; }
    }
    return err;
}
extern "C" unmasked uniform int futhark_mc_schedule_shim_18733(uniform struct futhark_context *uniform ctx, uniform struct futhark_mc_task_18665 *uniform args, uniform int iterations);
