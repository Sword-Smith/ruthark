module ntt_bfe = import "bfe_ntt"
module BFieldElement = import "BFieldElement"

def bfe_ntt = ntt_bfe.bfe_ntt
type BFieldElement = BFieldElement.BFieldElement

-- ==
-- entry: bench_bfe_ntt
-- random input { [1048576]u64 }
entry bench_bfe_ntt [n] (input: [n]u64): [n]BFieldElement =
    let input = map BFieldElement.new input
    in bfe_ntt input