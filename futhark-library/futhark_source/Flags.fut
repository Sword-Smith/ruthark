def segments_start_indices_i32 [n] (reps:[n]i32) : [n]i32 =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let cumsum = scan (+) 0 reps
   in map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)

def segments_start_indices_i64 [n] (reps:[n]i64) : [n]i64 =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let cumsum = scan (+) 0 reps
   in map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)

-- Test idxssegs
-- ==
-- entry: test_segment_start_indices
-- input { [2, 3, 1, 1] }
-- output { [0, 2, 5, 6] }
-- input { [2, 1, 3] }
-- output { [0, 2, 3] }
-- input { [1, 2, 3] }
-- output { [0, 1, 3] }
-- input { [1, 2] }
-- output { [0, 1] }
entry test_segment_start_indices reps =
  let reps_i64 = map i64.i32 reps
  let res = segments_start_indices_i64 reps_i64
   in map i32.i64 res

def segments_end_indices_i32 [n] (reps:[n]i32) : [n]i32 =
  -- assert no zero length segments
  let reps = assert (n > 0) reps
  let tmp = scan (+) (0) reps
   in map (\i -> i-1) tmp

def segments_end_indices_i64 [n] (reps:[n]i64) : [n]i64 =
  -- assert no zero length segments
  let reps = assert (n > 0) reps
  let tmp = scan (+) (0) reps
   in map (\i -> i-1) tmp

-- Test test_end
-- ==
-- entry: test_segment_end_indices
-- input { [2, 3, 1, 1] }
-- output { [1, 4, 5, 6] }
-- input { [2, 1, 3] }
-- output { [1, 2, 5] }
-- input { [1, 2, 3] }
-- output { [0, 2, 5] }
-- input { [1, 2] }
-- output { [0, 2] }
entry test_segment_end_indices reps = segments_end_indices_i32 reps

def gather_i32 [p] [r] (idxs : [p]i32) (vals : [r]i32) : [p]i32 =
  map (\i -> vals[i]) idxs

def gather_i64 [p] [r] (idxs : [p]i64) (vals : [r]i64) : [p]i64 =
  map (\i -> vals[i]) idxs

def gather_sums_i32 [n] [r] (reps :[n]i32) (segsum : [r]i32) : [n]i32 =
  let idxs = segments_end_indices_i32 reps
   in gather_i32 idxs segsum

def gather_sums_i64 [n] [r] (reps : [n]i64) (segsum : [r]i64) : [n]i64 =
  let idxs = segments_end_indices_i64 reps
   in gather_i64 idxs segsum

def idxs_to_flags_i32 [n] (reps:[n]i32) : ?[l].[l]bool =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let cumsum = scan (+) 0 reps
  let idxs = map i64.i32 <| map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)
  let length = i64.i32 <| reduce (+) 0 reps
  let canvas = replicate length false
  let vals = map (>0) (iota n)
   in scatter canvas idxs vals

def idxs_to_flags_i64 [n] (reps:[n]i64) : ?[l].[l]bool =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let cumsum = scan (+) 0 reps
  let idxs = map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)
  let length = reduce (+) 0 reps
  let canvas = replicate length false
  let vals = map (>0) (iota n)
   in scatter canvas idxs vals

-- Same as above, but `rv[0] == true`
def idxs_to_flags_i64_2 [n] (reps:[n]i64) : ?[length].[length]bool =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let cumsum        = scan (+) 0 reps
  let total_length  = cumsum[n-1]
  let segment_idxs  = map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)
  let canvas        = replicate total_length false
  let start_markers = replicate n true
   in scatter canvas segment_idxs start_markers

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
   in idxs_to_flags_i64 reps_i64

-- Test idxs
-- ==
-- entry: test_idxs_to_flags_2
-- input { [2, 3, 1, 1] }
-- output { [true, false, true, false, false, true, true ] }
-- input { [2, 1, 3] }
-- output { [true, false, true, true, false, false ] }
-- input { [1, 2, 3] }
-- output { [true, true, false, true, false, false ] }
-- input { [1, 2] }
-- output { [true, true, false ] }
entry test_idxs_to_flags_2 reps =
  let reps_i64 = map i64.i32 reps
   in idxs_to_flags_i64_2 reps_i64


-- Segmented scan with integer addition
def segmented_scan_add [n] (flags:[n]bool) (vals:[n]i32) : [n]i32 =
  let pairs = scan ( \(v1,f1) (v2,f2) ->
                       let f = f1 || f2
                       let v = if f2 then v2 else v1+v2
                       in (v,f) ) (0,false) (zip vals flags)
  let (res,_) = unzip pairs
   in res

-- Test segsum
-- ==
-- entry: test_segsum
-- input { [2, 1, 3]
--         [0, 1, 2, 3, 4, 5]
-- }
-- output { [0,1,2,3,7,12] }
entry test_segsum [n] [l] (reps : [n]i32) (vals : [l]i32) =
  let flags = idxs_to_flags_i32 reps :> [l]bool
  let segsum = segmented_scan_add flags vals
   in segsum

-- Test segsum1
-- ==
-- entry: test_gather_segsums1
-- input { [2, 1, 3]
--         [0, 1, 2, 3, 4, 5]
-- }
-- output { [false,false,true,true,false,false] }
entry test_gather_segsums1 [n] [l] (reps : [n]i32) (_vals : [l]i32) : [l]bool =
  let flags = idxs_to_flags_i32 reps :> [l]bool
  in flags

-- Test segsum2
-- ==
-- entry: test_gather_segsums2
-- input { [2, 1, 3]
--         [0, 1, 2, 3, 4, 5]
-- }
-- output { [1,2,5] }
entry test_gather_segsums2 [n] [l] (reps : [n]i32) (_vals : [l]i32) : [n]i32 =
  let idxs = segments_end_indices_i32 reps
   in idxs

-- Test segsum3
-- ==
-- entry: test_gather_segsums3
-- input { [2, 1, 3]
--         [0, 1, 2, 3, 4, 5]
-- }
-- output { [0,1,2,3,7,12] }
entry test_gather_segsums3 [n] [l] (reps : [n]i32) (vals : [l]i32) : [l]i32 =
  let flags = idxs_to_flags_i32 reps :> [l]bool
  let segsum = segmented_scan_add flags vals
  in segsum

-- Test segsum4
-- ==
-- entry: test_gather_segsums4
-- input { [2, 1, 3]
--         [0, 1, 2, 3, 4, 5]
-- }
-- output { [1,2,12] }
entry test_gather_segsums4 [n] [l] (reps : [n]i32) (vals : [l]i32) : [n]i32 =
  let flags = idxs_to_flags_i32 reps :> [l]bool
  let segsum = segmented_scan_add flags vals
  let idxs = segments_end_indices_i32 reps
   in map (\i -> segsum[i]) idxs -- ACTUAL: [0,0,2]

-- Test segsum5
-- ==
-- entry: test_gather_segsums5
-- input { [2, 1, 3]
--         [0, 1, 2, 3, 4, 5]
-- }
-- output { [1,2,12] }
entry test_gather_segsums5 [n] [l] (_reps : [n]i32) (_vals : [l]i32) : [n]i32 =
  let _flags = [false,false,true,true,false,false]
  let segsum = [0,1,2,3,7,12]
  let idxs = [1,2,5] :> [n]i32
   in map (\i -> segsum[i]) idxs
