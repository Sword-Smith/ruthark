module BFieldElement = import "BFieldElement"

type BFieldElement = BFieldElement.BFieldElement
type~ Polynomial = { coefficients: []BFieldElement }

--constructor
def new (coefficients: []BFieldElement) : Polynomial = 
    { coefficients = coefficients }

-- polynomial addition
def add (p1: Polynomial) (p2: Polynomial) : Polynomial = 
    -- determine longer polynomial
    let len1 = length p1.coefficients
    let len2 = length p2.coefficients
    let max_len = if len1 > len2 then len1 else len2
    -- Extend both coefficient arrays to the maximum length with zeros
    let coeffs1 = p1.coefficients ++ replicate (max_len - len1) BFieldElement.zero
    let coeffs2 = p2.coefficients ++ replicate (max_len - len2) BFieldElement.zero
    -- Add corresponding coefficients
    let coeffs1 = take max_len coeffs1 -- tell compiler the lengths are the same
    let coeffs2 = take max_len coeffs2
    let summed = map2 BFieldElement.add coeffs1 coeffs2 

    in { coefficients = summed }

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