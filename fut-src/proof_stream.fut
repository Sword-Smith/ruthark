module Tip5 = import "Tip5"
module BFieldElement = import "BFieldElement"
module Digest = import "Digest"
module bfield_codec = import "bfield_codec"

type Tip5 = Tip5.Tip5
type BFieldElement = BFieldElement.BFieldElement
type Digest = Digest.Digest

-- NOTE: ProofItem and ProofStream here are defined differently than in the original rust code
-- this is because the original rust code represents the ProofStream.items field as a 
-- Vec<ProofItem>, where each ProofItem can contain a variable size payload. This doesn't
-- translate well to futhark because it will lead to an irregular array. Instead, the payloads
-- for each proof item are stored contiguously witihin the ProofStream.items array, and the
-- ProofItem type is define as a way to index the correct start, end, and variant of each payload.
type ProofItem = {
    
    -- payload start and end idx within contiguous items array
    start_idx: i64,
    end_idx: i64,

    -- original data structure variant (simulated enum)
    variant: i64    
}
type~ ProofStream = {
    
    items: []BFieldElement, -- stored contiguously
    item_locations: []ProofItem,
    items_idx: i64,

    sponge: Tip5
}

-- constructor for ProofStream
def new : ProofStream ={
    
    -- NOTE: item_locations[0] is never used
    items = [BFieldElement.zero],
    item_locations = [{start_idx = 0i64, end_idx = 1i64, variant = 0i64}], 
    items_idx = 0,
    
    sponge = Tip5.new #variable_length 
}

-- transcript len
def transcript_length (self: ProofStream) : i64 = length self.items

-- Alters the Fiat-Shamir's sponge state with the encoding of the given item.
-- Does _not_ record the given item in the proof stream.
-- This is useful for items that are not sent to the verifier, _e.g._, the
def alter_fiat_shamir_state_with (self: ProofStream) (encoded_item: []BFieldElement) : ProofStream =
    self with sponge = Tip5.pad_and_absorb_all self.sponge encoded_item 

-- Addionally, the macro rule proof_items! from triton-vm/src/proof_item.rs will also require 
-- some significant modification as there is no meta programming in futhark. For now, there 
-- will be seperate enqueue/dequeue/.. for the different payload variants. This means also 
-- means that the Fiat-Shamir heuristic will be performed implicitly within each type specific
-- method.
def enqueue_MerkleRoot (proof_stream: ProofStream) (root: Digest) : ProofStream =
    -- merkle root is _in_ the fiat shamir heuristic
    let proof_stream = alter_fiat_shamir_state_with proof_stream root.0
    in proof_stream with items = proof_stream.items ++ root.0

def enqueue_Log2PaddedHeight (proof_stream: ProofStream) (l2ph: u32) : ProofStream =
    -- merkle root is _not_in_ the fiat shamir heuristic
    proof_stream with items = proof_stream.items ++ [bfield_codec.encode_u32 l2ph]

-- recieve a merkle root proof item from prover as verifier
def dequeue_MerkleRoot (proof_stream: ProofStream) : (ProofStream, Digest) = 
  -- locate and extract payload
  let loc: ProofItem = proof_stream.item_locations[length proof_stream.item_locations]
  let root = take (loc.end_idx - loc.start_idx) (drop loc.start_idx proof_stream.items) 
             |> \root -> { 0 = root } :> Digest
  
  -- fiat shamir
  let proof_stream' = proof_stream with items_idx = proof_stream.items_idx + 1
  let proof_stream'' =  alter_fiat_shamir_state_with proof_stream' root.0

  in  (proof_stream'', root)
