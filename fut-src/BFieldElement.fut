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

def wrapping_sub (minuend: u64) (subtrahend: u64) : u64 =
  minuend - subtrahend

def overflowing_sub (minuend: u64) (subtrahend: u64) : (u64, bool) =
  (minuend - subtrahend, subtrahend > minuend)

def wrapping_add (augend: u64) (addend: u64) : u64 =
  augend + addend

def montyred (x: U128) : u64 =
  let xl = u64_from x
  let xh = fst x
  let (a, e) = overflowing_add xl (xl << 32)
  let b = wrapping_sub (wrapping_sub a (a >> 32)) (u64.bool e)
  let (r, c) = overflowing_sub xh b
  in (wrapping_sub r (1 + !P) * (u64.bool c))

def new (n: u64) : BFieldElement = (montyred (u128_from n)) * R2

def value (self: BFieldElement): u64 =
  montyred (u128_from self)

-- -- Futhark's naming convention: BFieldElement.bool : bool -> BFieldElement
-- def bool (x: bool) : BFieldElement = u64.bool x
-- def U64 (x: u64) : BFieldElement = canonicalize x
-- def U32 (x: u32) : BFieldElement = U64 (u64.u32 x)
-- def I32 (x: i32) : BFieldElement = U64 (u64.i32 x)
-- --def newmod (n: i32): BFieldElement = canonicalize (u64.i32 n)

def add (lhs: BFieldElement) (rhs: BFieldElement): BFieldElement =
  let (x1, c1) = overflowing_sub (lhs) (P - rhs)
  let adj = 0 - (u32.bool c1)
  in wrapping_sub x1 (u64.u32 adj)

def sub (lhs: BFieldElement) (rhs: BFieldElement): BFieldElement =
  let (x1, c1) = overflowing_sub lhs rhs
  in wrapping_sub x1 ((1 + !P) * u64.bool c1)

-- Multiplication of two u64.
-- Instead of trying to debug in Futhark, have a look at `u64_mul.py` that
-- prints all intermediate values in a readable form.
--
-- This is needed because multiplication
--    #[inline]
--    fn mul(self, other: Self) -> Self {
--        let val: u64 = Self::mod_reduce(self.0 as u128 * other.0 as u128);
--        Self(val)
--
-- The math:
--   [ahi][alo]             * [bhi][blo]
-- = ([ahi] * 2^64 + [alo]) * ([bhi] * 2^64 + [blo])
-- assert ahi == bhi == 0
--   [alo]                                                  * [blo]
-- =([ah] * 2^32 + [al])                                    *([bh] * 2^32 + [bl])
-- = [ah] * 2^32 * ([bh] * 2^32 + [bl])                     + [al] * ([bh] * 2^32 + [bl])
-- = [ah] * 2^32 * [bh] * 2^32      + [ah] * 2^32 * [bl]    + [al] * [bh] * 2^32 + [al] * [bl]
-- = [ah] * [bh] * 2^32 * 2^32      + [ah] * [bl] * 2^32    + [al] * [bh] * 2^32 + [al] * [bl]
-- = [ah] * [bh] * 2^64             + [ah] * [bl] * 2^32    + [al] * [bh] * 2^32 + [al] * [bl]
-- = [ah] * [bh] * 2^64             +([ah] * [bl] + [al] * [bh] ) * 2^32         + [al] * [bl]
-- = [hi       ]                     [loh                       ]                  [lol      ]
--                                   [lo                                                     ]
def u64_mul (a: u64) (b: u64) : U128 =
  -- let (ahi, alo) : (u64, u64) = a
  -- let (bhi, blo) : (u64, u64) = b
  -- let _ = assert ahi 0u64
  -- let _ = assert bhi 0u64

  let alo = a
  let blo = b

  let ah : u64 = alo >> 32
  let al : u64 = alo & lower32bit
  let bh : u64 = blo >> 32
  let bl : u64 = blo & lower32bit

  -- start from least significant bits to allow for carry
  let lol : u64 = al * bl
  let lolh : u64 = lol >> 32
  let loll : u64 = lol & lower32bit

  -- this may need 2^65
  -- let loh : u64 = ah * bl + al * bh + lolh
  let loh1 : u64 = ah * bl
  let loh2 : u64 = al * bh
  let lohh : u64 = (loh1 >> 32) + (loh2 >> 32) + (lolh >> 32)
  let lohl : u64 = (loh1 & lower32bit) + (loh2 & lower32bit) + (lolh & lower32bit)
  let lohlh : u64 = lohl >> 32
  let lohll : u64 = lohl & lower32bit

  let hi : u64 = ah * bh + lohh + lohlh
  let lo : u64 = (lohll << 32) | loll

  in (hi, lo)

def mul (lhs: BFieldElement) (rhs: BFieldElement): BFieldElement =
  montyred (u64_mul lhs rhs)

-- -- Todo:  repeated squaring
-- def powmod (base: BFieldElement) (exponent: BFieldElement): BFieldElement =
--   fst <| loop (acc, exp) = (one, exponent) while 0 < exp do
--     (redmod <| u64_mul acc base, exp - 1)

-- ---- Todo: Winterfell's
-- def invmod (b: BFieldElement): BFieldElement = powmod b (P-2)
-- def divmod (a: BFieldElement) (b: BFieldElement): BFieldElement = mulmod a (invmod b)

entry main : bool =
  let a : u64 = 0x1ffffff23ffffff4 -- 18446744073709551615u64
  let b : u64 = 0x5888888678888889 -- 18156523423432432234u64
  -- let res = canonicalize <| redmod <| u64_mul a b
  let res = mul a b
  in res == 1008806499080522932 -- from Python3: a * b % 0xffff_ffff_0000_0001

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


-- Test new_is_inverse_of_value
-- ==
-- entry: new_is_inverse_of_value_test
-- input  {  1u64 }
-- output { 1u64 }
-- input  { 10000000000u64 }
-- output { 10000000000u64 }
entry new_is_inverse_of_value_test (a: u64) : u64 =
  value (new a)

-- The following test are original

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


-- Test multest
-- ==
-- entry: thorkil_mul_test
-- input  { 0x200u64 0x3000u64 }
-- output { 0x3200u64 }
entry thorkil_mul_test (a: u64) (b: u64) : u64 =
 montyred (u64_mul a b)
