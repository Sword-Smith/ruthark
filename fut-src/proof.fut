module BFieldElement = import "BFieldElement"
module Digest = import "Digest"

type BFieldElement = BFieldElement.BFieldElement
type Digest = Digest.Digest

type~ Proof = { 0: []BFieldElement } 

type~ Claim = {

    -- The hash digest of the program that was executed. The hash function in use is Tip5.
    program_digest: Digest,

    -- The publid input of the computation
    input: []BFieldElement,

    -- The public output of the computation
    output: []BFieldElement

}