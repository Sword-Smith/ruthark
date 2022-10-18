import "lib/github.com/Ulrik-dk/segmented/segmented"

-- Math foundation
module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
module Polynomial = import "Polynomial"
module MPolynomial = import "MPolynomial"

-- Experiments
module Fastlib = import "fastlib"
module Matmul = import "matmul"
module Parametric_module = import "parametric_module"

-- How to make imported functions callable
entry matmul = Matmul.matmul

type XFieldElement = XFieldElement.XFieldElement
type BFieldElement = BFieldElement.BFieldElement

def (x: XFieldElement) ^*^ (y: XFieldElement) = XFieldElement.mul x y

def (x: XFieldElement) ^+^ (y: XFieldElement) = XFieldElement.add x y

def (elm: XFieldElement) %** (exp: u64) = XFieldElement.mod_pow_u64 elm exp

def inner_redo_map
    ( exp_2d )
    ( coefficient_1d )
    ( evaluation_point_1d )
    =
    map2 (\ exp_1d coefficient ->
        map2 (%**) evaluation_point_1d exp_1d
        |> reduce_comm (^*^) XFieldElement.one
        |> (coefficient ^*^)
    ) exp_2d coefficient_1d

def kernel_padded_impl
    [n][m][p][q]
    ( zerofier_inverse_1d: [n]XFieldElement)
    ( evaluation_point_2d: [n]      [m]XFieldElement)
    ( exp_3d:                 [p][q][m]u64)
    ( coefficient_2d:         [p][q]XFieldElement)
    : [n][p]XFieldElement =
        map2 (\ zerofier_inverse evaluation_point_1d ->
            map2 (\ exp_2d    coefficient_1d ->
                inner_redo_map exp_2d coefficient_1d evaluation_point_1d
                |> reduce (^+^) XFieldElement.zero
                |> (zerofier_inverse ^*^)
            ) exp_3d coefficient_2d
        ) zerofier_inverse_1d evaluation_point_2d

def ex_scan 'a [n] (op: a -> a -> a) (ne: a) (as: [n]a) : [n]a =
    let inc_scan = scan op ne as
    let res_almost = rotate (-1) inc_scan
    in res_almost with [0] = ne

def create_segreduce_flags [p] (q_1d: [p]i64) (pq: i64) : [pq]bool =
    let is = ex_scan (+) 0 q_1d     :> [p]i64
    let vs = replicate p true       :> [p]bool
    let dest = replicate pq false   :> [pq]bool
    let flags = scatter dest is vs  :> [pq]bool
    in flags

def kernel_segmented_reduce_impl
    [n][m][p][pq]
    ( zerofier_inverse_1d:  [n]XFieldElement)
    ( evaluation_point_2d:  [n]    [m]XFieldElement)
    ( exp_2d_seg:              [pq][m]u64)
    ( coefficient_1d_seg:      [pq]XFieldElement)
    ( q_1d:                    [p]i64)
    : [n][p]XFieldElement =
        -- these flags are invarant to the outer map, and should therefore be created out here
        let flags = create_segreduce_flags q_1d pq :> [pq]bool
        in map2 (\ zerofier_inverse evaluation_point_1d ->
            let innermapped = inner_redo_map exp_2d_seg coefficient_1d_seg evaluation_point_1d
            -- this fails due to an off-by-one size somewhere
            let reduced = segmented_reduce (^+^) XFieldElement.zero flags innermapped :> [p]XFieldElement
            in  map (zerofier_inverse ^*^) reduced
        ) zerofier_inverse_1d evaluation_point_2d

def kernel_segmented_reduce_with_flags_impl
    [n][m][p][pq]
    ( zerofier_inverse_1d:  [n]XFieldElement)
    ( evaluation_point_2d:  [n]    [m]XFieldElement)
    ( exp_2d_seg:              [pq][m]u64)
    ( coefficient_1d_seg:      [pq]XFieldElement)
    ( flags:                   [pq]bool)
    : [n][p]XFieldElement =
        -- these flags are invarant to the outer map, and should therefore be created out here
        let res = map2 (\ zerofier_inverse evaluation_point_1d ->
                    let innermapped = inner_redo_map exp_2d_seg coefficient_1d_seg evaluation_point_1d :> [pq]XFieldElement
                    let reduced = segmented_reduce (^+^) XFieldElement.zero flags innermapped :> [p]XFieldElement
                    in  map (zerofier_inverse ^*^) reduced
                  ) zerofier_inverse_1d evaluation_point_2d
        let res = res :> [n][p]XFieldElement
        in res

def segmented_replicate [n] 't (revaluation_point_2d:[n]i64) (vs:[n]t) : []t =
    let idxs = replicated_iota revaluation_point_2d
    in map (\i -> vs[i]) idxs

def create_histogram_is
    [p]
    ( q_1d: [p]i64)
    ( pq )
    : [pq]i64
    =
    let false_is = scan (+) 0 q_1d
    let is_almost = map (\i -> false_is[(i+1)%p]) <| iota p
    let ice = copy is_almost with [0] = 0
    let is = segmented_replicate ice q_1d :> [pq]i64
    in is

def kernel_histogram_impl
    [n][m][p][pq]
    ( zerofier_inverse_1d:  [n]XFieldElement)
    ( evaluation_point_2d:  [n]    [m]XFieldElement)
    ( exp_2d_seg:              [pq][m]u64)
    ( coefficient_1d_seg:      [pq]XFieldElement)
    ( q_1d:                    [p]i64)
    : [n][p]XFieldElement =
        map2 (\ zerofier_inverse evaluation_point_1d ->
           let innermapped = inner_redo_map exp_2d_seg coefficient_1d_seg evaluation_point_1d
           let is = create_histogram_is q_1d pq
           let reduced = hist (^+^) XFieldElement.zero p is innermapped
           in  map (zerofier_inverse ^*^) reduced
        ) zerofier_inverse_1d evaluation_point_2d


def kernel_histogram_with_is_impl
    [n][m][p][pq]
    ( zerofier_inverse_1d:  [n]XFieldElement)
    ( evaluation_point_2d:  [n]    [m]XFieldElement)
    ( exp_2d_seg:              [pq][m]u64)
    ( coefficient_1d_seg:      [pq]XFieldElement)
    ( is:                      [pq]i64)
    : [n][p]XFieldElement =
        map2 (\ zerofier_inverse evaluation_point_1d ->
           let innermapped = inner_redo_map exp_2d_seg coefficient_1d_seg evaluation_point_1d
           let reduced = hist (^+^) XFieldElement.zero p is innermapped
           in  map (zerofier_inverse ^*^) reduced
        ) zerofier_inverse_1d evaluation_point_2d



---------------- Everything below this is boring entry-point wrapping ----------------

type XFieldElement_flat = [3]BFieldElement

def inner_to_outer
    (a: XFieldElement) : XFieldElement_flat =
    [a.0, a.1, a.2]

def outer_to_inner
    (a: XFieldElement_flat) : XFieldElement =
    (a[0], a[1], a[2])

entry kernel_padded
    [n][m][p][q]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_3d:                 [p][q][m]u64)
    ( coefficient_2d     :    [p][q]XFieldElement_flat)
    : [n][p]XFieldElement_flat =
    let kernel = kernel_padded_impl

    let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
    let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
    let inner_exp_3d = exp_3d
    let inner_coefficient_2d = map (map outer_to_inner) coefficient_2d
    let inner_res = kernel inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d
    in map (map inner_to_outer) inner_res

def generalised_wrapper
    ( kernel_f )
    ( zerofier_inverse_1d )
    ( evaluation_point_2d )
    ( exps_segs )
    ( coefficient_1d_seg )
    ( q_1d )
     =
    let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
    let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
    let inner_exp_3d = exps_segs
    let inner_coefficient_2d = map outer_to_inner coefficient_1d_seg
    let inner_res = kernel_f inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d q_1d
    in map (map inner_to_outer) inner_res

entry kernel_histogram
    [n][m][p][pq]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_2d_seg:             [pq][m]u64)
    ( coefficient_1d_seg:     [pq]XFieldElement_flat)
    ( q_1d:                   [p]i64)
    : [n][p]XFieldElement_flat =
    generalised_wrapper kernel_histogram_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg q_1d

entry kernel_histogram_with_is
    [n][m][p][pq]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_2d_seg:             [pq][m]u64)
    ( coefficient_1d_seg:     [pq]XFieldElement_flat)
    ( _q_1d:                  [p]i64)
    ( is:                     [pq]i64)
    : [n][p]XFieldElement_flat =
    generalised_wrapper kernel_histogram_with_is_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg is


entry kernel_segmented_reduce
    [n][m][p][pq]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_2d_seg:             [pq][m]u64)
    ( coefficient_1d_seg:     [pq]XFieldElement_flat)
    ( q_1d:                   [p]i64)
    : [n][p]XFieldElement_flat =
    generalised_wrapper kernel_segmented_reduce_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg q_1d

entry kernel_segmented_reduce_with_flags
    [n][m][p][pq]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_2d_seg:             [pq][m]u64)
    ( coefficient_1d_seg:     [pq]XFieldElement_flat)
    ( flags:                  [pq]bool)
    ( _witness:                [p]bool)
    : [n][p]XFieldElement_flat =

    let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
    let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
    let inner_exp_3d = exp_2d_seg
    let inner_coefficient_2d = map outer_to_inner coefficient_1d_seg
    let inner_res = kernel_segmented_reduce_with_flags_impl inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d flags : [n][p]XFieldElement
    in map (map inner_to_outer) inner_res
