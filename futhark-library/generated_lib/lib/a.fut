module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"

module Fastlib = import "fastlib"
module Matmul = import "matmul"

module Parametric_module = import "parametric_module"

entry matmul = Matmul.matmul

type XFieldElementOpaque = XFieldElement.XFieldElement
type BFieldElement = BFieldElement.BFieldElement

type XFieldElement = [3]BFieldElement

def inner_to_outer 
    (a: XFieldElementOpaque) : XFieldElement =
    [a.0, a.1, a.2]

def outer_to_inner
    (a: XFieldElement) : XFieldElementOpaque =
    (a[0], a[1], a[2])

type MPolynomial [p][m] = {coefficients: [p]([m]u64, XFieldElement)}



def make_transposed_quotient_codewords
    [n][m][p]
    ( zinvs:         [n]XFieldElementOpaque)
    ( eps:           [n][m]XFieldElementOpaque)
    ( expsss:           [m][p][m]u64)
    ( coefficientss:    [m][p]XFieldElementOpaque)
    : [n][m]XFieldElementOpaque =
        map2 (\ evaluation_points  z_inv ->
            map2 (\expss coefficients ->
                XFieldElement.mul z_inv (
                    reduce (XFieldElement.add) XFieldElement.zero <|
                    map2(\exps coefficient ->
                        XFieldElement.mul coefficient (
                            reduce (XFieldElement.mul) XFieldElement.one <|
                            map2 (\exp elm -> XFieldElement.mod_pow_u32 elm exp) exps evaluation_points
                        )
                    ) expss coefficients
                )
            ) expsss coefficientss
        ) eps zinvs

entry make_transposed_quotient_codewords_non_opaque
    [n][m][p]
    ( zinvs:         [n]XFieldElement)
    ( eps:           [n][m]XFieldElement)
    ( expsss:           [m][p][m]u64)
    ( coefficientss:    [m][p]XFieldElement)
    : [n][m]XFieldElement =
    let inner_zinvs = map outer_to_inner zinvs
    let inner_eps = map (map outer_to_inner) eps
    let inner_expsss = expsss
    let inner_coefficientss = map (map outer_to_inner) coefficientss
    let inner_res = make_transposed_quotient_codewords inner_zinvs inner_eps inner_expsss inner_coefficientss
    in map (map inner_to_outer) inner_res
