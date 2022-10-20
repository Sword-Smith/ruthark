module Flags = import "Flags"

-- import "lib/github.com/diku-dk/linalg/linalg"
-- module linalg_bfe = mk_linalg BFieldElement
-- module linalg_xfe = mk_linalg XFieldElement
--entry main : i32 =
--  let _ = linalg_bfe.matmul [[1,2],[3,4]] [[5,6],[7,8]]
--  in 5

module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
type BFieldElement = BFieldElement.BFieldElement
type XFieldElement = XFieldElement.XFieldElement

def map2d [m] [n] 't 'u (f : t -> u) (mtx : [m][n]t) : [m][n]u = map (map f) mtx
def zipWith [p] 't (f : t -> t -> t) (v1 : [p]t) (v2 : [p]t) : [p]t = map2 f v1 v2


-- [p] the number of [p]olynomials
-- [t] the sum of the number of [t]erms across all polynomials
-- [m] the number of variabels in each polynomial, i.e. 2x colu[m]n_count
-- [n] the number of evaluatio[n] points, i.e. length of FRI-domain, |omega|

def eval_term_on_point
  [m]
  (coefficient : XFieldElement)
  (term_exp : [m]u8)
  (point : [m]XFieldElement)
  : XFieldElement =
  let factors = map2 XFieldElement.mod_pow_u8 point term_exp
   in reduce_comm XFieldElement.mul coefficient factors

def eval_term_on_all_points
  [m] [n]
  (eval_points_mtx : [n][m]XFieldElement)
  (coefficient : XFieldElement)
  (term_exp : [m]u8)
  : [n]XFieldElement =
  map (eval_term_on_point coefficient term_exp) eval_points_mtx

-- t = qs_sum = number of terms
def eval_all_terms
  [n] [m] [t]
  (eval_points_mtx : [n][m]XFieldElement)
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t][m]u8)
  : ?[tn].[tn]XFieldElement =
  let tn = t * n
  let all_terms_all_points = map2 (eval_term_on_all_points eval_points_mtx) coefficients term_exp_mtx
   in flatten all_terms_all_points :> [tn]XFieldElement

-- r = t x n
def sum_terms_per_poly
  [n] [m] [t] [p]
  (term_exp_mtx : [t][m]u8)
  (qs : [p]i64)
  (eval_points_mtx : [n][m]XFieldElement)
  (coefficients : [t]XFieldElement)
  : ?[tn].[tn]XFieldElement =
  let tn = t * n
  let evaluated_terms = eval_all_terms eval_points_mtx coefficients term_exp_mtx :> [tn]XFieldElement
  let qs_flags = Flags.idxs_to_flags_i64 qs :> [tn]bool
  let segmented_sum = XFieldElement.segmented_scan_add qs_flags evaluated_terms
   in segmented_sum

def eval_polys
  [n] [m] [t] [p]
  (term_exp_mtx : [t][m]u8)
  (qs : [p]i64)
  (eval_points_mtx : [n][m]XFieldElement)
  (coefficients : [t]XFieldElement)
  : [p]XFieldElement =
  let segmented_sum = sum_terms_per_poly term_exp_mtx qs eval_points_mtx coefficients
  let sum_indices = Flags.segments_end_indices_i64 qs
  let sums = Flags.gather sum_indices segmented_sum
   in sums

def main
  [n] [m] [t] [p]
  (term_exp_mtx : [t][m]u8)
  (qs : [p]i64)
  (eval_points_mtx : [n][m]XFieldElement)
  (coefficients : [t]XFieldElement)
  (zerofiers : [p]XFieldElement)
  : [p]XFieldElement =
  let evaluated_polynomials = eval_polys term_exp_mtx qs eval_points_mtx coefficients
  let quotients = map2 XFieldElement.mul evaluated_polynomials zerofiers
   in quotients



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
-- input  { [ [ 2, 7]
--          , [ 3, 5] ]
--          [ false, false, false, false, false, false]
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

-- entry test_eval_all_terms [n] [m] [t] [r] (term_exp_mtx : [t][m]i32) (_qs : [r]bool)  (eval_points_mtx : [n][m]i32) : ?[r].[r][3]i32 =
--   let eval_points_mtx_xfe = map2d XFieldElement.from_i32 eval_points_mtx
--   let term_exp_mtx_u8 = map2d u8.i32 term_exp_mtx
--   let evaluated_terms = eval_all_terms term_exp_mtx_u8 eval_points_mtx_xfe
--   let all_terms = flatten evaluated_terms :> [r]XFieldElement
--    in map XFieldElement.tripple2array all_terms |> map2d i32.u64


-- Test test_term_exp_matrix
-- ==
-- entry: test_term_exp_matrix
-- input  { [ [ 2, 7]
--          , [ 3, 5] ]
--          [ 3, 3 ]
--          [ [ 0, 0]
--          , [ 1, 1]
--          , [ 2, 2] ]
-- }
-- output { [ [  513, 0, 0 ]
--        ,   [  257, 0, 0 ] ]
-- }
-- input  { [ [ 2, 7]
--          , [ 3, 5]
--          , [ 11, 13] ]
--          [ 6, 3 ]
--          [ [ 0, 0]
--          , [ 1, 1]
--          , [ 2, 2] ]
-- }
-- output { [ [  770, 0, 0 ]
--        ,   [  16777217, 0, 0 ] ]
-- }
-- entry test_term_exp_matrix [n] [m] [t] [p] (term_exp_mtx : [t][m]i32) (qs : [p]i32)  (eval_points_mtx : [n][m]i32) : [p][3]i32 =
--   let eval_points_mtx_xfe = map2d XFieldElement.from_i32 eval_points_mtx
--   let term_exp_mtx_u8 = map2d u8.i32 term_exp_mtx
--   let qs_i64 = map i64.i32 qs
--   let evaluated_terms = eval_all_terms term_exp_mtx_u8 eval_points_mtx_xfe
--   let all_terms = flatten evaluated_terms :> [p]XFieldElement
--   let segmented_sum = sum_terms_per_poly term_exp_mtx_u8 qs_i64 eval_points_mtx_xfe
--   let res = Flags.gather (Flags.segments_end_indices_i64 qs_i64) segmented_sum
--    in map XFieldElement.tripple2array res |> map2d i32.u64


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
