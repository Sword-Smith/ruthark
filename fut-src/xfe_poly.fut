module XFieldElement = import "XFieldElement"
module BFieldElement = import "BFieldElement"

type XFieldElement = XFieldElement.XFieldElement

type XfePolynomial [n] = { coefficients: [n]XFieldElement }

def new [n] (coefficients: [n]XFieldElement) : XfePolynomial [n] =
  {coefficients = coefficients}

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
entry test_degree (a: [][3]u64) : i64 = 
    let coefficients = map (\x -> (BFieldElement.new x[0], BFieldElement.new x[1], BFieldElement.new x[2])) a
    let poly = new (map XFieldElement.new coefficients)
    in degree poly

-- ==
-- entry: test_eq
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64], [6u64, 6u64, 6u64]] [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64], [6u64, 6u64, 6u64]]}
-- output { true }
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64]] [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64]] }
-- output { false }
-- input { [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64]] [[1u64, 1u64, 1u64], [2u64, 2u64, 2u64], [3u64, 3u64, 3u64], [4u64, 4u64, 4u64], [5u64, 5u64, 5u64]] }
-- output { false }
entry test_eq (a: [][3]u64) (b: [][3]u64) : bool = 
    let p1_coeffs = map (\x -> (BFieldElement.new x[0], BFieldElement.new x[1], BFieldElement.new x[2])) a
    let p2_coeffs = map (\x -> (BFieldElement.new x[0], BFieldElement.new x[1], BFieldElement.new x[2])) b
    let p1 = new (map XFieldElement.new p1_coeffs)
    let p2 = new (map XFieldElement.new p2_coeffs)
    in eq p1 p2