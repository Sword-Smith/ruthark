-- library imports
module array_module = import "./lib/github.com/diku-dk/containers/array"
module merge_sort_module = import "./lib/github.com/diku-dk/sorts/merge_sort"

let merge_sort = merge_sort_module.merge_sort
let dedup = array_module.dedup
let hash_i64 = array_module.hash_i64

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

-- Convert unsigned 64-bit integer to an array of 8 bytes (little-endian)
def u64_to_bytes_le (x: u64): [8]u8 =
  let byte0 = u8.u64(x >> 0)
  let byte1 = u8.u64(x >> 8)
  let byte2 = u8.u64(x >> 16)
  let byte3 = u8.u64(x >> 24)
  let byte4 = u8.u64(x >> 32)
  let byte5 = u8.u64(x >> 40)
  let byte6 = u8.u64(x >> 48)
  let byte7 = u8.u64(x >> 56)
  in [byte0, byte1, byte2, byte3, byte4, byte5, byte6, byte7]

-- Convert an array of 8 bytes (little-endian) to a 64-bit unsigned integer 
def bytes_le_to_u64 (x: [8]u8 ): u64=
  let byte0 = u64.u8(x[0]) << 0
  let byte1 = u64.u8(x[1]) << 8
  let byte2 = u64.u8(x[2]) << 16
  let byte3 = u64.u8(x[3]) << 24
  let byte4 = u64.u8(x[4]) << 32
  let byte5 = u64.u8(x[5]) << 40
  let byte6 = u64.u8(x[6]) << 48
  let byte7 = u64.u8(x[7]) << 56
  in byte0 + byte1 + byte2 + byte3 + byte4 + byte5 + byte6 + byte7

-- next multiple of m greater than or equal to x
let next_multiple_of (x: i64) (m: i64) : i64 =
  if m <= 0 then
    0
  else if x >= 0 then
    ((x + m - 1) // m) * m
  else
    let base_multiple = ((-x + m - 1) // m) * m
    in -base_multiple

def next_power_of_two_u64 (x : u64) : u64 =
  if x <= 1 then 1 
  else 
    let x = x - 1 
    -- modify so that all bits right of mbs are set
    let x = x | (x >> 1)
    let x = x | (x >> 2)
    let x = x | (x >> 4)
    let x = x | (x >> 8)
    let x = x | (x >> 16)
    let x = x | (x >> 32) 
    -- roll over to the next power of two 
    in x + 1

def next_power_of_two_i64 (x : i64) : i64 =
  if x <= 1 then 1 
  else 
    let x = x - 1 
    -- modify so that all bits right of mbs are set
    let x = x | (x >> 1)
    let x = x | (x >> 2)
    let x = x | (x >> 4)
    let x = x | (x >> 8)
    let x = x | (x >> 16)
    let x = x | (x >> 32) 
    -- roll over to the next power of two 
    in x + 1

-- handles umderflow only
let saturating_sub_u64 (x: u64) (y: u64) : u64 =
  if x < y then 0u64 else x - y



-- performs: arrayA - arrayB = { x | x in arrayA and x not in arrayB }
-- Requires arrays be sorted and deduped
def sorted_deduped_set_difference_i64 [n] [m] 
  (sortedA: [n]i64)  (sortedB: [m]i64)
  : []i64 =

  let init_res: [0]i64 = []
  let (result, _, _) =
    loop (res, i, j) = (init_res, 0, 0) while i < (length sortedA) do -- && j < (length sortedB) do
      -- subtrahend empty, rest in result
      if j >= length sortedB then 
        (concat res [sortedA[i]], i+1, j)
      -- not in B
      else if sortedA[i] < sortedB[j] then
        (concat res [sortedA[i]], i + 1, j)
      -- in B
      else if sortedA[i] == sortedB[j] then
        (res, i+1, j)
      -- in B
      else  
        (res, i, j+1)
  in result


-- performs: arrayA - arrayB = { x | x in arrayA and x not in arrayB }
-- Does not require sets to be sorted. Can handle duplicates
def unsorted_set_difference_i64 [n] [m] (arrayA: [n]i64) (arrayB: [m]i64) : []i64 = 
  -- dedup arrays
  let deduplicatedA = dedup hash_i64 (==) arrayA
  let deduplicatedB = dedup hash_i64 (==) arrayB
  -- sort
  let sortedA = merge_sort (<=) deduplicatedA
  let sortedB = merge_sort (<=) deduplicatedB
  -- set diff
  in sorted_deduped_set_difference_i64 sortedA sortedB

-- ==
-- entry: test_saturating_sub
-- input {}
-- output { true }
entry test_saturating_sub: bool =
    saturating_sub_u64 0u64 1u64 == 0u64 &&
    saturating_sub_u64 50 (0-1) == 0 

-- == 
-- entry: test_next_power_of_two_i64
-- input  { 0i64 }
-- output { 1i64 }
-- input  { 1i64 }
-- output { 1i64 }
-- input  { 2i64 }
-- output { 2i64 }
-- input  { 3i64 }
-- output { 4i64 }
-- input  { 62i64 }
-- output { 64i64 }
entry test_next_power_of_two_i64 (x: i64): i64 =
  next_power_of_two_i64 x

-- == 
-- entry: test_next_power_of_two_u64
-- input  { 0u64 }
-- output { 1u64 }
-- input  { 1u64 }
-- output { 1u64 }
-- input  { 2u64 }
-- output { 2u64 }
-- input  { 3u64 }
-- output { 4u64 }
-- input  { 62u64 }
-- output { 64u64 }
entry test_next_power_of_two_u64 (x: u64): u64 =
  next_power_of_two_u64 x
  
-- ==
-- entry: test_u64_to_bytes_le
-- input  { 0u64 }
-- output { [0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
-- input  { 89203u64 }
-- output { [115u8, 92u8, 1u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
-- input  { 9303949u64 }
-- output { [141u8, 247u8, 141u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
entry test_u64_to_bytes_le (x: u64): [8]u8 =
  u64_to_bytes_le(x)

-- ==
-- entry: test_bytes_to_u64
-- input  { [0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
-- output { 0u64 }
-- input  { [115u8, 92u8, 1u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
-- output { 89203u64 }
-- input  { [141u8, 247u8, 141u8, 0u8, 0u8, 0u8, 0u8, 0u8] }
-- output { 9303949u64 }
entry test_bytes_to_u64 (x: [8]u8): u64 =
  bytes_le_to_u64(x)

-- ==
-- entry: test_next_multiple_of
-- input  { 0i64 1i64 }
-- output { 0i64 }
-- input  { 1i64 1i64 }
-- output { 1i64 }
-- input  { 7i64 4i64 }
-- output { 8i64 }
-- input  { 7i64 0i64 }
-- output { 0i64 }
entry test_next_multiple_of (x: i64) (m: i64): i64 =
  next_multiple_of x m

-- == 
-- entry: sorted_deduped_set_difference_i64_test
-- input {[1i64, 3i64, 8i64, 9i64, 11i64] [1i64, 9i64] }
-- output {[3i64, 8i64, 11i64] }
entry sorted_deduped_set_difference_i64_test (lhs: []i64) (rhs: []i64) : []i64 =
  sorted_deduped_set_difference_i64 lhs rhs

-- == 
-- entry: sorted_deduped_set_diff_with_larger_subtrahend_produces_null_set
-- input { [1i64] [1i64, 3i64, 5i64]}
-- output { true }
entry sorted_deduped_set_diff_with_larger_subtrahend_produces_null_set (lhs: []i64) (rhs: []i64) : bool = 
 length (sorted_deduped_set_difference_i64 lhs rhs) == 0

-- == 
-- entry: unsorted_set_difference_i64_test
-- input { [1i64, 2i64, 3i64, 4i64, 5i64, 6i64, 7i64, 8i64, 9i64, 10i64] [1i64, 2i64, 4i64, 5i64, 7i64, 8i64, 9i64, 10i64] } 
-- output {[3i64, 6i64]}
-- input { [8i64, 7i64, 2i64, 6i64, 8i64] [7i64, 8i64]}
-- output { [2i64, 6i64] }
entry unsorted_set_difference_i64_test (lhs: []i64) (rhs: []i64) : []i64 =
  unsorted_set_difference_i64 lhs rhs
