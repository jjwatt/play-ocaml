(* -*- mode: tuareg; -*- *)

(* Samples from ML For the Working Programmer Chapter 03 ported to OCaml *)

(* Old take from 1st edition *)
let rec oldtake i =
  function
  | [] -> []
  | x::xs when i > 0 -> x::oldtake (i-1) xs
  | x::xs -> []

(* Newer take from 2nd edition *)
let rec take l i = match l with
  | [] -> []
  | x::xs when i > 0 -> x::take xs (i-1)
  | x::xs -> []
