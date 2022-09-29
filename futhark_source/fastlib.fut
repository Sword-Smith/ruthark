module BFieldElement = import "rp"

type BFieldElement = BFieldElement.BFieldElement

-- type BFieldElement = u64
-- module BFieldElement = {
--     def zero : BFieldElement = 0
--     def one  : BFieldElement = 1
-- }

type XFieldElement = (BFieldElement, BFieldElement, BFieldElement)
-- It's bad practice to have short arrays in futhark. The compiler
-- assumes that it should generate fast code for all arrays, which
-- has a lot of overhead, and is not worth it for small arrays.
-- If small and of constant size, use tuples/records instead.
module XFieldElement = {
    type Self = XFieldElement

    def zero : Self =
        (
            BFieldElement.zero,
            BFieldElement.zero,
            BFieldElement.zero
        )

    def one : XFieldElement =
        (
            BFieldElement.one,
            BFieldElement.zero,
            BFieldElement.zero
        )

    def mul (self: XFieldElement) (other: XFieldElement) =
        -- FIXME: Ignores overflow
        (
            self.0 * other.0,
            self.1 * other.1,
            self.2 * other.2
        )

    def is_zero (self: XFieldElement) =
        self == zero

    def inverse (self: XFieldElement) =
    --     fn inverse(&self) -> Self {
    --     let self_as_poly: Polynomial<BFieldElement> = self.to_owned().into();
    --     let (_, a, _) = Self::xgcd(self_as_poly, Self::shah_polynomial());
    --     a.into()
        self
}

-- module type Result = {
--     type value_type
--     type failure_type = bool
--     type Result = ( value_type, failure_type )
--     val asserts : failure_type -> value_type -> Result
-- }

type Succeeded = bool
let FAILURE = false
let SUCCESS = true


-- This can be implemented as a function in a parametric module,
-- taking a FiniteField module as a parameter, that then implements
-- the relevant primitive behaviors as in tf/src/shared_math/traits.rs
entry batch_inversion_futhark [input_length] (input: [input_length]XFieldElement) : ([input_length]XFieldElement, Succeeded) =
    -- This line doesn't really make much.
    if input_length == 0 then (input, FAILURE) else

    let zero = XFieldElement.zero
    let one = XFieldElement.one

    let scratch = replicate input_length zero
    let acc = one

    -- We can't assert in Futhark, but we can pass a flagvalue back, if we really want to.
    -- That costs, though...

    let flag = reduce (||) false <| map (XFieldElement.is_zero) input -- Cannot do batch inversion on zero
    let scratch = scan (XFieldElement.mul) input[0] input
    -- was it an inclusive or exclusive scan? or something inconsistent?

    --     for i in 0..input_length {
    --         scratch[i] = acc;
    --         acc *= input[i];
    --     }

    --     acc = acc.inverse();

    --     let mut res = input;
    --     for i in (0..input_length).rev() {
    --         let tmp = acc * res[i];
    --         res[i] = acc * scratch[i];
    --         acc = tmp;
    --     }

    --     res
    -- }
    in (input, SUCCESS)
