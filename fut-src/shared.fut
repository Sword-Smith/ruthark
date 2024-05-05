-- Constant-time log2 (depending on architecture, I guess)
def ilog2 (n: i64) : i64 = i64.i32 (63 - i64.clz n)

def is_power_of_2 (n: i64) : bool = n > 0 && ((n - 1) & n == 0)

def eq_arr 'a [n] [m] (eq: a -> a -> bool) (a: [n]a) (b: [m]a) : bool =
  n == m && and (map2 eq a (b :> [n]a))

def eq_arr_2d 'a [n1] [n2] [m1] [m2]
              (eq: a -> a -> bool) (a: [n1][n2]a) (b: [m1][m2]a) : bool =
  n1 == m1 && n2 == m2 && eq_arr (eq_arr eq) a (b :> [n1][n2]a)

def gather 'a (xs: []a) (is: []i64): []a =
  map (\i -> xs[i]) is
