(* -*- mode: sml; -*- *)

(* sorts from mlftwp Chapter 03 *)
(* A lot of these are available at the mlftwp website *)
(* But, it's probably helpful to type them in myself *)

(* 3.4 Take and drop *)

(* These are available in smlnj as List.take and List.drop *)

(* 1ed take *)
fun take1 (i, [])    = []
  | take1 (i, x::xs) = if i > 0 then x::take1(i-1,xs)
                      else [];

(* 2ed take *)
fun take ([], i)  = []
  | take (x::xs, i) = if i>0 then x::take(xs, i-1)
                      else [];

(* rtake1: Iterative version of take *)
fun rtake1 (_, [], taken)        = taken
  | rtake1 (i, x::xs, taken) =
    if i>0 then rtake1(i-1, xs, x::taken)
    else taken;

(* 2ed rtake: Iterative version of take *)
fun rtake ([], _, taken)        = taken
  | rtake (x::xs, i, taken)     =
    if i>0 then rtake(xs, i-1, x::taken)
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

(* 3.6 Lists of lists, lists of pairs *)
(* These are named differently in 1st v. 2nd ed *)

(* 2nd ed: concat, zip, unzip *)
(* 1st ed: flat, _, split *)

(* 2nd ed versions *)
fun conspair ( (x,y), (xs,ys) ) = (x::xs, y::ys);
fun unzip [] = ([], [])
  | unzip (pair::pairs) = conspair (pair, unzip pairs);

(* A let declaration, where pattern-matching takes apart the result of the
recursive call, eliminates the function conspair *)

fun lunzip [] = ([],[])
  | lunzip ( (x,y)::pairs) =
    let val (xs,ys) = lunzip pairs
    in (x::xs, y::ys) end;

(* An iterative function can construct several results in its arguments *)
(* This is the simplest way to unzip a list, but the resulting lists are
reversed *)

fun revunzip ([], xs, ys)  =  (xs, ys)
  | revunzip ( (x,y)::pairs, xs, ys ) =
    revunzip ( pairs, x::xs, y::ys );


(* 3.16 Association lists *)

fun assoc ([], a)        = []
  | assoc ((x,y)::pairs, a) = if a=x then [y]
                              else assoc(pairs, a);

(* 3.18 Random Numbers *)

(* TODO: This is probably worth studying *)
(* Calling /nextrand/ with any /seed/ between 1 and /m/ - 1 yields another
number in this range *)
local val a = 16807.0 and m = 2147483647.0
in fun nextrand seed =
       let val t = a*seed
       in t - m * real (floor (t/m) ) end end;

(* Calling /randlist (n,seed,[])/ generates a random list of length /n/
starting from /seed/ *)
fun randlist (n, seed, tail) =
    if n=0 then (seed, tail)
    else randlist(n-1, nextrand seed, seed::tail);

(* 3.19 Insertion Sort *)
fun ins (x, []): real list = [x]
  | ins (x, y::ys) =
    if x<=y then x::y::ys
    else         y::ins(x,ys);
fun insort []      = []
  | insort (x::xs) = ins (x, insort xs);

(* Top-down merge sort *)
(* fun merge ([], ys)    = ys : real list *)
(*   | merge (xs, [])    = xs *)
(*   | merge (x::xs, y::ys) = *)
(*     if x<=y then x::merge(xs, y::ys) *)
(*     else         y::merge(x::xs, ys); *)

(* naive version *)
(* fun tmergesort []    = [] *)
(*   | tmergesort [x]   = [x] *)
(*   | tmergesort xs    = *)
(*     let val k = length xs div 2 *)
(*     in  merge (tmergesort (take(k, xs)), *)
(*                tmergesort (drop(k,xs))) *)
(*     end; *)

