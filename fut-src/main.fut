-- Math foundation
module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
type XFieldElement = XFieldElement.XFieldElement
type BFieldElement = BFieldElement.BFieldElement

-- Everything below this is boring entry-point wrapping 
---It only exists because XFieldElement is a triple instead of a [3]BFieldElement

type XFieldElement_flat = [3]BFieldElement

def inner_to_outer
    (a: XFieldElement) : XFieldElement_flat =
    [a.0, a.1, a.2]

def outer_to_inner
    (a: XFieldElement_flat) : XFieldElement =
    (a[0], a[1], a[2])

-- entry kernel_histogram_with_is_and_muted
--     [n][m][p][pq][muted]
--     ( zerofier_inverse_1d: [n]XFieldElement_flat)
--     ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
--     ( evaluation_point_muted_2d:  [n][muted]XFieldElement_flat)
--     ( exp_2d_seg:             [pq][m]u64)
--     ( coefficient_1d_seg:     [pq]XFieldElement_flat)
--     ( q_1d:                  [p]i64)
--     ( is:                     [pq]i64)
--     : [n][p]XFieldElement_flat =
--     let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
--     let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
--     let inner_exp_3d = exp_2d_seg
--     let inner_coefficient_2d = map outer_to_inner coefficient_1d_seg
--     let inner_res = kernel_histogram_with_is_and_muted_impl inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d q_1d
--     in map (map inner_to_outer) inner_res

import "PaddedKernel"
entry kernel_padded
    [n][m][p][q]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_3d:                 [p][q][m]u8)
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
    ( exp_3d )
    ( coefficient_1d_seg )
    ( q_1d )
     =
    let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
    let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
    let inner_exp_3d = exp_3d
    let inner_coefficient_2d = map outer_to_inner coefficient_1d_seg
    let inner_res = kernel_f inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d q_1d
    in map (map inner_to_outer) inner_res

import "HistogramKernel"
entry kernel_histogram
    [n][m][p][pq]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_2d_seg:             [pq][m]u8)
    ( coefficient_1d_seg:     [pq]XFieldElement_flat)
    ( q_1d:                   [p]i64)
    : [n][p]XFieldElement_flat =
    generalised_wrapper kernel_histogram_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg q_1d

entry kernel_histogram_with_is
    [n][m][p][pq]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_2d_seg:             [pq][m]u8)
    ( coefficient_1d_seg:     [pq]XFieldElement_flat)
    ( _q_1d:                  [p]i64)
    ( is:                     [pq]i64)
    : [n][p]XFieldElement_flat =
    generalised_wrapper kernel_histogram_with_is_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg is

import "SegmentedReduceKernel"
entry kernel_segmented_reduce
    [n][m][p][pq]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_2d_seg:             [pq][m]u8)
    ( coefficient_1d_seg:     [pq]XFieldElement_flat)
    ( q_1d:                   [p]i64)
    : [n][p]XFieldElement_flat =
    generalised_wrapper kernel_segmented_reduce_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg q_1d

entry kernel_segmented_reduce_with_flags
    [n][m][p][pq]
    ( zerofier_inverse_1d: [n]XFieldElement_flat)
    ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
    ( exp_2d_seg:             [pq][m]u8)
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
