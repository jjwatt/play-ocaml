open Core

let rec insert lst x =
  match lst with
  |  [] -> [x]
  | y :: ys when x <= y -> x :: y :: ys
  | y :: ys -> y :: insert ys x


(* let insertion_sort = List.fold_left insert [];; *)
(* Core.Std List.fold_left needs named args *)
let insertion_sort = List.fold_left ~f:insert ~init:[]
;;

(* fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a *)
let rec fold_left f a l =
  match l with
    [] -> a
  | h::t -> fold_left f (f a h) t
;;

(* fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b *)
let rec fold_right f l a =
  match l with
    [] -> a
  | h::t -> f h (fold_right f t a)
;;

(* Reverse a list -- from 99 problems in ocaml *)
let revl list =
  let rec aux acc =
    function
    | [] -> acc
    | h::t -> aux (h::acc) t in
  aux [] list
;;
(* Reverse a list, simpler/definitional *)
let rec revlA l =
  match l with
  | [] -> []
  | h::t -> revlA t @ [h]
;;
(* NOTE: It looks so much like a fold_left, but I can't get it to work with fold_left *)
(* Got it to work with fold_left ! *)
let revF l = fold_left  (fun x y -> y::x) [] l
;;

let is_palindromel l =
  l = revl l (* list is equal to revl list *)
;;

(* Reverse a string -- from rosettacode *)
let rec revs_aux strin list index =
  if List.length list = String.length strin
  then String.concat ~sep:"" list
  else revs_aux strin ((String.sub strin index 1)::list)(index + 1)

let revs s = revs_aux s [] 0
;;

let is_palindromes s =
  s = revs s
;;

(* Combining revs_s to one function *)
let myrevs s =
  let rec aux strin list index =
    if List.length list = String.length strin
    then String.concat ~sep:"" list
    else aux strin ((String.sub strin index 1)::list)(index + 1)
  in aux s [] 0
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
