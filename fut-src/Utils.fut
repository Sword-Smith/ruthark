def fst (a, _b) = a
def snd (_a, b) = b

def segments_start_indices_i32 [n] (reps:[n]i32) : [n]i32 =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let reps = assert (n > 0) reps
  let cumsum = scan (+) 0 reps
   in map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)

def segments_start_indices_i64 [n] (reps:[n]i64) : [n]i64 =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let reps = assert (n > 0) reps
  let cumsum = scan (+) 0 reps
   in map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)

def segments_end_indices_i32 [n] (reps:[n]i32) : [n]i32 =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let reps = assert (n > 0) reps
  let tmp = scan (+) (0) reps
   in map (\i -> i-1) tmp

def segments_end_indices_i64 [n] (reps:[n]i64) : [n]i64 =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let reps = assert (n > 0) reps
  let tmp = scan (+) (0) reps
   in map (\i -> i-1) tmp

def gather [p] [r] 't (idxs : [p]i64) (vals : [r]t) : [p]t =
  map (\i -> vals[i]) idxs

def gather_i32 [p] [r] (idxs : [p]i32) (vals : [r]i32) : [p]i32 =
  map (\i -> vals[i]) idxs

def gather_i64 [p] [r] (idxs : [p]i64) (vals : [r]i64) : [p]i64 =
  map (\i -> vals[i]) idxs

def gather_sums_i32 [n] [r] (reps :[n]i32) (segsum : [r]i32) : [n]i32 =
  let idxs = segments_end_indices_i32 reps
   in gather_i32 idxs segsum

def gather_sums_i64 [n] [r] (reps : [n]i64) (segsum : [r]i64) : [n]i64 =
  let idxs = segments_end_indices_i64 reps
   in gather_i64 idxs segsum

def idxs_to_flags_i32 [n] (reps:[n]i32) : ?[l].[l]bool =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let cumsum = scan (+) 0 reps
  let idxs = map i64.i32 <| map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)
  let length = i64.i32 <| reduce (+) 0 reps
  let canvas = replicate length false
  let vals = map (>0) (iota n)
   in scatter canvas idxs vals

def idxs_to_flags_i64 [n] (reps:[n]i64) : ?[l].[l]bool =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let cumsum = scan (+) 0 reps
  let idxs = map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)
  let length = reduce (+) 0 reps
  let canvas = replicate length false
  let vals = map (>0) (iota n)
   in scatter canvas idxs vals

-- Same as above, but `rv[0] == true`
def idxs_to_flags_i64_2 [n] (reps:[n]i64) : ?[l].[l]bool =
  let reps = map (\rep -> assert (rep > 0) rep) reps
  let cumsum        = scan (+) 0 reps
  let total_length  = cumsum[n-1]
  let segment_idxs  = map (\i -> if i==0 then 0 else cumsum[i-1]) (iota n)
  let canvas        = replicate total_length false
  let start_markers = replicate n true
   in scatter canvas segment_idxs start_markers

-- Segmented scan with integer addition
def segmented_scan_add [n] (flags:[n]bool) (vals:[n]i32) : [n]i32 =
  let pairs = scan ( \(v1,f1) (v2,f2) ->
                       let f = f1 || f2
                       let v = if f2 then v2 else v1+v2
                       in (v,f) ) (0,false) (zip vals flags)
  let (res,_) = unzip pairs
   in res

def map2d [m] [n] 't 'u (f : t -> u) (mtx : [m][n]t) : [m][n]u = map (map f) mtx

def zipWith [p] 't (f : t -> t -> t) (v1 : [p]t) (v2 : [p]t) : [p]t = map2 f v1 v2

-- https://graphics.stanford.edu/~seander/bithacks.html#DetermineIfPowerOf2
def is_power_of_two v = bool.i64 v && ! bool.i64 (v & (v - 1))
