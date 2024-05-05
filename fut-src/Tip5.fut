module Digest = import "Digest"
module BFieldElement = import "BFieldElement"
module shared = import "shared"

type Digest = Digest.Digest
type BFieldElement = BFieldElement.BFieldElement

let STATE_SIZE: i64 = 16
let RATE: i64 = 10
let NUM_ROUNDS: i64 = 5

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

def round
  (round_index: i64)
  (self: Tip5)
  : Tip5 =
  -- TODO: Call `sbox_layer` and `mds_generate`

  let rounds_rc_indices = map ((+) (round_index * STATE_SIZE)) (iota STATE_SIZE)
  let rounds_rc = shared.gather ROUND_CONSTANTS rounds_rc_indices :> [STATE_SIZE]BFieldElement
  in {state = map2 (BFieldElement.+^) self.state rounds_rc }


def permutation
 (self: Tip5)
 : Tip5 =
 loop sponge = self for i < NUM_ROUNDS do
  round i sponge

def hash_pair
 (left: Digest)
 (right: Digest)
 : Digest =
--  let sponge_state = replicate STATE_SIZE BFieldElement.zero
  let sponge_state =
    left.0
    ++ right.0
    ++ replicate (STATE_SIZE - RATE) BFieldElement.one
    :> [STATE_SIZE]BFieldElement
  let sponge_state: Tip5 = { state = sponge_state }
  let sponge_state = permutation sponge_state

  -- TODO: Fix return value
  in left
--  let sponge_state = scatter (sponge.state) (iota DIGEST_LENGTH) left.0

 -- set first DIGEST_LENGTH words of state from left values
 -- set next DIGEST_LENGTH words of state from right values
