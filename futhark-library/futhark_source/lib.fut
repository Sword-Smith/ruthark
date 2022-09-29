module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"

module Fastlib = import "fastlib"
module Matmul = import "matmul"

module Parametric_module = import "parametric_module"

entry matmul = Matmul.matmul

type XFieldElement = XFieldElement.XFieldElement

type MPolynomial [p][m] = {coefficients: [p]([m]u64, XFieldElement)}

def make_transposed_quotient_codewords
    [n][m][p]
    ( aaa:      [n]([m]XFieldElement, XFieldElement)
    , transition_constraints : [m]MPolynomial[p][m])
    : [n][m]XFieldElement =
        map (\(evaluation_points, z_inv) ->
            map (\tc ->
                XFieldElement.mul z_inv (
                    reduce (XFieldElement.add) XFieldElement.zero <|
                    map(\(exps, coefficient) ->
                        XFieldElement.mul coefficient (
                            reduce (XFieldElement.mul) XFieldElement.one <|
                            map2 (\exp elm -> XFieldElement.mod_pow_u32 elm exp) exps evaluation_points
                        )
                    ) tc.coefficients
                )
            ) transition_constraints
        ) aaa