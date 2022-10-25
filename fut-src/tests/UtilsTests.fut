import "../Utils"
import "../SegmentedScanAdd"
module BFieldElement = import "../BFieldElement"
module XFieldElement = import "../XFieldElement"
type BFieldElement = BFieldElement.BFieldElement
type XFieldElement = XFieldElement.XFieldElement

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

-- DISABLED Test test_idxs_to_flags_old
-- entry: test_idxs_to_flags
-- input  { [1i64, 2i64, 3i64] }
-- output {
-- [ true,
--   false,
--   true,
--   false,
--   false,
--   true ]
-- }
-- DISABLED Test test_idxs_to_flags2
-- entry: idxs_to_flags
-- input  { [1i64, 2i64, 3i64] }
-- output {
-- [ false, false, false, true,
--   false, false, false, false,
--   false, false, false, true,
--   false, false, false, false,
--   false, false, false, false,
--   false, false, false, true ]
-- }



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
