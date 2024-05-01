module BFieldElement = import "BFieldElement"

type BFieldElement = BFieldElement.BFieldElement

let radix = 2i64

-- TODO: Can we use `resize` instead?
let concat_to 'a (m: i64) (a: []a) (b: []a) : [m]a =
  a ++ b :> [m]a

-- TODO: Add `forward` parameter to function signature
-- TODO: Consider calculating `omega_pow` outside of this function
def bfe_ntt_iteration [n] (ns: i64) (data: [n]BFieldElement) (w_m: BFieldElement) (j: i64) : (i64, BFieldElement, i64, BFieldElement) =
    let w = BFieldElement.mod_pow_i64 w_m j
    let (v0, v1) = (data[j],
                    data[j + n / radix] BFieldElement.*^ w)
    let (v0, v1) = (v0 BFieldElement.+^ v1, v0 BFieldElement.-^ v1)
    let idxD = j / ns * ns * radix + j % ns -- TODO: Consider using bit-shifting here instead, as `ns` is power of 2.
    in (idxD, v0, idxD + ns, v1)

-- TODO: Add `forward` parameter to function signature
def bfe_ntt' [n] (bits: i64) (omega: BFieldElement) (input: [n]BFieldElement): [n]BFieldElement =
    let input = copy input
    let output = copy input
    let ix = iota (n / radix)
    let NS = map (radix **) (iota bits)
    let (res,_) =
        loop (input': *[n]BFieldElement, output': *[n]BFieldElement) = (input, output) for ns in NS do
            let w_m = BFieldElement.mod_pow_i64 omega (n / (radix * ns))
            let (i0s, v0s, i1s, v1s) = unzip4 (map (bfe_ntt_iteration ns input' w_m) ix)
            in (scatter output'
                (concat_to n i0s i1s)
                (v0s ++ v1s :> [n]BFieldElement),
                input')
    in res

-- Constant-time log2 (depending on architecture, I guess)
def ilog2 (n: i64) : i64 = i64.i32 (63 - i64.clz n)

-- ==
-- entry: test_bfe_fft'
-- input { [10u64] 1u64 }
-- output { [10u64] }
-- input { [10u64, 0u64] 0xffff_ffff_0000_0000u64 }
-- output { [10u64, 10u64] }
-- input { [10u64, 0u64, 0u64, 0u64] 281474976710656u64 }
-- output { [10u64, 10u64, 10u64, 10u64] }
-- input { [1u64, 4u64, 0u64, 0u64] 281474976710656u64 }
-- output { [5u64, 1125899906842625u64, 18446744069414584318u64, 18445618169507741698u64] }
entry test_bfe_fft' [n] (input: [n]u64) (omega: u64): [n]u64 =
    -- map BFieldElement.value (bfe_ntt' 0i64 (map BFieldElement.new input) BFieldElement.one)
    map BFieldElement.new input |> bfe_ntt' (ilog2 n) (BFieldElement.new omega) |> map BFieldElement.value
