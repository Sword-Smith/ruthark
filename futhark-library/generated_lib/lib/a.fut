import "segmented"

-- Math foundation
module BFieldElement = import "BFieldElement"
module XFieldElement = import "XFieldElement"
module Polynomial = import "Polynomial"
module MPolynomial = import "MPolynomial"

-- Experiments
module Fastlib = import "fastlib"
module Matmul = import "matmul"
module Parametric_module = import "parametric_module"

-- How to make imported functions callable
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

def (x: XFieldElementOpaque) ^*^ (y: XFieldElementOpaque) = XFieldElement.my_mul x y

def (x: XFieldElementOpaque) ^+^ (y: XFieldElementOpaque) = XFieldElement.add x y

def (elm: XFieldElementOpaque) %** (exp: u64) = XFieldElement.my_mod_pow_u64 elm exp

def make_transposed_quotient_codewords
    [n][m][p][q]
    ( zinvs:         [n]XFieldElementOpaque)
    ( eps:           [n]      [m]XFieldElementOpaque)
    ( expsss:           [p][q][m]u64)
    ( coefficientss:    [p][q]XFieldElementOpaque)
    : [n][p]XFieldElementOpaque =

           --   XFE   [m]XFE
        map2 (\ z_inv evaluation_points ->
            --     [q][m]u64 [q]XFE  
            map2 (\ expss    coefficients ->

                --      [m]u64  XFE   ---> [q]XFE
                map2 (\ exps   coefficient ->
                        -- XFE ** u64  -> [m] XFE
                   map2 (%**) evaluation_points exps

                   -- [m]XFE -> XFE
                   |> reduce (^*^) XFieldElement.one
                    -- XFE   * XFE --> XFE
                   |> (coefficient ^*^)
                ) expss coefficients
                -- how to express this when exps and coefficients are flattened?

                -- [q] XFE
                |> reduce (^+^) XFieldElement.zero
                |> (z_inv ^*^)
            ) expsss coefficientss
        ) zinvs eps

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



def non_padded_make_transposed_quotient_codewords
    [n][m][p][pq]
    ( zinvs:          [n]XFieldElementOpaque)
    ( epss:           [n]    [m]XFieldElementOpaque)

    ( exps_segss:        [pq][m]u64)
    ( coefficients_segs: [pq]XFieldElementOpaque)
    ( qs:                [p]i64) -- the shadow dimension
    : [n][p]XFieldElementOpaque =
        -- n    XFE   [m]XFE
        let false_is = scan (+) 0 qs
        let is_almost = map (\i -> false_is[(i+1)%p]) <| iota p
        let is = copy is_almost with [0] = 0
        let vs = replicate p true
        let dest = replicate pq false
        --scatter 'a : (dest: *[]a) -> (is: []i32) -> (vs: []a) -> *[]a
        let flags = scatter dest is vs
        in

        map2 (\ z_inv evaluation_points ->
            -- pq   [m]u64 XFE
            -- the outer map reduces q, which is now hidden
            let innermapped = 
                map2 (\ exps   coefficient ->
                    -- the inner redomap reduces m, so we dont need to change anything really
                    -- XFE ** u64  -> [m] XFE
                    map2 (%**) evaluation_points exps
                    -- [m]XFE -> XFE
                    |> reduce (^*^) XFieldElement.one
                        -- XFE   * XFE --> XFE
                    |> (coefficient ^*^)
                    -- [q] XFE
                ) exps_segss coefficients_segs

            -- this reduction reduces pq to 1, 
            -- but it should segreduce to p
            -- segmented_reduce [n] 't: 
            -- (op: t -> t -> t) -> 
            -- (ne: t) -> 
            -- (flags: [n]bool) -> 
            -- (as: [n]t) ->
            -- ?[d₃₄].*[d₃₄]t
            let reduced = segmented_reduce (^+^) XFieldElement.zero flags innermapped
            let bob = map (\i -> reduced[i % (length reduced)]) <| iota p
            in  map (z_inv ^*^) bob
        ) zinvs epss

entry non_padded_make_transposed_quotient_codewords_non_opaque
    [n][m][p][pq]
    ( zinvs:         [n]XFieldElement)
    ( eps:           [n]        [m]XFieldElement)
    ( exps_segss:           [pq][m]u64)
    ( coefficients_segs:    [pq]XFieldElement)
    ( qs:                   [p]i64) -- the shadow dimension
    : [n][p]XFieldElement =
    let inner_zinvs = map outer_to_inner zinvs
    let inner_eps = map (map outer_to_inner) eps
    let inner_expsss = exps_segss
    let inner_coefficientss = map (outer_to_inner) coefficients_segs
    let inner_res = non_padded_make_transposed_quotient_codewords inner_zinvs inner_eps inner_expsss inner_coefficientss qs
    in map (map (inner_to_outer)) inner_res
