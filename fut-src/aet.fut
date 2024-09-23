module BFieldElement = import "BFieldElement"

type BFieldElement = BFieldElement.BFieldElement


let LOOKUP_TABLE_HEIGHT: i64 = 1 << 8

-- An Algebraic Execution Trace (AET) is the primary witness required for proof generation. It
-- holds every intermediate state of the processor and all co-processors, alongside additional
-- witness information, such as the number of times each instruction has been looked up
-- (equivalently, how often each instruction has been executed).
type~ AlgebraicExecutionTrace = {

    -- The program that was executed in order to generate the trace
    -- program: Program -- NOTE: Placeholder, additonal infrastructure is required

    -- The number of times each instruction has been executed
    -- 
    -- Each instruction int he `program` has one associated entry in `instruction_multiplicities`,
    -- counting the number of times this specific instruction at that location in the program
    -- memory has been executed.
    instruction_multiplicities: []u32,

    -- Records the state of the processor after each instruction
    processor_trace: [][]BFieldElement,

    op_stack_underflow_trace: [][]BFieldElement,

    ram_trace: [][]BFieldElement,

    -- The trace of hashing the program whose execution generated this `AlgebraicExecutionTrace`.
    -- The resulting digest
    -- 1. ties a `Proof` to the program it was produced from, and
    -- 1. is accessible to the program being executed.
    program_hash_trace: [][]BFieldElement,

    -- For the `hash` instruction, the hash trace records the internal state of the Tip5
    -- permutation for each round.
    hash_trace: [][]BFieldElement,

    -- For the Sponge instructions, i.e., `sponge_init`, `sponge_absorb`,
    -- `sponge_absorb_mem`, and `sponge_squeeze`, the Sponge trace records the
    -- internal state of the Tip5 permutation for each round.
    sponge_trace: [][]BFieldElement,

    -- The u32 entries hold all pairs of BFieldElements that were written to the U32 Table,
    -- alongside the u32 instruction that was executed at the time. Additionally, it records how
    -- often the instruction was executed with these arguments.
    -- u32_entries: HashMap<U32TableEntry, u64>, -- TODO detemine how hashmap should be represented in fut

    -- Records how often each entry in the cascade table was looked up.
    -- pub cascade_table_lookup_multiplicities: HashMap<u16, u64>, -- TODO detemine how hashmap should be represented in fut

    -- Records how often each entry in the lookup table was looked up.
    lookup_table_lookup_multiplicities: [LOOKUP_TABLE_HEIGHT]u64,
}