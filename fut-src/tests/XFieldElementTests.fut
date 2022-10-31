import "../XFieldElement"

-- Test minus
-- ==
-- entry: minus_test
-- input { -42 }
-- output { true }
-- input { 42 }
-- output { true }
-- input { -1 }
-- output { true }
-- input { 0 }
-- output { true }
-- input { -123312 }
-- output { true }
-- input { -0 }
-- output { true }
entry minus_test (arg : i32) : bool =
  eq (from_i32 arg) (neg <| from_i32 (-arg))


-- THIS IS WIP

-- Test mul
-- ==
-- entry: test_mod_pow_u8
-- input { 1 1 }
-- output { [1, 0, 0] }
-- input { 0 1 }
-- output { [0, 0, 0] }
-- input { 1 0 }
-- output { [1, 0, 0] }
-- input { 0 0 }
-- output { [1, 0, 0] }
-- input { 0 2 }
-- output { [0, 0, 0] }
-- input { 3 3 }
-- output { [27, 0, 0] }
entry test_mod_pow_u8 (xfe_raw : i32) (exp_raw : i32) : [3]i32 =
  let xfe = from_i32 xfe_raw
  let exp = u8.i32 exp_raw
  let res = mod_pow_u8 xfe exp
  let arr = tripple2array res
  in map i32.u64 arr

-- u64.highest = 18446744073709551615u64

-- Test mul
-- ==
-- entry: mul_test_array
-- input { [2u64, 3u64, 5u64] [7u64, 11u64, 13u64]}
-- output { [18446744069414584241u64, 72u64, 159u64] }
-- input { [0u64, 0u64, 0u64] [0u64, 0u64, 0u64] }
-- output { [0u64, 0u64, 0u64] }
-- input { [1u64, 0u64, 0u64] [1u64, 0u64, 0u64] }
-- output { [1u64, 0u64, 0u64] }
-- input { [0u64, 0u64, 0u64] [1u64, 0u64, 0u64] }
-- output { [0u64, 0u64, 0u64] }
-- input { [1u64, 0u64, 0u64] [0u64, 0u64, 0u64] }
-- output { [0u64, 0u64, 0u64] }
-- input { [18446744073709551615u64, 18446744073709551615u64, 18446744073709551615u64]
--         [18446744073709551615u64, 18446744073709551615u64, 18446744073709551615u64]
-- }
-- output { [12884901885u64, 18446744030759878666u64, 18446744017874976781u64] }
-- input { [0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64]
--         [0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64]
-- }
-- output { [12884901885u64, 18446744030759878666u64, 18446744017874976781u64] }
entry mul_test_array (a_coeffs: [3]u64) (b_coeffs: [3]u64) : [3]u64 =
  let a = new_u64(a_coeffs)
  let b = new_u64(b_coeffs)
  in tripple2array (mul a b)
