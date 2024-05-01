-- module LinAlg = import "lib/github.com/diku-dk/linalg/linalg"
-- import "Utils"
-- Helpers
def fst (a,_) = a
def snd (_,b) = b

-- Types and constants
type BFieldElement = u64

-- U128 related
type U128 = (u64, u64)
def u128_from (x: u64) : U128 = (0u64, x)
def u64_from (x: U128) : u64 = snd x

-- 2^32 - 1
def lower32bit : u64 = 0xffff_ffff
-- 2^64 - 2^32 + 1
-- let P : BFieldElement = 2**64 - 2**32 + 1
def P : BFieldElement = 0xffff_ffff_0000_0001u64
def R2: u64 = 0xffff_fffe_0000_0001
def MAX : BFieldElement = P - 1
def zero : BFieldElement = 0
def one  : BFieldElement = 1

def overflowing_add (augend: u64) (addend: u64) : (u64, bool) =
  let sum = augend + addend
  in (sum, sum < augend)

def overflowing_sub (minuend: u64) (subtrahend: u64) : (u64, bool) =
  (minuend - subtrahend, subtrahend > minuend)

def montyred (x: U128) : u64 =
  let xl = u64_from x
  let xh = fst x
  let (a, e) = overflowing_add xl (xl << 32)
  let b = (a - (a >> 32)) - (u64.bool e)
  let (r, c) = overflowing_sub xh b
  in r - (1 + !P) * (u64.bool c)

def add (lhs: BFieldElement) (rhs: BFieldElement): BFieldElement =
  let (x1, c1) = overflowing_sub (lhs) (P - rhs)
  let adj = 0 - (u32.bool c1)
  in x1 - (u64.u32 adj)

def sub (lhs: BFieldElement) (rhs: BFieldElement): BFieldElement =
  let (x1, c1) = overflowing_sub lhs rhs
  in x1 - ((1 + !P) * u64.bool c1)

def u64_mul (lhs: u64) (rhs: u64) : U128 =
  -- TODO: Is it better to represent these as u32s?
  let lhs_lo : u64 = lhs & lower32bit
  let lhs_hi : u64 = lhs >> 32
  let rhs_lo : u64 = rhs & lower32bit
  let rhs_hi : u64 = rhs >> 32

  -- start from least significant bits to allow for carry
  let a : u64 = lhs_lo * rhs_lo
  let carry0 : u64 = a >> 32
  let prod0 : u64 = a & lower32bit

  let loh1 : u64 = lhs_hi * rhs_lo
  let loh2 : u64 = lhs_lo * rhs_hi
  let b : u64 = (loh1 & lower32bit) + (loh2 & lower32bit) + carry0
  let prod1 : u64 = b & lower32bit
  let carry1 : u64 = b >> 32

  let hi : u64 = (loh1 >> 32) + (loh2 >> 32) + lhs_hi * rhs_hi + carry1
  let lo : u64 = (prod1 << 32) | prod0

  in (hi, lo)

def new (n: u64) : BFieldElement = montyred (u64_mul n R2)

def value (self: BFieldElement): u64 =
  montyred (u128_from self)

def mul (lhs: BFieldElement) (rhs: BFieldElement): BFieldElement =
  montyred (u64_mul lhs rhs)

-- -- Todo:  repeated squaring
-- def powmod (base: BFieldElement) (exponent: BFieldElement): BFieldElement =
--   fst <| loop (acc, exp) = (one, exponent) while 0 < exp do
--     (redmod <| u64_mul acc base, exp - 1)

-- ---- Todo: Winterfell's
-- def invmod (b: BFieldElement): BFieldElement = powmod b (P-2)
-- def divmod (a: BFieldElement) (b: BFieldElement): BFieldElement = mulmod a (invmod b)

entry main (a: u64) : u64 =
  let res = mul (new a) (new a)
  in value res

-- Test new_is_inverse_of_value
-- ==
-- entry: new_is_inverse_of_value_pbt
-- random input { u64 }
-- output { true }
entry new_is_inverse_of_value_pbt (a: u64) : bool =
  (value (new a)) == a

-- Test that multiplying small numbers does not wrap around
-- ==
-- entry: mul_small_no_wrap
-- random input { u32 u32 }
-- output { true }
entry mul_small_no_wrap (a: u32) (b: u32) : bool =
  value (mul (new (u64.u32 a)) (new (u64.u32 a))) == (u64.u32 a) * (u64.u32 b)

-- Test u64_mul
-- ==
-- entry: u64_mul_test
-- input  { 1u64 1u64 }
-- output { 0u64 1u64 }
-- input  { 999u64 999u64 }
-- output { 0u64 998001u64 }
-- input  { 0x1ffffff23ffffff4u64 0x5888888678888889u64 }
-- output { 0xb11110c0dbbbbd4u64 0x44445699999994u64  }
-- input  { 0x0u64 0xffffffffffffffffu64 }
-- output { 0x0u64 0x0u64 }
-- input  { 0xffffffffffffffffu64 0x0u64 }
-- output { 0x0u64 0x0u64 }
-- input  { 0xf000000000000000u64 0xf000000000000000u64 }
-- output { 0xe100000000000000u64 0x0u64 }
-- input  { 0xffffffffffffffffu64 0xffffffffffffffffu64 }
-- output { 0xfffffffffffffffeu64 0x1u64 }
entry u64_mul_test (a: u64) (b: u64) : (u64, u64) =
  u64_mul a b

-- Montyred mul test
-- ==
-- entry: montyred_mul_test
-- input  { 1u64 1u64 }
-- output { 18446744065119617025u64 }
-- input  { 2u64 2u64 }
-- output { 18446744052234715137u64 }
-- input  { 10u64 20u64 }
-- output { 18446743210421125121u64 }
entry montyred_mul_test (lhs: u64) (rhs: u64) : u64 =
  montyred (u64_mul lhs rhs)

-- Test multest
-- ==
-- entry: unit_test_mul
-- input  { 0x200u64 0x3000u64 }
-- output { 0x600000u64 }
-- input  { 0xffffffffu64 0xffffffffu64 }
-- output { 18446744065119617025u64 }
-- input  { 4294967295u64 4294967283u64 }
-- output { 18446744013580009485u64 }
entry unit_test_mul (a: u64) (b: u64) : u64 =
 value (mul (new a) (new b))

-- Test montyred_works
-- ==
-- entry: montyred_test
-- input  { 1u64 }
-- output { 18446744065119617025u64 }
-- input  { 2u64 }
-- output { 18446744060824649729u64 }
-- input  { 3u64 }
-- output { 18446744056529682433u64 }
-- input  { 10000000000u64 }
-- output { 12390559248243752963u64 }
-- input  { 4545u64 }
-- output { 18446724548788224001u64 }
-- input  { 18446744069414584320u64 }
-- output { 4294967296u64 }
-- input  { 18446744069414584319u64 }
-- output { 8589934592u64 }
entry montyred_test (a: u64) : u64 =
  montyred (u128_from a)