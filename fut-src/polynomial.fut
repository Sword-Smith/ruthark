module BFieldElement = import "BFieldElement"
module ntt = import "bfe_ntt"
module shared = import "shared"

type BFieldElement = BFieldElement.BFieldElement
type~ Polynomial = { coefficients: []BFieldElement }

let FAST_MULTIPLY_CUTOFF_THRESHOLD: i64 = 1 << 8

--constructor
def new (coefficients: []BFieldElement) : Polynomial = 
    { coefficients = coefficients }

-- degree
let degree (p: Polynomial) : i64 =
    -- determine highest degre (mod trailing zeros)
    let len: i64 = (length p.coefficients) - 1
    in let new_deg = 
    loop (deg) = (len) 
    while (deg >= 0) && (BFieldElement.eq (p.coefficients[deg]) BFieldElement.zero) do
        deg - 1
    in new_deg

-- equality
def eq (p1: Polynomial) (p2: Polynomial) : bool =
      if (degree p1) != (degree p2) then false
      else 
        -- ensure compiler knows the lengths are the same
        let shared_len = length p1.coefficients
        let coeffs_1 = take shared_len p1.coefficients
        let coeffs_2 = take shared_len p2.coefficients
        -- check if the coefficients are the same
        let check = (map2 BFieldElement.eq (coeffs_1) (coeffs_2))        
        in reduce (\x y -> x && y) true check
-- zero
def zero : Polynomial = { coefficients = [] }
def is_zero (p: Polynomial) : bool = eq p zero

-- one
def one : Polynomial = { coefficients = [BFieldElement.one] }
def is_one (p: Polynomial) : bool = 
    (degree p) == 0 && (BFieldElement.eq (p.coefficients[0]) BFieldElement.one)

-- polynomial addition
def add (p1: Polynomial) (p2: Polynomial) : Polynomial = 
    -- determine longer polynomial
    let len1 = length p1.coefficients
    let len2 = length p2.coefficients
    let max_len = if len1 > len2 then len1 else len2
    -- Extend both coefficient arrays to the maximum length with zeros
    let coeffs1 = p1.coefficients ++ replicate (max_len - len1) BFieldElement.zero
    let coeffs2 = p2.coefficients ++ replicate (max_len - len2) BFieldElement.zero
    -- Add corresponding coefficients (telling compiler the lengths are the same)
    in { coefficients = map2 BFieldElement.add (take max_len coeffs1) (take max_len coeffs2) }

-- Naive polynomial multiplication
let naive_multiply (p1: Polynomial) (p2: Polynomial) : Polynomial =
  let deg_lhs = degree p1
  let deg_rhs = degree p2
  in if deg_lhs < 0 || deg_rhs < 0 then
    copy zero
  else
    let init_product = replicate (deg_lhs + deg_rhs + 1) BFieldElement.zero
    in let final_product = loop product = init_product for i in 0 ... deg_lhs do
          loop product = product for j in 0 ... deg_rhs do
            let new_coeff = BFieldElement.mul (p1.coefficients[i]) (p2.coefficients[j])
            let current_coeff = product[i + j]
            let updated_coeff = BFieldElement.add current_coeff new_coeff
            in product with [i + j] = updated_coeff
    in { coefficients = final_product }
-- Function to extend array to the next power of two size with zeros
let extend_with_zeros (coeffs : []BFieldElement) (desired_length : i64) : []BFieldElement =
  let current_length = length coeffs
  let zeros_to_add = desired_length - current_length
  let zeros = replicate zeros_to_add BFieldElement.zero
  in coeffs ++ zeros

-- Fast polynomial multiplication using NTT
let fast_multiply (p1: Polynomial) (p2: Polynomial) : Polynomial = 
    let degree: i64 = (degree p1) + (degree p2)
    in if degree < 0 then
        copy zero
    else   
        -- get order for NTT
        let order = shared.next_power_of_two_i64 (degree + 1)
        -- pad coeffs to order w/ zeros
        let lhs_coeffs = take order (extend_with_zeros p1.coefficients order)
        let rhs_coeffs = take order (extend_with_zeros p2.coefficients order)
        -- apply number theoretic transform
        let lhs_ntt = ntt.bfe_ntt lhs_coeffs
        let rhs_ntt = ntt.bfe_ntt rhs_coeffs
        -- element wise mul in the NTT domain
        let hadamard_product = map2 BFieldElement.mul lhs_ntt rhs_ntt
        -- invert the ntt
        let intt = ntt.bfe_intt hadamard_product
        -- truncate to the correct degree
        let final_coeffs = take (degree + 1) intt
        in { coefficients = final_coeffs } :> Polynomial

-- multiplication
def multiply (p1: Polynomial) (p2: Polynomial) : Polynomial =
    if (degree p1) + (degree p2) < FAST_MULTIPLY_CUTOFF_THRESHOLD 
    then naive_multiply p1 p2
    else fast_multiply p1 p2
    
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
    let product_1 = fast_multiply p1 p2
    let product_2 = naive_multiply p1 p2
    in eq product_1 product_2

-- == 
-- entry: polynomial_zero_is_neutral_element_for_addition
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry polynomial_zero_is_neutral_element_for_addition (a: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = zero
    let sum = add p1 p2
    in eq p1 sum

-- == 
-- entry: polynomial_one_is_neutral_element_for_multiplication
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry polynomial_one_is_neutral_element_for_multiplication (a: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = one
    let product = multiply p1 p2
    in eq p1 product

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
-- entry: multiplication_by_zero_is_zero
-- input { [1u64, 2u64, 3u64] }
-- output { true }
entry multiplication_by_zero_is_zero (a: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = zero
    let product = multiply p1 p2
    in eq product zero

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
    -- check if the coefficients are the same
    in eq product_1 product_2

-- == 
-- entry: polynomial_multiplication_is_commutative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { true }
entry polynomial_multiplication_is_commutative (a: []u64) (b: []u64) : bool = 
    -- init polys
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    -- should be the same
    let product_1 = multiply p1 p2
    let product_2 = multiply p2 p1
    -- check if the coefficients are the same
    in eq product_1 product_2


-- == 
-- entry: test_zero
-- input {}
-- output { true }
entry test_zero : bool = 
    let p = zero
    in is_zero p

-- == 
-- entry: test_one
-- input {}
-- output { true }
entry test_one : bool = 
    let p = one
    in is_one p

-- == 
-- entry: test_degree
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] }
-- output { 5i64 }
-- input { [1u64, 2u64, 0u64, 0u64, 0u64, 0u64] }
-- output { 1i64 }
entry test_degree (a: []u64) : i64 = degree (new (map BFieldElement.new a))

-- ==
-- entry: test_eq
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] }
-- output { true }
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] [1u64, 2u64, 3u64, 4u64] }
-- output { false }
-- input { [1u64, 2u64, 3u64, 4u64, 5u64] [1u64, 2u64, 3u64, 4u64, 7u64] }
-- output { false }
entry test_eq (a: []u64) (b: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    in eq p1 p2

-- == 
-- entry: polynomial_addition_is_associative 
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64] [7u64, 8u64, 9u64] [10u64, 11u64, 12u64, 13u64] }
-- output { true }
entry polynomial_addition_is_associative (a: []u64) (b: []u64) (c: []u64) : bool = 
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    let p3 = new (map BFieldElement.new c)
    -- get max degree (so compiler knows the lengths are the same)
    let max_degree = reduce (\x y -> if x > y then x else y) 0 [length p1.coefficients, length p2.coefficients, length p3.coefficients]
    -- (p1 + p2) + p3 == p1 + (p2 + p3)
    let sum_1 = add (add p1 p2) p3
    let sum_2 = add p1 (add p2 p3)
    -- check if the coefficients are the same
    let check = (map2 (\x y -> BFieldElement.eq x y) (take max_degree sum_1.coefficients) (take max_degree sum_2.coefficients))
    in reduce (\x y -> x && y) true check

-- == 
-- entry: polynomial_addition_is_commutative
-- input { [1u64, 2u64, 3u64] [4u64, 5u64, 6u64] }
-- output { true }
entry polynomial_addition_is_commutative (a: []u64) (b: []u64) : bool = 
    -- init polys
    let p1 = new (map BFieldElement.new a)
    let p2 = new (map BFieldElement.new b)
    -- get max degree (so compiler knows the lengths are the same)
    let max_degree = reduce (\x y -> if x > y then x else y) 0 [length p1.coefficients, length p2.coefficients]
    -- should be the same
    let sum_1 = add p1 p2
    let sum_2 = add p2 p1
    -- check if the coefficients are the same
    let check = (map2 (\x y -> BFieldElement.eq x y) (take max_degree sum_1.coefficients) (take max_degree sum_2.coefficients))
    in reduce (\x y -> x && y) true check

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
    let same_degree_check = (map2 (\x y -> BFieldElement.eq x y) (take 3 p3_actual.coefficients) (take 3 p3_expected.coefficients))
    let same_degree_check = reduce (\x y -> x && y) true same_degree_check
    -- longer lhs
    let p1 = new [BFieldElement.new 1, BFieldElement.new 2, BFieldElement.new 3, BFieldElement.new 4]
    let p2 = new [BFieldElement.new 4, BFieldElement.new 5, BFieldElement.new 6]
    let p3_actual = add p1 p2
    let p3_expected = new [BFieldElement.new 5, BFieldElement.new 7, BFieldElement.new 9, BFieldElement.new 4]
    -- check if the coefficients are the same
    let larger_lhs_degree_check = (map2 (\x y -> BFieldElement.eq x y) (take 4 p3_actual.coefficients) (take 4 p3_expected.coefficients))
    let larger_lhs_degree_check = reduce (\x y -> x && y) true larger_lhs_degree_check
    -- longer rhs
    let p1 = new [BFieldElement.new 1, BFieldElement.new 2, BFieldElement.new 3]
    let p2 = new [BFieldElement.new 4, BFieldElement.new 5, BFieldElement.new 6, BFieldElement.new 7]
    let p3_actual = add p1 p2
    let p3_expected = new [BFieldElement.new 5, BFieldElement.new 7, BFieldElement.new 9, BFieldElement.new 7]
    -- check if the coefficients are the same
    let larger_rhs_degree_check  = (map2 (\x y -> BFieldElement.eq x y) (take 4 p3_actual.coefficients) (take 4 p3_expected.coefficients))
    let larger_rhs_degree_check = reduce (\x y -> x && y) true larger_rhs_degree_check
    -- ensure all checks pass
    in same_degree_check && larger_lhs_degree_check && larger_rhs_degree_check