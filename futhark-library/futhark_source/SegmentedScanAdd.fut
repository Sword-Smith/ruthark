module Utils = import "Utils"

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
  (coefficient : XFieldElement)
  (term_exp : [m]u8)
  (eval_points_mtx : [n][m]XFieldElement)
  : [n]XFieldElement =
  map (eval_term_on_point coefficient term_exp) eval_points_mtx

-- t = qs_sum = number of terms
def eval_all_terms
  [n] [m] [t]
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t][m]u8)
  (eval_points_mtx : [n][m]XFieldElement)
  : ?[tn].[tn]XFieldElement =
  let tn = t * n
  let all_terms_all_points = map2 (\cs texps -> eval_term_on_all_points cs texps eval_points_mtx) coefficients term_exp_mtx
   in flatten all_terms_all_points :> [tn]XFieldElement

-- r = t x n
def sum_terms_per_poly
  [n] [m] [t] [p]
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t][m]u8)
  (eval_points_mtx : [n][m]XFieldElement)
  (qs : [p]i64)
  : ?[tn].[tn]XFieldElement =
  let tn = t * n
  let evaluated_terms = eval_all_terms coefficients term_exp_mtx eval_points_mtx :> [tn]XFieldElement
  let qs_flags = Utils.idxs_to_flags_i64 qs :> [tn]bool
  let segmented_sum = XFieldElement.segmented_scan_add qs_flags evaluated_terms
   in segmented_sum

def eval_polys
  [n] [m] [t] [p]
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t][m]u8)
  (eval_points_mtx : [n][m]XFieldElement)
  (qs : [p]i64)
  : [p]XFieldElement =
  let segmented_sum = sum_terms_per_poly coefficients term_exp_mtx eval_points_mtx qs
  let sum_indices = Utils.segments_end_indices_i64 qs
  let sums = Utils.gather sum_indices segmented_sum
   in sums

entry main
  [n] [m] [t] [p]
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t][m]u8)
  (eval_points_mtx : [n][m]XFieldElement)
  (qs : [p]i64)
  (zerofiers : [p]XFieldElement)
  : [p]XFieldElement =
  let evaluated_polynomials = eval_polys coefficients term_exp_mtx eval_points_mtx qs
  let quotients = map2 XFieldElement.mul evaluated_polynomials zerofiers
   in quotients
