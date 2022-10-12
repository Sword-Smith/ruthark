import "lib/github.com/diku-dk/linalg/linalg"

module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
type BFieldElement = BFieldElement.BFieldElement
type XFieldElement = XFieldElement.XFieldElement


-- module linalg_bfe = mk_linalg BFieldElement


--entry main : i32 =
--  let _ = linalg_bfe.matmul [[1,2],[3,4]] [[5,6],[7,8]]
--  in 5

-- t = qs_sum = number of terms

def eval_term_on_point [m] (term_exp : [m]u8) (point : [m]XFieldElement) : XFieldElement =
  let factors = map2 XFieldElement.mod_pow_u8 point term_exp
  in reduce XFieldElement.mul XFieldElement.one factors

def eval_term_on_all_points [m] [n] (term_exp : [m]u8) (eval_points_mtx : [n][m]XFieldElement) : [n]XFieldElement =
  map (eval_term_on_point term_exp) eval_points_mtx

def eval_all_terms [n] [m] [t] (term_exp_mtx : [t][m]u8) (eval_points_mtx : [n][m]XFieldElement) : [t][n]XFieldElement =
  map (\term -> eval_term_on_all_points term eval_points_mtx) term_exp_mtx

def segmented_scan 't [n] (g:t->t->t) (ne: t) (flags: [n]bool) (vals: [n]t): [n]t =
  let pairs = scan ( \ (v1,f1) (v2,f2) ->
                       let f = f1 || f2
                       let v = if f2 then v2 else g v1 v2
                       in (v,f) ) (ne,false) (zip vals flags)
  let (res,_) = unzip pairs
  in res

def replicated_iota [n] (reps:[n]i64) : []i64 =
  let s1 = scan (+) 0 reps
  let s2 = map (\i -> if i==0 then 0 else s1[i-1]) (iota n)
  let tmp = scatter (replicate (reduce (+) 0 reps) 0) s2 (iota n)
  let flags = map (>0) tmp
  in segmented_scan (+) 0 flags tmp

def segmented_replicate [n] (reps:[n]i64) (vs:[n]i64) : []i64 =
  let idxs = replicated_iota reps
  in map (\i -> vs[i]) idxs

def idxs_to_flags [p] (qs : [p]i64) : []bool =
  let vs = segmented_replicate qs (iota p)
  let m = length vs
  in map2 (!=) (vs :> [m]i64) ([0] ++ vs[:m-1] :> [m]i64)

def segmented_add [t] (flags: [t]bool) (vals : [t]XFieldElement) : []XFieldElement =
  let pairs = scan ( \(v1, f1) (v2, f2) ->
                      let f = f1 || f2
                      let v = if f2 then v2 else XFieldElement.add v1 v2
                      in (v, f) )
                      (XFieldElement.zero, false) (zip vals flags)
  let (res, _) = unzip pairs
  in res

def sum_terms_per_poly [n] [m] [t] [p] (term_exp_mtx : [t][m]u8) (qs : [p]u64) (eval_points_mtx : [n][m]XFieldElement) : [p]XFieldElement =
  -- Here coefficient vector should multiplied
  let evaluated_terms = eval_all_terms term_exp_mtx eval_points_mtx
  let flags = idxs_to_flags (map i64.u64 qs)
  in segmented_add flags (flatten evaluated_terms)





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
-- entry: term_exp_matrix_test
-- input:  { [[ 2,  3,  5],
--            [ 7, 11, 13],
--            [17, 19, 23],
--            [ 2,  3,  5],
--            [ 7, 11, 13],
--            [17, 19, 23]]
--           [  1,  2,  3]
--           [[ 1, 54,  3],
--            [44, 23, 42],
--            [10, 11, 13],
--            [ 7,  4,  0]]
-- }
-- output: { [[4, 8, 12 ] ] }
entry term_exp_matrix_test = sum_terms_per_poly
