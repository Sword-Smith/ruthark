import "lib/github.com/diku-dk/linalg/linalg"

module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
type BFieldElement = BFieldElement.BFieldElement
type XFieldElement = XFieldElement.XFieldElement


import "Segmented"
-- module linalg_bfe = mk_linalg BFieldElement


--entry main : i32 =
--  let _ = linalg_bfe.matmul [[1,2],[3,4]] [[5,6],[7,8]]
--  in 5

-- t = qs_sum = number of terms

def eval_term_on_point [m] (term_exp : [m]u8) (point : [m]XFieldElement) : XFieldElement =
  let factors = map2 XFieldElement.mod_pow_u8 point term_exp
  in reduce XFieldElement.mul XFieldElement.one factors

def eval_term_on_all_points [m] [n] (eval_points_mtx : [n][m]XFieldElement) (term_exp : [m]u8) : [n]XFieldElement =
  map (eval_term_on_point term_exp) eval_points_mtx

def eval_all_terms [n] [m] [t] (term_exp_mtx : [t][m]u8) (eval_points_mtx : [n][m]XFieldElement) : [t][n]XFieldElement =
  map (eval_term_on_all_points eval_points_mtx) term_exp_mtx

-- r = t x n
def sum_terms_per_poly [n] [m] [t] [r] (term_exp_mtx : [t][m]u8) (qs_flags : [r]bool) (eval_points_mtx : [n][m]XFieldElement) : []XFieldElement =
  -- Here coefficient vector should multiplied
  let evaluated_terms = eval_all_terms term_exp_mtx eval_points_mtx
  let all_terms = flatten evaluated_terms :> [r]XFieldElement
  in segmented_add qs_flags all_terms




def matrix_map [m] [n] 't 'u (f : t -> u) (mtx : [m][n]t) : [m][n]u = map (map f) mtx


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

-- Test term_exp_matrix_test
-- ==
-- entry: test_term_exp_matrix
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
entry test_term_exp_matrix [n] [m] [t] [r] (term_exp_mtx : [t][m]u8) (qs_flags : [r]bool) (eval_points_mtx : [n][m]u64) : ?[p].[p][3]i32 =
  let eval_points_mtx_xfe = map (map XFieldElement.from_u64) eval_points_mtx
  let res = sum_terms_per_poly term_exp_mtx qs_flags eval_points_mtx_xfe
  in map XFieldElement.tripple2array res |> matrix_map i32.u64
