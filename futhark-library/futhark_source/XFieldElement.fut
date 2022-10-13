module BFieldElement = import "BFieldElement"

type BFieldElement = BFieldElement.BFieldElement
-- a*x^2 + b*x + c:  (c            , b            , a            )
type XFieldElement = (BFieldElement, BFieldElement, BFieldElement)

def new (c: BFieldElement) (b: BFieldElement) (a: BFieldElement) : XFieldElement =
  let canonicalize = BFieldElement.canonicalize
  in (canonicalize c, canonicalize b, canonicalize a)

def new_u64 (coeffs: [3]u64) : XFieldElement = new coeffs[0] coeffs[1] coeffs[2]

def new_const (element: BFieldElement) : XFieldElement = new element BFieldElement.zero BFieldElement.zero

def tripple2array (c, b, a) : [3]u64 = [c, b, a]
def array2tripple (cba: [3]u64) : XFieldElement = new cba[0] cba[1] cba[2]

def canonicalize ((c, b, a) : XFieldElement) : XFieldElement =
  ( BFieldElement.canonicalize c
  , BFieldElement.canonicalize b
  , BFieldElement.canonicalize a
  )

def eq (a : XFieldElement) (b : XFieldElement) : bool =
  (canonicalize a) == (canonicalize b)

def zero : XFieldElement = new_const BFieldElement.zero
def one : XFieldElement = new_const BFieldElement.one
-- def two : XFieldElement = new_const (BFieldElement.add BFieldElement.one BFieldElement.one)
-- def default : XFieldElement = one

def is_zero ((c, b, a) : XFieldElement) : bool =
  let zero = BFieldElement.zero in
  zero == BFieldElement.canonicalize c
  && zero == BFieldElement.canonicalize b
  && zero == BFieldElement.canonicalize a

def is_one ((c, b, a) : XFieldElement) : bool =
  let zero = BFieldElement.zero in
  let one = BFieldElement.one in
  one == BFieldElement.canonicalize c
  && zero == BFieldElement.canonicalize b
  && zero == BFieldElement.canonicalize a

def add ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement =
  ( (BFieldElement.add c0 c1)
  , (BFieldElement.add b0 b1)
  , (BFieldElement.add a0 a1)
  )

def neg ((c, b, a) : XFieldElement) : XFieldElement =
  ( BFieldElement.neg c
  , BFieldElement.neg b
  , BFieldElement.neg a
  )

def sub (a: XFieldElement) (b: XFieldElement) : XFieldElement =
  add a (neg b)

-- TODO: Requires Polynomial.divide and BFieldElement.inverse
-- This should not be needed at all.
def inverse (_a : XFieldElement) : XFieldElement = zero
--  let self_as_poly = Polynomial.XFieldElement a in
--  let (_, inverse, _) = Polynoimal.xgcd self_as_poly Polynoimal.shah_polynomial in
--  inverse

def xfexfemul ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement =
--  let canonicalizeB = BFieldElement.canonicalize
--  let mul = \x y -> canonicalizeB (BFieldElement.mul x y)
--  let add = \x y -> canonicalizeB (BFieldElement.add x y)
--  let sub = \x y -> canonicalizeB (BFieldElement.sub x y)
  let mul = BFieldElement.mul
  let add = BFieldElement.add
  let sub = BFieldElement.sub
-- Special casing for LHS = 0 + (a : BFieldElement) or RHS = 0 + (b: BFieldElement) is
-- likely not a good idea for GPU code.  But run benchmarks.
-- Note that `sub` is likely more expensive than `add`.
  in
-- ( c0 * c1 - a0 * b1 - b0 * a1                      -- * x^0
-- ( c0 * c1 - (a0 * b1 + b0 * a1)                    -- * x^0
-- canonicalize
-- alternatively: ( sub (mul c0 c1) (add (mul a0 b1) (mul b0 a1))
    ( sub
      (mul c0 c1)
      (add
        (mul a0 b1)
        (mul b0 a1))
-- , b0 * c1 + c0 * b1 - a0 * a1 + a0 * b1 + b0 * a1  -- * x^1
-- , b0 * c1 + c0 * b1 + a0 * b1 + b0 * a1 - a0 * a1
-- alternatively: , sub (add (add (add (mul b0 c1) (mul c0 b1)) (mul a0 b1)) (mul b0 a1)) (mul a0 a1)
  , sub
      (add
        (add
          (add
            (mul b0 c1)
            (mul c0 b1))
          (mul a0 b1))
        (mul b0 a1))
      (mul a0 a1)
 -- , a0 * c1 + b0 * b1 + c0 * a1 + a0 * a1           -- * x^2
-- alternatively, add (add (add (mul a0 c1) (mul b0 b1)) (mul c0 a1)) (mul a0 a1)
  , add
      (add
        (add
          (mul a0 c1)
          (mul b0 b1))
        (mul c0 a1))
      (mul a0 a1)
  )

def (x: BFieldElement) |-| (y: BFieldElement) = BFieldElement.sub x y
def (x: BFieldElement) |+| (y: BFieldElement) = BFieldElement.add x y
def (x: BFieldElement) |*| (y: BFieldElement) = BFieldElement.mul x y

-- def special_mul ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement =
-- -- Special cases
-- -- use arithmetic operations from this module
--   let a0b1 = (a0 |*| b1)
--   let b0a1 = (b0 |*| a1)
--   let a0a1 = (a0 |*| a1)
--   in
--  ( (( (c0 |*| c1) |-| a0b1) |-| b0a1)                                  -- * x^0
--  , ((((b0 |*| c1) |+| (c0 |*| b1)) |-| a0a1) |+| a0b1) |+| b0a1 -- * x^1
--  , (( (a0 |*| c1) |+| (b0 |*| b1)) |+| (c0 |*| a1)) |+| a0a1                  -- * x^2
--  )

-- def special_mul ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement =
-- -- Special cases
-- -- use arithmetic operations from this module
--  ( c0 * c1 - a0 * b1 - b0 * a1                      -- * x^0
--  , b0 * c1 + c0 * b1 - a0 * a1 + a0 * b1 + b0 * a1  -- * x^1
--  , a0 * c1 + b0 * b1 + c0 * a1 + a0 * a1            -- * x^2
--  )

def xfebfemul ((c0, b0, a0) : XFieldElement) ((c1, _b1, _a1) : XFieldElement) : XFieldElement =
                (c0 |*| c1, b0 |*| c1, a0 |*| c1)

def combined_mul ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement =
          if (a1 == 0) && (b1 == 0) then xfebfemul (c0, b0, a0) (c1, b1, a1)
          else xfexfemul (c0, b0, a0) (c1, b1, a1)

def mul = combined_mul

-- this version adds makes the 260s take 290s, hence it is commented out
-- def dumb_mod_pow_u64 (element : XFieldElement) (exponent: u64) : XFieldElement =
--   reduce (mul) one (replicate (i64.u64 exponent) element)

def div (a: XFieldElement) (b: XFieldElement) : XFieldElement =
  mul a (inverse b)

def mod_pow_u64 (element : XFieldElement) (exponent: u64) : XFieldElement =
  let (_, _, result) = loop (x, i, result) = (element, exponent, one) while i > 0 do
      if i % 2 == 1
      then (mul x x, i>>1, mul x result)
      else (mul x x, i>>1, result)
  in result

-- def rem ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement = one

-- it calls this
def my_mul = mul
-- and it calls this
def my_mod_pow_u64 = mod_pow_u64

def mod_pow_u32 (element : XFieldElement) (exponent: u32) : XFieldElement =
  mod_pow_u64 element (u64.u32 exponent)

-- u64.highest = 18446744073709551615u64

-- Test mul
-- ==
-- entry: mul_test_array
-- input { [2u64, 3u64, 5u64] [7u64, 11u64, 13u64]}
-- output { [18446744069414584241u64, 72u64, 159u64] }
-- input { [0u64, 0u64, 0u64] [0u64, 0u64, 0u64] }
-- output { [0u64, 0u64, 0u64] }
-- input { [1u64, 0u64, 0u64] [1u64, 0u64, 0u64] }
-- output { [1u64, 0u64, 0u64] }
-- input { [0u64, 0u64, 0u64] [1u64, 0u64, 0u64] }
-- output { [0u64, 0u64, 0u64] }
-- input { [1u64, 0u64, 0u64] [0u64, 0u64, 0u64] }
-- output { [0u64, 0u64, 0u64] }
-- input { [18446744073709551615u64, 18446744073709551615u64, 18446744073709551615u64] [18446744073709551615u64, 18446744073709551615u64, 18446744073709551615u64] }
-- output { [12884901885u64, 18446744030759878666u64, 18446744017874976781u64] }
-- input { [0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64] [0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64] }
-- output { [12884901885u64, 18446744030759878666u64, 18446744017874976781u64] }
entry mul_test_array (a_coeffs: [3]u64) (b_coeffs: [3]u64) : [3]u64 =
  let a = new_u64(a_coeffs)
  let b = new_u64(b_coeffs)
  in tripple2array (mul a b)
