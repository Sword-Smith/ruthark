-- Constant-time log2 (depending on architecture, I guess)
def ilog2 (n: i64) : i64 = i64.i32 (63 - i64.clz n)

def is_power_of_2 (n: i64) : bool = n > 0 && ((n - 1) & n == 0)

def eq_arr 'a [n] [m] (eq: a -> a -> bool) (a: [n]a) (b: [m]a) : bool =
  n == m && and (map2 eq a (b :> [n]a))

def eq_arr_2d 'a [n1] [n2] [m1] [m2]
              (eq: a -> a -> bool) (a: [n1][n2]a) (b: [m1][m2]a) : bool =
  n1 == m1 && n2 == m2 && eq_arr (eq_arr eq) a (b :> [n1][n2]a)

def gather 'a (xs: []a) (is: []i64): []a =
  map (\i -> xs[i]) is

-- Convert a 64-bit integer to an array of 8 bytes (little-endian)
def i64_to_bytes_le (x: i64): [8]u8 =
  let byte0 = u8.i64(x >> 0)
  let byte1 = u8.i64(x >> 8)
  let byte2 = u8.i64(x >> 16)
  let byte3 = u8.i64(x >> 24)
  let byte4 = u8.i64(x >> 32)
  let byte5 = u8.i64(x >> 40)
  let byte6 = u8.i64(x >> 48)
  let byte7 = u8.i64(x >> 56)
  in [byte0, byte1, byte2, byte3, byte4, byte5, byte6, byte7]

-- ==
-- entry: test_i64_to_bytes_le
-- input  { 0i64 }
-- output { [0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
-- input  { 89203i64 }
-- output { [115u8, 92u8, 1u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
-- input  { 9303949i64 }
-- output { [141u8, 247u8, 141u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
entry test_i64_to_bytes_le (x: i64): [8]u8 =
  i64_to_bytes_le(x)