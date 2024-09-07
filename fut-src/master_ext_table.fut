module ArithmeticDomain = import "arithmetic_domain"
module XFieldElement = import "XFieldElement"
module XfePolynomial = import "xfe_poly"
module BFieldElement = import "BFieldElement"
module MerkleTree = import "MerkleTree"
module Digest = import "Digest"
module Tip5 = import "Tip5"
module bfield_codec = import "bfield_codec"

let NUM_BASE_COLUMNS: i64 = 375
let NUM_COLUMNS: i64 = NUM_BASE_COLUMNS

type BFieldElement = BFieldElement.BFieldElement
type ArithmeticDomain = ArithmeticDomain.ArithmeticDomain
type XFieldElement = XFieldElement.XFieldElement
type XfePolynomial [n] = XfePolynomial.XfePolynomial [n]
type~ MerkleTree = MerkleTree.MerkleTree
type Digest = Digest.Digest
type Tip5 = Tip5.Tip5

let RATE = Tip5.RATE

-- NOTE: MasterExtTable is 
-- TODO: it might be more ram efficient to store data implicitly rather than in these types
type MasterExtTable [rows] [cols] = {

    num_trace_randomizers: i64,

    trace_domain: ArithmeticDomain,
    randomized_trace_domain : ArithmeticDomain,
    quotient_domain : ArithmeticDomain,
    fri_domain : ArithmeticDomain,

    randomized_trace_table: [rows][cols]XFieldElement,

    -- low_degree_extended_table: [][]XFieldElement, 
    -- interpolated_polynomials: []XfePolynomial[NUM_EXT_COLUMNS]
}

-- same for MasterExtTable and MasterBaseTable 
def evaluation_domain (table: MasterExtTable [] [] ) : ArithmeticDomain =
    if table.quotient_domain.len > table.fri_domain.len
    then table.quotient_domain
    else table.fri_domain

-- low-degree extend all columns of the randomized trace domain table. 
def low_degree_extend_all_columns [rows] [cols] (table: MasterExtTable [rows] [cols]) : [cols]XfePolynomial[] =  

    let randomized_trace_domain: ArithmeticDomain = table.randomized_trace_domain

    -- get randomized trace table
    let trace_table: [rows][cols]XFieldElement = table.randomized_trace_table

    -- flip to collumn major -- TODO Theres probably a cleverer way that doesnt require doing this
    let trace_columns: [cols][rows]XFieldElement=
        map 
        (\col_idx -> map (\row_idx -> trace_table[row_idx][col_idx])(iota rows)) 
        (iota cols)

    -- Perform the interpolation for each column
    let interpolated_polynomials =
        map 
        (\trace_column ->  ArithmeticDomain.interpolate_xfe_values randomized_trace_domain trace_column) 
        trace_columns

    in interpolated_polynomials


-- Futhark modules adaptation of rust Helper struct and function to absorb however many 
-- elements are available; used in the context of hashing rows in a streaming fashion.
type SpongeWithPendingAbsorb = {
    sponge: Tip5,
    pending_input: [RATE]BFieldElement,
    num_symbols_pending: i64
}   

module SpongeWithPendingAbsorb = {

    def new : SpongeWithPendingAbsorb = {
        sponge = Tip5.new #variable_length,
        pending_input = replicate RATE BFieldElement.zero,
        num_symbols_pending = 0
    } :> SpongeWithPendingAbsorb


    -- Similar to Tip5.absorb but buffers input elements until a full block is available.
    def absorb (self: SpongeWithPendingAbsorb) (input: []BFieldElement) : SpongeWithPendingAbsorb =

      -- loop symbols in the input
      let sponge = loop sponge = self for symbol in input do

        -- put next symbol into pending input
        let pending_input = copy sponge.pending_input
        let updated_pending_input: [Tip5.RATE]BFieldElement = 
          pending_input with [sponge.num_symbols_pending] = symbol  -- class var update

        -- increment num symbols pending
        let updated_num_symbols_pending: i64 = sponge.num_symbols_pending + 1  --- class var update

        -- if we've reached RATE num symbols pending, 
        -- absorb and restart the above filling process 
        let sponge = 
          -- if therre are enough sybols to absorb, do it
          if updated_num_symbols_pending == RATE then
    
            -- absorb using the internal Tip5 sponge
            let updated_sponge: Tip5 = Tip5.absorb sponge.sponge updated_pending_input 
            in {    
                sponge = updated_sponge,                 -- updated
                pending_input = updated_pending_input,   -- updated
                num_symbols_pending = 0 -- reset num sybols pending
            } :> SpongeWithPendingAbsorb

          else {
                sponge = sponge.sponge, -- unchanged 
                pending_input = take RATE updated_pending_input,  -- updated
                num_symbols_pending = updated_num_symbols_pending -- updated
            }  :> SpongeWithPendingAbsorb
        in sponge
      in sponge

    -- absorbs rest of pending input w/ zero padding
    def finalize (self: SpongeWithPendingAbsorb) : Digest = -- should updated sponge also be returned?
      
      -- pad input w/ [one, zero ,zero ...]
      let num_zeros_to_pad = RATE - (1 + self.num_symbols_pending)
      let pending_input = take self.num_symbols_pending self.pending_input
                          |> (\x -> x ++ [BFieldElement.one])
                          |> (\x -> x ++ (replicate num_zeros_to_pad BFieldElement.zero))
                          |> take Tip5.RATE

      -- absorb and squeeze the sponge
      let sponge: Tip5 = Tip5.absorb self.sponge pending_input
      let (digest, _) = Tip5.squeeze (copy sponge) 
      let digest =  take Digest.DIGEST_LENGTH digest -- tell compiler the size
      in {0 = digest} :> Digest
    }


-- NOTE: in the rust implementation of this function, the number of threads available for parallelism
-- is checked. It is then used to determine how many interpolant polynomials to hash in parallel during
-- each iteration of JIT hashing. There are multiple ways this could be ported to futhark, such as 
-- seting a constant number of threads for how many interpolants to process in parallel. The below
-- port processes each interpolant in sequence, but this could be easily modified to more closely match
-- that in the rust impelementation. The evaluation and hashing of each interpolant should still benefit
-- from the parallelism that happens for those processes, though.
def hash_all_fri_domain_rows_just_in_time
    (interpolants: []XfePolynomial[]) 
    (fri_domain: ArithmeticDomain)
    : []Digest = 

    -- init sponge states
    let init_sponges: []SpongeWithPendingAbsorb = 
      replicate fri_domain.len SpongeWithPendingAbsorb.new

    -- absorb codewords into sponges just in time
    let sponge_state = 
      loop (sponges, i) = (init_sponges, 0) for interpolant in interpolants do

        -- eval codeword over the fri domain
        let codeword: []BFieldElement = 
          ArithmeticDomain.evaluate_xfe_poly_over_domain fri_domain interpolant 
          |> bfield_codec.encode_arr_xfe

        -- absorb codeword into corresponding sponge
        let sponge_absorbed = SpongeWithPendingAbsorb.absorb (copy sponges[i]) codeword
        in (sponges with [i] = sponge_absorbed, i + 1)
      
    -- finalize codewords
    in map SpongeWithPendingAbsorb.finalize sponge_state.0

--  eval interpolants over fri domain and hash each row, merkleize resulting digests
def merkle_tree (interpolants: []XfePolynomial[]) (fri_domain: ArithmeticDomain) : MerkleTree =
    let hashed_rows: []Digest = 
      hash_all_fri_domain_rows_just_in_time interpolants fri_domain 
    in MerkleTree.from_digests hashed_rows


-- == 
-- entry: test_absorb_sponge_with_pending_absorb
-- input { [0u64, 1u64, 2u64, 3u64] [4u64, 5u64, 6u64, 7u64, 8u64, 9u64, 10u64, 11u64, 12u64, 13u64] }
-- output { [0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64] [0u64, 1u64, 2u64, 3u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64] 4i64 [13886772045657434313u64, 13821702462561574064u64, 16797697271999889561u64, 13817547174256396628u64, 12496231857312136970u64, 14125549128413978307u64, 4606913010038267158u64, 13305442125551575186u64, 17130135209073368178u64, 15371008984867536940u64, 6500756199737621736u64, 12380079174316527865u64, 4609325385470769829u64, 10462928785321372163u64, 10118270339443978388u64, 9896642526990573323u64] [10u64, 11u64, 12u64, 13u64, 4u64, 5u64, 6u64, 7u64, 8u64, 9u64] 4i64}
entry test_absorb_sponge_with_pending_absorb 
  (substring_0_values: []u64) 
  (substring_1_values: []u64)
  : ([]u64, -- sponge_state_after_one_absorb 
    []u64, -- pending_input_after_one_absorb 
    i64, -- num_pending_sybols_after_one_absorb 
    []u64, -- sponge_state_after_two_absorbs
    []u64, -- pending_input_after_two_absorbs
    i64) -- num_pending_sybols_after_two_absorbs
    = 

  -- convert substrings to Bfe arrays
  let substring_0: []BFieldElement = map BFieldElement.new substring_0_values
  let substring_1: []BFieldElement = map BFieldElement.new substring_1_values

  -- init swpa
  let init_sponge: SpongeWithPendingAbsorb = SpongeWithPendingAbsorb.new 
 
  -- call absorb onces on the first substring
  let sponge_one_absorb: SpongeWithPendingAbsorb =
    SpongeWithPendingAbsorb.absorb init_sponge substring_0

  -- get current state for return
  let sponge_state_after_one_absorb: []u64 = map BFieldElement.value sponge_one_absorb.sponge.state
  let pending_input_after_one_absorb: []u64 = map BFieldElement.value sponge_one_absorb.pending_input 
  let num_symbols_pending_after_one_absorb: i64 = sponge_one_absorb.num_symbols_pending

  -- call absorb again on the second substring
  let sponge_two_absorbs: SpongeWithPendingAbsorb = 
    SpongeWithPendingAbsorb.absorb sponge_one_absorb substring_1

  -- get updates state for return
  let sponge_state_after_two_absorbs: []u64 = map BFieldElement.value sponge_two_absorbs.sponge.state
  let pending_input_after_two_absorbs: []u64 = map BFieldElement.value sponge_two_absorbs.pending_input 
  let num_symbols_pending_after_two_absorbs: i64 = sponge_two_absorbs.num_symbols_pending

  in (
    sponge_state_after_one_absorb,
    pending_input_after_one_absorb,
    num_symbols_pending_after_one_absorb,
    sponge_state_after_two_absorbs,
    pending_input_after_two_absorbs,
    num_symbols_pending_after_two_absorbs,
  )

-- ==
-- entry: check_final_digest_sponge_with_pending_absorb
-- input { [0u64, 1u64, 2u64, 3u64] [4u64, 5u64, 6u64, 7u64, 8u64, 9u64, 10u64, 11u64, 12u64, 13u64] }
-- output { true [12922749756431966115u64, 5852969553998012914u64, 10492382927995344180u64, 12751217697759846191u64, 12039120402859971306u64] }
entry check_final_digest_sponge_with_pending_absorb  
  (substring_0_values: []u64) 
  (substring_1_values: []u64)
  : (bool, []u64) = 

  -- convert substrings to bfe arrs
  let substring_0: []BFieldElement = map BFieldElement.new substring_0_values
  let substring_1: []BFieldElement = map BFieldElement.new substring_1_values

  -- init swpa
  let init_sponge: SpongeWithPendingAbsorb = SpongeWithPendingAbsorb.new 
 
  -- call absorb onces on the first substring
  let sponge_one_absorb: SpongeWithPendingAbsorb =
    SpongeWithPendingAbsorb.absorb init_sponge substring_0

  -- call absorb again on the second substring
  let sponge_two_absorbs: SpongeWithPendingAbsorb = 
    SpongeWithPendingAbsorb.absorb sponge_one_absorb substring_1

  --finalize hash
  let digest: Digest = SpongeWithPendingAbsorb.finalize (copy sponge_two_absorbs)
  let digest_values: []u64 = map BFieldElement.value digest.0

  -- extexted digest should be the same as in hash_varlen
  let expected_digest: Digest = Tip5.hash_varlen (substring_0 ++ substring_1)
  let success = map2 BFieldElement.eq digest.0 expected_digest.0
    |> reduce (==) true 

  in (success, digest_values)