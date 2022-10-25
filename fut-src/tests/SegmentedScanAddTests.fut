import "../Utils"
import "../SegmentedScanAdd"
module BFieldElement = import "../BFieldElement"
module XFieldElement = import "../XFieldElement"
type BFieldElement = BFieldElement.BFieldElement
type XFieldElement = XFieldElement.XFieldElement

-- Terms Exponent Matrix
-- Dimensions: qs_sum x m = 6 x 3
-- qs[] = { 1, 2, 3 }
--
-- p0:
--     2  3  5
-- p1:
--     7 11 13
--    17 19 23
-- p3:
--     2  3  5
--     7 11 13
--    17 19 23
--

-- Evaluation Points
-- Dimensions: n x m = 4 x 3
--
--  1 54  3
-- 44 23 42
-- 10 11 13
--  7  4  0


-- Expected result
-- Dimensions: qs_sum x n = 6 x 4
--
-- 1 1 1 1
-- 1 1 1 1
-- 1 1 1 1
-- 1 1 1 1
-- 1 1 1 1
-- 1 1 1 1

-- 4
-- 8
-- 12

-- Test test_eval_all_terms
-- ==
-- entry: test_eval_all_terms
-- input  { [ 1, 1 ]
--          [ [ 2, 7]
--          , [ 3, 5] ]
--          [ [ 0, 0]
--          , [ 1, 1]
--          , [ 2, 2] ]
-- }
-- output {
--       [ [  0, 0, 0 ]
--       , [  1, 0, 0 ]
--       , [  512, 0, 0 ]
--       , [  0, 0, 0 ]
--       , [  1, 0, 0 ]
--       , [  256, 0, 0 ] ]
-- }
entry test_eval_all_terms
  [n] [m] [t]
    (coefficients_i32 : [t]i32)
  (term_exp_mtx_i32 : [t][m]i32)
  (eval_points_mtx_i32 : [n][m]i32)
  : ?[tn].[tn][3]i32 =
  let coefficients = map XFieldElement.from_i32 coefficients_i32
  let term_exp_mtx = map2d u8.i32 term_exp_mtx_i32
  let eval_points_mtx = map2d XFieldElement.from_i32 eval_points_mtx_i32
  --let tn = t * n
  let evaluated_terms = eval_all_terms coefficients term_exp_mtx eval_points_mtx
   in map XFieldElement.tripple2array evaluated_terms |> map2d i32.u64


-- Test test_term_exp_matrix
-- ==
-- entry: test_term_exp_matrix
-- input  { [ 1, 1 ]
--          [ [ 2, 7]
--          , [ 3, 5] ]
--          [ [ 0, 0]
--          , [ 1, 1]
--          , [ 2, 2] ]
--          [ 3, 3 ]
-- }
-- output { [ [  513, 0, 0 ]
--        ,   [  257, 0, 0 ] ]
-- }
-- input  { [ 3, 2, 1 ]
--          [ [ 2, 7]
--          , [ 3, 5]
--          , [ 11, 13] ]
--          [ [ 0, 0]
--          , [ 1, 1]
--          , [ 2, 2] ]
--          [ 6, 3 ]
-- }
-- output { [ [      2053, 0, 0 ]
--          , [  16777217, 0, 0 ] ]
-- }
entry test_term_exp_matrix
  [n] [m] [t] [p]
  (coefficients_i32 : [t]i32)
  (term_exp_mtx_i32 : [t][m]i32)
  (eval_points_mtx_i32 : [n][m]i32)
  (qs_i32 : [p]i32)
  : [p][3]i32 =
  let coefficients = map XFieldElement.from_i32 coefficients_i32
  let term_exp_mtx = map2d u8.i32 term_exp_mtx_i32
  let eval_points_mtx = map2d XFieldElement.from_i32 eval_points_mtx_i32
  let qs = map i64.i32 qs_i32
  let evaluated_terms = eval_all_terms coefficients term_exp_mtx eval_points_mtx
  let tn = t * n
  let all_terms = evaluated_terms :> [tn]XFieldElement
  let segmented_sum = sum_terms_per_poly coefficients term_exp_mtx eval_points_mtx qs
  let sums_indices = Utils.segments_end_indices_i64 qs
  let res = Utils.gather sums_indices segmented_sum
   in map XFieldElement.tripple2array res |> map2d i32.u64


-- test_term_exp_matrix
--
-- entry: test_term_exp_matrix
-- input  { [ [ 2u8, 7u8]
--          , [ 3u8, 5u8] ]
--          [ false, true]
--          [ [ 2u64, 1u64]
--          , [ 1u64, 0u64] ]
-- }
-- output {
--       [ [ 28u64, 2u64 ]
--       , [ 40u64, 3u64 ]]
-- }
-- input  { [[ 2u8,  3u8,  5u8],
--            [ 7u8, 11u8, 13u8],
--            [17u8, 19u8, 23u8],
--            [ 2u8,  3u8,  5u8],
--            [ 7u8, 11u8, 13u8],
--            [17u8, 19u8, 23u8]]
--           [ false, false, false, true,
--             false, false, false, false,
--             false, false, false, true,
--             false, false, false, false,
--             false, false, false, false,
--             false, false, false, true ]
--           [[ 1u64, 54u64,  3u64],
--            [44u64, 23u64, 42u64],
--            [10u64, 11u64, 13u64],
--            [ 7u64,  4u64,  0u64]]
-- }
-- output {
--       [ [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]
--       , [ 1, 2, 3 ]]
-- }
