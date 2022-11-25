-- expected input array before each iteration:
-- 1  2  3  4  5  6  7  8
-- 3  2  7  4 11  6 15  8
--10  2  7  4 26  6 15  8
--36  2  7  4 26  6 15  8

def aliasing_fun [n]
  (level: *[n]i64)
  :i64
  =
  let (level, _idx_count, _spacing) =
    loop (level, idx_count, spacing) = (level, n//2, 2) while 0 < idx_count do
      let left_sibling_idxs:  [idx_count]i64 = iota idx_count |> map (*spacing)
      let right_sibling_idxs: [idx_count]i64 = map (+spacing//2) left_sibling_idxs
      let next_level_values:  [idx_count]i64 =
        map2 (\x y -> level[x] + level[y]) left_sibling_idxs right_sibling_idxs
      let level = scatter level left_sibling_idxs next_level_values
       in (level, idx_count//2, spacing*2)
  let root = level[0]
   in root


-- Test test_aliasing_fun
-- ==
-- entry: test_aliasing_fun
-- input {}
-- output { true }
entry test_aliasing_fun =
  let n = 8
  let input = iota n |> map (+1) -- n first natural numbers
   in n*(n+1)//2 == aliasing_fun input
