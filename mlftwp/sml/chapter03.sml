(* -*- mode: sml; -*- *)

(* sorts from mlftwp Chapter 03 *)
(* A lot of these are available at the mlftwp website *)
(* But, it's probably helpful to type them in myself *)

(* 3.4 Take and drop *)

(* These are available in smlnj as List.take and List.drop *)
fun take (i, [])    = []
  | take (i, x::xs) = if i > 0 then x::take(i-1,xs)
                      else [];

(* rtake: Iterative version of take *)
fun rtake (_, [], taken)        = taken
  | rtake (i, x::xs, taken) =
    if i>0 then rtake(i-1, xs, x::taken)
    else taken;

fun drop (_, [])    = []
  | drop (i, x::xs) = if i>0 then drop(i-1,xs)
                      else x::xs;

(* 3.5 Append and Reverse *)

(* append, @ *)
infix @;
fun  []        @ ys = ys
    |  (x::xs) @ ys = x :: (xs@ys);

(* naive, slow reversal, defined using append *)
(* quadratic: proportional to n^2 *)
fun nrev [] = []
  | nrev (x::xs) = (nrev xs) @ [x];

(* 3.18 Merge sorting *)

(* Top-down merge sort *)
fun merge ([], ys)    = ys : real list
  | merge (xs, [])    = xs
  | merge (x::xs, y::ys) =
    if x<=y then x::merge(xs, y::ys)
    else         y::merge(x::xs, ys);

(* naive version *)
fun tmergesort []    = []
  | tmergesort [x]   = [x]
  | tmergesort xs    =
    let val k = length xs div 2
    in  merge (tmergesort (take(k, xs)),
               tmergesort (drop(k,xs)))
    end;

