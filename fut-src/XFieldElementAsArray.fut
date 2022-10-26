module BFieldElement = import "BFieldElement"

type BFieldElement = BFieldElement.BFieldElement
-- a*x^2 + b*x + c:  (c            , b            , a            )

type XFieldElement = [3]BFieldElement

def new (c: BFieldElement) (b: BFieldElement) (a: BFieldElement) : XFieldElement =
  let canonicalize = BFieldElement.canonicalize
  in [canonicalize c, canonicalize b, canonicalize a]

-- def new_u64 (coeffs: [3]u64) : XFieldElement = new coeffs[0] coeffs[1] coeffs[2]

def new_const (element: BFieldElement) : XFieldElement = new element BFieldElement.zero BFieldElement.zero

def from_u64 (number: u64) : XFieldElement = BFieldElement.new number |> new_const

def from_i32 (number: i32) : XFieldElement = u64.i32 number |> BFieldElement.new |> new_const

def canonicalize (X : XFieldElement) : XFieldElement =
    map BFieldElement.canonicalize X

def eq (X : XFieldElement) (Y : XFieldElement) : bool =
    let c0 = X[0]
    let b0 = X[1]
    let a0 = X[2]
    let c1 = Y[0]
    let b1 = Y[1]
    let a1 = Y[2]
    in c0 == c1
    && b0 == b1 
    && a0 == a1

def zero : XFieldElement = new_const BFieldElement.zero
def one : XFieldElement = new_const BFieldElement.one
-- def two : XFieldElement = new_const (BFieldElement.add BFieldElement.one BFieldElement.one)
-- def default : XFieldElement = one

def is_zero (X : XFieldElement) : bool =
    let c = X[0]
    let b = X[1]
    let a = X[2]
    let zero = BFieldElement.zero
    in zero == BFieldElement.canonicalize c
    && zero == BFieldElement.canonicalize b
    && zero == BFieldElement.canonicalize a

def is_one (X : XFieldElement) : bool =
    let c = X[0]
    let b = X[1]
    let a = X[2]
    let zero = BFieldElement.zero
    let one = BFieldElement.one
    in one == BFieldElement.canonicalize c
    && zero == BFieldElement.canonicalize b
    && zero == BFieldElement.canonicalize a

def add (X : XFieldElement) (Y : XFieldElement) : XFieldElement =
    map2 BFieldElement.add X Y 

def neg (X : XFieldElement) : XFieldElement =
    map BFieldElement.neg X

def sub (a: XFieldElement) (b: XFieldElement) : XFieldElement =
    add a (neg b)

-- TODO: Requires Polynomial.divide and BFieldElement.inverse
-- This should not be needed at all.
-- def inverse (_a : XFieldElement) : XFieldElement = zero
--  let self_as_poly = Polynomial.XFieldElement a in
--  let (_, inverse, _) = Polynoimal.xgcd self_as_poly Polynoimal.shah_polynomial in
--  inverse

def xfexfemul (X : XFieldElement) (Y : XFieldElement) : XFieldElement =
    let c0 = X[0]
    let b0 = X[1]
    let a0 = X[2]
    let c1 = Y[0]
    let b1 = Y[1]
    let a1 = Y[2]
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
    [ sub
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
    ]

def xfebfemul (X : XFieldElement) (Y : XFieldElement) : XFieldElement =
    map (\bfeX -> BFieldElement.mul bfeX Y[0]) X

def mul (X : XFieldElement) (Y : XFieldElement) : XFieldElement =
    let b1 = Y[1]
    let a1 = Y[2]
    in if (a1 == 0) && (b1 == 0) 
        then xfebfemul X Y
        else xfexfemul X Y

def mul_bfe (X : XFieldElement) (bfe : BFieldElement) : XFieldElement =
    map (\bfeX -> BFieldElement.mul bfeX bfe) X


-- def div (a: XFieldElement) (b: XFieldElement) : XFieldElement =
--   mul a (inverse b)

-- def rem ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement = one
-- Not supported https://futhark-book.readthedocs.io/en/latest/language.html#parametric-polymorphism
-- def mod_pow 't (element : XFieldElement) (exponent: t) : XFieldElement =

def mod_pow_u64 (element : XFieldElement) (exponent: u64) : XFieldElement =
  let (_, _, result) = loop (x, i, result) = (element, exponent, copy one) while i > 0 do
      if i % 2 == 1
      then (mul x x, i>>1, mul x result)
      else (mul x x, i>>1, result)
  in result

def mod_pow_u32 (element : XFieldElement) (exponent: u32) : XFieldElement =
  let (_, _, result) = loop (x, i, result) = (element, exponent, copy one) while i > 0 do
      if i % 2 == 1
      then (mul x x, i>>1, mul x result)
      else (mul x x, i>>1, result)
   in result

def mod_pow_u8 (element : XFieldElement) (exponent: u8) : XFieldElement =
  let (_, _, result) = loop (x, i, result) = (element, exponent, copy one) while i > 0 do
      if i % 2 == 1
      then (mul x x, i>>1, mul x result)
      else (mul x x, i>>1, result)
   in result

-- Test mul
-- ==
-- entry: test_mod_pow_u8
-- input { 1 1 }
-- output { [1, 0, 0] }
-- input { 0 1 }
-- output { [0, 0, 0] }
-- input { 1 0 }
-- output { [1, 0, 0] }
-- input { 0 0 }
-- output { [1, 0, 0] }
-- input { 0 2 }
-- output { [0, 0, 0] }
-- input { 3 3 }
-- output { [27, 0, 0] }
entry test_mod_pow_u8 (xfe_raw : i32) (exp_raw : i32) : [3]i32 =
  let xfe = from_i32 xfe_raw
  let exp = u8.i32 exp_raw
  let res = mod_pow_u8 xfe exp
  let arr = res
  in map i32.u64 arr

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
-- input { [18446744073709551615u64, 18446744073709551615u64, 18446744073709551615u64]
--         [18446744073709551615u64, 18446744073709551615u64, 18446744073709551615u64]
-- }
-- output { [12884901885u64, 18446744030759878666u64, 18446744017874976781u64] }
-- input { [0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64]
--         [0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64, 0xffff_ffff_ffff_ffffu64]
-- }
-- output { [12884901885u64, 18446744030759878666u64, 18446744017874976781u64] }
entry mul_test_array (a: [3]u64) (b: [3]u64) : [3]u64 =
    mul a b

-- Segmented scan with XFieldElementaddition
-- Benchmark against version from library
def segmented_scan_add [n] (flags : [n]bool) (vals : [n]XFieldElement) : ?[l].[l]XFieldElement =
  let pairs = scan ( \(v1,f1) (v2,f2) ->
                       let f = f1 || f2
                       let v = if f2 then v2 else add v1 v2
                       in (v,f) ) (zero, false) (zip vals flags)
  let (res, _) = unzip pairs
   in res


