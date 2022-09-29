module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"

type U128 = BFieldElement.U128


module type PrimeFieldElement = {
  type t
  val zero : t
  val one : t
  val canonicalize : t -> t
  val new : i32 -> t
  val add : t -> t -> t
  val rem : t -> t -> t
  val sub : t -> t -> t
  val red : U128 -> u64
  val fastmul : u64 -> u64 -> u64
  val mul : u64 -> u64 -> t
  val pow : t -> t -> t
  val inv : t -> t
  val div : t -> t -> t
}

module arithmetic (PFE: PrimeFieldElement) = {

}


-- module PFElem
