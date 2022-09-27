use generated_lib::{Array_i32_2d, Error, FutharkContext};

#[cfg(test)]
#[test]
fn futhark_mmul() {
    let a = vec![1, 2, 3, 4];
    let b = vec![2, 3, 4, 1];

    let mut ctx = FutharkContext::new().unwrap();

    let a_arr = Array_i32_2d::from_vec(ctx, &a, &[2, 2]).unwrap();
    let b_arr = Array_i32_2d::from_vec(ctx, &b, &[2, 2]).unwrap();

    let res_arr = ctx.matmul(a_arr, b_arr).unwrap();

    let res = &res_arr.to_vec().unwrap().0;

    assert_eq!(*res, vec![10, 5, 22, 13])
}
