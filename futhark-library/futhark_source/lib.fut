-- Math foundation
module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"

-- Experiments
module Fastlib = import "fastlib"
module Parametric_module = import "parametric_module"

type XFieldElementOpaque = XFieldElement.XFieldElement
type BFieldElement = BFieldElement.BFieldElement

-- This definition is a odds with the one in `XFieldElement.fut`.
type XFieldElement = [3]BFieldElement

def inner_to_outer
    (a: XFieldElementOpaque) : XFieldElement =
    [a.0, a.1, a.2]

def outer_to_inner
    (a: XFieldElement) : XFieldElementOpaque =
    (a[0], a[1], a[2])

def make_transposed_quotient_codewords
    [n][m][p][q]
    ( zinvs:         [n]XFieldElementOpaque)
    ( eps:           [n]      [m]XFieldElementOpaque)
    ( expsss:           [p][q][m]u64)
    ( coefficientss:    [p][q]XFieldElementOpaque)
    : [n][p]XFieldElementOpaque =
        map2 (\ evaluation_points  z_inv ->
            map2 (\expss coefficients ->
                XFieldElement.mul z_inv (
                    reduce (XFieldElement.add) XFieldElement.zero <|
                    map2(\exps coefficient ->
                        XFieldElement.mul coefficient (
                            reduce (XFieldElement.mul) XFieldElement.one <|
                            map2 (\exp elm -> XFieldElement.mod_pow_u64 elm exp) exps evaluation_points
                        )
                    ) expss coefficients
                )
            ) expsss coefficientss
        ) eps zinvs

entry make_transposed_quotient_codewords_non_opaque
    [n][m][p][q]
    ( zinvs:         [n]XFieldElement)
    ( eps:           [n]      [m]XFieldElement)
    ( expsss:           [p][q][m]u64)
    ( coefficientss:    [p][q]XFieldElement)
    : [n][p]XFieldElement =
    let inner_zinvs = map outer_to_inner zinvs
    let inner_eps = map (map outer_to_inner) eps
    let inner_expsss = expsss
    let inner_coefficientss = map (map outer_to_inner) coefficientss
    let inner_res = make_transposed_quotient_codewords inner_zinvs inner_eps inner_expsss inner_coefficientss
    in map (map inner_to_outer) inner_res
