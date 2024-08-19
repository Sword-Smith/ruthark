module BFieldElement = import "BFieldElement"
module shared = import "shared"
module bfe_ntt_module = import "bfe_ntt"
def bfe_ntt = bfe_ntt_module.bfe_ntt
def bfe_intt = bfe_ntt_module.bfe_intt

type BFieldElement = BFieldElement.BFieldElement

type BfePolynomial [n] = { coefficients: [n]BFieldElement }

let FAST_MULTIPLY_CUTOFF_THRESHOLD: i64 = 1 << 8

-- constructor from BFieldElement array
def new [n] (coefficients: [n]BFieldElement): BfePolynomial[n] =
    {coefficients = coefficients}

-- constructor from u64 array
def new_from_arr_u64 (coefficients: []u64): BfePolynomial [] = 
    map BFieldElement.new coefficients |> new
    
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
    -- pad shorter polynomial with zeros
    let n_len = length p1.coefficients
    let m_len = length p2.coefficients
    let max_len = if n_len > m_len then n_len else m_len
    -- Extend both polynomials to the maximum length by appending zeros if necessary
    let coeffs_1 = p1.coefficients ++ replicate (max_len - n_len) BFieldElement.zero
    let coeffs_2 = p2.coefficients ++ replicate (max_len - m_len) BFieldElement.zero
    -- Check if the extended coefficients are the same
    let check = map2 BFieldElement.eq (take max_len coeffs_1) (take max_len coeffs_2)
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

-- negation
def neg [n] (p: BfePolynomial [n]) : BfePolynomial [n] =
    { coefficients = map BFieldElement.neg p.coefficients }

-- subtraction
def sub (p1: BfePolynomial []) (p2: BfePolynomial []) : BfePolynomial [] =
    add p1 (neg p2) 

-- determines leading coefficient
-- returns a tuple w/ leading coeff and a flag indicating ig the poly is zero
-- The flag is implemented bc futhark does not have Options/Maybes
def leading_coefficient [n] (poly: BfePolynomial [n]) : (BFieldElement, bool) =
    let deg: i64 = degree poly 
    in if (deg == -1) 
    then (BFieldElement.zero, false)
    else (poly.coefficients[deg], true)

-- removes trailing zeros
def normalize [n] (poly: BfePolynomial [n]) : BfePolynomial [] =
    let deg: i64 = degree poly
    in if deg < 0
    then copy zero
    else { coefficients = take (deg + 1) poly.coefficients }

def naive_divide'' 
  (rev_quotient: []BFieldElement) 
  (remainder: BfePolynomial []) 
  (normal_rev_divisor: []BFieldElement)
  (divisor_lc_inv: BFieldElement)
  : ([]BFieldElement, BfePolynomial[]) =
  -- pop
  let remainder_lc = remainder.coefficients[length remainder.coefficients-1] 
  let remainder = take (length remainder.coefficients - 1) remainder.coefficients |> new
  -- compute and push quotient coefficient
  let quotient_coeff = BFieldElement.mul remainder_lc divisor_lc_inv
  let rev_quotient = rev_quotient ++ [quotient_coeff]

  in if BFieldElement.is_zero quotient_coeff then (rev_quotient, remainder)
  else 
    let remainder_degree = (length remainder.coefficients) |> u64.i64 |> \x -> shared.saturating_sub_u64 x 1 |> i64.u64
    let (_, remainder_coeffs) = 
      loop (i, remainder_coeffs) = (0i64, copy remainder.coefficients) 
      for divisor_coeff in (drop 1 normal_rev_divisor) do
        let remainder_coeffs = remainder_coeffs with [remainder_degree - i] = 
          BFieldElement.mul quotient_coeff divisor_coeff
          |> \x -> BFieldElement.sub remainder_coeffs[remainder_degree - i] x

          in (i+1, remainder_coeffs)

    let remainder = new remainder_coeffs 
    in (rev_quotient, remainder)
    
def naive_divide' [n] [m] 
    (dividend: BfePolynomial [n]) 
    (divisor: BfePolynomial [m]) 
    (quotient_degree: i64) 
    (divisor_lc_inv: BFieldElement)
    : (BfePolynomial [], BfePolynomial []) = 

    -- quotient is built from back to fron, must be reversed later
    let rev_quotient = [] :> []BFieldElement
    let remainder = normalize dividend

    -- The divisor is also iterated back to front
    let divisor_coefficients =  divisor.coefficients
    let rev_divisor =  BFieldElement.reverse_array divisor_coefficients
    let normal_rev_divisor = normalize (new rev_divisor)

    let (rev_quotient, remainder) =
        loop (rev_quotient, remainder) = (rev_quotient, remainder) for _ in 0...quotient_degree do
            naive_divide'' rev_quotient remainder normal_rev_divisor.coefficients divisor_lc_inv

    -- reverse and convert to poly
    let quotieint = BFieldElement.reverse_array rev_quotient |> new
    in (quotieint, remainder)

def naive_divide [n] [m] (dividend: BfePolynomial [n]) (divisor: BfePolynomial [m]) 
    : (BfePolynomial [], BfePolynomial []) = 
    -- expect divisor should be non-zero
    let divisor_lc :BFieldElement = leading_coefficient divisor |> \(lc, some) -> assert (some) lc 
    let divisor_lc_inv :BFieldElement = BFieldElement.inverse divisor_lc
    let quotient_degree: i64 = (degree dividend) - (degree divisor)
    
    in if quotient_degree < 0 then (copy zero, dividend) -- indivisible
    else naive_divide' dividend divisor quotient_degree divisor_lc_inv

-- extended euclidean algorithm
def xgcd (x: BfePolynomial []) (y: BfePolynomial [])
    : (BfePolynomial [], BfePolynomial [], BfePolynomial []) =

    let (a_factor, a1) = (one, zero)
    let (b_factor, b1) = (zero, one)

    let (x, _, a_factor, _, b_factor, _) = 
        loop (x, y, a_factor, a1, b_factor, b1) = (x, y, a_factor, a1, b_factor, b1)
        while not (is_zero y) do
            let (quotient, remainder) = naive_divide x y
            let c = sub a_factor (multiply quotient a1)
            let d = sub b_factor (multiply quotient b1)

            -- reorder bindings
            in (y, remainder, a1, c, b1, d)

    -- normalizes result to ensure the gcd. _i.e_, 'x' has leading coefficient 1
    let lc_inv = 
        leading_coefficient x 
        |> \(lc, some) -> if some then lc else BFieldElement.one
        |> BFieldElement.inverse
    let normalizer [n] (poly: BfePolynomial [n]) : BfePolynomial[n] = 
        map (BFieldElement.mul lc_inv) poly.coefficients |> new
    let (x, a, b) = (normalizer x, normalizer a_factor, normalizer b_factor)
    in (x, a, b)
    
-- chunks polynomial coefficients into chunks of a given length
-- smaller than chunk_length chunks are padded with zeros
def chunk_coefficients [n] (poly: BfePolynomial [n]) (chunk_length: i64) : [][]BFieldElement =
    let num_chunks = (n + chunk_length - 1) // chunk_length

    -- Initialize an empty array to hold the chunks
    let chunks = loop chunks = [] while num_chunks > length chunks do
        let i = length chunks
        let chunk_start = i * chunk_length
        let chunk_end = i64.min ((i + 1) * chunk_length) n

        -- Slice the chunk of coefficients
        let chunk_coeffs = poly.coefficients[chunk_start:chunk_end]

        -- pad chunks smaller than chunk_length w/ zeroes, and tell compiler the length
        let chunk_coeffs = 
            chunk_coeffs ++ replicate (chunk_length - length chunk_coeffs) BFieldElement.zero
        let chunk_coeffs = take chunk_length chunk_coeffs

        -- Append
        in chunks ++ [chunk_coeffs]
    in chunks
    

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
    let poly = new_from_arr_u64 coefficients
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
    let poly = new_from_arr_u64 coefficients
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
    let poly = new_from_arr_u64 a
    in eq poly (add poly zero)
    
-- == 
-- entry: polynomial_addition_is_associative 
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] [7u64, 8u64, 9u64] [10u64, 11u64, 12u64, 13u64] }
-- output { true }
entry polynomial_addition_is_associative (a: []u64) (b: []u64) (c: []u64) : bool = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    let p3 = new_from_arr_u64 c
    -- (p1 + p2) + p3 == p1 + (p2 + p3)
    let sum_1 = add (add p1 p2) p3
    let sum_2 = add p1 (add p2 p3)
    in eq sum_1 sum_2

-- == 
-- entry: polynomial_addition_is_commutative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { true }
entry polynomial_addition_is_commutative (a: []u64) (b: []u64) : bool = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    in eq (add p1 p2) (add p2 p1)

-- == 
-- entry: polynomial_addition_test_vector
-- input {}
-- output { true }
entry polynomial_addition_test_vector : bool = 
    -- same length
    let p1 = new_from_arr_u64 [1, 2, 3]
    let p2 = new_from_arr_u64 [4, 5, 6]
    let p3_actual = add p1 p2
    let p3_expected = new_from_arr_u64 [5, 7, 9]
    -- check if the coefficients are the same
    let same_degree_check = eq p3_actual p3_expected

    -- longer lhs
    let p1 = new_from_arr_u64 [1, 2, 3, 4]
    let p2 = new_from_arr_u64 [4, 5, 6]
    let p3_actual = add p1 p2
    let p3_expected = new_from_arr_u64 [5, 7, 9, 4]
    -- check if the coefficients are the same
    let larger_lhs_degree_check = eq p3_actual p3_expected

    -- longer rhs
    let p1 = new_from_arr_u64 [1, 2, 3]
    let p2 = new_from_arr_u64 [4, 5, 6, 7]
    let p3_actual = add p1 p2
    let p3_expected = new_from_arr_u64 [5, 7, 9, 7]
    -- check if the coefficients are the same
    let larger_rhs_degree_check  = eq p3_actual p3_expected

    -- ensure all checks pass
    in same_degree_check && larger_lhs_degree_check && larger_rhs_degree_check

-- == 
-- entry: fast_multiply_test_vector
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64, 8u64, 12u64] }
-- output { [4u64, 13u64, 28u64, 35u64, 46u64, 48u64, 36u64] }
entry fast_multiply_test_vector (a: []u64) (b: []u64) : []u64 = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    let p3 = fast_multiply p1 p2
    in map BFieldElement.value p3.coefficients

-- == 
-- entry: fast_multiply_same_as_naive 
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { true }
entry fast_multiply_same_as_naive (a: []u64) (b: []u64) : bool = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    in eq (fast_multiply p1 p2) (naive_multiply p1 p2)

-- == 
-- entry: polynomial_one_is_neutral_element_for_multiplication
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry polynomial_one_is_neutral_element_for_multiplication (a: []u64) : bool = 
    let poly = new_from_arr_u64 a
    in eq poly (multiply poly one)

-- == 
-- entry: multiplication_by_zero_is_zero
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry multiplication_by_zero_is_zero (a: []u64) : bool = 
    let poly = new_from_arr_u64 a
    in eq zero (multiply poly zero)

-- == 
-- entry: naive_multiply_test_vector
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64, 8u64, 12u64] }
-- output { [4u64, 13u64, 28u64, 35u64, 46u64, 48u64, 36u64] }
entry naive_multiply_test_vector (a: []u64) (b: []u64) : []u64 = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    let p3 = naive_multiply p1 p2
    in map BFieldElement.value p3.coefficients    

-- ==
-- entry: polynomial_multiplication_is_associative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] [7u64, 8u64, 9u64] }
-- output { true }
entry polynomial_multiplication_is_associative (a: []u64) (b: []u64) (c: []u64) : bool = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    let p3 = new_from_arr_u64 c
    -- (p1 * p2) * p3 == p1 * (p2 * p3)
    let product_1 = multiply (multiply p1 p2) p3
    let product_2 = multiply p1 (multiply p2 p3)
    in eq product_1 product_2

-- == 
-- entry: polynomial_multiplication_is_commutative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { true }
entry polynomial_multiplication_is_commutative (a: []u64) (b: []u64) : bool = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    -- p1 * p2 == p2 * p1
    let product_1 = multiply p1 p2
    let product_2 = multiply p2 p1
    in eq product_1 product_2

-- ==
-- entry: chunk_coefficients_unit_test
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64, 7u64, 8u64] 3i64 }
-- output { [[1u64, 2u64, 3u64], [4u64, 5u64, 6u64], [7u64, 8u64, 0u64]] }
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64, 7u64, 8u64] 4i64 }
-- output { [[1u64, 2u64, 3u64, 4u64], [5u64, 6u64, 7u64, 8u64]] }
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64, 7u64] 2i64 }
-- output { [[1u64, 2u64], [3u64, 4u64], [5u64, 6u64], [7u64, 0u64]] }
-- input { [1u64] 7i64 }
-- output { [[1u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64]] }
entry chunk_coefficients_unit_test [n] (coefficients: [n]u64) (chunk_length: i64) : [][]u64 =
    let poly = new_from_arr_u64 coefficients
    in map (map BFieldElement.value) (chunk_coefficients poly chunk_length)

-- ==
-- entry: leading_coefficient_of_non_zero_polynomial_is_some
-- input { [1u64, 2u64, 3u64] 3u64 9i64 }
-- output { true }
entry leading_coefficient_of_non_zero_polynomial_is_some
    (coeffs: []u64) (leading_coeff: u64) (num_trailing_zeros: i64) : bool = 

    -- -- setup poly w/ the given leading coeff and trailing zeros
    let lc_actual = BFieldElement.new leading_coeff
    let bfe_coeffs: []BFieldElement = 
        map BFieldElement.new coeffs
        |> \init_coeffs -> init_coeffs 
                           ++ [lc_actual] 
                           ++ (replicate num_trailing_zeros BFieldElement.zero)
    let poly = new bfe_coeffs

    -- get leading coeff using lc func and compare
    let lc_found = leading_coefficient poly |> \(lc, some_flag) -> assert some_flag lc
    in BFieldElement.eq lc_actual lc_found

-- ==
-- entry: leading_coefficient_of_zero_polynomial_is_none
-- input { 87i64 }
-- output { true }
entry leading_coefficient_of_zero_polynomial_is_none (num_trailing_zeros: i64) : bool = 
    let poly = new (replicate num_trailing_zeros BFieldElement.zero)
    let (_, has_lc_flag) = leading_coefficient poly
    in not has_lc_flag

-- ==
-- entry: normalize_unit_test
-- input { [1u64, 2u64, 3u64, 0u64, 0u64, 0u64] }
-- output { [1u64, 2u64, 3u64] }
-- input { [0u64, 0u64, 0u64] }
-- output { [0u64] }
-- input { [1u64, 2u64, 3u64] }
-- output { [1u64, 2u64, 3u64] }
entry normalize_unit_test [n] (coefficients: [n]u64) : []u64 =
    let poly = new_from_arr_u64 coefficients
    let normalized = normalize poly
    in 
        if is_zero normalized 
        then [0u64]  -- [] not recognized in test case
        else map BFieldElement.value normalized.coefficients

-- ==
-- entry: a_plus_neg_a_is_zero
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry a_plus_neg_a_is_zero (coeffs: []u64) : bool =
    let poly = new_from_arr_u64 coeffs
    let poly_neg = neg poly
    let sum = add poly poly_neg
    in is_zero sum

-- == 
-- entry: a_minus_a_is_zero
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry a_minus_a_is_zero (coeffs: []u64) : bool =
    let poly = new_from_arr_u64 coeffs
    let sum = sub poly poly
    in is_zero sum
    

-- ==
-- entry: subtraction_is_not_commutative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { false }
entry subtraction_is_not_commutative (a: []u64) (b: []u64) : bool =
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    in eq (sub p1 p2) (sub p2 p1)

-- == 
-- entry: subtraction_is_not_associative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] [7u64, 8u64, 9u64] }
-- output { false }
entry subtraction_is_not_associative (a: []u64) (b: []u64) (c: []u64) : bool =
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    let p3 = new_from_arr_u64 c
    let lhs = sub (sub p1 p2) p3
    let rhs = sub p1 (sub p2 p3)
    in eq lhs rhs

-- == 
-- entry: naive_division_result_can_reproduce_dividend_and_divisor
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] [1u64, 2u64, 3u64] }
-- output { true }
-- input { [4u64, 8u64, 9u64] [12u64, 88u64, 1u64, 3u64]}
entry naive_division_result_can_reproduce_dividend_and_divisor (a: []u64) (b: []u64) : bool =
    let a_poly = new_from_arr_u64 a
    let b_poly = new_from_arr_u64 b
    let (quot, rem) = naive_divide a_poly b_poly
    -- ensure reconstructed dividend is the same as the original dividend
    let reconstructed_a_poly = add (multiply quot b_poly) rem
    in eq a_poly reconstructed_a_poly

-- == 
-- entry: naive_division_result_has_zero_remainder
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] [1u64, 0u64, 3u64] }
-- output { true }
entry naive_division_result_has_zero_remainder (a: []u64) (b: []u64) : bool =
    let a_poly = new_from_arr_u64 a
    let b_poly = new_from_arr_u64 b
    let product = multiply a_poly b_poly
    let (_, rem_1) = naive_divide product a_poly
    let (_, rem_2) = naive_divide product b_poly
    in (is_zero rem_1) && (is_zero rem_2)

-- -- NOTE This should produce an error
-- -- == 
-- -- entry: naive_div_by_zero
-- -- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] }
-- -- output { true }
-- entry naive_div_by_zero (a: []u64) : bool =
--     let a_poly = new_from_arr_u64 a
--     let b_poly = zero
--     let (_, rem) = naive_divide a_poly b_poly
--     in is_zero rem

-- ==
-- entry: xgcd_b_field_pol_test 
-- input { [1u64, 2u64, 7u64, 9u64, 88u64, 99u64, 1208423u64] [4u64, 5u64, 6u64, 8u64, 12u64] }
-- output { true }
-- input { [1u64, 1u64] [1u64, 1u64] }
-- output { true }
-- input { [2u64, 2u64] [2u64, 2u64, 2u64, 5u64]}
-- output { true }
entry xgcd_b_field_pol_test (x: []u64) (y: []u64) : bool = 
    let x_poly = new_from_arr_u64 x
    let y_poly = new_from_arr_u64 y
    let (gcd, a, b) = xgcd x_poly y_poly
    let reconstructed = add (multiply a x_poly) (multiply b y_poly)
    in eq gcd reconstructed

-- ==
-- entry: xgcd_does_not_panic_on_input_zero
-- input { }
-- output { true }
entry xgcd_does_not_panic_on_input_zero : bool =
    let (gcd, _, _) = xgcd zero zero 
    in eq zero gcd
