module BFieldElement = import "BFieldElement"
module shared = import "shared"
module bfe_ntt_module = import "bfe_ntt"
def bfe_ntt = bfe_ntt_module.bfe_ntt
def bfe_intt = bfe_ntt_module.bfe_intt

type BFieldElement = BFieldElement.BFieldElement

type BfePolynomial [n] = { coefficients: [n]BFieldElement }

let FAST_MULTIPLY_CUTOFF_THRESHOLD: i64 = 1 << 8

-- constructor
def new [n] (coefficients: [n]BFieldElement): BfePolynomial[n] =
    {coefficients = coefficients}

-- degree
let degree [n] (p: BfePolynomial [n]) : i64 =
    -- determine highest degre (mod trailing zeros)
    let len: i64 = n - 1
    in let new_deg = 
    loop (deg) = (len) 
    while (deg >= 0) && (BFieldElement.eq (p.coefficients[deg]) BFieldElement.zero) do
        deg - 1
    in new_deg

-- equality
def eq [n] [m] (p1: BfePolynomial [n]) (p2: BfePolynomial [m]) : bool =
      if (degree p1) != (degree p2) then false
      else 
        -- ensure compiler knows the lengths are the same
        let shared_len = length p1.coefficients -- TODO: trailing zeros would affect this
        let coeffs_1 = take shared_len p1.coefficients
        let coeffs_2 = take shared_len p2.coefficients
        -- check if the coefficients are the same
        let check = (map2 BFieldElement.eq (coeffs_1) (coeffs_2))        
        in reduce (\x y -> x && y) true check

-- zero
def zero : BfePolynomial [0] = { coefficients = [] }
def is_zero [n] (p: BfePolynomial [n]) : bool = eq p zero

-- one
def one : BfePolynomial [1] = { coefficients = [BFieldElement.one] }
def is_one [n] (p: BfePolynomial [n]) : bool = 
    (degree p) == 0 && (BFieldElement.eq (p.coefficients[0]) BFieldElement.one)

-- polynomial addition
def add [n] [m] (p1: BfePolynomial [n]) (p2: BfePolynomial [m]) : BfePolynomial [] = 
    -- determine longer polynomial
    let max_len = if n > m then n else m
    -- Extend both coefficient arrays to the maximum length with zeros
    let coeffs1 = p1.coefficients ++ replicate (max_len - n) BFieldElement.zero
    let coeffs2 = p2.coefficients ++ replicate (max_len - m) BFieldElement.zero
    -- Add corresponding coefficients (telling compiler the lengths are the same)
    in { coefficients = map2 BFieldElement.add (take max_len coeffs1) (take max_len coeffs2) }

-- Naive polynomial multiplication
let naive_multiply [n] [m] (p1: BfePolynomial [n]) (p2: BfePolynomial [m]) : BfePolynomial [] =
  let deg_lhs = degree p1
  let deg_rhs = degree p2
  -- if either polynomial is zero, return zero
  in if deg_lhs < 0 || deg_rhs < 0 then
    copy zero
  else -- perform convolutional polynomial multiplication
    let init_product = replicate (deg_lhs + deg_rhs + 1) BFieldElement.zero
    in let final_product = loop product = init_product for i in 0 ... deg_lhs do
          loop product = product for j in 0 ... deg_rhs do
            let new_coeff = BFieldElement.mul (p1.coefficients[i]) (p2.coefficients[j])
            let current_coeff = product[i + j]
            let updated_coeff = BFieldElement.add current_coeff new_coeff
            in product with [i + j] = updated_coeff
    in { coefficients = final_product }

-- Function to extend array to the next power of two size with zeros
let pad_with_zeros (coeffs : []BFieldElement) (desired_length : i64) : []BFieldElement =
  let current_length = length coeffs
  let zeros_to_add = desired_length - current_length
  let zeros = replicate zeros_to_add BFieldElement.zero
  in coeffs ++ zeros

-- Fast polynomial multiplication using NTT
let fast_multiply [n] [m] (p1: BfePolynomial [n]) (p2: BfePolynomial [m]) : BfePolynomial [] = 
    let degree: i64 = (degree p1) + (degree p2)
    in if degree < 0 then
        copy zero
    else   
        -- get order for NTT
        let order = shared.next_power_of_two_i64 (degree + 1)
        -- pad coeffs to order w/ zeros
        let lhs_coeffs = take order (pad_with_zeros p1.coefficients order)
        let rhs_coeffs = take order (pad_with_zeros p2.coefficients order)
        -- apply number theoretic transform
        let lhs_ntt = bfe_ntt lhs_coeffs
        let rhs_ntt = bfe_ntt rhs_coeffs
        -- element wise mul in the NTT domain
        let hadamard_product = map2 BFieldElement.mul lhs_ntt rhs_ntt
        -- invert the ntt
        let intt = bfe_intt hadamard_product
        -- truncate to the correct degree
        let final_coeffs = take (degree + 1) intt
        in { coefficients = final_coeffs } :> BfePolynomial []

-- multiplication
def multiply [n] [m] (p1: BfePolynomial [n]) (p2: BfePolynomial [m]) : BfePolynomial [] =
    if (degree p1) + (degree p2) < FAST_MULTIPLY_CUTOFF_THRESHOLD 
    then naive_multiply p1 p2
    else fast_multiply p1 p2
    

-- Given a polynomial P(x), produce P'(x) := P(α·x)
-- Evaluating P'(x) corresponds to evaluating P(α·x)
def scale [n] (alpha: BFieldElement) (poly: BfePolynomial [n]): BfePolynomial [n] =
    let powers_of_alpha = map (BFieldElement.mod_pow_i64 alpha) (iota n)
    let new_coefficients = map2 BFieldElement.mul powers_of_alpha poly.coefficients
    in { coefficients = new_coefficients }

def evaluate [n] (poly: BfePolynomial [n]) (x: BFieldElement): BFieldElement =
    -- TODO: Do we want to implement this with Horner evaluation?
    let powers_of_x = map (BFieldElement.mod_pow_i64 x) (iota n)
    in reduce (BFieldElement.+^) BFieldElement.zero (map2 (BFieldElement.*^) poly.coefficients powers_of_x)

def fast_coset_interpolate [n] (offset: BFieldElement) (values: [n]BFieldElement): BfePolynomial[n] =
  -- TODO: Consider writing a new function for `bfe_intt` since we already have an `omega`/generator
  let unscaled = bfe_intt values
  let poly = new unscaled
  in scale (BFieldElement.inverse offset) poly

def fast_coset_evaluate [n] (offset: BFieldElement) (order: i64) (poly: BfePolynomial[n]): [order]BFieldElement =
    let coefficients = (scale offset poly).coefficients
    let coefficients = coefficients ++ (replicate (order - n) BFieldElement.zero) :> [order]BFieldElement
    in bfe_ntt coefficients

-- Low-degree extend a single column
def low_degree_extend
    [n]
    (offset: BFieldElement)
    (extension_factor: i64)
    (randomized_trace: [n]BFieldElement)
    : ([extension_factor * n]BFieldElement, BfePolynomial[n]) =
    let interpolation_polynomial = fast_coset_interpolate BFieldElement.one randomized_trace
    let lde_codeword = fast_coset_evaluate offset (extension_factor * n) interpolation_polynomial
    in (lde_codeword, interpolation_polynomial)

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

-- ==
-- entry: low_degree_extend_test
-- input { [12u64, 12u64] 2i64 }
-- output { [12u64, 12u64, 12u64, 12u64] [12u64, 0u64] }
entry low_degree_extend_test [n] (trace: [n]u64) (extension_factor: i64): ([extension_factor*n]u64, [n]u64) =
    let trace = map BFieldElement.new trace
    let (lde_codeword, interpolant) = low_degree_extend (BFieldElement.new 7) extension_factor trace
    let interpolant_coefficients = map BFieldElement.value interpolant.coefficients
    in (map BFieldElement.value lde_codeword, interpolant_coefficients)

-- == 
-- entry: test_zero
-- input {}
-- output { true }
entry test_zero : bool = is_zero zero

-- == 
-- entry: test_one
-- input {}
-- output { true }
entry test_one : bool = is_one one

-- == 
-- entry: polynomial_zero_is_neutral_element_for_addition
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry polynomial_zero_is_neutral_element_for_addition (a: []u64) : bool = 
    let poly = new (map BFieldElement.new a)
    in eq poly (add poly zero)
    
-- == 
-- entry: polynomial_addition_is_associative 
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] [7u64, 8u64, 9u64] [10u64, 11u64, 12u64, 13u64] }
-- output { true }
entry polynomial_addition_is_associative (a: []u64) (b: []u64) (c: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    let p3 = new (map BFieldElement.new c)
    -- (p1 + p2) + p3 == p1 + (p2 + p3)
    let sum_1 = add (add p1 p2) p3
    let sum_2 = add p1 (add p2 p3)
    in eq sum_1 sum_2

-- == 
-- entry: polynomial_addition_is_commutative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { true }
entry polynomial_addition_is_commutative (a: []u64) (b: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    in eq (add p1 p2) (add p2 p1)


-- == 
-- entry: polynomial_addition_test_vector
-- input {}
-- output { true }
entry polynomial_addition_test_vector : bool = 
    -- same length
    let p1 = new [BFieldElement.new 1, BFieldElement.new 2, BFieldElement.new 3]
    let p2 = new [BFieldElement.new 4, BFieldElement.new 5, BFieldElement.new 6]
    let p3_actual = add p1 p2
    let p3_expected = new [BFieldElement.new 5, BFieldElement.new 7, BFieldElement.new 9]
    -- check if the coefficients are the same
    let same_degree_check = eq p3_actual p3_expected

    -- longer lhs
    let p1 = new [BFieldElement.new 1, BFieldElement.new 2, BFieldElement.new 3, BFieldElement.new 4]
    let p2 = new [BFieldElement.new 4, BFieldElement.new 5, BFieldElement.new 6]
    let p3_actual = add p1 p2
    let p3_expected = new [BFieldElement.new 5, BFieldElement.new 7, BFieldElement.new 9, BFieldElement.new 4]
    -- check if the coefficients are the same
    let larger_lhs_degree_check = eq p3_actual p3_expected

    -- longer rhs
    let p1 = new [BFieldElement.new 1, BFieldElement.new 2, BFieldElement.new 3]
    let p2 = new [BFieldElement.new 4, BFieldElement.new 5, BFieldElement.new 6, BFieldElement.new 7]
    let p3_actual = add p1 p2
    let p3_expected = new [BFieldElement.new 5, BFieldElement.new 7, BFieldElement.new 9, BFieldElement.new 7]
    -- check if the coefficients are the same
    let larger_rhs_degree_check  = eq p3_actual p3_expected

    -- ensure all checks pass
    in same_degree_check && larger_lhs_degree_check && larger_rhs_degree_check

-- == 
-- entry: fast_multiply_test_vector
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64, 8u64, 12u64] }
-- output { [4u64, 13u64, 28u64, 35u64, 46u64, 48u64, 36u64] }
entry fast_multiply_test_vector (a: []u64) (b: []u64) : []u64 = 
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    let p3 = fast_multiply p1 p2
    in map BFieldElement.value p3.coefficients

-- == 
-- entry: fast_multiply_same_as_naive 
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { true }
entry fast_multiply_same_as_naive (a: []u64) (b: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    in eq (fast_multiply p1 p2) (naive_multiply p1 p2)

-- == 
-- entry: polynomial_one_is_neutral_element_for_multiplication
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry polynomial_one_is_neutral_element_for_multiplication (a: []u64) : bool = 
    let poly = new (map BFieldElement.new a)
    in eq poly (multiply poly one)

-- == 
-- entry: multiplication_by_zero_is_zero
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry multiplication_by_zero_is_zero (a: []u64) : bool = 
    let poly = new (map BFieldElement.new a)
    in eq zero (multiply poly zero)

-- == 
-- entry: naive_multiply_test_vector
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64, 8u64, 12u64] }
-- output { [4u64, 13u64, 28u64, 35u64, 46u64, 48u64, 36u64] }
entry naive_multiply_test_vector (a: []u64) (b: []u64) : []u64 = 
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    let p3 = naive_multiply p1 p2
    in map BFieldElement.value p3.coefficients    

-- ==
-- entry: polynomial_multiplication_is_associative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] [7u64, 8u64, 9u64] }
-- output { true }
entry polynomial_multiplication_is_associative (a: []u64) (b: []u64) (c: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    let p3 = new (map BFieldElement.new c)
    -- (p1 * p2) * p3 == p1 * (p2 * p3)
    let product_1 = multiply (multiply p1 p2) p3
    let product_2 = multiply p1 (multiply p2 p3)
    in eq product_1 product_2

-- == 
-- entry: polynomial_multiplication_is_commutative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { true }
entry polynomial_multiplication_is_commutative (a: []u64) (b: []u64) : bool = 
    -- init polys
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    -- p1 * p2 == p2 * p1
    let product_1 = multiply p1 p2
    let product_2 = multiply p2 p1
    in eq product_1 product_2
