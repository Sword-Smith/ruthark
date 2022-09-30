module BFieldElement = import "BFieldElement"

type BFieldElement = BFieldElement.BFieldElement
type XFieldElement = (BFieldElement, BFieldElement, BFieldElement)



def new (lo: BFieldElement) (mi: BFieldElement) (hi: BFieldElement) : XFieldElement = (lo, mi, hi)

def canonicalize ((lo, mi, hi) : XFieldElement) : XFieldElement =
  ( BFieldElement.canonicalize lo
  , BFieldElement.canonicalize mi
  , BFieldElement.canonicalize hi
  )

def new_u64 (lo: u64, mi: u64, hi: u64) : XFieldElement =
  (BFieldElement.U64 lo, BFieldElement.U64 mi, BFieldElement.U64 hi)

def new_const (element: BFieldElement) : XFieldElement = new element BFieldElement.zero BFieldElement.zero

def one : XFieldElement = new_const BFieldElement.one

def zero : XFieldElement = new_const BFieldElement.zero

def default : XFieldElement = one

def is_zero ((lo, mi, hi) : XFieldElement) : bool =
  let zero = BFieldElement.zero in
  zero == BFieldElement.canonicalize lo
  && zero == BFieldElement.canonicalize mi
  && zero == BFieldElement.canonicalize hi

def is_one ((lo, mi, hi) : XFieldElement) : bool =
  let zero = BFieldElement.zero in
  let one = BFieldElement.one in
  one == BFieldElement.canonicalize lo
  && zero == BFieldElement.canonicalize mi
  && zero == BFieldElement.canonicalize hi

def add ((a_lo, a_mi, a_hi) : XFieldElement) ((b_lo, b_mi, b_hi) : XFieldElement) : XFieldElement =
  ( (BFieldElement.add a_lo b_lo)
  , (BFieldElement.add a_mi b_mi)
  , (BFieldElement.add a_hi b_hi)
  )

def neg ((lo, mi, hi) : XFieldElement) : XFieldElement =
  ( BFieldElement.neg lo
  , BFieldElement.neg mi
  , BFieldElement.neg hi
  )

def sub (a: XFieldElement) (b: XFieldElement) : XFieldElement =
  canonicalize (add a (neg b))

def mul ((a_lo, a_mi, a_hi) : XFieldElement) ((b_lo, b_mi, b_hi) : XFieldElement) : XFieldElement =
  ( (BFieldElement.mulmod a_lo b_lo)
  , (BFieldElement.mulmod a_mi b_mi)
  , (BFieldElement.mulmod a_hi b_hi)
  ) -- TODO: IMPLEMENT PROPERLY

def mod_pow_u32 ((a_lo, a_mi, a_hi) : XFieldElement) (exp :  u64) : XFieldElement =
  ( (BFieldElement.powmod exp a_lo)
  , (BFieldElement.powmod exp a_mi)
  , (BFieldElement.powmod exp a_hi)
  ) -- TODO: IMPLEMENT PROPERLY

def inverse = id -- TODO
