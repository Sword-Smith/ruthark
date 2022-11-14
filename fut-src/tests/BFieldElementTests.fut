import "../BFieldElement"

-- Tests from Rust documentation:
-- https://doc.rust-lang.org/std/primitive.u64.html#method.overflowing_add
-- u64.highest = 18446744073709551615u64


-- Test the `overflowing_sub` function.
--
-- assert_eq!(5u64.overflowing_sub(2), (3, false));
-- assert_eq!(0u64.overflowing_sub(1), (u64::MAX, true));
-- ==
-- entry: overflowing_sub_test
-- input { 5u64 2u64 }
-- output { 3u64 false }
-- input { 0u64 1u64 }
-- output { 18446744073709551615u64 true }

entry overflowing_sub_test (minuend: u64) (subtrahend: u64) : (u64, bool) =
  overflowing_sub minuend subtrahend


-- Test the `wrapping_sub` function.
--
-- assert_eq!(100u64.wrapping_sub(100), 0);
-- assert_eq!(100u64.wrapping_sub(u64::MAX), 101);
-- ==
-- entry: wrapping_sub_test
-- input { 100u64 100u64 }
-- output { 0u64 }
-- input { 100u64 18446744073709551615u64 }
-- output { 101u64 }

entry wrapping_sub_test (minuend: u64) (subtrahend: u64) : u64 =
  wrapping_sub minuend subtrahend


-- Test the `overflowing_add` function.
--
-- assert_eq!(5u64.overflowing_add(2), (7, false));
-- assert_eq!(u64::MAX.overflowing_add(1), (0, true));
-- ==
-- entry: overflowing_add_test
-- input { 5u64 2u64 }
-- output { 7u64 false }
-- input { 18446744073709551615u64 1u64 }
-- output { 0u64 true }

entry overflowing_add_test (augend: u64) (addend: u64) : (u64, bool) =
  overflowing_add augend addend


-- Test the `wrapping_add` function.
--
-- assert_eq!(200u64.wrapping_add(55), 255);
-- assert_eq!(200u64.wrapping_add(u32::MAX), 199);
-- ==
-- entry: wrapping_add_test
-- input { 200u64 55u64 }
-- output { 255u64 }
-- input { 200u64 18446744073709551615u64 }
-- output { 199u64 }

entry wrapping_add_test (augend: u64) (addend: u64) : u64 =
  wrapping_add augend addend


-- The following test are original

-- Test u64_mul
-- ==
-- entry: u64_mul_test
-- input  { 1u64 1u64 }
-- output { 0u64 1u64 }
-- input  { 999u64 999u64 }
-- output { 0u64 998001u64 }
-- input  { 0x1ffffff23ffffff4u64 0x5888888678888889u64 }
-- output { 0xb11110c0dbbbbd4u64 0x44445699999994u64  }
-- input  { 0x0u64 0xffffffffffffffffu64 }
-- output { 0x0u64 0x0u64 }
-- input  { 0xffffffffffffffffu64 0x0u64 }
-- output { 0x0u64 0x0u64 }
-- input  { 0xf000000000000000u64 0xf000000000000000u64 }
-- output { 0xe100000000000000u64 0x0u64 }
-- input  { 0xffffffffffffffffu64 0xffffffffffffffffu64 }
-- output { 0xfffffffffffffffeu64 0x1u64 }
entry u64_mul_test (a: u64) (b: u64) : (u64, u64) =
  u64_mul a b


-- Test multest
-- ==
-- entry: thorkil_mul_test
-- input  { 0x200000000000u64 0x200000000000u64 }
-- output { 288230376084602880u64 }
entry thorkil_mul_test (a: u64) (b: u64) : u64 =
 redmod (u64_mul a b)


-- Test powmod
-- ==
-- entry: test_powmod
-- input  { 2 }
-- output { 2 }
-- input  { 4 }
-- output { 4 }
-- input  { 7 }
-- output { 7 }
-- input  { 2135213 }
-- output { 2135213 }
entry test_powmod (input : i32) : i32 =
  let alpha = U64 7u64
  let alphainv = U64 10540996611094048183u64
  let tmp = powmod (I32 input) alpha
  let tmp2 = powmod tmp alphainv
   in i32.u64 tmp2

