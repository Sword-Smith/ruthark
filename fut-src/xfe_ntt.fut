module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
module shared = import "shared"

type BFieldElement = BFieldElement.BFieldElement
type XFieldElement = XFieldElement.XFieldElement

-- TODO: Can we use `resize` instead?
let concat_to 'a (m: i64) (a: []a) (b: []a) : [m]a =
  a ++ b :> [m]a

-- main NTT iteration logic
def xfe_ntt_iteration [n] (log2m: i64) (data: [n]XFieldElement) (w_m: BFieldElement) (j: i64) : (i64, XFieldElement, i64, XFieldElement) =
    let m = 1 << log2m
    let bitmask = m - 1
    let w = BFieldElement.mod_pow_i64 w_m (j & bitmask)
    let (u, v) = (data[j],
                  data[j + (n >> 1)] XFieldElement.*^ XFieldElement.new_const(w))
    let (u, v) = (u XFieldElement.+^ v, u XFieldElement.-^ v)
    let idxD = ((j & !bitmask) << 1) + (j & bitmask)
    in (idxD, u, idxD + m, v)

def xfe_ntt' [n] (bits: i64) (omega: BFieldElement) (input: [n]XFieldElement): [n]XFieldElement =
    -- init input and output arrays to copies of the input
    let input = copy input
    let output = copy input
    let ix = iota (n >> 1) 
    let log2ms = iota bits

    -- loop over the log2m values, modifying the input and output arrays
    let (res,_) =
        loop (input': *[n]XFieldElement, output': *[n]XFieldElement) = (input, output) for log2m in log2ms do
            -- apply NTT iteration to each element in the input array
            let w_m = BFieldElement.mod_pow_i64 omega (n >> (log2m + 1))
            let (i0s, us, i1s, vs) = unzip4 (map (xfe_ntt_iteration log2m input' w_m) ix)
            -- scatter results into output arr
            in (scatter output'
                (concat_to n i0s i1s)
                (us ++ vs :> [n]XFieldElement),
                input')
    in res

-- computes ntt array for a given array of BFieldElement
def xfe_ntt [n] (data: [n]XFieldElement): [n]XFieldElement =
    -- ensure n is a power of 2 when getting log2 of n
    let bits = assert (shared.is_power_of_2 n) (shared.ilog2 n)
    -- omega is a BFieldElement, when performing NTT on XFieldElements
    let omega = BFieldElement.primitive_root n
    in xfe_ntt' bits omega data


-- computes inverse ntt array for a given array of BFieldElement
def xfe_intt [n] (data: [n]XFieldElement): [n]XFieldElement =
    let bits = assert (shared.is_power_of_2 n) (shared.ilog2 n)
    -- omega is Bfe, when performing NTT on Xfe
    let omega_inverse = BFieldElement.inverse (BFieldElement.primitive_root n)
    let n_bfe_inv = BFieldElement.inverse (BFieldElement.new (u64.i64 n))
    let unscaled_result = xfe_ntt' bits omega_inverse data
    -- This is multiplication of Xfe w/ Bfe
    in map (\x -> XFieldElement.xfe_bfe_mul x n_bfe_inv) unscaled_result

-- ==
-- entry: xfe_xfe_inv_brings_back_original
-- input {}
-- output { true }
entry xfe_xfe_inv_brings_back_original : bool =

    -- setup Xfe values
    let n = 16
    let values : [n]XFieldElement =
        iota n
        |> map u64.i64
        |> map (\i -> (BFieldElement.new i, BFieldElement.new i, BFieldElement.new i))
        |> map (\(a, b, c) -> XFieldElement.new (a, b, c))

    -- ensure all of each value's coefficients is equal to the index
    let (success, i) : (bool, i64) = loop (success, i) = (true, 0) while i < n do
        -- get the coefficients of the Xfe value
        let (a, b, c) = values[i].coefficients
        let coeff_values = map BFieldElement.value [a, b, c]
        let i_u64 = u64.i64 i
        let success = success 
                      && (coeff_values[0] == i_u64)
                      && (coeff_values[1] == i_u64)
                      && (coeff_values[2] == i_u64)
        in (success, i + 1)

    -- perform NTT and inverse NTT
    let ntt_values = xfe_ntt values
    let intt_vlaues = xfe_intt ntt_values

    -- ensure Original and inverse NTT values are equal to the original values
    let (success, _) = loop (success, i) = (success, 0) while i < n do
        -- get intt value's coefficients
        let (a_intt, b_intt, c_intt) = intt_vlaues[i].coefficients
        let intt_coeff_values = map BFieldElement.value [a_intt, b_intt, c_intt]

        -- get og coefficients of the Xfe value
        let (a_og, b_og, c_og) = values[i].coefficients
        let og_coeff_values = map BFieldElement.value [a_og, b_og, c_og]

        -- ensure all coefficients are equal and indices are equal
        let i_u64 = u64.i64 i
        let success = success 
            && (intt_coeff_values[0] == i_u64) && (intt_coeff_values[0] == og_coeff_values[0])
            && (intt_coeff_values[1] == i_u64) && (intt_coeff_values[1] == og_coeff_values[1])
            && (intt_coeff_values[2] == i_u64) && (intt_coeff_values[2] == og_coeff_values[2])
        in (success, i + 1)
    in success :> bool