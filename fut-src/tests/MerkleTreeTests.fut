import "../MerkleTree"

def get_merkle_root (input: []Digest) : Digest =
  let input = assert (length input >= 2) input
   in input[1]

-- Test test_kernel_merkle_root_2d
-- ==
-- entry: test_kernel_merkle_root_2d
-- input {}
-- output { [13859358503793762910u64, 2009113882361408138u64, 17050123618626809774u64, 15103114509658508451u64, 2058376048807697405u64] }
entry test_kernel_merkle_root_2d =
  let ds = iota (2**4)
  let input = map (\v -> replicate Parameters.rescue_prime_digest_length (BFieldElement.I64 v)) ds
  let root = kernel_merkle_root_2d input
   in root


-- Test test_kernel_merkle_root_inplace
-- ==
-- entry: test_kernel_merkle_root_inplace
-- input {}
-- output { [13859358503793762910u64, 2009113882361408138u64, 17050123618626809774u64, 15103114509658508451u64, 2058376048807697405u64] }
entry test_kernel_merkle_root_inplace =
  let l = RescuePrime.Parameters.rescue_prime_digest_length
  let ds = iota (2**4)
  let input = map (\v -> replicate l (BFieldElement.I64 v)) ds
  let flattened_input = flatten input
  let nl = length flattened_input
  let n = nl // l
  let flattened_input = assert (length ds == n) flattened_input
  let flattened_input = assert (Utils.is_power_of_two n) flattened_input
  --let flattened_digests: [n]Digest = unflatten n l input :> [n][Parameters.rescue_prime_digest_length]BFieldElement
  let root = kernel_merkle_root_inplace flattened_input
   in root

-- Test test_kernel_merkle_tree_full
-- ==
-- entry: test_kernel_merkle_tree_full
-- input {}
-- output { true }
entry test_kernel_merkle_tree_full =
  let ds = iota (2**4)
  let input = map (\v -> replicate Parameters.rescue_prime_digest_length (BFieldElement.I64 v)) ds
  let root_expected =  kernel_merkle_root_2d input
  let tree_actual   =  kernel_merkle_tree_full input
  let root_actual   =  get_merkle_root tree_actual
   in root_expected == root_actual
