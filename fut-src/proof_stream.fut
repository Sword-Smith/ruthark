module Tip5 = import "Tip5"
module BFieldElement = import "BFieldElement"

type Tip5 = Tip5.Tip5
type BFieldElement = BFieldElement.BFieldElement



-- NOTE: ProofItem and ProofStream here are defined differently than in the original rust code
-- this is because the original rust code represents the ProofStream.items field as a 
-- Vec<ProofItem>, where each ProofItem can contain a variable size payload. This doesn't
-- translate well to futhark because it will lead to an irregular array. Instead, the payloads
-- for each proof item are stored contiguously witihin the ProofStream.items array, and the
-- ProofItem type is define as a way to index the correct start, end, and type of each payload.
type ProofItem = {
    
    -- payload start and end idx within contiguous items array
    start_idx: i64,
    end_idx: i64,

    -- original data structure variant (simulated enum)
    variant: i64    
}
type~ ProofStream = {
    items: []BFieldElement, -- stored contiguously
    items_location: []ProofItem,
    items_idx: i64,
    sponge: Tip5
}

-- constructor for ProofStream
def new : ProofStream ={
    items = [],
    items_location = [],
    items_idx = 0,
    sponge = Tip5.new #variable_length 
  }


