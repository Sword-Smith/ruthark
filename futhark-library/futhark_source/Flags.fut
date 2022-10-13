def seglen_to_indices [n] (reps:[n]i64) : [n]i64 =
  let cumsum = scan (+) 0 reps
  in  map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)

-- Test idxssegs
-- ==
-- entry: test_seglen_to_indices
-- input { [2, 3, 1, 1] }
-- output { [0, 2, 5, 6] }
-- input { [2, 1, 3] }
-- output { [0, 2, 3] }
-- input { [1, 2, 3] }
-- output { [0, 1, 3] }
-- input { [1, 2] }
-- output { [0, 1] }
entry test_seglen_to_indices reps =
  let reps_i64 = map i64.i32 reps
  let res = seglen_to_indices reps_i64
  in  map i32.i64 res

def idxs_to_flags [n] (reps:[n]i64) : ?[N].[N]bool =
  let cumsum = scan (+) 0 reps
  let idxs = map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)
  let N = reduce (+) 0 reps
  let canvas = replicate N false
  let vals = map (>0) (iota n)
  in  scatter canvas idxs vals

-- Test idxs
-- ==
-- entry: test_idxs_to_flags
-- input { [2, 3, 1, 1] }
-- output { [false, false, true, false, false, true, true ] }
-- input { [2, 1, 3] }
-- output { [false, false, true, true, false, false ] }
-- input { [1, 2, 3] }
-- output { [false, true, false, true, false, false ] }
-- input { [1, 2] }
-- output { [false, true, false ] }
entry test_idxs_to_flags reps =
  let reps_i64 = map i64.i32 reps
  in  idxs_to_flags reps_i64




