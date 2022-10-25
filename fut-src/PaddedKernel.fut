import "KernelHelpers"

def kernel_padded_impl
    [n][m][p][q]
    ( zerofier_inverse_1d: [n]XFieldElement)
    ( evaluation_point_2d: [n]      [m]XFieldElement)
    ( exp_3d:                 [p][q][m]u8)
    ( coefficient_2d:         [p][q]XFieldElement)
    : [n][p]XFieldElement =
        map2 (\ zerofier_inverse evaluation_point_1d ->
            map2 (\ exp_2d    coefficient_1d ->
                inner_redo_map exp_2d coefficient_1d evaluation_point_1d
                |> reduce (^+^) XFieldElement.zero
                |> (zerofier_inverse ^*^)
            ) exp_3d coefficient_2d
        ) zerofier_inverse_1d evaluation_point_2d
