module ArithmeticDomain = import "arithmetic_domain"
module XFieldElement = import "XFieldElement"
module XfePolynomial = import "xfe_poly"
module BFieldElement = import "BFieldElement"

let NUM_BASE_COLUMNS: i64 = 375
let NUM_COLUMNS: i64 = NUM_BASE_COLUMNS

type BFieldElement = BFieldElement.BFieldElement
type ArithmeticDomain = ArithmeticDomain.ArithmeticDomain
type XFieldElement = XFieldElement.XFieldElement
type XfePolynomial [n] = XfePolynomial.XfePolynomial [n]


-- NOTE: MasterExtTable is 
type MasterExtTable [rows] [cols] = {

    num_trace_randomizers: i64,

    trace_domain: ArithmeticDomain,
    randomized_trace_domain : ArithmeticDomain,
    quotient_domain : ArithmeticDomain,
    fri_domain : ArithmeticDomain,

    randomized_trace_table: [rows][cols]XFieldElement,

    -- TODO: once more proving is done on the GPU, this will be needed
    -- low_degree_extended_table: [][]XFieldElement, 
    -- interpolated_polynomials: []XfePolynomial[NUM_EXT_COLUMNS]
}

-- same for MasterExtTable and MasterBaseTable 
def evaluation_domain (table: MasterExtTable [] [] ) : ArithmeticDomain =
    if table.quotient_domain.len > table.fri_domain.len
    then table.quotient_domain
    else table.fri_domain

-- low-degree extend all columns of the randomized trace domain table. 
-- ! NOTE: this code is not fully tested, I am moving to github so I can access from remote GPU. 
-- ! Began expeiencing inconsistent outputs in unit tests from thermal throttling. Laptop very hot.
def low_degree_extend_all_columns [rows] [cols] (table: MasterExtTable [rows] [cols]) : [cols]XfePolynomial[] =  

    let randomized_trace_domain: ArithmeticDomain = table.randomized_trace_domain

    -- get randomized trace table
    let trace_table: [rows][cols]XFieldElement = table.randomized_trace_table

    -- flip to collumn major -- TODO Theres probably a cleverer way that doesnt require doing this
    let trace_columns: [cols][rows]XFieldElement=
        map 
        (\col_idx -> map (\row_idx -> trace_table[row_idx][col_idx])(iota rows)) 
        (iota cols)

    -- Perform the interpolation for each column
    let interpolant_polynomials =
        map 
        (\trace_column ->  ArithmeticDomain.interpolate_xfe_values randomized_trace_domain trace_column) 
        trace_columns

    in interpolant_polynomials
