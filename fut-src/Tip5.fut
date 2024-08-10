module Digest = import "Digest"
module BFieldElement = import "BFieldElement"
module shared = import "shared"
module mds = import "mds"

type Digest = Digest.Digest
type BFieldElement = BFieldElement.BFieldElement

let STATE_SIZE: i64 = 16
let NUM_SPLIT_AND_LOOKUP: i64 = 4
let RATE: i64 = 10
let NUM_ROUNDS: i64 = 5

-- The lookup table with a high algebraic degree used in the TIP-5 permutation. To verify its
-- correctness, see the test “lookup_table_is_correct.”
let LOOKUP_TABLE: [256]u8 = [
    0u8, 7u8, 26u8, 63u8, 124u8, 215u8, 85u8, 254u8, 214u8, 228u8, 45u8, 185u8, 140u8, 173u8, 33u8, 240u8,
    29u8, 177u8, 176u8, 32u8, 8u8, 110u8, 87u8, 202u8, 204u8, 99u8, 150u8, 106u8, 230u8, 14u8, 235u8, 128u8,
    213u8, 239u8, 212u8, 138u8, 23u8, 130u8, 208u8, 6u8, 44u8, 71u8, 93u8, 116u8, 146u8, 189u8, 251u8, 81u8,
    199u8, 97u8, 38u8, 28u8, 73u8, 179u8, 95u8, 84u8, 152u8, 48u8, 35u8, 119u8, 49u8, 88u8, 242u8, 3u8,
    148u8, 169u8, 72u8, 120u8, 62u8, 161u8, 166u8, 83u8, 175u8, 191u8, 137u8, 19u8, 100u8, 129u8, 112u8, 55u8,
    221u8, 102u8, 218u8, 61u8, 151u8, 237u8, 68u8, 164u8, 17u8, 147u8, 46u8, 234u8, 203u8, 216u8, 22u8, 141u8,
    65u8, 57u8, 123u8, 12u8, 244u8, 54u8, 219u8, 231u8, 96u8, 77u8, 180u8, 154u8, 5u8, 253u8, 133u8, 165u8,
    98u8, 195u8, 205u8, 134u8, 245u8, 30u8, 9u8, 188u8, 59u8, 142u8, 186u8, 197u8, 181u8, 144u8, 92u8, 31u8,
    224u8, 163u8, 111u8, 74u8, 58u8, 69u8, 113u8, 196u8, 67u8, 246u8, 225u8, 10u8, 121u8, 50u8, 60u8, 157u8,
    90u8, 122u8, 2u8, 250u8, 101u8, 75u8, 178u8, 159u8, 24u8, 36u8, 201u8, 11u8, 243u8, 132u8, 198u8, 190u8,
    114u8, 233u8, 39u8, 52u8, 21u8, 209u8, 108u8, 238u8, 91u8, 187u8, 18u8, 104u8, 194u8, 37u8, 153u8, 34u8,
    200u8, 143u8, 126u8, 155u8, 236u8, 118u8, 64u8, 80u8, 172u8, 89u8, 94u8, 193u8, 135u8, 183u8, 86u8, 107u8,
    252u8, 13u8, 167u8, 206u8, 136u8, 220u8, 207u8, 103u8, 171u8, 160u8, 76u8, 182u8, 227u8, 217u8, 158u8, 56u8,
    174u8, 4u8, 66u8, 109u8, 139u8, 162u8, 184u8, 211u8, 249u8, 47u8, 125u8, 232u8, 117u8, 43u8, 16u8, 42u8,
    127u8, 20u8, 241u8, 25u8, 149u8, 105u8, 156u8, 51u8, 53u8, 168u8, 145u8, 247u8, 223u8, 79u8, 78u8, 226u8,
    15u8, 222u8, 82u8, 115u8, 70u8, 210u8, 27u8, 41u8, 1u8, 170u8, 40u8, 131u8, 192u8, 229u8, 248u8, 255u8
]

-- TODO: Is it more performant to use `from_raw_u64` here? In other words: Will Futhark
-- do the appropriate constant-folding here?
def ROUND_CONSTANTS: [NUM_ROUNDS * STATE_SIZE]BFieldElement =
  map BFieldElement.new
    [
      13630775303355457758u64,
      16896927574093233874,
      10379449653650130495,
      1965408364413093495,
      15232538947090185111,
      15892634398091747074,
      3989134140024871768,
      2851411912127730865,
      8709136439293758776,
      3694858669662939734,
      12692440244315327141,
      10722316166358076749,
      12745429320441639448,
      17932424223723990421,
      7558102534867937463,
      15551047435855531404,
      17532528648579384106,
      5216785850422679555,
      15418071332095031847,
      11921929762955146258,
      9738718993677019874,
      3464580399432997147,
      13408434769117164050,
      264428218649616431,
      4436247869008081381,
      4063129435850804221,
      2865073155741120117,
      5749834437609765994,
      6804196764189408435,
      17060469201292988508,
      9475383556737206708,
      12876344085611465020,
      13835756199368269249,
      1648753455944344172,
      9836124473569258483,
      12867641597107932229,
      11254152636692960595,
      16550832737139861108,
      11861573970480733262,
      1256660473588673495,
      13879506000676455136,
      10564103842682358721,
      16142842524796397521,
      3287098591948630584,
      685911471061284805,
      5285298776918878023,
      18310953571768047354,
      3142266350630002035,
      549990724933663297,
      4901984846118077401,
      11458643033696775769,
      8706785264119212710,
      12521758138015724072,
      11877914062416978196,
      11333318251134523752,
      3933899631278608623,
      16635128972021157924,
      10291337173108950450,
      4142107155024199350,
      16973934533787743537,
      11068111539125175221,
      17546769694830203606,
      5315217744825068993,
      4609594252909613081,
      3350107164315270407,
      17715942834299349177,
      9600609149219873996,
      12894357635820003949,
      4597649658040514631,
      7735563950920491847,
      1663379455870887181,
      13889298103638829706,
      7375530351220884434,
      3502022433285269151,
      9231805330431056952,
      9252272755288523725,
      10014268662326746219,
      15565031632950843234,
      1209725273521819323,
      6024642864597845108
    ] :> [NUM_ROUNDS * STATE_SIZE]BFieldElement

type Domain = #variable_length | #fixed_length

type Tip5 = { state: [STATE_SIZE]BFieldElement }

def new
  (domain: Domain)
  : Tip5 =
  match domain
  case #variable_length ->
    { state = replicate STATE_SIZE BFieldElement.zero }
  case #fixed_length ->
    { state
     = (replicate RATE BFieldElement.zero)
      ++ replicate (STATE_SIZE - RATE) BFieldElement.one
      :> [STATE_SIZE]BFieldElement }

-- used in lookup table verification
def offset_fermat_cube_map (x: u16): u16 =
  let xx = u64.u16(x) + 1 
  let xxx = xx * xx * xx     
  let result = (xxx + 256) % 257
  in u16.u64(result)   

-- split and lookup
def split_and_lookup 
  (element: BFieldElement)
  : BFieldElement = 
  -- convert field element value to bytes
  let bytes: [8]u8 = shared.u64_to_bytes_le element.0
  -- Perform lookup 
  let updated_bytes = 
    loop bytes_acc = bytes for i in 0..<8 do
      let index = i32.u8(bytes_acc[i])
      let new_val = LOOKUP_TABLE[index]
      in (bytes_acc with [i] = new_val)
  -- convert to u64, return
  in { 0 = shared.bytes_le_to_u64 updated_bytes }
  
-- mds generated
def mds_generated 
  (self: *Tip5)  -- * == pass ownership to modify in place
  : Tip5 =
  -- init lo and hi arrs
  let lo: [STATE_SIZE]u64 = map (\_ -> 0u64) (iota STATE_SIZE)
  let hi: [STATE_SIZE]u64 = map (\_ -> 0u64) (iota STATE_SIZE)
  -- fill w/ lo and hi bits
  let (lo, hi): ([STATE_SIZE]u64, [STATE_SIZE]u64) =
    loop (lo, hi) = (lo, hi) for i < STATE_SIZE do
      let b: u64 = BFieldElement.to_raw_u64 self.state[i]
      let new_hi: u64 = b >> 32
      let new_lo: u64 = b & 0xffffffffu64
      in (lo with [i] = new_lo, hi with [i] = new_hi)
  -- call mds generated function on each
  let lo = mds.generated_function lo
  let hi = mds.generated_function hi
  -- Update state arr
  let new_state =
    loop state = self.state for r < STATE_SIZE do
      -- isolate lhs and rhs of the addition s
      let s_lhs: BFieldElement.U128 = BFieldElement.u128_from(lo[r] >> 4)
      let hi_u128: BFieldElement.U128 =  BFieldElement.u128_from(hi[r])
      let s_rhs: BFieldElement.U128 =  BFieldElement.u128_left_shift hi_u128 28
      -- s = lhs + rhs
      let s: BFieldElement.U128 = BFieldElement.u128_add s_lhs s_rhs
      -- split s bits into hi and lo
      let s_hi: u64 = BFieldElement.u64_from(BFieldElement.u128_right_shift s 64)
      let s_lo: u64 = BFieldElement.u64_from(s)
      -- overflowing addition of hi and lo 
      let (res, over) = BFieldElement.overflowing_add s_lo (s_hi * 0xffffffffu64)
      -- update state[r] depending on overflow
      in state with [r] =
        if over then
          BFieldElement.from_raw_u64(res + 0xffffffffu64)
        else
          BFieldElement.from_raw_u64(res)
   -- Return the updated record with the new state
  in { state = new_state } :> Tip5

  -- sbox
def sbox_layer 
  (self: *Tip5) -- * == pass ownership
  : Tip5 = 
  -- get alias for state
  let state = self.state
  -- split and lookup 
  let state = loop state for i in 0..<NUM_SPLIT_AND_LOOKUP do
      let updated_element = split_and_lookup state[i]
      in (state with [i] = updated_element)
  -- power map 
  let state = loop state for i in NUM_SPLIT_AND_LOOKUP..<STATE_SIZE do
    let x: BFieldElement = state[i]
    let sq = BFieldElement.mul x x
    let qu = BFieldElement.mul sq sq
    let updated_element = BFieldElement.mul x ( BFieldElement.mul sq  qu)
    in (state with [i] = updated_element)
  in { state = state } :> Tip5 

-- round 
def round
  (round_index: i64)
  (self: *Tip5)
  : Tip5 =
  -- call sbox_layer and mds_generated
  let self = sbox_layer self
  let self = mds_generated self

  let rounds_rc_indices = map ((+) (round_index * STATE_SIZE)) (iota STATE_SIZE)
  let rounds_rc = shared.gather ROUND_CONSTANTS rounds_rc_indices :> [STATE_SIZE]BFieldElement
  in {state = map2 (BFieldElement.+^) self.state rounds_rc }

-- permutation calls round func NUM_ROUNDS times
def permutation
 (self: *Tip5)
 : Tip5 =
 loop sponge = self for i < NUM_ROUNDS do
  round i sponge

-- hashes two digests, useful for merkle trees
def hash_pair (left: Digest) (right: Digest) : Digest =
  -- append digests and pad
  let sponge_state = left.0 ++ right.0 ++ replicate (STATE_SIZE - RATE) BFieldElement.one :> [STATE_SIZE]BFieldElement
  -- package in Tip5 type
  let sponge: Tip5 = { state = sponge_state }
  -- permute
  let sponge_state = permutation sponge
  -- extract the first DIGEST_LENGTH values for return
  let digest_values = take Digest.DIGEST_LENGTH sponge_state.state
  in { 0 = digest_values }
  
-- Hashes 10 elements or two digests. There is no padding ibc input len is fixed
def hash_10 (input: [10]BFieldElement) : [Digest.DIGEST_LENGTH]BFieldElement = 
  -- init sponge state
  let sponge_state = input ++ replicate (STATE_SIZE - 10) BFieldElement.one :> [STATE_SIZE]BFieldElement
  -- package in Tip5 type
  let sponge: Tip5 = { state = sponge_state }
  -- permute
  let sponge_state = permutation sponge
  -- return the first DIGEST_LENGTH values 
  in take Digest.DIGEST_LENGTH sponge_state.state

-- absorb for sponge
def absorb (self: Tip5) (input: [RATE]BFieldElement) : Tip5 =
  -- replace first RATE elements of state w/ input and permute
  let state = self.state
  let new_state = map2 (\i x -> if i < RATE then input[i] else x) (iota STATE_SIZE) state
  in permutation { state = new_state } :> Tip5

-- squeeze for sponge
def squeeze (self: *Tip5) : ([RATE]BFieldElement, Tip5) =
  -- clone first RATE elements of state
  let produce = map (\x -> x) (take RATE self.state)
  -- permute the original state
  let permuted = permutation self
  -- return both
  in (produce, permuted)

-- pad and absorb all (used within hash_varlen)
def pad_and_absorb_all(self: Tip5) (input: []BFieldElement) : Tip5 =
  -- pad input
  let padded_length: i64 = shared.next_multiple_of ((length input) + 1) RATE
  let padding = replicate (padded_length - length input) BFieldElement.zero
  let padded_input = input ++ [BFieldElement.one] ++ padding -- [1, 0, 0, ...]
  -- absorb all chunks
  let num_chunks = padded_length // RATE
  let self' = loop self' = self for i < num_chunks do
    let chunk_start = i * RATE
    let chunk = padded_input[chunk_start:(chunk_start + RATE)]
    let chunk = take RATE chunk -- ensure length is RATE (compiler needs to know)
    in absorb self' chunk
  in self'

-- hashes variable length input
def hash_varlen (input: []BFieldElement) : Digest =
  -- init sponge state w/ variable len
  let sponge = new #variable_length
  -- pad, absorb, squeeze
  let sponge: Tip5 = pad_and_absorb_all sponge input
  let (produce, _) = squeeze (copy sponge)
  -- -- package into digest
  in { 0 = take Digest.DIGEST_LENGTH produce } :> Digest

-- ==
-- entry: lookup_table_is_correct
-- random input { }
-- output { true }
entry lookup_table_is_correct : bool =
  let generated_table : [256]u8 = 
    map (\i -> u8.u16(offset_fermat_cube_map(u16.i64(i)))) (iota 256)
  in reduce (&&) true (map2 (==) LOOKUP_TABLE generated_table)

-- ==
-- entry: test_split_and_lookup
-- input { 48592u64 }
-- output { 46905u64 }
-- input { 593284u64 }
-- output { 14986571u64 }
-- input { 5324675u64 }
-- output { 6685552u64 }
entry test_split_and_lookup (x: u64) : u64 = 
  let field_element = BFieldElement.new x 
  let out = split_and_lookup field_element
  in BFieldElement.value(out)

-- ==
-- entry: test_sbox_layer
-- input { }
-- output { [0u64, 1u64, 8u64, 27u64, 16384u64, 78125u64, 279936u64, 823543u64, 2097152u64, 4782969u64, 10000000u64, 19487171u64, 35831808u64, 62748517u64, 105413504u64, 170859375u64] }
entry test_sbox_layer : [STATE_SIZE]u64 =
  let zero_to_fifteen: [STATE_SIZE]u64 = map u64.i64 (iota STATE_SIZE)
  let state: [STATE_SIZE]BFieldElement = map BFieldElement.new (zero_to_fifteen)
  let performed_sbox: Tip5 = sbox_layer { state = state } :> Tip5
  in map BFieldElement.value performed_sbox.state

-- ==
-- entry: test_mds_generated
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64, 7u64, 8u64, 9u64, 10u64, 11u64, 12u64, 13u64, 14u64, 15u64, 16u64] }
-- output {[3995122u64, 4502151u64, 4566908u64, 4550497u64, 4955990u64, 4788843u64, 4451760u64, 4783973u64, 4397514u64, 4481935u64, 4345076u64, 4215417u64, 4547838u64, 4117571u64, 4213560u64, 4452797u64]}
entry test_mds_generated (input: [STATE_SIZE]u64) : [STATE_SIZE]u64 =
  let state: [STATE_SIZE]BFieldElement = map BFieldElement.new input
  let tip5: Tip5 = { state = state }
  let tip5: Tip5 = mds_generated tip5
  in map BFieldElement.value tip5.state

-- == 
-- entry: test_round
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64, 7u64, 8u64, 9u64, 10u64, 11u64, 12u64, 13u64, 14u64, 15u64, 16u64] }
-- output { [13630787642203001902u64, 16896947564003473633u64, 10379470073464134983u64, 1965427456556198464u64, 15232567016277269303u64, 15892661416395869245u64, 3989155112214343120u64, 2851440915057620430u64, 8709159127100967584u64, 3694883791534778133u64, 12692463329003091445u64, 10722336274544247558u64, 12745456772474232568u64, 17932443119992221648u64, 7558121867372096151u64, 15551071123497955001u64] }
entry test_round (input: [STATE_SIZE]u64) : [STATE_SIZE]u64 =
  let state: [STATE_SIZE]BFieldElement = map BFieldElement.new input
  let tip5: Tip5 = { state = state }
  let tip5: Tip5 = round 0 tip5
  in map BFieldElement.value tip5.state

-- == 
-- entry: test_permutation
-- input { [1u64, 2u64, 3u64, 4u64, 5u64, 6u64, 7u64, 8u64, 9u64, 10u64, 11u64, 12u64, 13u64, 14u64, 15u64, 16u64] }
-- output { [3738715405479954556u64, 16991178370001441009u64, 1342414182333913173u64, 3805445081528134291u64, 16691165090776765767u64, 12310760454738969197u64, 12434079818696690066u64, 4565885946143111712u64, 10837812882172880148u64, 2010441594153163076u64, 16902475684635846384u64, 6159046892226671443u64, 13255912557551608855u64, 223433057183395922u64, 17068148105184310368u64, 357496177803468966u64]}
entry test_permutation (input: [STATE_SIZE]u64) : [STATE_SIZE]u64 =
  let state: [STATE_SIZE]BFieldElement = map BFieldElement.new input
  let tip5: Tip5 = { state = state }
  let tip5: Tip5 = permutation tip5
  in map BFieldElement.value tip5.state

-- == 
-- entry: hash_pair_test
-- input { [1u64, 1u64, 1u64, 1u64, 1u64] [2u64, 2u64, 2u64, 2u64, 2u64] }
-- output { [8730289631809914998u64, 1009323861008521215u64, 58075149203029478u64, 10017054356005686881u64, 7147585122682319752u64] }
-- input { [88u64, 88u64, 88u64, 88u64, 88u64] [123u64, 123u64, 123u64, 123u64, 123u64] }
-- output { [580041251555676278u64, 16666865939069142333u64, 5272045431067232340u64, 5762991365971536457u64, 14581353241871598518u64] }
entry hash_pair_test (left: [Digest.DIGEST_LENGTH]u64) (right: [Digest.DIGEST_LENGTH]u64) : [Digest.DIGEST_LENGTH]u64 =
  let left_digest: Digest = { 0 = map BFieldElement.new left }
  let right_digest: Digest = { 0 = map BFieldElement.new right }
  let result: Digest = hash_pair left_digest right_digest
  in map BFieldElement.value result.0

-- -- ==
-- -- entry: hash10_test_vectors
-- -- input {}
-- -- output { [10869784347448351760u64, 1853783032222938415u64, 6856460589287344822u64, 17178399545409290325u64, 7650660984651717733u64] }
entry hash10_test_vectors : bool =
  -- create preimage
  let preimage_init: [10]BFieldElement = map (\_ -> BFieldElement.zero) (iota 10)
  
  -- hash preimage multiple
  let final_preimage =
    loop (preimage) = (preimage_init) for i < 6 do
      -- hash current preimage
      let digest = hash_10 preimage
      -- place digest in preimage
      let prefix = take i preimage
      let suffix = drop (i + Digest.DIGEST_LENGTH) preimage
      let updated_preimage = prefix ++ digest ++ suffix
      -- take the first 10 elements  (so compiler knows the length)
      in take 10 updated_preimage

  -- Compuute final hash and gather values
  let last_digest = hash_10 final_preimage
  let last_digest = map BFieldElement.value last_digest

  -- Expected final hash values
  let expected_final_digest = [
    10869784347448351760u64,
    1853783032222938415u64,
    6856460589287344822u64,
    17178399545409290325u64,
    7650660984651717733u64
  ]

  -- Check if the final hash is correct
  let check_0: bool = expected_final_digest[0] == last_digest[0]
  let check_1: bool = expected_final_digest[1] == last_digest[1]
  let check_2: bool = expected_final_digest[2] == last_digest[2]
  let check_3: bool = expected_final_digest[3] == last_digest[3]
  let check_4: bool = expected_final_digest[4] == last_digest[4]

  in check_0 && check_1 && check_2 && check_3 && check_4


-- == 
-- entry: absorb_test
-- input { [1u64, 1u64, 1u64, 1u64, 1u64, 1u64, 1u64, 1u64, 1u64, 1u64] }
-- output { [12276694923556208976u64, 7756442493947946745u64, 13743817057173723560u64, 3999954619626529058u64, 3348872667620553407u64, 11714074877412406751u64, 15106843309009503369u64, 9639208608967363300u64, 11549119483956107222u64, 5833668434441772619u64, 12025854796187829337u64, 15309005811211805093u64, 14033860760017979716u64, 2166987574418210223u64, 9392502802113476128u64, 6462878597501194570u64]}
entry absorb_test (input: [RATE]u64) : [STATE_SIZE]u64 =
  let input = map BFieldElement.new input
  let tip5 = new #variable_length
  let tip5 = absorb tip5 input
  in map BFieldElement.value tip5.state

-- == 
-- entry: squeeze_test
-- input { }
-- output { [9513097171871388188u64, 3642894535466991979u64, 11900176395730479649u64, 2833868294984721560u64, 13162030402806853734u64, 7298820437337462149u64, 7309960967578619849u64, 5771961918525632945u64, 9033987145334062528u64, 17091107411642127967u64, 14491063761991657932u64, 921297860939203994u64, 14761216787163201376u64, 4658636456911727154u64, 16629099993905651428u64, 13073621988708012208u64] [0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64, 0u64] }
entry squeeze_test : ([STATE_SIZE]u64, [RATE]u64) = 
  let sponge = new #variable_length
  let (produce, tip5) = squeeze sponge 
  let tip5_values = map BFieldElement.value tip5.state
  let produce_values = map BFieldElement.value produce
  in (tip5_values, produce_values)

-- ==
-- entry: test_pad_and_absorb_all
-- input { }
-- output { [3588662367340377189u64, 1674308759493466027u64, 15812284298942888812u64, 7234362949470865885u64, 10691079157494539585u64, 9786430604252666752u64, 9603442183392290278u64, 8950705941670498115u64, 4433355208077567955u64, 1328443036119347625u64, 4821595268274838208u64, 7336820815704793185u64, 7436619006474582588u64, 744124146292718456u64, 2683076373473407838u64, 12204837371088226891u64] }
entry test_pad_and_absorb_all : [STATE_SIZE]u64 = 
  let sponge = new #variable_length
  let input = map (\_ -> BFieldElement.one) (iota (RATE * 7 + 3))
  let state = pad_and_absorb_all sponge input
  in map BFieldElement.value state.state

-- == 
-- entry: hash_varlen_test
-- input { }
-- output {[3588662367340377189u64, 1674308759493466027u64, 15812284298942888812u64, 7234362949470865885u64, 10691079157494539585u64]}
entry hash_varlen_test : [Digest.DIGEST_LENGTH]u64 =
  let input = map (\_ -> BFieldElement.one) (iota (RATE * 7 + 3))
  let digest = hash_varlen input
  in map BFieldElement.value digest.0

