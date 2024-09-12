-- Math foundation
module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
module bfe_poly = import "bfe_poly"
module xfe_poly = import "xfe_poly"
module ArithmeticDomain = import "arithmetic_domain"
module master_base_table_module = import "master_base_table"
module master_ext_table = import "master_ext_table"
module SpongeWithPendingAbsorb = master_ext_table.SpongeWithPendingAbsorb
module MerkleTree = import "MerkleTree"
module Digest = import "Digest"
module Tip5 = import "Tip5"

type XFieldElement = XFieldElement.XFieldElement
type BFieldElement = BFieldElement.BFieldElement
type BfePolynomial [n] = bfe_poly.BfePolynomial [n]
type XfePolynomial [n] = xfe_poly.XfePolynomial [n]
type ArithmeticDomain = ArithmeticDomain.ArithmeticDomain
type~ MasterBaseTable [rows] [cols] = master_base_table_module.MasterBaseTable [rows] [cols]
type MasterExtTable [rows] [cols] = master_ext_table.MasterExtTable [rows] [cols]
type Digest = Digest.Digest
type~ MerkleTree = MerkleTree.MerkleTree

let NUM_COLUMNS = master_ext_table.NUM_COLUMNS

let fri_domain_offset = BFieldElement.new 7

-- test rust-futhark interop
entry test_gpu_kernel (number: u64) : u64 = number + 1

-- converts [][][3]u64 to [][]XFieldElement 
entry test_array_conversion_does_not_change_data (u64_table: [][][3]u64) : [][][3]u64 = 
    -- [][][3]u64 -> [][]XFieldElement
    let xfe_table : [][]XFieldElement = 
      map (map (\x -> XFieldElement.new_from_raw_u64_arr x)) u64_table
    -- [][]XFieldElement --> [][][3]u64
    in map (map (\x -> XFieldElement.to_raw_u64_arr x)) xfe_table

-- low degree extension of master base table
entry lde_master_base_table_kernel
  (randomized_trace_domain_offset: u64) 
  (randomized_trace_domain_gen: u64) 
  (randomized_trace_domain_len: i64)
  (randomized_trace_table: [][]u64)
  : [][]u64 = 

    -- [][]u64 -> [][]BFieldElement
    let randomized_trace_table : [][]BFieldElement = 
      map (map (\x -> BFieldElement.from_raw_u64 x)) randomized_trace_table

    -- to arithmetic domain
    let randomized_trace_domain: ArithmeticDomain = {
      offset = { 0 = randomized_trace_domain_offset} :> BFieldElement,
      generator = {0 = randomized_trace_domain_gen } :> BFieldElement,
      len = randomized_trace_domain_len
    }

    -- package table
    let master_base_table =  {   
        randomized_trace_domain,
        randomized_trace_table
    } :> MasterBaseTable [] []

    -- run lde
    let interpolant_polynomials: []BfePolynomial[] =
      master_base_table_module.low_degree_extend_all_columns master_base_table


    let poly_coeff_values: [][]u64 = 
      map (\poly -> map BFieldElement.to_raw_u64 poly.coefficients) interpolant_polynomials    

    in poly_coeff_values


-- Note, the u64 values passed into this kernel are raw coefficient values for Xfe/Bfe/...
-- This is not that same as what is returned by .value()/BFieldElement.value() 
entry lde_master_ext_table_kernel  
  (num_trace_randomizers: i64)
  (trace_domain_offset: u64) (trace_domain_gen: u64) (trace_domain_len: i64) -- "ArithmeticDomain"
  (randomized_trace_domain_offset: u64) (randomized_trace_domain_gen: u64) (randomized_trace_domain_len: i64)
  (quotient_domain_offset: u64) (quotient_domain_gen: u64) (quotient_domain_len: i64)
  (fri_domain_offset: u64) (fri_domain_gen: u64) (fri_domain_len:i64)
  (randomized_trace_table: [][][3]u64) -- 2d Xfe array
  : [][][3]u64 = -- encoded version of [NUM_COLUMNS][rows]XfePolynomial[] 

    -- package into master ext table
    let master_extension_table: MasterExtTable [][] = master_ext_table.new
      num_trace_randomizers
      trace_domain_offset trace_domain_gen trace_domain_len
      randomized_trace_domain_offset randomized_trace_domain_gen randomized_trace_domain_len 
      quotient_domain_offset quotient_domain_gen quotient_domain_len
      fri_domain_offset fri_domain_gen fri_domain_len
      randomized_trace_table

    -- interpolate on larger domain
    let interpolant_polynomials =
      master_ext_table.low_degree_extend_all_columns master_extension_table

    -- conversion for return into rust program
    -- NOTE: the rows of the major axis each contain a polynomial represented
    -- as encoded coefficients of [][3]u64
    let poly_coeff_values: [][][3]u64 = 
      map 
      (\poly -> map XFieldElement.to_raw_u64_arr poly.coefficients)
      interpolant_polynomials    

    in poly_coeff_values

-- -- NOTE: this entry point assumes it is receicing the Array_u64_3d that was output
-- -- by the call of lde_master_ext_table_kernel above
entry master_ext_table_merkle_tree_kernel
  (interpolants: [][][3]u64)
  (fri_domain_offset: u64) (fri_domain_gen: u64) (fri_domain_len: i64)
  : [][]u64 =  

    -- correct data format
    let interpolants: []XfePolynomial[] = 
      map (map XFieldElement.new_from_raw_u64_arr) interpolants  
      |> map xfe_poly.new 

    let fri_domain = ArithmeticDomain.new 
      (BFieldElement.from_raw_u64 fri_domain_offset) 
      (BFieldElement.from_raw_u64 fri_domain_gen) 
      fri_domain_len

    -- hash all fri domain rows JIT
    let hashed_rows: []Digest = 
      master_ext_table.hash_all_fri_domain_rows_just_in_time interpolants fri_domain

    -- compute merkle tree
    let merkle_tree: MerkleTree = MerkleTree.from_digests hashed_rows
    in map (\x -> map BFieldElement.to_raw_u64 x.0) merkle_tree.nodes

-- hashes a variable length input of raw bfe u64 internal values
entry tip5_hash_varlen_kernel (input: []u64) : []u64 =
  map BFieldElement.from_raw_u64 input |> Tip5.hash_varlen |> \x -> map BFieldElement.to_raw_u64 x.0

-- tip5 sponge w/ pending absorb (for testing purposes)
entry sponge_with_pending_absorb_kernel (input: []u64) : []u64 = 
  let input: []BFieldElement = map BFieldElement.from_raw_u64 input
 
  let sponge = SpongeWithPendingAbsorb.new 
  let absorbed = SpongeWithPendingAbsorb.absorb sponge input
  let finalized: Digest = SpongeWithPendingAbsorb.finalize absorbed
  
  in map BFieldElement.to_raw_u64 finalized.0


-- computes merkle tree from set of digests, returns raw u64 node digest bfe values
entry from_digest_tip5_kernel (input: [][]u64) : [][Digest.DIGEST_LENGTH]u64 = 
  let input: []Digest = map (\x -> map BFieldElement.from_raw_u64 x) input
                        |> map (take Digest.DIGEST_LENGTH)
                        |> map (\x -> { 0 = x}) 
  let merkle_tree = MerkleTree.from_digests input 
  let nodes = map (\x -> map BFieldElement.to_raw_u64 x.0) merkle_tree.nodes
  in nodes

-- compures fri domain rows using interpolation polynomials from lde of the 
-- MasterExtTable, then computes the hash of each w/ SpongeWithPendingAbsorb
-- (for testing purposes)
entry hash_all_fri_domain_rows_just_in_time_kernel 
  (interpolants: [][][3]u64)
  (fri_domain_offset: u64) (fri_domain_gen: u64) (fri_domain_len:i64) 
  : [][]u64 = 
    -- correct data format
    let interpolants: []XfePolynomial[] = 
      map (map XFieldElement.new_from_raw_u64_arr) interpolants  
      |> map xfe_poly.new 

    let fri_domain = ArithmeticDomain.new 
      (BFieldElement.from_raw_u64 fri_domain_offset) 
      (BFieldElement.from_raw_u64 fri_domain_gen) 
      fri_domain_len

    -- hash all fri domain rows JIT
    let result: []Digest = 
      master_ext_table.hash_all_fri_domain_rows_just_in_time interpolants fri_domain

    in map (\x -> map BFieldElement.to_raw_u64 x.0) result



-- entry lde_single_column
--   [n]
--   (extension_factor: i64)
--   (randomized_trace: [n]u64)
--   : ([extension_factor * n]u64, [n]u64) =
--   let randomized_trace = map (BFieldElement.from_raw_u64) randomized_trace
--   let (extended_column, poly) = low_degree_extend fri_domain_offset extension_factor randomized_trace
--   in (map (BFieldElement.to_raw_u64) extended_column, map (BFieldElement.to_raw_u64) poly.coefficients)

-- entry lde_multiple_columns
--   [m][n]
--   (extension_factor: i64)
--   (randomized_traces: [m][n]u64)
--   : ([extension_factor * n][m]u64, [m][n]u64) =
--   let randomized_traces = map (map (BFieldElement.from_raw_u64)) randomized_traces
--   let (extended_columns, polys) =
--     unzip2
--     (map (low_degree_extend fri_domain_offset extension_factor) randomized_traces)
--   let extended_columns = map (map BFieldElement.to_raw_u64) extended_columns
--   let polys = map (\poly -> map BFieldElement.to_raw_u64 poly.coefficients) polys
--   in (transpose extended_columns, polys)

-- Everything below this is boring entry-point wrapping
---It only exists because XFieldElement is a triple instead of a [3]BFieldElement

-- type XFieldElement_flat = [3]BFieldElement

-- def inner_to_outer
--     (a: XFieldElement) : XFieldElement_flat =
--     [a.0, a.1, a.2]

-- def outer_to_inner
--     (a: XFieldElement_flat) : XFieldElement =
--     (a[0], a[1], a[2])

-- -- entry kernel_histogram_with_is_and_muted
-- --     [n][m][p][pq][muted]
-- --     ( zerofier_inverse_1d: [n]XFieldElement_flat)
-- --     ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
-- --     ( evaluation_point_muted_2d:  [n][muted]XFieldElement_flat)
-- --     ( exp_2d_seg:             [pq][m]u64)
-- --     ( coefficient_1d_seg:     [pq]XFieldElement_flat)
-- --     ( q_1d:                  [p]i64)
-- --     ( is:                     [pq]i64)
-- --     : [n][p]XFieldElement_flat =
-- --     let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
-- --     let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
-- --     let inner_exp_3d = exp_2d_seg
-- --     let inner_coefficient_2d = map outer_to_inner coefficient_1d_seg
-- --     let inner_res = kernel_histogram_with_is_and_muted_impl inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d q_1d
-- --     in map (map inner_to_outer) inner_res

-- import "PaddedKernel"
-- entry kernel_padded
--     [n][m][p][q]
--     ( zerofier_inverse_1d: [n]XFieldElement_flat)
--     ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
--     ( exp_3d:                 [p][q][m]u8)
--     ( coefficient_2d     :    [p][q]XFieldElement_flat)
--     : [n][p]XFieldElement_flat =
--     let kernel = kernel_padded_impl

--     let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
--     let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
--     let inner_exp_3d = exp_3d
--     let inner_coefficient_2d = map (map outer_to_inner) coefficient_2d
--     let inner_res = kernel inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d
--     in map (map inner_to_outer) inner_res

-- def generalised_wrapper
--     ( kernel_f )
--     ( zerofier_inverse_1d )
--     ( evaluation_point_2d )
--     ( exp_3d )
--     ( coefficient_1d_seg )
--     ( q_1d )
--      =
--     let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
--     let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
--     let inner_exp_3d = exp_3d
--     let inner_coefficient_2d = map outer_to_inner coefficient_1d_seg
--     let inner_res = kernel_f inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d q_1d
--     in map (map inner_to_outer) inner_res

-- import "HistogramKernel"
-- entry kernel_histogram
--     [n][m][p][pq]
--     ( zerofier_inverse_1d: [n]XFieldElement_flat)
--     ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
--     ( exp_2d_seg:             [pq][m]u8)
--     ( coefficient_1d_seg:     [pq]XFieldElement_flat)
--     ( q_1d:                   [p]i64)
--     : [n][p]XFieldElement_flat =
--     generalised_wrapper kernel_histogram_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg q_1d

-- entry kernel_histogram_with_is
--     [n][m][p][pq]
--     ( zerofier_inverse_1d: [n]XFieldElement_flat)
--     ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
--     ( exp_2d_seg:             [pq][m]u8)
--     ( coefficient_1d_seg:     [pq]XFieldElement_flat)
--     ( _q_1d:                  [p]i64)
--     ( is:                     [pq]i64)
--     : [n][p]XFieldElement_flat =
--     generalised_wrapper kernel_histogram_with_is_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg is

-- import "SegmentedReduceKernel"
-- entry kernel_segmented_reduce
--     [n][m][p][pq]
--     ( zerofier_inverse_1d: [n]XFieldElement_flat)
--     ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
--     ( exp_2d_seg:             [pq][m]u8)
--     ( coefficient_1d_seg:     [pq]XFieldElement_flat)
--     ( q_1d:                   [p]i64)
--     : [n][p]XFieldElement_flat =
--     generalised_wrapper kernel_segmented_reduce_impl zerofier_inverse_1d evaluation_point_2d exp_2d_seg coefficient_1d_seg q_1d

-- entry kernel_segmented_reduce_with_flags
--     [n][m][p][pq]
--     ( zerofier_inverse_1d: [n]XFieldElement_flat)
--     ( evaluation_point_2d: [n]    [m]XFieldElement_flat)
--     ( exp_2d_seg:             [pq][m]u8)
--     ( coefficient_1d_seg:     [pq]XFieldElement_flat)
--     ( flags:                  [pq]bool)
--     ( _witness:                [p]bool)
--     : [n][p]XFieldElement_flat =

--     let inner_zerofier_inverse_1d = map outer_to_inner zerofier_inverse_1d
--     let inner_evaluation_point_2d = map (map outer_to_inner) evaluation_point_2d
--     let inner_exp_3d = exp_2d_seg
--     let inner_coefficient_2d = map outer_to_inner coefficient_1d_seg
--     let inner_res = kernel_segmented_reduce_with_flags_impl inner_zerofier_inverse_1d inner_evaluation_point_2d inner_exp_3d inner_coefficient_2d flags : [n][p]XFieldElement
--     in map (map inner_to_outer) inner_res

-- module RescuePrime = import "RescuePrime"
-- def parameteres = RescuePrime.parameters
-- entry kernel_rescue_prime_hash = RescuePrime.rescue_prime_hash parameteres -- this is not the one you want
-- entry kernel_rescue_prime_hash_10 = RescuePrime.rescue_prime_hash_10 parameteres -- it is this one
-- entry kernel_rescue_prime_hash_varlen = RescuePrime.rescue_prime_hash_varlen parameteres

-- module MerkleTree = import "MerkleTree"
-- entry kernel_merkle_root_2d = MerkleTree.kernel_merkle_root_2d
-- entry kernel_merkle_root_inplace = MerkleTree.kernel_merkle_root_inplace
-- entry kernel_merkle_tree_full = MerkleTree.kernel_merkle_tree_full
