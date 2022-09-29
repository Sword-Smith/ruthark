module add_i32 = {
  type t = i32
  def add (x: t) (y: t): t = x + y
  def zero: t = 0
}

module type monoid = {
  type t
  val add : t -> t -> t
  val zero : t
}

module type i32_monoid = monoid with t = i32

module sum (M: monoid) = {
  def sum (a: []M.t): M.t =
    reduce M.add M.zero a
}

module sum_i32 = sum add_i32

entry main : i32 = sum_i32.sum [1,2,3,4,5,6,7,8,9,0]
