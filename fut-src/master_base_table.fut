module ArithmeticDomain = import "arithmetic_domain"
module BFieldElement = import "BFieldElement"
module bfe_poly = import "bfe_poly"
module SpongeWithPendingAbsorb = import "sponge_with_pending_absorb"
module Digest = import "Digest"
module MerkleTree = import "MerkleTree"

type ArithmeticDomain = ArithmeticDomain.ArithmeticDomain
type BFieldElement = BFieldElement.BFieldElement
type BfePolynomial [n] = bfe_poly.BfePolynomial [n]
type SpongeWithPendingAbsorb = SpongeWithPendingAbsorb.SpongeWithPendingAbsorb
type Digest = Digest.Digest
type~ MerkleTree = MerkleTree.MerkleTree

let AIR_TARGET_DEGREE: i64 = 4

type~ MasterBaseTable [rows] [cols] = {

    -- num_randomizers: i64,

    -- program_table_len: i64,
    -- main_execution_len: i64,
    -- op_stack_table_len: i64,
    -- ram_table_len: i64,
    -- hash_coprocessor_execution_len: i64,
    -- cascade_table_len: i64,
    -- u32_coprocesor_execution_len: i64,

    -- trace_domain: ArithmeticDomain,
    randomized_trace_domain: ArithmeticDomain,
    -- quotient_domain: ArithmeticDomain,
    -- fri_domain: ArithmeticDomain,

    randomized_trace_table: [rows][cols]BFieldElement,
    -- low_degree_extended_table: [][]BFieldElement,
    -- interpolation_polynomials: []BfePolynomial[]
}


-- low-degree extend all columns of the randomized trace domain table. 
def low_degree_extend_all_columns [rows] [cols] (table: MasterBaseTable [rows] [cols]) : [cols]BfePolynomial[] =  

    let randomized_trace_domain: ArithmeticDomain = table.randomized_trace_domain

    -- get randomized trace table
    let trace_table: [rows][cols]BFieldElement = table.randomized_trace_table

    -- flip to collumn major 
    let trace_columns: [cols][rows]BFieldElement=
        map 
        (\col_idx -> map (\row_idx -> trace_table[row_idx][col_idx])(iota rows)) 
        (iota cols)

    -- Perform the interpolation for each column
    let interpolated_polynomials =
        map 
        (\trace_column ->  ArithmeticDomain.interpolate_bfe_values randomized_trace_domain trace_column) 
        trace_columns

    in interpolated_polynomials

-- eval interpolants over fri domain and hash rows
def hash_all_fri_domain_rows_just_in_time 
    (interpolants: []BfePolynomial[]) (fri_domain: ArithmeticDomain) : []Digest = 

    -- init sponge states
    let init_sponges: []SpongeWithPendingAbsorb = 
      replicate fri_domain.len SpongeWithPendingAbsorb.new

    -- absorb codewords into sponges just in time
    let (sponges_absorbed, _) = 
      loop (sponges, i) = (init_sponges, 0) for interpolant in interpolants do

        -- eval codeword over the fri domain
        let codeword: [][]BFieldElement = 
          ArithmeticDomain.evaluate_bfe_poly_over_domain fri_domain interpolant 
          |> map (\x -> [x])

      -- Absorb each codeword into every sponge just in time
        let updated_sponges = map2 SpongeWithPendingAbsorb.absorb sponges codeword

        in (updated_sponges, i + 1)
      
    -- finalize codewords
    in map SpongeWithPendingAbsorb.finalize sponges_absorbed

--  eval interpolants over fri domain and hash each row, merkleize resulting digests
def merkle_tree (interpolants: []BfePolynomial[]) (fri_domain: ArithmeticDomain) : MerkleTree =
    let hashed_rows: []Digest = 
      hash_all_fri_domain_rows_just_in_time interpolants fri_domain 
    in MerkleTree.from_digests hashed_rows
