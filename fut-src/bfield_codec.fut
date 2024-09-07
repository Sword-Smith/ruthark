module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"

type XFieldElement = XFieldElement.XFieldElement
type BFieldElement = BFieldElement.BFieldElement

-- encode individual xfe by extracting coefficients
def encode_xfe (xfe: XFieldElement) : [3]BFieldElement = 
    [xfe.coefficients.0, xfe.coefficients.1, xfe.coefficients.2]


-- xfe adaptation of impl<T: BFieldCodec> BFieldCodec for Vec<T> in twentyfirst::math::bfield_codec
def encode_arr_xfe  (arr_xfe: []XFieldElement) : []BFieldElement =
    
    -- get num elelement as bfe
    let num_elements: BFieldElement = length arr_xfe |> u64.i64 |> BFieldElement.new    

    -- encode each and concatenate to 
    let individual_bfe_arrs = map encode_xfe arr_xfe
    let (_, encoded) = loop (i, arr) = (0, [num_elements]) for x in individual_bfe_arrs do
        let i = i + 1
        in (i, arr ++ x) 
    in encoded

-- == 
-- entry: test_encode_arr_xfe
-- input { [1u64, 2u64, 3u64] }
-- output { [3u64, 1u64, 0u64, 0u64, 2u64, 0u64, 0u64, 3u64, 0u64, 0u64] }
-- input { [22u64, 3u64, 99u64, 55u64] }
-- output { [4u64, 22u64, 0u64, 0u64, 3u64, 0u64, 0u64, 99u64, 0u64, 0u64, 55u64, 0u64, 0u64] }
entry test_encode_arr_xfe (values_arr: []u64) : []u64 = 
    let xfe_arr = map XFieldElement.new_const_from_u64 values_arr
    let encoded = encode_arr_xfe xfe_arr
    in map BFieldElement.value encoded