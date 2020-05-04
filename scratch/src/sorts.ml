open Core


let rec insert lst x =
  match lst with
  | [] -> [x]
  | y :: ys when x <= y -> x :: y :: ys
  | y :: ys -> y :: insert ys x

(* let insertion_sort = List.fold_left insert [];; *)
(* Core.Std List.fold_left needs named args *)
let insertion_sort = List.fold_left ~f:insert ~init:[]
;;

(* bubblesort -- from rosettacode *)
let rec bsort s =
  let rec _bsort =
    function
    | x :: x2 :: xs when x > x2 ->
      x2 :: _bsort (x::xs)
    | x :: x2 :: xs ->
      x :: _bsort (x2::xs)
    | s -> s
  in
  let t = _bsort s in
  if t = s then t
  else bsort t
;;

(* bubblesort -- adapted from StandardML version on rosettacode *)
(* Seems a little clearer on how it works *)
(* TODO: Adapt the scheme fixpoint one to Ocaml *)
let rec bubble_select =
  function
  | [] -> []
  | [a] -> [a]
  | a::b::xs -> if b < a
    then b::(bubble_select(a::xs))
    else a::(bubble_select(b::xs))
let rec bs_bsort =
  function
  | [] -> []
  | x::xs -> bubble_select (x::(bs_bsort xs))
;;

(* selection sort -- from rosettacode ocaml *)
let rec selection_sort =
  function
  | [] -> []
  | first::lst ->
    let rec select_r small output =
      function
      | [] -> small :: selection_sort output
      | x::xs when x < small -> select_r x (small::output) xs
      | x::xs -> select_r small (x::output) xs
    in
    select_r first [] lst
;;

