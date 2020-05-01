open Core

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
