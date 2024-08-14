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
