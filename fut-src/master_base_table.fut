module ArithmeticDomain = import "arithmetic_domain"
module BFieldElement = import "BFieldElement"
module bfe_poly = import "bfe_poly"

type ArithmeticDomain = ArithmeticDomain.ArithmeticDomain
type BFieldElement = BFieldElement.BFieldElement
type BfePolynomial [n] = bfe_poly.BfePolynomial [n]

type~ MasterBaseTable [rows] [cols] = {

    -- num_randomizers: i64,

    -- program_table_len: i64,
    -- main_execution_len: i64,
    -- op_stack_table_len: i64,
    -- ram_table_len: i64,
    -- hash_coprocessor_execution_len: i64,
    -- cascade_table_len: i64,
    -- u32_coprocesor_execution_len: i64,

    -- trace_domain: ArithmeticDomain,
    randomized_trace_domain: ArithmeticDomain,
    -- quotient_domain: ArithmeticDomain,
    -- fri_domain: ArithmeticDomain,

    randomized_trace_table: [rows][cols]BFieldElement,
    -- low_degree_extended_table: [][]BFieldElement,
    -- interpolation_polynomials: []BfePolynomial[]
}


-- low-degree extend all columns of the randomized trace domain table. 
def low_degree_extend_all_columns [rows] [cols] (table: MasterBaseTable [rows] [cols]) : [cols]BfePolynomial[] =  

    let randomized_trace_domain: ArithmeticDomain = table.randomized_trace_domain

    -- get randomized trace table
    let trace_table: [rows][cols]BFieldElement = table.randomized_trace_table

    -- flip to collumn major 
    let trace_columns: [cols][rows]BFieldElement=
        map 
        (\col_idx -> map (\row_idx -> trace_table[row_idx][col_idx])(iota rows)) 
        (iota cols)

    -- Perform the interpolation for each column
    let interpolated_polynomials =
        map 
        (\trace_column ->  ArithmeticDomain.interpolate_bfe_values randomized_trace_domain trace_column) 
        trace_columns

    in interpolated_polynomials
