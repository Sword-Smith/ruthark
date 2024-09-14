module Tip5 = import "Tip5"
module Digest = import "Digest"
module BFieldElement = import "BFieldElement"
module merge_sort_module = import "./lib/github.com/diku-dk/sorts/merge_sort"

let merge_sort = merge_sort_module.merge_sort

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


-- check if an element is in an array
let in_array_i64 (arr: []i64) (x: i64): bool =
  reduce (||) false (map (== x) arr)

--adds element to array if it's not already present
let add_unique_i64 (arr: []i64) (x: i64): []i64 =
  if in_array_i64 arr x then arr else arr ++ [x]

-- Function to compute the difference between two sets represented as sorted arrays
let array_difference (set1: []i64) (set2: []i64): []i64 =
  filter (\x -> not (in_array_i64 set2 x)) set1

-- Function to implement the authentication structure node indices logic
let authentication_structure_node_indices (num_leafs: i64) (leaf_indices: []i64) (root_index: i64): []i64 =
  let (node_is_needed, node_can_be_computed) =
    loop (node_is_needed, node_can_be_computed) = ([], []) for leaf_index in leaf_indices do

      if leaf_index >= num_leafs then
        ([], [])  -- invalid leaf indices
      else
        let initial_node_index = leaf_index + num_leafs
        let (node_is_needed, node_can_be_computed, _) =
          loop (node_is_needed, node_can_be_computed, node_index) = (node_is_needed, node_can_be_computed, initial_node_index)
          while node_index > root_index do

            -- Calculate the sibling index (by flipping the last bit of node_index).
            let sibling_index = node_index ^ 1

             -- Add the sibling index to node_is_needed if it's not already included.
            let node_is_needed = add_unique_i64 node_is_needed sibling_index

            -- Add the current node index to node_can_be_computed if it's not already included.
            let node_can_be_computed = add_unique_i64 node_can_be_computed node_index

            -- Move to the parent node in the next iteration.
            in (node_is_needed, node_can_be_computed, node_index // 2)

        in (node_is_needed, node_can_be_computed)
        
  -- set diff of (needed - can be computed), sort, and reverse
  let set_difference = array_difference node_is_needed node_can_be_computed
  let sorted_set = merge_sort (<) set_difference
  in reverse sorted_set

-- Generate a de-duplicated authentication structure for the given leaf indices.
-- If a single index is supplied, the authentication structure is the
-- authentication path for the indicated leaf.
--
-- For example, consider the following Merkle tree.
--
-- ```markdown
--         ──── 1 ────          ╮
--        ╱           ╲         │
--       2             3        │
--      ╱  ╲          ╱  ╲      ├╴ node indices
--     ╱    ╲        ╱    ╲     │
--    4      5      6      7    │
--   ╱ ╲    ╱ ╲    ╱ ╲    ╱ ╲   │
--  8   9  10 11  12 13  14 15  ╯
--
--  0   1  2   3  4   5  6   7  ←── leaf indices
-- ```
--
-- The authentication path for leaf 2, _i.e._, node 10, is nodes [11, 4, 3].
--
-- The authentication structure for leafs 0 and 2, _i.e._, nodes 8 and 10
-- respectively, is nodes [11, 9, 3].
-- Note how:
-- - Node 3 is included only once, even though the individual authentication
--   paths for leafs 0 and 2 both include node 3. This is one part of the
--   de-duplication.
-- - Node 4 is not included at all, even though the authentication path for
--   leaf 2 requires the node: node 4 can be computed from nodes 8 and 9;
--   the former is supplied explicitly during [verification][verify],
--   the latter is included in the authentication structure.
--   This is the other part of the de-duplication.
--
-- [verify]: MerkleTreeInclusionProof::verify
def authentication_structure (self: MerkleTree) (leaf_indices: []i64) : []Digest =
  let num_leafs = num_leafs self
  let indices: []i64 = authentication_structure_node_indices num_leafs leaf_indices ROOT_INDEX
  in map (\idx -> self.nodes[idx]) indices

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

-- ==
-- entry: test_authentication_structure_node_indices
-- input { 8i64 [0i64, 5i64] }
-- output {[12i64, 9i64, 7i64, 5i64] }
-- input { 16i64 [3i64, 5i64, 8i64, 9i64] }
-- output { [20i64, 18i64, 13i64, 11i64, 8i64, 7i64] }
entry test_authentication_structure_node_indices (num_leafs: i64) (leaf_indices: []i64) : []i64 =
  authentication_structure_node_indices num_leafs leaf_indices ROOT_INDEX
