-- Helpers
def fst (a,_) = a
def snd (_,b) = b


-- Types and constants

type BFieldElement = u64
type U128 = (u64, u64)
def u128_from (x: u64) : U128 = (0u64, x)
def u64_from (x: U128) : u64 = snd x


-- 2^32 - 1
def lower32bit : u64 = 0xffff_ffff
-- 2^64 - 2^32 + 1
-- let prime : BFieldElement = 2**64 - 2**32 + 1
def prime : BFieldElement = 0xffff_ffff_0000_0001u64
def quotient : BFieldElement = 0xffff_ffff_0000_0001u64
def MAX : BFieldElement = quotient - 1
-- let prime : BFieldElement = 101
def zero : BFieldElement = 0
def one  : BFieldElement = 1

def canonicalize (n: BFieldElement) : BFieldElement = n % prime

def new (n: u64) : BFieldElement = canonicalize n

-- Futhark's naming convention: BFieldElement.bool : bool -> BFieldElement
def bool (x: bool) : BFieldElement = u64.bool x
def U64 (x: u64) : BFieldElement = canonicalize x
def U32 (x: u32) : BFieldElement = U64 (u64.u32 x)
def I32 (x: i32) : BFieldElement = U64 (u64.i32 x)
--def newmod (n: i32): BFieldElement = canonicalize (u64.i32 n)

def overflowing_sub (minuend: u64) (subtrahend: u64) : (u64, bool) =
  (minuend - subtrahend, subtrahend > minuend)


def wrapping_sub (minuend: u64) (subtrahend: u64) : u64 =
  minuend - subtrahend


def overflowing_add (augend: u64) (addend: u64) : (u64, bool) =
  let sum = augend + addend
  in (sum, sum < augend)


def wrapping_add (augend: u64) (addend: u64) : u64 =
  augend + addend

def add (a: BFieldElement) (b: BFieldElement): BFieldElement =
  let (result, overflow) = overflowing_add a b
  let vala = wrapping_sub result (quotient * (u64.bool overflow)) in
  if vala > MAX then vala - quotient else vala


--TODO: what happens when b > a
-- def submod (a: BFieldElement) (b: BFieldElement): BFieldElement = (a - b) % prime
def sub (a: BFieldElement) (b: BFieldElement): BFieldElement =
  let (result, overflow) = overflowing_sub a (canonicalize b)
  in wrapping_add result (prime * u64.bool overflow)

def rem (a: BFieldElement) (b: BFieldElement): BFieldElement = canonicalize (a % b)

def neg (n: BFieldElement) : BFieldElement = prime - canonicalize n

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




-- This reduces for prime 2^64 - 2^32 + 1
-- improvement let _sub return u64 directly
-- inline arithmetic operations
def redmod (x: U128) : u64 =
        let (xh, xl) : (u64, u64) = x
        -- Copied from (MIT licensed):
        --
        -- assume x consists of four 32-bit values: a, b, c, d such that a contains 32 least
        -- significant bits and d contains 32 most significant bits. we break x into corresponding
        -- values as shown below
        -- let ab = x as u64;
        let ab : u64 = xl
        -- let cd = (x >> 64) as u64;
        let cd : u64 = xh
        -- let c = (cd as u32) as u64;
        let c : u64 = u64.u32 (u32.u64 cd)
        -- alternatively
        -- let c = cd & lower32bit
        let d : u64 = cd >> 32

        -- compute ab - d; because d may be greater than ab we need to handle potential underflow
        let (tmp0, under) : (u64, bool) = overflowing_sub ab d
        --let tmp1 = tmp0.wrapping_sub(Self::LOWER_MASK * (under as u64));
        let tmp1 : u64 = wrapping_sub tmp0 (lower32bit  * (u64.bool under))

        -- compute c * 2^32 - c; this is guaranteed not to underflow
        let tmp2 : u64 = (c << 32) - c

        -- add temp values and return the result; because each of the temp may be up to 64 bits,
        -- we need to handle potential overflow
        let (result, over) : (u64, bool) = overflowing_add tmp1 tmp2
        let ret = wrapping_add result (lower32bit * (u64.bool over))
        in ret

def fastmul (a: u64) (b: u64): u64 = redmod (u64_mul a b)
def mulmod (a: u64) (b: u64): BFieldElement = canonicalize (fastmul a b)
def mul = fastmul

-- Todo:  repeated squaring
def powmod (base: BFieldElement) (exponent: BFieldElement): BFieldElement =
  fst <| loop (acc, exp) = (one, exponent) while 0 < exp do
    (redmod <| u64_mul acc base, exp - 1)

---- Todo: Winterfell's
def invmod (b: BFieldElement): BFieldElement = powmod b (prime-2)
def divmod (a: BFieldElement) (b: BFieldElement): BFieldElement = mulmod a (invmod b)

entry main : bool =
  let a : u64 = 0x1ffffff23ffffff4 -- 18446744073709551615u64
  let b : u64 = 0x5888888678888889 -- 18156523423432432234u64
  let res = canonicalize <| redmod <| u64_mul a b
  in res == 1008806499080522932 -- from Python3: a * b % 0xffff_ffff_0000_0001

entry main2  =
  let a : u64 = 0xffffffffffffffff
  let b : u64 = 0xffffffffffffffff
  let res = u64_mul a b
  in res

-- Verify output tuple with:
-- a = 0x1ffffff23ffffff4
-- b = 0x5888888678888889
-- expected = hex(a*b)

-- def pp(a,b):
--     print(f'{a:#0{16+2}x}{b:0{16}x}')
-- actual = pp($OUTPUT1, $OUTPUT2)

def mainnext : bool =
  (powmod 11 3253254) == 4407581000591417503


-- Tests from Rust documentation:
-- https://doc.rust-lang.org/std/primitive.u64.html#method.overflowing_add
-- u64.highest = 18446744073709551615u64


-- Test the `overflowing_sub` function.
--
-- assert_eq!(5u64.overflowing_sub(2), (3, false));
-- assert_eq!(0u64.overflowing_sub(1), (u64::MAX, true));
-- ==
-- entry: overflowing_sub_test
-- input { 5u64 2u64 }
-- output { 3u64 false }
-- input { 0u64 1u64 }
-- output { 18446744073709551615u64 true }

entry overflowing_sub_test (minuend: u64) (subtrahend: u64) : (u64, bool) =
  overflowing_sub minuend subtrahend


-- Test the `wrapping_sub` function.
--
-- assert_eq!(100u64.wrapping_sub(100), 0);
-- assert_eq!(100u64.wrapping_sub(u64::MAX), 101);
-- ==
-- entry: wrapping_sub_test
-- input { 100u64 100u64 }
-- output { 0u64 }
-- input { 100u64 18446744073709551615u64 }
-- output { 101u64 }

entry wrapping_sub_test (minuend: u64) (subtrahend: u64) : u64 =
  wrapping_sub minuend subtrahend


-- Test the `overflowing_add` function.
--
-- assert_eq!(5u64.overflowing_add(2), (7, false));
-- assert_eq!(u64::MAX.overflowing_add(1), (0, true));
-- ==
-- entry: overflowing_add_test
-- input { 5u64 2u64 }
-- output { 7u64 false }
-- input { 18446744073709551615u64 1u64 }
-- output { 0u64 true }

entry overflowing_add_test (augend: u64) (addend: u64) : (u64, bool) =
  overflowing_add augend addend


-- Test the `wrapping_add` function.
--
-- assert_eq!(200u64.wrapping_add(55), 255);
-- assert_eq!(200u64.wrapping_add(u32::MAX), 199);
-- ==
-- entry: wrapping_add_test
-- input { 200u64 55u64 }
-- output { 255u64 }
-- input { 200u64 18446744073709551615u64 }
-- output { 199u64 }

entry wrapping_add_test (augend: u64) (addend: u64) : u64 =
  wrapping_add augend addend


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
-- input  { 0x200000000000u64 0x200000000000u64 }
-- output { 288230376084602880u64 }
entry thorkil_mul_test (a: u64) (b: u64) : u64 =
 redmod (u64_mul a b)
