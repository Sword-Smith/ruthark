module XFieldElement = import "XFieldElement"
module BFieldElement = import "BFieldElement"

type XFieldElement = XFieldElement.XFieldElement

type XfePolynomial [n] = { coefficients: [n]XFieldElement }

-- constructor from XFieldElement array
def new [n] (coefficients: [n]XFieldElement) : XfePolynomial [n] =
  {coefficients = coefficients}

-- constructor from u64 array
def new_from_arr_u64 [n] (coeffs: [n][3]u64) : XfePolynomial [n] =
    map (\x -> (BFieldElement.new x[0], BFieldElement.new x[1], BFieldElement.new x[2])) coeffs
    |> map XFieldElement.new 
    |> new

-- degree
let degree [n] (p: XfePolynomial [n]) : i64 =
    -- determine highest degre (mod trailing zeros)
    let len: i64 = n - 1
    in let new_deg = 
    loop (deg) = (len) 
    while (deg >= 0) && (XFieldElement.eq (p.coefficients[deg]) XFieldElement.zero) do
        deg - 1
    in new_deg

-- equality
def eq [n] [m] (p1: XfePolynomial [n]) (p2: XfePolynomial [m]) : bool =
    -- pad shorter polynomial with zeros
    let n_len = length p1.coefficients
    let m_len = length p2.coefficients
    let max_len = if n_len > m_len then n_len else m_len
    -- Extend both polynomials to the maximum length by appending zeros if necessary
    let coeffs_1 = p1.coefficients ++ replicate (max_len - n_len) XFieldElement.zero
    let coeffs_2 = p2.coefficients ++ replicate (max_len - m_len) XFieldElement.zero
    -- Check if the extended coefficients are the same
    let check = map2 XFieldElement.eq (take max_len coeffs_1) (take max_len coeffs_2)
    in reduce (\x y -> x && y) true check

-- zero
def zero : XfePolynomial [0] = new []
def is_zero [n] (p: XfePolynomial [n]) : bool = eq p zero

-- one 
def one : XfePolynomial [1] = { coefficients = [XFieldElement.one]}
def is_one [n] (p: XfePolynomial [n]) : bool =
    (degree p) == 0 && (XFieldElement.eq (p.coefficients[0]) XFieldElement.one)

-- polynomial addition
def add [n] [m] (p1: XfePolynomial [n]) (p2: XfePolynomial [m]) : XfePolynomial [] = 
    -- determine longer polynomial
    let max_len = if n > m then n else m
    -- Extend both coefficient arrays to the maximum length with zeros
    let coeffs1 = p1.coefficients ++ replicate (max_len - n) XFieldElement.zero
    let coeffs2 = p2.coefficients ++ replicate (max_len - m) XFieldElement.zero
    -- Add corresponding coefficients (telling compiler the lengths are the same)
    in { coefficients = map2 XFieldElement.add (take max_len coeffs1) (take max_len coeffs2) }

-- == 
-- entry: polynomial_addition_is_associative 
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64,3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64], [6u64, 6u64, 6u64]] [[7u64, 7u64, 7u64], [8u64, 8u64, 8u64], [9u64, 9u64, 9u64]] [[10u64, 10u64, 10u64], [11u64, 11u64, 11u64], [12u64, 12u64, 12u64], [13u64, 13u64, 13u64]] }
-- output { true }
entry polynomial_addition_is_associative (a: [][3]u64) (b: [][3]u64) (c: [][3]u64) : bool = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    let p3 = new_from_arr_u64 c
    in eq ( add (add p1 p2) p3 ) ( add p1 (add p2 p3) )
-- == 
-- entry: polynomial_addition_is_commutative
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64,3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64], [6u64, 6u64, 6u64]] [[7u64, 7u64, 7u64], [8u64, 8u64, 8u64], [9u64, 9u64, 9u64]] }
-- output { true }
entry polynomial_addition_is_commutative (a: [][3]u64) (b: [][3]u64) : bool = 
    let p1 = new_from_arr_u64 a
    let p2 = new_from_arr_u64 b
    in eq ( add p1 p2 ) ( add p2 p1 )

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
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64], [6u64, 6u64, 6u64]] }
-- output { 5i64 }
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [0u64, 0u64, 0u64], [0u64, 0u64, 0u64], [0u64, 0u64, 0u64]] }
-- output { 1i64 }
entry test_degree (a: [][3]u64) : i64 = degree (new_from_arr_u64 a)

-- ==
-- entry: test_eq
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64], [6u64, 6u64, 6u64]] [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64], [6u64, 6u64, 6u64]]}
-- output { true }
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64]] [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64]] }
-- output { false }
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64]] [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64]] }
-- output { false }
entry test_eq (a: [][3]u64) (b: [][3]u64) : bool =
    eq (new_from_arr_u64 a) (new_from_arr_u64 b)