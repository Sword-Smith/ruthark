def idxs_to_flags [n] (reps:[n]i64) : ?[N].[N]bool =
  let cumsum = scan (+) 0 reps
  let idxs = map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)
  let N = reduce (+) 0 reps
  let canvas = replicate N false
  let vals = map (>0) (iota n)
  in scatter canvas idxs vals

-- Test idxs
-- ==
-- entry: test_idxs_to_flags
-- input { [2, 3, 1, 1] }
-- output { [false, false, true, false, false, true, true ] }
-- input { [2, 1, 3] }
-- output { [false, false, true, true, false, false ] }
-- input { [1, 2, 3] }
-- output { [false, true, false, true, false, false ] }
entry test_idxs_to_flags reps =
  let reps_i64 = map i64.i32 reps
  in idxs_to_flags reps_i64
