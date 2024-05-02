module BFieldElement = import "BFieldElement"
module shared = import "shared"

type BFieldElement = BFieldElement.BFieldElement

-- TODO: Can we use `resize` instead?
let concat_to 'a (m: i64) (a: []a) (b: []a) : [m]a =
  a ++ b :> [m]a

def bfe_ntt_iteration [n] (log2m: i64) (data: [n]BFieldElement) (w_m: BFieldElement) (j: i64) : (i64, BFieldElement, i64, BFieldElement) =
    let m = 1 << log2m
    let bitmask = m - 1
    let w = BFieldElement.mod_pow_i64 w_m (j & bitmask)
    let (u, v) = (data[j],
                  data[j + (n >> 1)] BFieldElement.*^ w)
    let (u, v) = (u BFieldElement.+^ v, u BFieldElement.-^ v)
    let idxD = ((j & !bitmask) << 1) + (j & bitmask)
    in (idxD, u, idxD + m, v)

def bfe_ntt' [n] (bits: i64) (omega: BFieldElement) (input: [n]BFieldElement): [n]BFieldElement =
    let input = copy input
    let output = copy input
    let ix = iota (n >> 1)
    let log2ms = iota bits
    let (res,_) =
        loop (input': *[n]BFieldElement, output': *[n]BFieldElement) = (input, output) for log2m in log2ms do
            let w_m = BFieldElement.mod_pow_i64 omega (n >> (log2m + 1))
            let (i0s, us, i1s, vs) = unzip4 (map (bfe_ntt_iteration log2m input' w_m) ix)
            in (scatter output'
                (concat_to n i0s i1s)
                (us ++ vs :> [n]BFieldElement),
                input')
    in res

def bfe_ntt [n] (data: [n]BFieldElement): [n]BFieldElement =
    let bits = assert (shared.is_power_of_2 n) (shared.ilog2 n)
    let omega = BFieldElement.primitive_root n
    in bfe_ntt' bits omega data

def bfe_intt [n] (data: [n]BFieldElement): [n]BFieldElement =
    let bits = assert (shared.is_power_of_2 n) (shared.ilog2 n)
    let omega_inverse = BFieldElement.inverse (BFieldElement.primitive_root n)
    let n_bfe_inv = BFieldElement.inverse (BFieldElement.new (u64.i64 n))
    let unscaled_result = bfe_ntt' bits omega_inverse data
    in map (BFieldElement.mul n_bfe_inv) unscaled_result

-- Run `m` NTTs in parallel
def parallel_col_major_ntt [n][m] (data: [m][n]BFieldElement): [m][n]BFieldElement =
    let bits = assert (shared.is_power_of_2 n) (shared.ilog2 n)
    let omega = BFieldElement.primitive_root n
    in map (bfe_ntt' bits omega) data

def parallel_col_major_intt [n][m] (data: [m][n]BFieldElement): [m][n]BFieldElement =
    let bits = assert (shared.is_power_of_2 n) (shared.ilog2 n)
    let omega_inverse = BFieldElement.inverse (BFieldElement.primitive_root n)
    let n_bfe_inv = BFieldElement.inverse (BFieldElement.new (u64.i64 n))
    let unscaled_results = map (bfe_ntt' bits omega_inverse) data
    in map (map (BFieldElement.mul n_bfe_inv)) unscaled_results

-- ==
-- entry: unit_test_bfe_ntt'
-- input { [10u64] 1u64 }
-- output { [10u64] }
-- input { [10u64, 0u64] 0xffff_ffff_0000_0000u64 }
-- output { [10u64, 10u64] }
-- input { [10u64, 0u64, 0u64, 0u64] 281474976710656u64 }
-- output { [10u64, 10u64, 10u64, 10u64] }
-- input { [1u64, 4u64, 0u64, 0u64] 281474976710656u64 }
-- output { [5u64, 1125899906842625u64, 18446744069414584318u64, 18445618169507741698u64] }
-- input { [2u64, 3u64, 5u64, 7u64] 281474976710656u64 }
-- output { [17u64, 18445618169507741694u64, 0xffff_fffe_ffff_fffeu64, 1125899906842621u64] }
entry unit_test_bfe_ntt' [n] (input: [n]u64) (omega: u64): [n]u64 =
    map BFieldElement.new input |> bfe_ntt' (shared.ilog2 n) (BFieldElement.new omega) |> map BFieldElement.value

-- ==
-- entry: intt_unit_test
-- input { [10u64] }
-- output { [10u64] }
-- input { [10u64, 10u64] }
-- output { [10u64, 0u64] }
-- input { [10u64, 10u64, 10u64, 10u64] }
-- output { [10u64, 0u64, 0u64, 0u64] }
entry intt_unit_test [n] (input: [n]u64): [n]u64 =
    let input = map BFieldElement.new input
    in map BFieldElement.value (bfe_intt input)

-- ==
-- entry: ntt_intt_identity_pbt
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
entry ntt_intt_identity_pbt [n] (input: [n]u64): bool =
    let input = map BFieldElement.new input
    let should_be_input = (bfe_ntt input |> bfe_intt)
    let res = shared.eq_arr BFieldElement.eq input should_be_input
    in res

-- ==
-- entry: parallel_ntt_unit_test
-- input { [[10u64], [10u64]] }
-- output { [[10u64], [10u64]] }
-- input { [[10u64, 0u64], [10u64, 0u64]] }
-- output { [[10u64, 10u64], [10u64, 10u64]] }
-- input { [[10u64, 0u64, 0u64, 0u64], [11u64, 0u64, 0u64, 0u64], [16u64, 0u64, 0u64, 0u64] ] }
-- output { [[10u64, 10u64, 10u64, 10u64], [11u64, 11u64, 11u64, 11u64], [16u64, 16u64, 16u64, 16u64]] }
entry parallel_ntt_unit_test [n][m] (input: [m][n]u64): [m][n]u64 =
    let input = map (map BFieldElement.new) input
    in map (map BFieldElement.value) (parallel_col_major_ntt input)

-- ==
-- entry: parallel_intt_unit_test
-- input { [[10u64], [10u64]] }
-- output { [[10u64], [10u64]] }
-- input { [[10u64, 10u64], [10u64, 10u64]] }
-- output { [[10u64, 0u64], [10u64, 0u64]] }
-- input { [[10u64, 10u64, 10u64, 10u64], [11u64, 11u64, 11u64, 11u64], [16u64, 16u64, 16u64, 16u64]] }
-- output { [[10u64, 0u64, 0u64, 0u64], [11u64, 0u64, 0u64, 0u64], [16u64, 0u64, 0u64, 0u64] ] }
entry parallel_intt_unit_test [n][m] (input: [m][n]u64): [m][n]u64 =
    let input = map (map BFieldElement.new) input
    in map (map BFieldElement.value) (parallel_col_major_intt input)

-- ==
-- entry: parallel_ntt_intt_identity_pbt
-- random input { [3][1]u64 }
-- output { true }
-- random input { [6][2]u64 }
-- output { true }
-- random input { [12][4]u64 }
-- output { true }
-- random input { [2][8]u64 }
-- output { true }
-- random input { [7][16]u64 }
-- output { true }
-- random input { [133][32]u64 }
-- output { true }
-- random input { [5][64]u64 }
-- output { true }
entry parallel_ntt_intt_identity_pbt [n][m] (input: [m][n]u64): bool =
    let input = map (map BFieldElement.new) input
    let should_be_input = (parallel_col_major_ntt input |> parallel_col_major_intt)
    in shared.eq_arr_2d BFieldElement.eq input should_be_input
