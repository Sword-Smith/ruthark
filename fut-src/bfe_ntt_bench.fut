module ntt_bfe = import "bfe_ntt"
module BFieldElement = import "BFieldElement"

def bfe_ntt = ntt_bfe.bfe_ntt
def parallel_col_major_ntt = ntt_bfe.parallel_col_major_ntt
type BFieldElement = BFieldElement.BFieldElement

-- ==
-- entry: bench_bfe_ntt_single
-- random input { [1048576]u64 }
entry bench_bfe_ntt_single [n] (input: [n]u64): [n]BFieldElement =
    let input = map BFieldElement.from_raw_u64 input
    in bfe_ntt input

-- ==
-- entry: bench_bfe_ntt_many
-- random input { [75][1048576]u64 }
entry bench_bfe_ntt_many [m][n] (input: [m][n]u64): [m][n]BFieldElement =
    let input = map (map BFieldElement.from_raw_u64) input
    in parallel_col_major_ntt input
