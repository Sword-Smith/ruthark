module BFieldElement = import "BFieldElement"
module shared = import "shared"  
module bfe_poly = import "bfe_poly"

type BFieldElement = BFieldElement.BFieldElement
type BfePolynomial [n] = bfe_poly.BfePolynomial [n]

type ArithmeticDomain = {
    offset: BFieldElement,
    generator: BFieldElement,
    len: i64
}

-- derives generator for a domain of the given length
-- Error if the length is not a power of two
def generator_for_length(domain_length: i64) : BFieldElement = 
    let generator: BFieldElement = 
      assert (shared.is_power_of_2 domain_length) (BFieldElement.primitive_root domain_length)
    in generator  

-- Create a new domain with the given length
-- No offset is applied, but can be added through with_offset()
-- Errors if the domain lenght is not a power of two
def of_length (len: i64) : ArithmeticDomain = 
    let offset = BFieldElement.one
    let generator = generator_for_length len 
    in {offset, generator, len}

-- sets the offset of an existing domain
def with_offset (domain: ArithmeticDomain) (offset: BFieldElement) : ArithmeticDomain = 
    domain with offset = offset

-- evaluate a polynomial over the domain
def evaluate [n] (domain: ArithmeticDomain) (polynomial: BfePolynomial [n]) : []BFieldElement =
    -- unpack domain attributes
    let offset: BFieldElement = domain.offset
    let len: i64 = domain.len

    -- Anonymous function to evaluate polynomial chunk over the domain
    let evaluate_from [m] (chunked_coeffs: [m]BFieldElement) : [len]BFieldElement =
        let chunk_poly = bfe_poly.new chunked_coeffs
        in bfe_poly.fast_coset_evaluate offset len chunk_poly

    -- chunk polynomial into domain length sized chunks
    let chunked_coeffs: [][]BFieldElement = bfe_poly.chunk_coefficients polynomial len

    -- Initial values: handle empty or single chunk case
    let initial_values: [len]BFieldElement = 
        if (length chunked_coeffs == 0)
        then replicate len BFieldElement.zero
        else evaluate_from (chunked_coeffs[0])

    -- Parallel loop to process each chunk with the appropriate scaled offset
    let final_values =
        loop values = initial_values for chunk_i in 1..<length chunked_coeffs do
            let chunk = chunked_coeffs[chunk_i]
            let coefficient_index = chunk_i * len
            let scaled_offset = BFieldElement.mod_pow_i64 offset coefficient_index
            let evaluations = evaluate_from chunk

            -- Scale and add evaluations to running totals
            let scale_and_add =  \value eval ->
                let scaled_eval = BFieldElement.mul eval scaled_offset
                in BFieldElement.add value scaled_eval
            in map2 scale_and_add values evaluations

    in final_values

-- interpolation
def interpolate (domain: ArithmeticDomain) (values: []BFieldElement) : BfePolynomial [] =
    bfe_poly.fast_coset_interpolate domain.offset values

-- compute the n'th element in the domain
def domain_value (domain: ArithmeticDomain) (n: i64) : BFieldElement = 
    BFieldElement.mul domain.offset (BFieldElement.mod_pow_i64 domain.generator n)

-- compute all values in the domain
let domain_values (domain: ArithmeticDomain) : [domain.len]BFieldElement =
    -- init accumulator and values arr
    let accumulator = BFieldElement.one
    let init_values = replicate domain.len BFieldElement.zero

    -- Loop through, updating accumulator and setting values in the array
    let (accumulator, domain_values) = 
        loop (accumulator, domain_values) = (accumulator, init_values) for i in 0..<domain.len do
            let value = BFieldElement.mul accumulator domain.offset
            let updated_values = domain_values with [i] = value
            let new_accumulator = BFieldElement.mul accumulator domain.generator
            in (new_accumulator, updated_values)
    let _ = 
        assert (BFieldElement.is_one accumulator) "length must be order of generator"

    in domain_values

-- == 
-- entry: test_domain_values 
-- input { }
-- output { true }
entry test_domain_values : bool =

    let x_cubed_coefficients = [BFieldElement.zero, BFieldElement.zero, BFieldElement.zero, BFieldElement.one]
    let poly = bfe_poly.new x_cubed_coefficients

    let orders = [4, 8, 32]
    let success = loop success = true for order in orders do

        -- generator, offset, domain (w/ offset applied)
        let generator = BFieldElement.primitive_root order   
        let offset = BFieldElement.generator
        let b_domain: ArithmeticDomain = with_offset (of_length order) offset

        -- expected
        let expected_b_values =
            map (\i -> BFieldElement.mul offset (BFieldElement.mod_pow_i64 generator i) ) (iota order)

        -- actual in two different ways
        let actual_b_values_1 = take order (domain_values b_domain)
        let actual_b_values_2 = take order (map (\i -> domain_value b_domain i) (iota order))
        
        -- ensure all values are equal
        let success = success && (reduce (&&) true (map2 BFieldElement.eq expected_b_values actual_b_values_1 )) 
        let success = success && (reduce (&&) true (map2 BFieldElement.eq expected_b_values actual_b_values_2 ))
        
        -- evaluate polynomial over the domain
        let values = evaluate b_domain poly

        -- assert not equal to x cubed coefficients
        let length_values = length values
        let length_x_cubed_coefficients = length x_cubed_coefficients
        let success = 
            -- same lengths, so can compare
            if length_values == length_x_cubed_coefficients
            then 
                -- tell compiler these are the same len
                let values = take (length_values) values
                let x_cubed_coefficients = take (length_values) x_cubed_coefficients 
                -- ensure the values ae not equal to the x cubed coefficients
                in success && !(reduce (&&) true (map2 BFieldElement.eq values x_cubed_coefficients)) 

            -- different lengths, so can't be equal, return success
            else success

        -- interpolate and compare 
        let interpolant = interpolate b_domain values
        let success = success && (bfe_poly.eq interpolant poly)
        
        -- Verify that batch-evaluated values match a manual evaluation
        let success = loop success = success for i in (iota order) do 
            let manual_eval = domain_value b_domain i |> bfe_poly.evaluate poly
            let computed_eval = values[i]
            in success && (manual_eval == computed_eval)

        in success
    in success