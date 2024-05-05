module Digest = import "Digest"
module BFieldElement = import "BFieldElement"

type Digest = Digest.Digest
type BFieldElement = BFieldElement.BFieldElement

let STATE_SIZE: i64 = 16
let RATE: i64 = 10

type Domain = #variable_length | #fixed_length

type Tip5 = { state: [STATE_SIZE]BFieldElement }

def new
  (domain: Domain)
  : Tip5 =
  match domain
  case #variable_length -> { state = replicate STATE_SIZE BFieldElement.zero }
  case #fixed_length -> { state = (replicate RATE BFieldElement.zero) ++ replicate (STATE_SIZE - RATE) BFieldElement.zero :> [STATE_SIZE]BFieldElement }

-- def hash_pair
--  (left: Digest)
--  (right: Digest)
--  : Digest
