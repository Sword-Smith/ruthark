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

-- requires number of digests be a power of 2 and non-zero
def from_digests (digests: []Digest) : MerkleTree  = 
    
    -- ensure valid input when getting leaf count
    let valid_digests: bool = (length digests > 0) && (is_power_of_two (length digests))
    let leafs_count: i64 = assert (valid_digests) (length digests)

    -- init nodes as current digests
    let nodes = copy digests

    -- digest calculation
    let (nodes, _) =
        loop (nodes, node_count_on_this_level) = (nodes, leafs_count) while node_count_on_this_level > 1 do
            -- update node count
            let node_count_on_next_level = node_count_on_this_level // 2
            -- hash pairs
            let collect_and_hash = \i ->
                let left = nodes[i]
                let right = nodes[i+1]
                in Tip5.hash_pair left right 
            let local_digests = map collect_and_hash (iota node_count_on_next_level)
            -- append to current nodes
            let nodes = local_digests ++ nodes
            in (nodes, node_count_on_next_level)
    -- append unused nodes[0] to make length a power of 2
    let nodes = [default_digest] ++ nodes
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


-- module RescuePrime = import "RescuePrime"
-- module BFieldElement = import "BFieldElement"
-- module Utils = import "Utils"
-- type BFieldElement = BFieldElement.BFieldElement
-- type Digest = RescuePrime.RescuePrimeDigest

-- module Parameters = import "RescuePrimeParameters"
-- type DefaultParameters = Parameters.DefaultParameters
-- def parameters : DefaultParameters = Parameters.default_parameters
-- def rate = parameters.rate -- parameters.m - parameters.capacity


-- -- [0,1,2,3,4,5,6,7]
-- -- [x,y,x,y,x,y,x,y]
-- -- lvlw = 4
-- --  0,2,4,6
-- --  1,3,5,7
-- --
-- --
-- -- [0,1,2,3]
-- -- lvlw = 2
-- -- 0,2
-- -- 2,4
-- -- [x,y,x,y]


-- --  0,0,1,1
-- -- [x,y,x,y]

-- entry kernel_merkle_root_2d
--  [n]
--  (input: [n]Digest)
--  :Digest
--  =
--  let input = assert (Utils.is_power_of_two n) input
--  let (result, _elements_count) =
--    loop (level,          level_width) = (input, n//2) while 0 < level_width do
--      let left_indices:  [level_width]i64 = iota level_width |> map (*2)
--      let right_indices: [level_width]i64 = map (+1) left_indices
--      let siblings:      [level_width][RescuePrime.Parameters.rate]BFieldElement =
--        map2 (\x y -> (level[x] ++ level[y]) :> [RescuePrime.Parameters.rate]BFieldElement) left_indices right_indices
--      let next_level:    [level_width]Digest = map RescuePrime.rescue_prime_hash_10_default_parameters siblings
--       in (next_level,    level_width // 2)
--   in result[0]



-- -- [0,1,2,3,4,5,6,7]
-- -- [x,y,x,y,x,y,x,y]
-- -- lvlw = 4
-- -- spacing = 1
-- --  0,2,4,6
-- --  1,3,5,7
-- --
-- --
-- -- lvlw = 2
-- -- spacing = 2
-- -- [0,1,2,3,4,5,6,7]
-- -- [x,-,y,-,x,-,y,-]
-- --
-- -- 0,4
-- -- 2,6
-- -- [x,y,x,y]


-- --  0,0,1,1
-- -- [x,y,x,y]


-- def flattened_indices L =
--   let l = RescuePrime.Parameters.rescue_prime_digest_length
--    in map (\k -> map (\i -> i+k) (iota l)) L |> flatten

-- entry kernel_merkle_root_inplace
--   [nl]
--   (level: *[nl]BFieldElement)
--   :*Digest
--   =
--  let l = RescuePrime.Parameters.rescue_prime_digest_length
--  let n = nl // l
--  let n = assert (Utils.is_power_of_two n) n
--   --let level = assert (Utils.is_power_of_two n) level
--   let (level, _indices_count, _spacing) =
--     loop (level,          indices_count, spacing) = (level, n//2, 2) while 0 < indices_count do
--       let nhl = indices_count*l
--       let left_digests_start:  [indices_count]i64 = iota indices_count |> map (*spacing*l)
--       let right_digests_start: [indices_count]i64 = map (+spacing//2*l) left_digests_start
--       let siblings:            [indices_count][RescuePrime.Parameters.rate]BFieldElement =
--         map2 (\x y -> level[x:x+l] ++ level[y:y+l] :> [RescuePrime.Parameters.rate]BFieldElement)
--           left_digests_start
--           right_digests_start
--       let next_level_values:   [indices_count]Digest = map RescuePrime.rescue_prime_hash_10_default_parameters siblings
--       -- level must be flattened
--       let write_indices = flattened_indices left_digests_start :> [nhl]i64
--       -- let right_indices: [indices_count]i64 = map (+spacing//2*l) left_indices
--       let level: [nl]BFieldElement = scatter level write_indices (flatten next_level_values :> [nhl]BFieldElement)
--        in (level,         indices_count // 2, spacing * 2)
--  let root: Digest = level[:l] :> Digest
--   in root


-- entry kernel_merkle_tree_full_partial
--   -- `l` is leaves_count, `n` is `l * 2`
--  (input: []Digest)
--  :[]Digest
--  =
--  let filler: Digest = input[0]
--  let l = length input
--  let l = assert (Utils.is_power_of_two l) l
--  let n = l * 2
--  let scratch = replicate n filler
--  let indices = l..<n :> [l]i64
--  let input2 = input :> [l]Digest
--  let nodes = scatter scratch indices input2
--   in nodes


-- entry kernel_merkle_tree_full
--   -- `l` is leaves_count, `n` is `l * 2`
--  (input: []Digest)
--  :[]Digest
--  =
--  let l = length input
--  let l = assert (Utils.is_power_of_two l) l
--  let n = l * 2
--  let filler: Digest = input[0]
--  let scratch: [n]Digest = replicate n filler
--  let indices = l..<n :> [l]i64
--  let nodes = scatter scratch indices (input :> [l]Digest)

--  let (nodes, _level_width) =
--   loop (nodes, level_width) = (nodes, l//2) while level_width > 0 do
--     let js: [level_width]i64 = level_width..<(level_width+level_width) :> [level_width]i64
--     let siblings: [level_width][RescuePrime.Parameters.rate]BFieldElement = map (\j -> nodes[2*j] ++ nodes[2*j+1] :> [RescuePrime.Parameters.rate]BFieldElement) js
--     let next_level_values: [level_width]Digest = map RescuePrime.rescue_prime_hash_10_default_parameters siblings :> [level_width]Digest
--     let nodes = scatter nodes js next_level_values
--      in (nodes, level_width//2)
--   in nodes
