module XFieldElement = import "XFieldElement"
module BFieldElement = import "BFieldElement"
module xfe_ntt_module = import "xfe_ntt"

type XFieldElement = XFieldElement.XFieldElement
type BFieldElement = BFieldElement.BFieldElement

let xfe_ntt = xfe_ntt_module.xfe_ntt
let xfe_intt = xfe_ntt_module.xfe_intt

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


-- Given a polynomial P(x), produce P'(x) := P(α·x)
-- Evaluating P'(x) corresponds to evaluating P(α·x)
def scale [n] (alpha: BFieldElement) (poly: XfePolynomial [n]): XfePolynomial [n] =
    let powers_of_alpha = map (BFieldElement.mod_pow_i64 alpha) (iota n)
    let new_coefficients = map2 XFieldElement.xfe_bfe_mul poly.coefficients powers_of_alpha
    in { coefficients = new_coefficients }

def evaluate [n] (poly: XfePolynomial [n]) (x: XFieldElement): XFieldElement =
    -- TODO: Do we want to implement this with Horner evaluation?
    let powers_of_x = iota n  |> map u64.i64 |> map (\i -> XFieldElement.mod_pow_u64 x i)
    in reduce (XFieldElement.+^) XFieldElement.zero (map2 (XFieldElement.*^) poly.coefficients powers_of_x)        

-- XFieldElement values to XfePolynomial
def fast_coset_interpolate [n] (offset: BFieldElement) (values: [n]XFieldElement): XfePolynomial[n] =
  let unscaled = xfe_intt values
  let poly = new unscaled
  in scale (BFieldElement.inverse offset) poly

def fast_coset_evaluate [n] (offset: BFieldElement) (order: i64) (poly: XfePolynomial[n]): [order]XFieldElement =
    let coefficients = (scale offset poly).coefficients
    let coefficients = coefficients ++ (replicate (order - n) XFieldElement.zero) :> [order]XFieldElement
    in xfe_ntt coefficients


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

-- ==
-- entry: evaluate_unit_test
-- input { [1u64, 2u64, 3u64] [1u64, 2u64, 3u64] }
-- output { 18446744069414584291u64 25u64 63u64 }
-- input { [988u64, 324u64, 3135135u64, 123u64, 123u64] [ 88u64, 99u64, 22u64]}
-- output { 18446744007089048948u64 134492625432u64 137077922784u64 }
entry evaluate_unit_test (poly_coeffs: []u64) (input_coeffs: [3]u64): (u64, u64, u64) =
    let xfe_polynomial = 
        map BFieldElement.new poly_coeffs 
        |> map XFieldElement.new_const 
        |> new
    let x = XFieldElement.new (
        BFieldElement.new input_coeffs[0], 
        BFieldElement.new input_coeffs[1], 
        BFieldElement.new input_coeffs[2]
        )
    let result = evaluate xfe_polynomial x
    in (
        BFieldElement.value result.coefficients.0,
        BFieldElement.value result.coefficients.1,
        BFieldElement.value result.coefficients.2
        )

-- == 
-- entry: evaluating_scaled_polynomial_is_equvalant_to_evaluating_original_int_offset_point
-- input {}
-- output { true }
entry evaluating_scaled_polynomial_is_equvalant_to_evaluating_original_int_offset_point : bool =
    let alpha = BFieldElement.new 3
    let xfe_polynomial = 
      map XFieldElement.new_const [BFieldElement.new 1, BFieldElement.new 2, BFieldElement.new 3] |> new
    -- scaled and unscaled input
    let x = XFieldElement.new_const (BFieldElement.new 9)
    let scaled_input = XFieldElement.xfe_bfe_mul x alpha
    -- scaled poly
    let scaled_poly = scale alpha xfe_polynomial
    -- evaluate scaled poly on og x
    let scaled_result = evaluate scaled_poly x
    -- evaluate original poly on scaled x
    let unscaled_result = evaluate xfe_polynomial scaled_input
    in XFieldElement.eq scaled_result unscaled_result

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
    let input = map BFieldElement.new input |> map XFieldElement.new_const
    let poly = fast_coset_interpolate offset input
    let values_again = fast_coset_evaluate offset n poly
    in map2 XFieldElement.eq values_again input |> reduce (==) true 
