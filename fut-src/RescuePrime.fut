-- Implementation of https://eprint.iacr.org/2020/1143.pdf
import "lib/github.com/diku-dk/linalg/linalg"
module BFieldElement = import "BFieldElement"
module Fp = BFieldElement
type Fp = BFieldElement.BFieldElement
module Utils = import "Utils"
module Parameters = import "RescuePrimeParameters"


type DefaultParameters = Parameters.DefaultParameters
def parameters : DefaultParameters = Parameters.default_parameters
def rate = parameters.rate -- parameters.m - parameters.capacity
def m = parameters.m
type State             = [Parameters.m]Fp
type~ InputSequence    = []Fp
type InputSequence10   = [Parameters.rate]Fp
type RescuePrimeDigest = [Parameters.rescue_prime_digest_length]Fp


def vecadd = map2 Fp.add


def dotprod [n] (xs: [n]Fp) (ys: [n]Fp): Fp =
  reduce (Fp.add) (Fp.zero) (map2 (Fp.mul) xs ys)


def matvecmul [n][m] (xss: [n][m]Fp) (ys: [m]Fp) =
  map (dotprod ys) xss


def rescue_XLIX_round
  (parameters: DefaultParameters)
  (state: State)
  (i: i64)
  : State
  =
  -- S-box
  let state1 : State = map (\s -> Fp.powmod s parameters.alpha) state
  -- MDS
  let state2 : State = matvecmul parameters.MDS state1
  -- 1st Round Constants
  let offset1 : i64 = i*2*m
  let round_constants_1st = parameters.round_constants[offset1:offset1+m] :> State
  let state3 : State = vecadd state2 round_constants_1st
  -- Inverse S-Box
  let state4 : State = map (\s -> Fp.powmod s parameters.alphainv) state3
  -- MDS
  let state5 : State = matvecmul (parameters.MDS) state4
  -- 2nd Round Constants
  let offset2 = (i*2+1)*m
  let round_constants_2nd = parameters.round_constants[offset2:offset2+m] :> State
  let state6 : State = vecadd state5 round_constants_2nd
   in state6


def rescue_XLIX_permutation
  (parameters: DefaultParameters)
  (state: State)
  : State
  =
  loop state = state for i < parameters.N do
    rescue_XLIX_round parameters state (i64.i32 i)


entry rescue_prime_hash
  (parameters : DefaultParameters)
  (input_sequence : InputSequence)
  : RescuePrimeDigest
  =
  let input_sequence = assert (length input_sequence % rate == 0) input_sequence
  let chunks_count = (length input_sequence) / rate

  -- initialize state to all zeroes
  let init_state : State = replicate parameters.m Fp.zero :> State

  let final_state =
    loop state = init_state for i < chunks_count do
      let offset = i * rate
      let chunk: State =
        input_sequence[offset:offset+rate] ++ (replicate parameters.capacity Fp.zero) :> State
      let state1: State = vecadd state chunk
       in rescue_XLIX_permutation parameters state1

   in final_state[:Parameters.rescue_prime_digest_length] :> RescuePrimeDigest


entry rescue_prime_hash_10
  (parameters : DefaultParameters)
  (input_sequence : InputSequence10)
  : RescuePrimeDigest
  =
  let input_sequence = assert ((length input_sequence) == 10) input_sequence

  let init_state : State =
    input_sequence ++ [Fp.one] ++ replicate (parameters.capacity - 1) Fp.zero :> State

  let final_state = rescue_XLIX_permutation parameters init_state
   in final_state[:Parameters.rescue_prime_digest_length] :> RescuePrimeDigest

entry rescue_prime_hash_10_default_parameters = rescue_prime_hash_10 parameters

entry rescue_prime_hash_varlen
  (parameters : DefaultParameters)
  (input_sequence : InputSequence)
  : RescuePrimeDigest
  =
  let padding_zeroes = (rate - (length input_sequence + 1) % rate) % rate
  let padded_sequence = input_sequence ++ [Fp.one] ++ replicate padding_zeroes Fp.zero
  let padded_sequence = assert (((length padded_sequence) % rate) == 0) padded_sequence
  let chunks_count = (length padded_sequence) / rate

  let init_state : State = replicate parameters.m Fp.zero :> State

  let final_state =
    loop state = init_state for i < chunks_count do
      let offset = i * rate
      let chunk_with_padding: State =
        (padded_sequence[offset:offset+rate] ++ (replicate parameters.capacity Fp.zero)) :> State
      let state1: State = vecadd state chunk_with_padding
       in rescue_XLIX_permutation parameters state1

   in final_state[:Parameters.rescue_prime_digest_length] :> RescuePrimeDigest

