import "lib/github.com/diku-dk/linalg/linalg"

module BFieldElement = import "BFieldElement"
type BFieldElement = BFieldElement.BFieldElement

module linalg_bfe = mk_linalg BFieldElement


entry main : i32 =
  let _ = linalg_bfe.matmul [[1,2],[3,4]] [[5,6],[7,8]]
  in 5




def eval_point [m] = (term_exp : [m]u8)  (point : [m]XFieldElement) : XFieldElement =
  let factors = map2 mod_pow point term_exp
  in reduce (XFieldElement.mul) XFieldElement.one factors

-- t = qs_sum = number of terms

def pointwise_pow [n] [m] [t] (term_exp_mtx : [t][m]u8) (eval_points_mtx : [n][m]XFieldElement) : [t][n]:XFieldElement =
  map 


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


-- test
--
--
--
--

entry term_exp_matrix_test = 1

