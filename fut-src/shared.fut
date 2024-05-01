-- Constant-time log2 (depending on architecture, I guess)
def ilog2 (n: i64) : i64 = i64.i32 (63 - i64.clz n)

def is_power_of_2 (n: i64) : bool = n > 0 && ((n - 1) & n == 0)
