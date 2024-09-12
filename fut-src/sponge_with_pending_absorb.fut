module Tip5 = import "Tip5"
module BFieldElement = import "BFieldElement"
module Digest = import "Digest"

type Tip5 = Tip5.Tip5
type BFieldElement = BFieldElement.BFieldElement
type Digest = Digest.Digest

let RATE = Tip5.RATE



-- Futhark modules adaptation of rust Helper struct and function to absorb however many 
-- elements are available; used in the context of hashing rows in a streaming fashion.
type SpongeWithPendingAbsorb = {
    sponge: Tip5,
    pending_input: [RATE]BFieldElement,
    num_symbols_pending: i64
}   


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
