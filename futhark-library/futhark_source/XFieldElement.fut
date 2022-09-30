-- TODO:
-- 1. Rename c, b, a to c, b, a
--

module BFieldElement = import "BFieldElement"

type BFieldElement = BFieldElement.BFieldElement
type XFieldElement = (BFieldElement, BFieldElement, BFieldElement)

def new (c: BFieldElement) (b: BFieldElement) (a: BFieldElement) : XFieldElement = (c, b, a)

def tripple2array (c, b, a) : [3]u64 = [c, b, a]
def array2tripple (cba: [3]u64) : XFieldElement = new cba[0] cba[1] cba[2]


def canonicalize ((c, b, a) : XFieldElement) : XFieldElement =
  ( BFieldElement.canonicalize c
  , BFieldElement.canonicalize b
  , BFieldElement.canonicalize a
  )

def new_u64 (c: u64, b: u64, a: u64) : XFieldElement =
  (BFieldElement.U64 c, BFieldElement.U64 b, BFieldElement.U64 a)

def new_const (element: BFieldElement) : XFieldElement = new element BFieldElement.zero BFieldElement.zero

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

def add ((a_c, b0, a0) : XFieldElement) ((b_c, b1, a1) : XFieldElement) : XFieldElement =
  ( (BFieldElement.add a_c b_c)
  , (BFieldElement.add b0 b1)
  , (BFieldElement.add a0 a1)
  )

def neg ((c, b, a) : XFieldElement) : XFieldElement =
  ( BFieldElement.neg c
  , BFieldElement.neg b
  , BFieldElement.neg a
  )

def sub (a: XFieldElement) (b: XFieldElement) : XFieldElement =
  canonicalize (add a (neg b))

-- TODO: Requires Polynomial.divide and BFieldElement.inverse
def inverse (a : XFieldElement) : XFieldElement = one
--  let self_as_poly = Polynomial.XFieldElement a in
--  let (_, inverse, _) = Polynoimal.xgcd self_as_poly Polynoimal.shah_polynomial in
--  inverse

def mul ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement =
-- Special cases
-- use arithmetic operations from this module
 ( c0 * c1 - a0 * b1 - b0 * a1                      -- * x^0
 , b0 * c1 + c0 * b1 - a0 * a1 + a0 * b1 + b0 * a1  -- * x^1
 , a0 * c1 + b0 * b1 + c0 * a1 + a0 * a1            -- * x^2
 )

def div (a: XFieldElement) (b: XFieldElement) : XFieldElement =
  mul a (inverse b)

-- def mod ((c0, b0, a0) : XFieldElement) ((c1, b1, a1) : XFieldElement) : XFieldElement = one

def mod_pow_u64 (element : XFieldElement) (exponent: u64) : XFieldElement =
  let (_, _, result) = loop (x, i, result) = (element, exponent, one) while i > 0 do
      if i % 2 == 1
      then (mul x x, i>>1, mul x result)
      else (mul x x, i>>1, result)
   in result

def mod_pow_u32 (element : XFieldElement) (exponent: u32) : XFieldElement =
  mod_pow_u64 element (u64.u32 exponent)
