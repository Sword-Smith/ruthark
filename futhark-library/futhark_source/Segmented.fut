module XFieldElement = import "XFieldElement"
type XFieldElement = XFieldElement.XFieldElement

def segmented_scan 't [n] (g:t->t->t) (ne: t) (flags: [n]bool) (vals: [n]t): [n]t =
  let pairs = scan ( \ (v1,f1) (v2,f2) ->
                       let f = f1 || f2
                       let v = if f2 then v2 else g v1 v2
                       in (v,f) ) (ne,false) (zip vals flags)
  let (res,_) = unzip pairs
  in res

def replicated_iota [n] (reps:[n]i64) : []i64 =
  let s1 = scan (+) 0 reps
  let s2 = map (\i -> if i==0 then 0 else s1[i-1]) (iota n)
  let tmp = scatter (replicate (reduce (+) 0 reps) 0) s2 (iota n)
  let flags = map (>0) tmp
  in segmented_scan (+) 0 flags tmp

def segmented_replicate [n] (reps:[n]i64) (vs:[n]i64) : []i64 =
  let idxs = replicated_iota reps
  in map (\i -> vs[i]) idxs

--entry idxs_to_flags [p] (qs : [p]i64) : []bool =
--  let vs = segmented_replicate qs (iota p)
--  let m = length vs
--  in map2 (!=) (vs :> [m]i64) ([0] ++ vs[:m-1] :> [m]i64)

def segmented_add [t] (flags: [t]bool) (vals : [t]XFieldElement) : []XFieldElement =
  let pairs = scan ( \(v1, f1) (v2, f2) ->
                      let f = f1 || f2
                      let v = if f2 then v2 else XFieldElement.add v1 v2
                      in (v, f) )
                      (XFieldElement.zero, false) (zip vals flags)
  let (res, _) = unzip pairs
  in res

entry main : i32 =
  let one = XFieldElement.one
  let res = segmented_add [false, false, false, true, true] [one, one, one, one, one]
  let _ = trace res
  in 0


-- Test test_idxs_to_flags
-- ==
-- entry: idxs_to_flags
-- input  { [1i64, 2i64, 3i64] }
-- output {
-- [ true,
--   false,
--   true,
--   false,
--   false,
--   true ]
-- }

-- Test test_idxs_to_flags2
-- ==
-- entry: idxs_to_flags
-- input  { [1i64, 2i64, 3i64] }
-- output {
-- [ false, false, false, true,
--   false, false, false, false,
--   false, false, false, true,
--   false, false, false, false,
--   false, false, false, false,
--   false, false, false, true ]
-- }
