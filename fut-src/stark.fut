module XFieldElement = import "XFieldElement"
module master_base_table = import "master_base_table"

type XFieldElement = XFieldElement.XFieldElement

let EXTENSION_DEGREE = XFieldElement.EXTENSION_DEGREE

let NUM_QUOTIENT_SEGMENTS: i64 = master_base_table.AIR_TARGET_DEGREE

-- The Zero-Knowledge [Scalable Transparent ARgument of Knowledge] STARK for Triton-VM
-- [stark]: https://www.iacr.org/archive/crypto2019/116940201/116940201.pdf
type Stark = {

    -- The conjectured security level in bits. Concretely, the system
    -- - is perfectly complete, and
    -- - has soundness error 2^(-security_level).
    security_level: i64,

    -- The ratio between the lengths of the randomized trace domain and the FRI domain.
    -- Must be a power of 2 for efficiency reasons.
    fri_expansion_factor: i64,

    -- The number of randomizers for the execution trace. The trace randomizers are integral for
    -- achieving zero-knowledge. In particular, they achieve ZK for the (DEEP) ALI part of the
    -- zk-STARK.
    num_trace_randomizers: i64,

    -- The number of collinearity checks to perform in FRI.
    num_collinearity_checks: i64,
}

-- Constructor for Stark struct
def new (security_level: i64) (log2_of_fri_expansion_factor: i64) : Stark = 
    let FRI_expansion_factor_must_be_greater_than_1 = assert (log2_of_fri_expansion_factor > 0) ""

    let fri_expansion_factor: i64 = 1 << log2_of_fri_expansion_factor  
    let num_collinearity_checks: i64 = security_level / log2_of_fri_expansion_factor

    let num_out_of_domain_rows: i64 = 2
    let num_trace_randomizers = 
        num_collinearity_checks 
        + (num_out_of_domain_rows * EXTENSION_DEGREE) 
        + (NUM_QUOTIENT_SEGMENTS * EXTENSION_DEGREE)

    in {
        security_level = security_level,
        fri_expansion_factor = fri_expansion_factor,
        num_trace_randomizers = num_trace_randomizers,
        num_collinearity_checks = num_collinearity_checks
    } :> Stark
