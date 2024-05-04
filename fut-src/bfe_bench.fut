module ntt_bfe = import "bfe_ntt"
import "bfe_poly"
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

-- ==
-- entry: bench_bfe_ldes
-- random input { [149][2048]u64 }
entry bench_bfe_ldes
  [m][n]
  (input: [m][n]u64)
  : ([2048 * n][m]u64, [m][n]u64) =
  let fri_domain_offset = BFieldElement.new 7
  let extension_factor = 2048
  let randomized_traces = map (map (BFieldElement.from_raw_u64)) input
  let (extended_columns, polys) =
    unzip2
    (map (low_degree_extend fri_domain_offset extension_factor) randomized_traces)
  let extended_columns = map (map BFieldElement.to_raw_u64) extended_columns
  let polys = map (\poly -> map BFieldElement.to_raw_u64 poly.coefficients) polys
  in (transpose extended_columns, polys)
