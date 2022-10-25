-- Test
-- ==
-- input { 42 }
-- output { 42 }

entry main (res : i32) : i32 =
-- Use this shadowing pattern to test multiple assertions which may or may note
-- depend on the input argument or size types.
 let res = assert (res > 0) res
 let res = assert (1 > 0) res
 let res = assert (2 > 0) res
 let res = assert (100 > res) res
  in res
