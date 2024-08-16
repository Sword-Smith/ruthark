module shared = import "shared"

-- module LinAlg = import "lib/github.com/diku-dk/linalg/linalg"
-- import "Utils"
-- Helpers
def fst (a,_) = a
def snd (_,b) = b

-- Types and constants
type BFieldElement = { 0: u64 }

-- U128 related
type U128 = (u64, u64)
def u128_from (x: u64) : U128 = (0u64, x)
def u64_from (x: U128) : u64 = snd x

-- U128 addition
def u128_add (x: U128) (y: U128) : U128 =
  let (x_hi, x_lo) = x
  let (y_hi, y_lo) = y
  -- add lo values
  let lo = x_lo + y_lo
  -- check for overflow
  let carry = if lo < x_lo then 1u64 else 0u64
  -- add hi values and any carry
  let hi = x_hi + y_hi + carry
  in (hi, lo)

-- U128 left shift
def u128_left_shift (x: U128) (shift: u64) : U128 =
  let (hi, lo) = x
  in if shift >= 64
     then
       -- When shift is 64 or more, all bits move to the higher part
       (lo << (shift - 64), 0u64)
     else
       -- Regular shifting within 64 bits
       let new_hi = (hi << shift) | (lo >> (64 - shift))
       let new_lo = lo << shift
       in (new_hi, new_lo)

-- right shift for u128
def u128_right_shift (x: U128) (shift: u64) : U128 =
  let (hi, lo) = x
   -- When shift is 64 or more, all bits move to the lower part
  in if shift >= 64 
    then (0u64, hi >> (shift - 64))  
    else 
     -- Regular shifting within 64 bits
      let new_lo = (hi << (64 - shift)) | (lo >> shift)
      let new_hi = hi >> shift
      in (new_hi, new_lo)

-- 2^32 - 1
def lower32bit : u64 = 0xffff_ffff
-- 2^64 - 2^32 + 1
-- let P : BFieldElement = 2**64 - 2**32 + 1
def P : u64 = 0xffff_ffff_0000_0001u64
def MAX : u64 = P - 1
def R2: u64 = 0xffff_fffe_0000_0001
def zero: BFieldElement = {0 = 0}
def one: BFieldElement = {0 = 4294967295} -- inner representation of one, montyred(R2)

def is_zero (x: BFieldElement): bool =
  x.0 == zero.0

def is_one (x: BFieldElement): bool =
  x.0 == one.0

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

def eq (a: BFieldElement) (b: BFieldElement): bool =
  a.0 == b.0

def (a: BFieldElement) ==^ (b: BFieldElement): bool =
  eq a b

def add (a: BFieldElement) (b: BFieldElement): BFieldElement =
  let (x1, c1) = overflowing_sub a.0 (P - b.0)
  let adj = 0 - (u32.bool c1)
  in {0 = x1 - (u64.u32 adj)}

def (a: BFieldElement) +^ (b: BFieldElement): BFieldElement =
  add a b

def sub (a: BFieldElement) (b: BFieldElement): BFieldElement =
  let (x1, c1) = overflowing_sub a.0 b.0
  in {0 = (x1 - ((1u64 + !P) * u64.bool c1))}

def (lhs: BFieldElement) -^ (rhs: BFieldElement): BFieldElement =
  sub lhs rhs

def neg (a: BFieldElement): BFieldElement =
  zero -^ a

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

def new (n: u64) : BFieldElement = {0 = montyred (u64_mul n R2) }

-- get a generator for the entire field
def generator : BFieldElement = new 7 

def from_raw_u64 (raw_u64: u64) : BFieldElement =
  { 0 = raw_u64 }

def to_raw_u64 (value: BFieldElement) : u64 =
  value.0

def primitive_root (order: i64) : BFieldElement =
  match order
    case 0i64 -> assert false zero
    case 1i64 -> new 1u64
    case 2i64 -> new 18446744069414584320u64
    case 4i64 -> new 281474976710656u64
    case 8i64 -> new 18446744069397807105u64
    case 16i64 -> new 17293822564807737345u64
    case 32i64 -> new 70368744161280u64
    case 64i64 -> new 549755813888u64
    case 128i64 -> new 17870292113338400769u64
    case 256i64 -> new 13797081185216407910u64
    case 512i64 -> new 1803076106186727246u64
    case 1024i64 -> new 11353340290879379826u64
    case 2048i64 -> new 455906449640507599u64
    case 4096i64 -> new 17492915097719143606u64
    case 8192i64 -> new 1532612707718625687u64
    case 16384i64 -> new 16207902636198568418u64
    case 32768i64 -> new 17776499369601055404u64
    case 65536i64 -> new 6115771955107415310u64
    case 131072i64 -> new 12380578893860276750u64
    case 262144i64 -> new 9306717745644682924u64
    case 524288i64 -> new 18146160046829613826u64
    case 1048576i64 -> new 3511170319078647661u64
    case 2097152i64 -> new 17654865857378133588u64
    case 4194304i64 -> new 5416168637041100469u64
    case 8388608i64 -> new 16905767614792059275u64
    case 16777216i64 -> new 9713644485405565297u64
    case 33554432i64 -> new 5456943929260765144u64
    case 67108864i64 -> new 17096174751763063430u64
    case 134217728i64 -> new 1213594585890690845u64
    case 268435456i64 -> new 6414415596519834757u64
    case 536870912i64 -> new 16116352524544190054u64
    case 1073741824i64 -> new 9123114210336311365u64
    case 2147483648i64 -> new 4614640910117430873u64
    case 4294967296i64 -> new 1753635133440165772u64
    case _ -> assert false zero

def value (self: BFieldElement): u64 =
  montyred (u128_from self.0)

def mul (lhs: BFieldElement) (rhs: BFieldElement): BFieldElement =
  {0 = montyred (u64_mul lhs.0 rhs.0)}

def (a: BFieldElement) *^ (b: BFieldElement): BFieldElement =
  mul a b

def mod_pow_i64 (base: BFieldElement) (exponent: i64): BFieldElement =
  let (_, _, result) = loop (x, i, result) = (base, exponent, one) while i > 0 do
    if i % 2 == 1
      then (mul x x, i >> 1, mul x result)
      else (mul x x, i >> 1, result)
    in result

def square (x: BFieldElement): BFieldElement =
  x *^ x

-- Calculate the value $base ^ {2 ^ i}$
def to_the_power_of_power_of_2 (base: BFieldElement) (log2_exponent: i64) : BFieldElement =
  let (res, _) = loop (acc, i) = (base, log2_exponent) while i > 0 do
    (acc *^ acc, i - 1)
  in res

def inverse (x: BFieldElement): BFieldElement =
  -- counter-intuitive name for this helper function but it gives the correct error if execution
  -- halts here.
  let div_by_zero (x: BFieldElement): bool = !(is_zero x)

  let x = assert (div_by_zero x) x
  let bin_2_ones = (square x) *^ x
  let bin_3_ones = (square bin_2_ones) *^ x
  let bin_6_ones = (to_the_power_of_power_of_2 bin_3_ones 3) *^ bin_3_ones
  let bin_12_ones = (to_the_power_of_power_of_2 bin_6_ones 6) *^ bin_6_ones
  let bin_24_ones = (to_the_power_of_power_of_2 bin_12_ones 12) *^ bin_12_ones
  let bin_30_ones = (to_the_power_of_power_of_2 bin_24_ones 6) *^ bin_6_ones
  let bin_31_ones = (square bin_30_ones) *^ x
  let bin_31_ones_1_zero = square bin_31_ones
  let bin_32_ones = (square bin_31_ones) *^ x

  in (to_the_power_of_power_of_2 bin_31_ones_1_zero 32) *^ bin_32_ones

def (lhs: BFieldElement) /^ (rhs: BFieldElement): BFieldElement =
  mul lhs (inverse rhs)

def reverse_array [n] (arr: [n]BFieldElement) : [n]BFieldElement =
    map (\i -> arr[n - 1 - i]) (iota n)

-- == 
-- entry: reverse_array_test
-- input  { [0u64, 1u64, 2u64] }
-- output { [2u64, 1u64, 0u64] }
-- input { [0u64] }
-- output { [0u64] }
entry reverse_array_test (values_arr: []u64) : []u64 =
  map new values_arr |> reverse_array |> map value

-- Test new_is_inverse_of_value
-- ==
-- entry: new_is_inverse_of_value_pbt
-- input  { 1u64 }
-- output { true }
-- input  { 0xffff_ffff_0000_0000u64 }
-- output { true }
-- random input { u64 }
-- output { true }
entry new_is_inverse_of_value_pbt (a: u64) : bool =
  (value (new a)) == a

-- ==
-- entry: neg_plus_self_is_zero
-- random input { u64 }
-- output { true }
entry neg_plus_self_is_zero (a: u64) : bool =
  let a = new a
  in value (add (neg a) a) == 0

-- ==
-- entry: one_is_one
-- random input { }
-- output { true }
entry one_is_one: bool =
  value one == value (new 1) && is_one one

-- ==
-- entry: zero_is_zero
-- random input { }
-- output { true }
entry zero_is_zero: bool =
  value zero == value (new 0) && is_zero zero

-- Test that multiplying small numbers does not wrap around
-- ==
-- entry: mul_small_no_wrap
-- random input { u32 u32 }
-- output { true }
entry mul_small_no_wrap (a: u32) (b: u32) : bool =
  value (mul (new (u64.u32 a)) (new (u64.u32 a))) == (u64.u32 a) * (u64.u32 b)

-- ==
-- entry: mul_with_inverse_yields_one
-- input  { 1u64 }
-- output { true }
-- input  { 2u64 }
-- output { true }
-- input  { 0xffff_ffff_0000_0000u64 }
-- output { true }
-- random input { u64 }
-- output { true }
-- input { 0u64 }
-- error: div_by_zero
entry mul_with_inverse_yields_one (x: u64) : bool =
  let x = new x
  let should_be_one = (inverse x) *^ x
  in is_one should_be_one

-- random input { u64 u64 }
-- output { true }
entry mul_then_div_is_identity (x: u64) (y: u64) : bool =
  let x = new x
  let y = new y
  let should_be_x = (x *^ y) /^ y
  in should_be_x ==^ x

-- ==
-- entry: infix_notation_works
-- random input { u64 u64 }
-- output { true }
entry infix_notation_works (a: u64) (b: u64) : bool =
  -- value (mul (new (u64.u32 a)) (new (u64.u32 a))) == (u64.u32 a) * (u64.u32 b)
  let a_bfe: BFieldElement = new a
  let b_bfe: BFieldElement = new b
  in add (mul a_bfe b_bfe) (sub a_bfe b_bfe) == (a_bfe *^ b_bfe +^ (a_bfe -^ b_bfe))
    && a_bfe ==^ a_bfe && is_one (a_bfe /^ a_bfe)

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

-- Test mod_pow_i64 for BFEs
-- ==
-- entry: mod_pow_i64_unit_test
-- input  { 1u64 0i64 }
-- output { 1u64 }
-- input  { 1u64 1i64 }
-- output { 1u64 }
-- input  { 0xffff_ffff_0000_0000u64 2i64 }
-- output { 1u64 }
-- input  { 281474976710656u64 4i64 }
-- output { 1u64 }
-- input  { 281474976710656u64 0i64 }
-- output { 1u64 }
-- input { 1234567890123u64 0i64 }
-- output { 1u64 }
entry mod_pow_i64_unit_test (base: u64) (exponent: i64) =
  let base = new base
  in value (mod_pow_i64 base exponent)

-- ==
-- entry: primitive_roots_are_primitive_roots
-- input  { 32i64 }
entry primitive_roots_are_primitive_roots (max_log2_order: i64): bool =
  let i = 1i64
  let acc: bool = true
  let (_, res) = loop (i, acc) while i < max_log2_order do
    let order = 1i64 << i
    let primitive_root = primitive_root order
    let should_be_one = mod_pow_i64 primitive_root order
    let is_primitive = if i == 1
      then true
      else
        let half_order = 1i64 << (i - 1)
        let should_not_be_one = mod_pow_i64 primitive_root half_order
        in !(is_one should_not_be_one)
    in (i + 1, acc && is_one should_be_one && is_primitive)
  in res

-- ==
-- entry: to_the_power_of_power_of_2_test
-- random input { u64 }
-- output { true }
entry to_the_power_of_power_of_2_test (base: u64): bool =
  let base = new base
  let max_log2_power = 6
  let i = 0i64
  let acc: bool = true
  let (_, res) = loop (i, acc) while i < max_log2_power do
    let power = 1i64 << i
    in (i + 1, acc && (mod_pow_i64 base power) ==^ (to_the_power_of_power_of_2 base i))
  in res

-- ==
-- entry: u128_left_shift_test
-- input  { 0u64 1u64 32u64 }
-- output { 0u64 4294967296u64 }
-- input  { 0u64 1u64 64u64 }
-- output { 1u64 0u64 }
-- input { 0u64 1u64 88u64 }
-- output { 16777216u64 0u64 }
entry u128_left_shift_test (l_u128: u64) (r_u128: u64) (shift: u64) : (u64, u64) =
  let out = u128_left_shift (l_u128, r_u128) shift
  in (fst out, snd out)

-- ==
-- entry: u128_right_shift_test
-- input  { 0u64 1u64 32u64 }
-- output { 0u64 0u64 }
-- input { 1844674407370955161u64 11105193132817121280u64 6u64 }
-- output { 28823037615171174u64 7379278046493061120u64 }
entry u128_right_shift_test (l_u128: u64) (r_u128: u64) (shift: u64) : (u64, u64) =
  let out = u128_right_shift (l_u128, r_u128) shift
  in (fst out, snd out)

-- ==
-- entry: u128_add_test
-- input  { 0u64 1u64 0u64 1u64 }
-- output { 0u64 2u64 }
-- input  { 0u64 18446744073709551615u64 0u64 1u64 }
-- output { 1u64 0u64 }
-- input { 16777215u64 18446744073709551615u64 34359738367u64 18446744073709551615u64 }
-- output { 34376515583u64 18446744073709551614u64}
entry u128_add_test (l_hi: u64) (l_lo: u64) (r_hi: u64) (r_lo: u64) : (u64, u64) =
  let out = u128_add (l_hi, l_lo) (r_hi, r_lo)
  in (fst out, snd out)