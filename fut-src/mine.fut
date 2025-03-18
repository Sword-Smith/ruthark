module Digest = import "Digest"
module BFieldElement = import "BFieldElement"
module Tip5 = import "Tip5"

type Digest = Digest.Digest
type BFieldElement = BFieldElement.BFieldElement

def fast_kernel_mast_hash (kernel_auth_path: [2]Digest) (header_auth_path: [3] Digest) (nonce: Digest) : Digest =
  let header_mast_hash = Tip5.hash_pair (Tip5.hash_varlen nonce.0) header_auth_path[0]
  let header_mast_hash = Tip5.hash_pair header_mast_hash header_auth_path[1]
  let header_mast_hash = Tip5.hash_pair header_auth_path[2] header_mast_hash

  in Tip5.hash_pair
    (Tip5.hash_pair
      (Tip5.hash_varlen header_mast_hash.0)
      kernel_auth_path[0])
    kernel_auth_path[1]

def guess (mutator: i64) (base_digest: Digest) (kernel_auth_path: [2]Digest) (header_auth_path: [3]Digest): Digest =
  let nonce_guess = Digest.set_4 base_digest mutator
  in fast_kernel_mast_hash kernel_auth_path header_auth_path nonce_guess

def has_solution (arr: []bool) : bool =
  reduce (||) false arr

def find_first_true (arr: []bool) : i64 =
    let (_, found) =
        loop (i, found) = (0, -1)
        while i < length arr && found == -1 do
            (i + 1, if arr[i] then i else found)
    in found

def has_solution_new (guesses: []Digest) (threshold: Digest): bool =
  reduce (||) false (map (\x -> Digest.leq x threshold) guesses)

def has_solution_new_new (guesses: []Digest) (threshold_e4: BFieldElement): bool =
  reduce (||) false (map (\x -> Digest.certain_under x threshold_e4) guesses)

def mine_inner_own_alt
 (base_digest: Digest)
 (kernel_auth_path: [2]Digest)
 (header_auth_path: [3] Digest)
 (threshold: Digest)
 : Digest =
 let BATCH_SIZE = 1 << 22
  let (_, correct_i) =
    loop (found, i) = (false, 0)
    while not found do
      let batch = map (\x -> x + i * BATCH_SIZE) (iota BATCH_SIZE)
      let guesses = map (\x -> guess x base_digest kernel_auth_path header_auth_path) batch
      let has_solution = has_solution_new_new guesses threshold.0[4]
      in if has_solution then
        (true, i)
      else
        (false, i + 1)

    let good_batch = map (\x -> x + correct_i * BATCH_SIZE) (iota BATCH_SIZE)
    let good_guesses = map (\x -> guess x base_digest kernel_auth_path header_auth_path) good_batch
    let valid_guesses = map (\x -> Digest.leq x threshold) good_guesses

    let first_valid = find_first_true valid_guesses
    in Digest.set_4 base_digest (first_valid +correct_i * BATCH_SIZE)

def mine_inner_own
 (base_digest: Digest)
 (kernel_auth_path: [2]Digest)
 (header_auth_path: [3] Digest)
 (threshold: Digest)
  : Digest =
  let (result, _) =
    loop (valid_guess, i) = (copy Digest.DEFAULT, 0)
    while Digest.eq valid_guess Digest.DEFAULT do
      let BATCH_SIZE = 1 << 2
      let batch = map (\x -> x + i * BATCH_SIZE) (iota BATCH_SIZE)
      let guesses = map (\x -> guess x base_digest kernel_auth_path header_auth_path) batch
      in (Digest.find_small guesses threshold, i + 1)
      -- let valid_guesses = map (\x -> Digest.leq x threshold) guesses
      -- in if (has_solution valid_guesses) then
      -- -- in if first_valid != -1 then
      -- --   (Digest.set_4 base_digest first_valid, i)
      --   let first_valid = find_first_true valid_guesses
      --   in (Digest.set_4 base_digest first_valid, i)
      -- -- else
      -- else
      --   (copy Digest.DEFAULT, i + 1)
    in result

entry main
  (base_digest: [Digest.DIGEST_LENGTH]u64)
  (kernel_auth_path: [2][Digest.DIGEST_LENGTH]u64)
  (header_auth_path: [3] [Digest.DIGEST_LENGTH]u64)
  (threshold: [Digest.DIGEST_LENGTH]u64)
   : [Digest.DIGEST_LENGTH]u64 =
   let bfes_to_digest (bfes: [Digest.DIGEST_LENGTH]u64): Digest = {0 = map (\x -> BFieldElement.new x) bfes}
   let bfe_to_u64 (bfe: BFieldElement): u64 = BFieldElement.value(bfe)
   let base_digest: Digest = bfes_to_digest base_digest
   let kernel_auth_path: [2]Digest = map bfes_to_digest kernel_auth_path
   let header_auth_path: [3]Digest = map bfes_to_digest header_auth_path
   let threshold: Digest = bfes_to_digest threshold
   let result = mine_inner_own_alt base_digest kernel_auth_path header_auth_path threshold
   in map bfe_to_u64 result.0

-- ==
-- entry: fast_kernel_mast_hash_bench
-- random input { [1000][5]u64 [2][5]u64 [3][5]u64 }
-- random input { [1000000][5]u64 [2][5]u64 [3][5]u64 }
-- random input { [10000000][5]u64 [2][5]u64 [3][5]u64 }
-- random input { [100000000][5]u64 [2][5]u64 [3][5]u64 }
entry fast_kernel_mast_hash_bench ( nonces: [][Digest.DIGEST_LENGTH]u64 ) (kernel_auth_path: [2][Digest.DIGEST_LENGTH]u64) (header_auth_path: [3][Digest.DIGEST_LENGTH]u64) =
   let u64s_to_digest (bfes: [Digest.DIGEST_LENGTH]u64): Digest = {0 = map (\x -> BFieldElement.new x) bfes}
   let bfe_to_u64 (bfe: BFieldElement): u64 = BFieldElement.value(bfe)
   let nonces = map u64s_to_digest nonces
   let kap = map u64s_to_digest kernel_auth_path
   let hap = map u64s_to_digest header_auth_path
   in map (\x -> fast_kernel_mast_hash kap hap x) nonces


-- ==
-- entry: fast_kernel_mast_hash_test
-- input { [0u64, 0u64, 0u64, 0u64, 0u64] [1u64, 1u64, 1u64, 1u64, 1u64] [2u64, 2u64, 2u64, 2u64, 2u64] [3u64, 3u64, 3u64, 3u64, 3u64] [4u64, 4u64, 4u64, 4u64, 4u64] [5u64, 5u64, 5u64, 5u64, 5u64] }
-- output { [10232109720740602556u64, 10645201683943891387u64, 05039662571924979396u64, 02304072020892771714u64, 10985331418412655871u64] }
entry fast_kernel_mast_hash_test
  (d0: [Digest.DIGEST_LENGTH]u64)
  (d1: [Digest.DIGEST_LENGTH]u64)
  (d2: [Digest.DIGEST_LENGTH]u64)
  (d3: [Digest.DIGEST_LENGTH]u64)
  (d4: [Digest.DIGEST_LENGTH]u64)
  (d5: [Digest.DIGEST_LENGTH]u64)
  : [Digest.DIGEST_LENGTH]u64 =
  let d0: Digest = { 0 = map BFieldElement.new d0 }
  let d1: Digest = { 0 = map BFieldElement.new d1 }
  let d2: Digest = { 0 = map BFieldElement.new d2 }
  let d3: Digest = { 0 = map BFieldElement.new d3 }
  let d4: Digest = { 0 = map BFieldElement.new d4 }
  let d5: Digest = { 0 = map BFieldElement.new d5 }
  let result: Digest = fast_kernel_mast_hash [d0, d1] [d2, d3, d4] d5
  in map BFieldElement.value result.0
