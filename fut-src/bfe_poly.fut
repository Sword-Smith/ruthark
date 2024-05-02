module BFieldElement = import "BFieldElement"
module shared = import "shared"
module bfe_ntt_module = import "bfe_ntt"
def bfe_ntt = bfe_ntt_module.bfe_ntt
def bfe_intt = bfe_ntt_module.bfe_intt

type BFieldElement = BFieldElement.BFieldElement

type BfePolynomial [n] = { coefficients: [n]BFieldElement }

def new [n] (coefficients: [n]BFieldElement): BfePolynomial[n] =
    {coefficients = coefficients}

-- Given a polynomial P(x), produce P'(x) := P(α·x)
-- Evaluating P'(x) corresponds to evaluating P(α·x)
def scale [n] (alpha: BFieldElement) (poly: BfePolynomial [n]): BfePolynomial [n] =
    let powers_of_alpha = map (BFieldElement.mod_pow_i64 alpha) (iota n)
    let new_coefficients = map2 BFieldElement.mul powers_of_alpha poly.coefficients
    in { coefficients = new_coefficients }

def evaluate [n] (poly: BfePolynomial [n]) (x: BFieldElement): BFieldElement =
    -- TODO: Do we want to implement this with Horner evaluation?
    let powers_of_x = map (BFieldElement.mod_pow_i64 x) (iota n)
    in reduce (BFieldElement.+^) BFieldElement.zero (map2 (BFieldElement.*^) poly.coefficients powers_of_x) -- <-- works

def fast_coset_interpolate [n] (offset: BFieldElement) (values: [n]BFieldElement): BfePolynomial[n] =
  -- TODO: Consider writing a new function for `bfe_intt` since we already have an `omega`/generator
  let unscaled = bfe_intt values
  let poly = new unscaled
  in scale (BFieldElement.inverse offset) poly

def fast_coset_evaluate [n] (offset: BFieldElement) (order: i64) (poly: BfePolynomial[n]): [order]BFieldElement =
    let coefficients = (scale offset poly).coefficients
    let coefficients = coefficients ++ (replicate (order - n) BFieldElement.zero) :> [order]BFieldElement
    in bfe_ntt coefficients

 -- P(3) = 1 + 3*1 = 4
 -- P'(1) = 1 + 1*3 = 4
-- ==
-- entry: scale_unit_test
-- input { [1u64, 1u64, 0u64] 3u64 }
-- output { [1u64, 3u64, 0u64] }
entry scale_unit_test [n] (coefficients: [n]u64) (alpha: u64) =
    let alpha = BFieldElement.new alpha
    let coefficients = map BFieldElement.new coefficients
    let poly = new coefficients
    in map BFieldElement.value (scale alpha poly).coefficients

-- ==
-- entry: evaluate_unit_test
-- input { [12u64] 3u64 }
-- output { 12u64 }
-- input { [1u64, 1u64, 0u64] 3u64 }
-- output { 4u64 }
-- input { [1u64, 1u64, 1u64] 3u64 }
-- output { 13u64 }
-- input { [2u64, 5u64, 7u64] 3u64 }
-- output { 80u64 }
entry evaluate_unit_test [n] (coefficients: [n]u64) (x: u64) =
    let x = BFieldElement.new x
    let coefficients = map BFieldElement.new coefficients
    let poly = new coefficients
    in BFieldElement.value (evaluate poly x)

-- ==
-- entry: fast_coset_interpolate_and_evaluate_is_identity_pbt
-- random input { [1]u64 }
-- output { true }
-- random input { [2]u64 }
-- output { true }
-- random input { [4]u64 }
-- output { true }
-- random input { [8]u64 }
-- output { true }
-- random input { [16]u64 }
-- output { true }
-- random input { [32]u64 }
-- output { true }
-- random input { [64]u64 }
-- output { true }
entry fast_coset_interpolate_and_evaluate_is_identity_pbt [n] (input: [n]u64): bool =
    let offset = BFieldElement.new 7
    let input = map BFieldElement.new input
    let poly = fast_coset_interpolate offset input
    let values_again = fast_coset_evaluate offset n poly
    in shared.eq_arr BFieldElement.eq values_again input

-- ==
-- entry: fast_coset_evaluate_and_interpolate_is_identity_different_sizes
-- random input { [1]u64 }
-- output { true }
-- random input { [2]u64 }
-- output { true }
-- random input { [4]u64 }
-- output { true }
-- random input { [8]u64 }
-- output { true }
-- random input { [16]u64 }
-- output { true }
-- random input { [32]u64 }
-- output { true }
-- random input { [64]u64 }
-- output { true }
entry fast_coset_evaluate_and_interpolate_is_identity_different_sizes [n] (coefficients: [n]u64): bool =
    let offset = BFieldElement.new 7
    let coefficients = map BFieldElement.new coefficients
    let poly = new coefficients
    let values = fast_coset_evaluate offset (2*n) poly
    let coefficients_again = (fast_coset_interpolate offset values).coefficients
    let (should_be_coefficients_again, should_be_zeros) =
      (coefficients_again[0:n], coefficients_again[n:n+n] :> [n]BFieldElement)
    in shared.eq_arr BFieldElement.eq should_be_coefficients_again coefficients && and (map BFieldElement.is_zero should_be_zeros)
