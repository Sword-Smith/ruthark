import "KernelHelpers"

def ex_scan 'a [n] (op: a -> a -> a) (ne: a) (as: [n]a) : [n]a =
    let inc_scan = scan op ne as
    let res_almost = rotate (-1) inc_scan
    in res_almost with [0] = ne

def create_segreduce_flags [p] (q_1d: [p]i64) (pq: i64) : [pq]bool =
    let is = ex_scan (+) 0 q_1d     :> [p]i64
    let vs = replicate p true       :> [p]bool
    let dest = replicate pq false   :> [pq]bool
    let flags = scatter dest is vs  :> [pq]bool
    in flags

def kernel_segmented_reduce_impl
    [n][m][p][pq]
    ( zerofier_inverse_1d:  [n]XFieldElement)
    ( evaluation_point_2d:  [n]    [m]XFieldElement)
    ( exp_2d_seg:              [pq][m]u8)
    ( coefficient_1d_seg:      [pq]XFieldElement)
    ( q_1d:                    [p]i64)
    : [n][p]XFieldElement =
        -- these flags are invarant to the outer map, and should therefore be created out here
        let flags = create_segreduce_flags q_1d pq :> [pq]bool
        in map2 (\ zerofier_inverse evaluation_point_1d ->
            let innermapped = inner_redo_map exp_2d_seg coefficient_1d_seg evaluation_point_1d
            -- this fails due to an off-by-one size somewhere
            let reduced = segmented_reduce (^+^) XFieldElement.zero flags innermapped :> [p]XFieldElement
            in  map (zerofier_inverse ^*^) reduced
        ) zerofier_inverse_1d evaluation_point_2d

def kernel_segmented_reduce_with_flags_impl
    [n][m][p][pq]
    ( zerofier_inverse_1d:  [n]XFieldElement)
    ( evaluation_point_2d:  [n]    [m]XFieldElement)
    ( exp_2d_seg:              [pq][m]u8)
    ( coefficient_1d_seg:      [pq]XFieldElement)
    ( flags:                   [pq]bool)
    : [n][p]XFieldElement =
        -- these flags are invarant to the outer map, and should therefore be created out here
        let res = map2 (\ zerofier_inverse evaluation_point_1d ->
                    let innermapped = inner_redo_map exp_2d_seg coefficient_1d_seg evaluation_point_1d :> [pq]XFieldElement
                    let reduced = segmented_reduce (^+^) XFieldElement.zero flags innermapped :> [p]XFieldElement
                    in  map (zerofier_inverse ^*^) reduced
                  ) zerofier_inverse_1d evaluation_point_2d
        let res = res :> [n][p]XFieldElement
        in res