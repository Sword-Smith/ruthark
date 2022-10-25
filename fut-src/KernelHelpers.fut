module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
type XFieldElement = XFieldElement.XFieldElement
type BFieldElement = BFieldElement.BFieldElement
open import "lib/github.com/Ulrik-dk/segmented/segmented"

def (x: XFieldElement) ^*^ (y: XFieldElement) = XFieldElement.mul x y

def (x: XFieldElement) ^+^ (y: XFieldElement) = XFieldElement.add x y

def (elm: XFieldElement) %** (exp: u8) = XFieldElement.mod_pow_u8 elm exp

def inner_redo_map
    ( exp_2d )
    ( coefficient_1d )
    ( evaluation_point_1d )
    =
    map2 (\ exp_1d coefficient ->
        map2 (%**) evaluation_point_1d exp_1d
        |> reduce_comm (^*^) XFieldElement.one
        |> (coefficient ^*^)
    ) exp_2d coefficient_1d
