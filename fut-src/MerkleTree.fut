module Tip5 = import "Tip5"
module Digest = import "Digest"
module BFieldElement = import "BFieldElement"

type Digest = Digest.Digest
type BFieldElement = BFieldElement.BFieldElement
type~ MerkleTree = { nodes: []Digest }

let ROOT_INDEX: i64 = 1

def default_digest : Digest = 
    { 0 = map (\_ -> BFieldElement.zero) (iota Digest.DIGEST_LENGTH) } 

def is_power_of_two (n: i64) : bool =
    n > 0 && (n & (n - 1)) == 0

def reverse_array_i64 [n] (arr: [n]i64) : [n]i64 =
  map (\i -> arr[n - 1 - i]) (iota n)

-- returns num leafs w/ check
def num_leafs (self: MerkleTree) : i64 = 
  let node_count = length self.nodes 
  let leaf_count = assert (is_power_of_two node_count) node_count / 2
  in leaf_count

-- requires number of digests be a power of 2 and non-zero
def from_digests (digests: []Digest) : MerkleTree = 

  -- ensure valid input when getting leaf count 
  let valid_input: bool = (length digests > 0) && (is_power_of_two (length digests))
  let leaf_count: i64 = assert (valid_input) (length digests)

  -- intilize node state
  let init_nodes: []Digest = (replicate (length digests) default_digest) ++ digests
  
  -- sequential method
  let iter_through: []i64 = 1...(leaf_count - 1)
  let iter_through_rev = reverse_array_i64 iter_through
  let nodes = loop nodes = init_nodes for i in iter_through_rev do
    nodes with [i] = Tip5.hash_pair (copy nodes[i * 2]) (copy nodes[(i * 2) + 1])
  in { nodes = nodes } :> MerkleTree


-- ==
-- entry: test_from_digests
-- input {}
-- output { [[0u64, 0u64, 0u64, 0u64, 0u64], [15724892667502592618u64, 13850510571775421807u64, 14944926317937857992u64, 6071698931099546034u64, 9307566280769432565u64],  [8579641722220975599u64, 5018131886603910658u64, 13340051286813984917u64, 5143956232014806794u64, 10347107528309608227u64], [8579641722220975599u64, 5018131886603910658u64, 13340051286813984917u64, 5143956232014806794u64, 10347107528309608227u64], [18008192845958902073u64, 10900893521032121856u64, 5391490908942574506u64, 4714723590141826241u64, 12579287558637076295u64],  [18008192845958902073u64, 10900893521032121856u64, 5391490908942574506u64, 4714723590141826241u64, 12579287558637076295u64],  [18008192845958902073u64, 10900893521032121856u64, 5391490908942574506u64, 4714723590141826241u64, 12579287558637076295u64],  [18008192845958902073u64, 10900893521032121856u64, 5391490908942574506u64, 4714723590141826241u64, 12579287558637076295u64],  [941080798860502477u64, 5295886365985465639u64, 14728839126885177993u64, 10358449902914633406u64, 14220746792122877272u64], [941080798860502477u64, 5295886365985465639u64, 14728839126885177993u64, 10358449902914633406u64, 14220746792122877272u64], [941080798860502477u64, 5295886365985465639u64, 14728839126885177993u64, 10358449902914633406u64, 14220746792122877272u64], [941080798860502477u64, 5295886365985465639u64, 14728839126885177993u64, 10358449902914633406u64, 14220746792122877272u64], [941080798860502477u64, 5295886365985465639u64, 14728839126885177993u64, 10358449902914633406u64, 14220746792122877272u64], [941080798860502477u64, 5295886365985465639u64, 14728839126885177993u64, 10358449902914633406u64, 14220746792122877272u64], [941080798860502477u64, 5295886365985465639u64, 14728839126885177993u64, 10358449902914633406u64, 14220746792122877272u64], [941080798860502477u64, 5295886365985465639u64, 14728839126885177993u64, 10358449902914633406u64, 14220746792122877272u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64], [0u64, 0u64, 0u64, 0u64, 0u64]] }
entry test_from_digests : [32][Digest.DIGEST_LENGTH]u64 = 
    let initial_digests: [16]Digest = map (\_ -> copy default_digest) (iota 16)
    let tree = from_digests initial_digests

    let convert_digest_to_values = \d -> map BFieldElement.value d.0
    let out =  map convert_digest_to_values tree.nodes
    let out: [32][Digest.DIGEST_LENGTH]u64 = take 32 out
    in out

-- == 
-- entry: test_num_leafs
-- input {}
-- output {true}
entry test_num_leafs : bool =
    let initial_digests: [16]Digest = map (\_ -> copy default_digest) (iota 16)
    let merkle_tree = from_digests initial_digests 
    in (num_leafs merkle_tree) == 16
