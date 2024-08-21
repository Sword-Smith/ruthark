module BFieldElement = import "BFieldElement"
module bfe_poly = import "bfe_poly"

type BFieldElement = BFieldElement.BFieldElement
type BfePolynomial [n] = bfe_poly.BfePolynomial [n]

type XFieldElement = { coefficients: (BFieldElement, BFieldElement, BFieldElement) }

def new (coefficients: (BFieldElement, BFieldElement, BFieldElement)) : XFieldElement =
  {coefficients = coefficients}

def new_const (element: BFieldElement) : XFieldElement = new (element, BFieldElement.zero, BFieldElement.zero)

def from_u64 (number: u64) : XFieldElement = BFieldElement.new number |> new_const

def eq (a : XFieldElement) (b : XFieldElement) : bool =
  a.coefficients.0 == b.coefficients.0
  && a.coefficients.1 == b.coefficients.1
  && a.coefficients.2 == b.coefficients.2

def zero : XFieldElement = new_const BFieldElement.zero
def one : XFieldElement = new_const BFieldElement.one

def is_zero (x : XFieldElement) : bool =
  let zero = BFieldElement.value BFieldElement.zero
  in zero == BFieldElement.value x.coefficients.0
  && zero == BFieldElement.value x.coefficients.1
  && zero == BFieldElement.value x.coefficients.2

def is_one (x : XFieldElement) : bool =
  let zero = BFieldElement.value BFieldElement.zero
  let one = BFieldElement.value BFieldElement.one
  in one == BFieldElement.value x.coefficients.0
  && zero == BFieldElement.value x.coefficients.1
  && zero == BFieldElement.value x.coefficients.2

def add (lhs : XFieldElement) (rhs : XFieldElement) : XFieldElement =
  { coefficients = ((BFieldElement.add lhs.coefficients.0 rhs.coefficients.0)
  , (BFieldElement.add lhs.coefficients.1 rhs.coefficients.1)
  , (BFieldElement.add lhs.coefficients.2 rhs.coefficients.2))
  }

def neg (a : XFieldElement) : XFieldElement =
   { coefficients = ( BFieldElement.neg a.coefficients.0
  , BFieldElement.neg a.coefficients.1
  , BFieldElement.neg a.coefficients.2
  )
   }

def minus_one : XFieldElement = neg one

def from_i32 (number: i32) : XFieldElement =
  if number >= 0
  then u64.i32 number |> BFieldElement.new |> new_const
  else u64.i32 (-number) |> BFieldElement.new |> new_const |> neg

def sub (a: XFieldElement) (b: XFieldElement) : XFieldElement =
  add a (neg b)

def xfe_xfe_mul (lhs : XFieldElement) (rhs: XFieldElement) : XFieldElement =
  let c0 = lhs.coefficients.0
  let b0 = lhs.coefficients.1
  let a0 = lhs.coefficients.2
  let c1 = rhs.coefficients.0
  let b1 = rhs.coefficients.1
  let a1 = rhs.coefficients.2
  let mul = BFieldElement.mul
  let add = BFieldElement.add
  let sub = BFieldElement.sub
  in {
    coefficients =
    ( sub
      (mul c0 c1)
      (add
        (mul a0 b1)
        (mul b0 a1))
  , sub
      (add
        (add
          (add
            (mul b0 c1)
            (mul c0 b1))
          (mul a0 b1))
        (mul b0 a1))
      (mul a0 a1)
  , add
      (add
        (add
          (mul a0 c1)
          (mul b0 b1))
        (mul c0 a1))
      (mul a0 a1)
  )
  }


def (x: BFieldElement) |-| (y: BFieldElement) = BFieldElement.sub x y
def (x: BFieldElement) |+| (y: BFieldElement) = BFieldElement.add x y
def (x: BFieldElement) |*| (y: BFieldElement) = BFieldElement.mul x y

-- def xfebfemul ((c0, b0, a0) : XFieldElement) ((c1, _b1, _a1) : XFieldElement) : XFieldElement =
--                 (c0 |*| c1, b0 |*| c1, a0 |*| c1)

-- def mul ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement =
--           if (a1 == 0) && (b1 == 0) then xfebfemul (c0, b0, a0) (c1, b1, a1)
--           else xfexfemul (c0, b0, a0) (c1, b1, a1)

-- Multiply XFieldElement by BFieldElement
def xfe_bfe_mul (x: XFieldElement) (b: BFieldElement) : XFieldElement =
  { coefficients = (
      x.coefficients.0 |*| b,
      x.coefficients.1 |*| b,
      x.coefficients.2 |*| b 
      )
  }

def (a: XFieldElement) *^ (b: XFieldElement): XFieldElement =
  xfe_xfe_mul a b

def (a: XFieldElement) +^ (b: XFieldElement): XFieldElement =
  add a b

def (lhs: XFieldElement) -^ (rhs: XFieldElement): XFieldElement =
  sub lhs rhs

-- def div (a: XFieldElement) (b: XFieldElement) : XFieldElement =
--  mul a (inverse b)

-- def rem ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement = one
-- Not supported https://futhark-book.readthedocs.io/en/latest/language.html#parametric-polymorphism
-- def mod_pow 't (element : XFieldElement) (exponent: t) : XFieldElement =

def mod_pow_u64 (element : XFieldElement) (exponent: u64) : XFieldElement =
  let (_, _, result) = loop (x, i, result) = (element, exponent, one) while i > 0 do
      if i % 2 == 1
      then (
        xfe_xfe_mul x x, 
        i>>1, 
        xfe_xfe_mul x result
        )
      else (
        xfe_xfe_mul x x, 
        i>>1, 
        result
        )
  in result

-- def mod_pow_u32 (element : XFieldElement) (exponent: u32) : XFieldElement =
--   let (_, _, result) = loop (x, i, result) = (element, exponent, one) while i > 0 do
--       if i % 2 == 1
--       then (mul x x, i>>1, mul x result)
--       else (mul x x, i>>1, result)
--    in result

-- def mod_pow_u8 (element : XFieldElement) (exponent: u8) : XFieldElement =
--   let (_, _, result) = loop (x, i, result) = (element, exponent, one) while i > 0 do
--       if i % 2 == 1
--       then (mul x x, i>>1, mul x result)
--       else (mul x x, i>>1, result)
--    in result

-- Segmented scan with XFieldElement.add
-- Benchmark against version from fut library
-- def segmented_scan_add [t] (flags : [t]bool) (vals : [t]XFieldElement) : []XFieldElement =
--   let pairs = scan ( \(v1,f1) (v2,f2) ->
--                        let f = f1 || f2
--                        let v = if f2 then v2 else add v1 v2
--                        in (v,f) ) (zero, false) (zip vals flags)
--   let (res, _) = unzip pairs
--    in res

def shah_polynomial : BfePolynomial [4] =
  bfe_poly.new_from_arr_u64 [1, 18446744069414584320, 0, 1] 

def inverse (x: XFieldElement) : XFieldElement = 
  -- cannot invert zero element in extension field
  let x = assert (not (is_zero x)) x 
  --convert Xfe to poly, xgcd w/ shah poly, convert back to Xfe 
  let x_as_poly = bfe_poly.new [x.coefficients.0, x.coefficients.1, x.coefficients.2]
  let (_, a, _) = bfe_poly.xgcd x_as_poly shah_polynomial
  let a_coeffs = take 3 a.coefficients
  in new (a_coeffs[0], a_coeffs[1], a_coeffs[2]) 

-- ==
-- entry: unit_test_add
-- input  { 2u64 3u64 4u64 100u64 130u64 170u64 }
-- output { 102u64 133u64 174u64 }
-- input  { 0xfffffffefffffffeu64 12u64 4u64 2u64 45000u64 0xfffffffefffffffdu64 }
-- output { 0xffffffff00000000u64 45012u64 0u64 }
entry unit_test_add (a0: u64) (a1: u64) (a2: u64) (b0: u64) (b1: u64) (b2: u64) : (u64, u64, u64)  =
 let a: XFieldElement = {
  coefficients = (BFieldElement.new a0, BFieldElement.new a1, BFieldElement.new a2 )
  }
  let b: XFieldElement = {
  coefficients = (BFieldElement.new b0, BFieldElement.new b1, BFieldElement.new b2 )
  }
  let c: XFieldElement = add a b
  in (BFieldElement.value c.coefficients.0, BFieldElement.value c.coefficients.1, BFieldElement.value c.coefficients.2)

-- ==
-- entry: unit_test_mul
-- input  { 13u64 2u64 3u64 19u64 0u64 5u64 }
-- output { 237u64 33u64 137u64 }
-- input  { 2u64 5u64 7u64 53u64 57u64 73u64 }
-- output { 18446744069414583663u64 632u64 1313u64 }
entry unit_test_mul (a0: u64) (a1: u64) (a2: u64) (b0: u64) (b1: u64) (b2: u64) : (u64, u64, u64)  =
 let a: XFieldElement = {
  coefficients = (BFieldElement.new a0, BFieldElement.new a1, BFieldElement.new a2 )
  }
  let b: XFieldElement = {
  coefficients = (BFieldElement.new b0, BFieldElement.new b1, BFieldElement.new b2 )
  }
  let c: XFieldElement = xfe_xfe_mul a b
  in (BFieldElement.value c.coefficients.0, BFieldElement.value c.coefficients.1, BFieldElement.value c.coefficients.2)

-- == 
-- entry: mul_xfe_with_bfe_pnt
-- input { [1u64, 2u64, 3u64] 8u64}
-- output { true }
-- input { [1u64, 2u64, 3u64] 0u64}
-- output { true }
entry mul_xfe_with_bfe_pnt (x_coeffs: []u64) (b_val: u64) : bool =
  let x = (map BFieldElement.new x_coeffs) |> \x -> new (x[0], x[1], x[2])
  let b = BFieldElement.new b_val
  let res_mul = xfe_bfe_mul x b
  in
       res_mul.coefficients.0 == (x.coefficients.0 |*| b)
    && res_mul.coefficients.1 == (x.coefficients.1 |*| b)
    && res_mul.coefficients.2 == (x.coefficients.2 |*| b)

-- ==
-- entry: xfe_mod_pow_u64_zero_is_one
-- input  { }
-- output { true }
entry xfe_mod_pow_u64_zero_is_one : bool =
  (eq one (mod_pow_u64 zero 0)) && (eq one (mod_pow_u64 one 0))
  
-- ==
-- entry: xfe_mod_pow_u64_test
-- input { 88u64 12i64 }
-- output { true }
-- input { 25341u64 77i64 }
-- output { true }
entry xfe_mod_pow_u64_test (base_u64: u64) (exponent: i64) : bool =
  let base = from_u64 base_u64
  let exponents_u64 = iota exponent |> map u64.i64
  let (success, _) = loop (success, acc) = (true, one) for i in exponents_u64 do
    let success = success && (eq acc (mod_pow_u64 base i))
    let acc =  xfe_xfe_mul acc base
    in (success, acc)
  in success

-- -- == 
-- entry: xfe_inverse_test
-- input {  }
-- output { true }
entry xfe_inverse_test : bool =
  let x: XFieldElement = new (BFieldElement.new 1, BFieldElement.new 2, BFieldElement.new 3)
  let x_inv = inverse x
  in eq (one) (xfe_xfe_mul x x_inv)

-- -- == 
-- entry: shah_polynomial_is_correct
-- input { }
-- output { [1u64, 18446744069414584320u64, 0u64, 1u64] }
entry shah_polynomial_is_correct : [4]u64 =
    let shah_poly = shah_polynomial
    in map BFieldElement.value shah_poly.coefficients