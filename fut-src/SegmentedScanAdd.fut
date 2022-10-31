module Utils = import "Utils"

-- Todo
-- import "lib/github.com/diku-dk/linalg/linalg"
-- module linalg_bfe = mk_linalg BFieldElement
-- module linalg_xfe = mk_linalg XFieldElement
--entry main : i32 =
--  let _ = linalg_bfe.matmul [[1,2],[3,4]] [[5,6],[7,8]]
--  in 5

module BFieldElement = import "BFieldElement"
type BFieldElement = BFieldElement.BFieldElement

module XFieldElement = import "XFieldElement"
type XFieldElement = XFieldElement.XFieldElement

-- [m] the number of variabels in each polynomial, i.e. 2x colu[m]n_count
-- [n] the number of evaluatio[n] points, i.e. length of FRI-domain, |omega|
-- [p] the number of [p]olynomials
-- [t] the sum of the number of [t]erms across all polynomials.
--     Same as number of coefficients.
--
-- Computation Chart
--         m          1          m                 t               p        1        p
--      _______       _       _______       _______________       ___       _       ___
--     |       |     | |     |       |     |               |     |   |     | |     |   |
--     |   P   |     |C|     |   T   |     |       E       |     | S |     |Z|     | Q |
--     |   o   |     |o|     |   e   |     |       v       |     | e |     |e|     | u |
--     |   i   |   t |e|   t |   r   |     |       a       |     | g |     |r|     | o |
--     |   n   |     |f|     |   m   |     |       l       |     | s |     |o|     | t |
--   n |   t   |     |s|     |   s   |   n |       e       |   n | u |   n |f|   n | i |
--     |   s   |     |_|     |_______|     |       d       |     | m |     |.|     | e |
--     |       |                           |               |     | s |     |i|     | n |
--     |       |                           |               |     |   |     |n|     | t |
--     |       |                           |               |     |   |     |v|     | s |
--     |       |                           |               |     |   |     |s|     |   |
--     |_______|                           |_______________|     |___|     |_|     |___|
--
--            eval_term_on_point       ->    map segsum           ->   multiply2D   ->
--

def divide_zerofier_on_row
  [p]
  (zerofier_inverse : XFieldElement)
  (row : [p]XFieldElement)
  : [p]XFieldElement =
  map (XFieldElement.mul zerofier_inverse) row

-- This is code for this math operation: $$ Diag(zerofier_inverses) @ segsums $$
-- https://math.stackexchange.com/a/3713048
def multiply2D
  [n] [p]
  (zerofier_inverses: [n]XFieldElement)
  (segsums: [n][p]XFieldElement)
  : [n][p]XFieldElement =
  map2 divide_zerofier_on_row zerofier_inverses segsums

def eval_term_on_point
  [m]
  (coefficient : XFieldElement)
  (term_exp : [m]u8)
  (point : [m]XFieldElement)
  : XFieldElement =
  let variation1 = false
  in if variation1 && any (XFieldElement.is_zero) point then XFieldElement.zero
     else let factors = map2 XFieldElement.mod_pow_u8 point term_exp
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

def eval_all_terms_on_point_new
  [m] [t]
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t][m]u8)
  (point : [m]XFieldElement)
  : [t]XFieldElement =
  let evaled : [t]XFieldElement = map2 (\coefficient term -> eval_term_on_point coefficient term point) coefficients term_exp_mtx
   in evaled

def eval_all_terms_on_all_points_new
                  [t][n][m]
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t]   [m]u8)
  (eval_points_mtx : [n][m]XFieldElement)
  : [n][t]XFieldElement =
  let evaled : [n][t]XFieldElement = map (eval_all_terms_on_point_new coefficients term_exp_mtx) eval_points_mtx
   in evaled

def mapsegsum
  [n] [m] [t] [p]
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t][m]u8)
  (eval_points_mtx : [n][m]XFieldElement)
  (qs : [p]i64)
  : [n][p]XFieldElement =
  let evaled_mtx : [n][t]XFieldElement = eval_all_terms_on_all_points_new coefficients term_exp_mtx eval_points_mtx
  let qs_flags : [t]bool = Utils.idxs_to_flags_i64 qs :> [t]bool
  let segcumsums: [n][t]XFieldElement = map (\row -> XFieldElement.segmented_scan_add qs_flags row) evaled_mtx
  let sum_indices: [p]i64= Utils.segments_end_indices_i64 qs
  let segsums: [n][p]XFieldElement = map (Utils.gather sum_indices) segcumsums
   in segsums

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

def eval_polys_new
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

def kernel_opaque_new
  [n] [m] [t] [p]
  (coefficients : [t]XFieldElement)
  (term_exp_mtx : [t][m]u8)
  (eval_points_mtx : [n][m]XFieldElement)
  (qs : [p]i64)
  (zerofier_inverses : [n]XFieldElement)
  : [n][p]XFieldElement =
  let segsums = mapsegsum coefficients term_exp_mtx eval_points_mtx qs
  let quotients : [n][p]XFieldElement = multiply2D zerofier_inverses segsums
   in quotients

-- def kernel_opaque
--   [n] [m] [t] [p]
--   (coefficients : [t]XFieldElement)
--   (term_exp_mtx : [t][m]u8)
--   (eval_points_mtx : [n][m]XFieldElement)
--   (qs : [p]i64)
--   (zerofier_inverses : [n]XFieldElement)
--   : [n][p]XFieldElement =
--   let evaluated_polynomials = eval_polys coefficients term_exp_mtx eval_points_mtx qs
--   let quotients = map2 XFieldElement.mul evaluated_polynomials zerofier_inverses
--    in quotients

-- Returns the evalution of `p` transition quotients in `n` different points,
-- i.e. the length of the Fri-domain.
entry kernel
  [n] [m] [t] [p]
  (coefficients_as_3u64 : [t][3]u64)
  (term_exp_mtx : [t][m]u8)
  (eval_points_mtx_as_3u64 : [n][m][3]u64)
  (qs : [p]i64)
  (zerofier_inverses_as_3u64 : [n][3]u64)
  : [n][p][3]u64 =
  let coefficients = map XFieldElement.array2tripple coefficients_as_3u64
  let eval_points_mtx = Utils.map2d XFieldElement.array2tripple eval_points_mtx_as_3u64
  let zerofier_inverses = map XFieldElement.array2tripple zerofier_inverses_as_3u64
   in kernel_opaque_new coefficients term_exp_mtx eval_points_mtx qs zerofier_inverses
   |> Utils.map2d XFieldElement.tripple2array
