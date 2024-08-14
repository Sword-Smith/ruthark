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
        let b_domain = with_offset (of_length order) offset

        -- expected
        let expected_b_values =
            map (\i -> BFieldElement.mul offset (BFieldElement.mod_pow_i64 generator i) ) (iota order)

        -- actual in two different ways
        let actual_b_values_1 = take order (domain_values b_domain)
        let actual_b_values_2 = take order (map (\i -> domain_value b_domain i) (iota order))
        
        -- ensure all values are equal
        let success = success && (reduce (&&) true (map2 BFieldElement.eq expected_b_values actual_b_values_1 )) 
        let success = success && (reduce (&&) true (map2 BFieldElement.eq expected_b_values actual_b_values_2 ))
        
        -- TODO continue w/ poly eval
    
        in success
    in success