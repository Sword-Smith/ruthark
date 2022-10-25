import "KernelHelpers"

def create_histogram_is
    [p]
    ( q_1d: [p]i64)
    ( pq )
    : [pq]i64
    =
    let false_is = scan (+) 0 q_1d
    let is_almost = map (\i -> false_is[(i+1)%p]) <| iota p
    let ice = copy is_almost with [0] = 0
    let is = segmented_replicate ice q_1d :> [pq]i64
    in is

def kernel_histogram_impl
    [n][m][p][pq]
    ( zerofier_inverse_1d:  [n]XFieldElement)
    ( evaluation_point_2d:  [n]    [m]XFieldElement)
    ( exp_2d_seg:              [pq][m]u8)
    ( coefficient_1d_seg:      [pq]XFieldElement)
    ( q_1d:                    [p]i64)
    : [n][p]XFieldElement =
        map2 (\ zerofier_inverse evaluation_point_1d ->
           let innermapped = inner_redo_map exp_2d_seg coefficient_1d_seg evaluation_point_1d
           let is = create_histogram_is q_1d pq
           let reduced = hist (^+^) XFieldElement.zero p is innermapped
           in  map (zerofier_inverse ^*^) reduced
        ) zerofier_inverse_1d evaluation_point_2d

-- TODO:
-- Most expontents are always 0, and most of the rest are 1
-- Exponents are a property of the virtual machine, not a given evm program
-- so they could be represented by futhark code, instead of input data here.

-- Zerofier could be generated in futhark
def kernel_histogram_with_is_impl
    [n][m][p][pq]
    ( zerofier_inverse_1d:  [n]XFieldElement)
    ( evaluation_point_2d:  [n]    [m]XFieldElement) -- Extension codewords
    ( exp_2d_seg:              [pq][m]u8)           -- Exponents of AIR
    ( coefficient_1d_seg:      [pq]XFieldElement)    -- Coefficients of AIR (that is, Multivariate Polynomials)
    ( is:                      [pq]i64)
    : [n][p]XFieldElement =
        map2 (\ zerofier_inverse evaluation_point_1d ->
           let innermapped = inner_redo_map exp_2d_seg coefficient_1d_seg evaluation_point_1d
           let reduced = hist (^+^) XFieldElement.zero p is innermapped
           in  map (zerofier_inverse ^*^) reduced
        ) zerofier_inverse_1d evaluation_point_2d

-------------- Experiment
def inner_redo_map_segregated
    ( exp_2d )
    ( coefficient_1d )
    ( evaluation_point_1d )
    ( evaluation_point_muted_1d )
    =
    map2 (\ exp_1d coefficient ->
        let foo = map2 (%**) evaluation_point_1d exp_1d
        let bar = reduce_comm (^*^) XFieldElement.one foo 
        let bob = reduce_comm (^*^) XFieldElement.one evaluation_point_muted_1d
        in bar ^*^ bob ^*^ coefficient
    ) exp_2d coefficient_1d

def kernel_histogram_with_is_and_muted_impl
    [n][m][p][pq][muted]
    ( zerofier_inverse_1d:        [n]XFieldElement)
    ( evaluation_point_2d:        [n]    [m]XFieldElement)
    ( evaluation_point_muted_2d:  [n]    [muted]XFieldElement)
    ( exp_2d_seg:              [pq]      [m]u8)
    ( coefficient_1d_seg:      [pq]XFieldElement)
    ( is:                      [pq]i64)
    : [n][p]XFieldElement =
        map3 (\ zerofier_inverse evaluation_point_1d evaluation_point_muted_1d->
           let innermapped = inner_redo_map_segregated exp_2d_seg coefficient_1d_seg evaluation_point_1d evaluation_point_muted_1d
           let reduced = hist (^+^) XFieldElement.zero p is innermapped
           in  map (zerofier_inverse ^*^) reduced
        ) zerofier_inverse_1d evaluation_point_2d evaluation_point_muted_2d