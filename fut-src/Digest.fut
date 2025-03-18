module BFieldElement = import "BFieldElement"
type BFieldElement = BFieldElement.BFieldElement

let DIGEST_LENGTH: i64 = 5

type Digest = { 0: [DIGEST_LENGTH]BFieldElement }

let DEFAULT: Digest = { 0 = replicate DIGEST_LENGTH BFieldElement.zero }

def set_4 (value: Digest) (i: i64): Digest =
    let elems = copy value.0
    let ret = scatter elems [DIGEST_LENGTH - 1] [BFieldElement.from_raw_u64(u64.i64 i)]
    in {0 = ret}

def mutate_4 (value: Digest) (i: i64): Digest =
    let elems = copy value.0
    let ret = scatter elems [DIGEST_LENGTH - 1] [BFieldElement.from_raw_u64(elems[4].0 + u64.i64 i)]
    in {0 = ret}

def mutate_3 (value: Digest) (i: i64): Digest =
    let elems = copy value.0
    let ret = scatter elems [DIGEST_LENGTH - 2] [BFieldElement.from_raw_u64(elems[3].0 + u64.i64 i)]
    in {0 = ret}

def eq (lhs: Digest) (rhs: Digest): bool =
  let lhs: [DIGEST_LENGTH]BFieldElement = lhs.0
  let rhs: [DIGEST_LENGTH]BFieldElement = rhs.0
  in reduce (&&) true (map2 (==) lhs rhs)

def certain_under (digest: Digest) (threshold_e4: BFieldElement): bool =
  BFieldElement.value(digest.0[4]) < BFieldElement.value(threshold_e4)

def leq (lhs: Digest) (rhs: Digest): bool =
  -- panics if both digests are equal. Which is probably OK, because hash function.
  let lhs: [DIGEST_LENGTH]BFieldElement = lhs.0
  let rhs: [DIGEST_LENGTH]BFieldElement = rhs.0
  let (_, res, _) = loop (have_result, result, i) = (false, true, 0) while (!have_result && i < DIGEST_LENGTH) do
    let idx = DIGEST_LENGTH - 1 - i
    let lhse: u64 = BFieldElement.value(lhs[idx])
    let rhse: u64 = BFieldElement.value(rhs[idx])
    let leqv = lhse <= rhse
    in (lhse != rhse, leqv, i + 1)
  in res

def find_small (guesses: []Digest) (threshold: Digest) =
  reduce (\acc x -> if leq x threshold then x else acc) (copy DEFAULT) guesses

-- ==
-- entry: leq_test
-- input { [1u64, 0u64, 0u64, 0u64, 0u64] [0u64, 0u64, 0u64, 0u64, 1u64] }
-- output { true }
-- input { [0u64, 0u64, 0u64, 0u64, 1u64] [1u64, 0u64, 0u64, 0u64, 0u64] }
-- output { false }
-- input { [15u64, 14u64, 14u64, 14u64, 14u64] [14u64, 15u64, 14u64, 14u64, 14u64] }
-- output { true }
-- input { [14u64, 15u64, 14u64, 14u64, 14u64] [15u64, 14u64, 14u64, 14u64, 14u64] }
-- output { false }
-- input { [1u64, 2u64, 3u64, 4u64, 5u64] [1u64, 2u64, 3u64, 4u64, 5u64] }
-- output { true }
entry leq_test
  (lhs: [DIGEST_LENGTH]u64)
  (rhs: [DIGEST_LENGTH]u64)
  : bool =
  let lhs: Digest = { 0 = map BFieldElement.new lhs }
  let rhs: Digest = { 0 = map BFieldElement.new rhs }
  in leq lhs rhs

-- ==
-- entry: find_small_test
-- input { [[14u64, 14u64, 14u64, 14u64, 14u64], [17u64, 17u64, 17u64, 17u64, 17u64]] [15u64,15u64,15u64,15u64,15u64] }
-- output { [14u64, 14u64, 14u64, 14u64, 14u64] }
-- input { [[17u64, 17u64, 17u64, 17u64, 17u64], [14u64, 14u64, 14u64, 14u64, 14u64]] [15u64,15u64,15u64,15u64,15u64] }
-- output { [14u64, 14u64, 14u64, 14u64, 14u64] }
-- input { [[17u64, 17u64, 17u64, 17u64, 17u64], [14u64, 14u64, 14u64, 14u64, 14u64]] [15u64,15u64,15u64,15u64,12u64] }
-- output { [0u64, 0u64, 0u64, 0u64, 0u64] }
-- input { [[100u64, 100u64, 100u64, 100u64, 100u64], [101u64, 100u64, 100u64, 100u64, 100u64], [102u64, 100u64, 100u64, 100u64, 100u64]] [18446744069414584320u64,18446744069414584320u64,18446744069414584320u64,18446744069414584320u64,18446744069414584320u64] }
-- output { [102u64, 100u64, 100u64, 100u64, 100u64] }
-- input { [[101u64, 100u64, 100u64, 100u64, 100u64], [99u64, 100u64, 100u64, 100u64, 100u64], [102u64, 100u64, 100u64, 100u64, 100u64]] [100u64, 100u64, 100u64, 100u64, 100u64] }
-- output { [99u64, 100u64, 100u64, 100u64, 100u64] }
entry find_small_test
  (digests: [][DIGEST_LENGTH]u64)
  (threshold: [DIGEST_LENGTH]u64)
  : [DIGEST_LENGTH]u64 =
  let u64s_to_digest (bfes: [DIGEST_LENGTH]u64): Digest = {0 = map (\x -> BFieldElement.new x) bfes}
  let bfe_to_u64 (bfe: BFieldElement): u64 = BFieldElement.value(bfe)
  let digests = map u64s_to_digest digests
  let threshold = u64s_to_digest threshold
  let res = find_small digests threshold
  in map bfe_to_u64 res.0
