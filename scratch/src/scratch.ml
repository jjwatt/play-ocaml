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

(* defining infix operators *)
module Infixy = struct
  let (^^) x y = max x y
end

module Trees = struct
  type 'a tree =
    | Leaf
    | Node of 'a * 'a tree * 'a tree
  let rec size = function
    | Leaf -> 0
    | Node (_,l,r) -> 1 + size l + size r
  let rec preorder = function
    | Leaf -> []
    | Node (value,l,r) -> [value] @ preorder l @ preorder r
  let rec inorder = function
    | Leaf -> []
    | Node (value,l,r) -> inorder l @ [value] @ inorder r
  let rec postorder = function
    | Leaf -> []
    | Node (value,l,r) -> postorder l @ postorder r @ [value]
end

module RecTrees = struct
  type 'a tree =
    | Leaf
    | Node of 'a node
  and 'a node = {
    value: 'a;
    left: 'a tree;
    right: 'a tree
  }
  let rec mem x = function
    | Leaf -> false
    | Node { value; left; right } -> value = x || mem x left || mem x right
  let rec preorder = function
    | Leaf -> []
    | Node {value; left; right} -> [value] @ preorder left @ preorder right
  let preorder_linear t =
    let rec pre_acc acc = function
      | Leaf -> acc
      | Node {value; left; right} -> value :: (pre_acc (pre_acc acc right) left)
    in pre_acc [] t
end

module MLftwpTrees = struct
  type 'a tree =
    | Lf
    | Br of 'a * 'a tree * 'a tree
  let rec size = function
    | Lf -> 0
    | Br(v,t1,t2) -> 1 + size t1 + size t2
  let rec depth = function
    | Lf -> 0
    | Br(v,t1,t2) -> 1 + max (depth t1) (depth t2)
  let rec comptree k n =
    if n = 0 then Lf
    else Br(k, comptree (2*k) (n-1),
            comptree (2*k+1) (n-1))
  let rec reflect = function
    | Lf -> Lf
    | Br(v,t1,t2) -> Br(v, reflect t2, reflect t1)
  let rec preorder = function
    | Lf -> []
    | Br(v,t1,t2) -> [v] @ preorder t1 @ preorder t2
  let rec inorder = function
    | Lf -> []
    | Br(v,t1,t2) -> inorder t1 @ [v] @ inorder t2
  let rec postorder = function
    | Lf -> []
    | Br(v,t1,t2) -> postorder t1 @ postorder t2 @ [v]
  (* Linear traversal functions *)
  (* Adapted from ML in MLftwp *)
  let preorder_lin t =
    let rec pre_acc acc = function
      | Lf -> acc
      | Br(v,t1,t2) -> v :: pre_acc (pre_acc acc t2) t1
    in pre_acc [] t
  let inorder_lin t =
    let rec in_acc acc = function
      | Lf -> acc
      | Br(v,t1,t2) ->
        let int2 = in_acc acc t2 in
        let acclist = v::int2 in
        in_acc acclist t1
    in in_acc [] t
  let postorder_lin t =
    let rec post_acc acc = function
      | Lf -> acc
      | Br(v,t1,t2) ->
        let newacc = v::acc in
        post_acc (post_acc newacc t2) t1
    in post_acc [] t

  (* 4.12 Building Trees from a list *)
  (* To construct balanced trees divide the list of
     labels roughly in half
  *)
  let rec balpre = function
    | [] -> Lf
    | x::xs ->
      let len = List.length xs in
      let k = len / 2 in
      Br(x, (balpre (List.take xs k)),
         (balpre (List.drop xs k)))

  let rec balin = function
    | [] -> Lf
    | x::xs ->
      let k = (List.length xs) / 2 in
      begin
        match List.drop xs k with
        | y::ys ->
          Br(y, balin (List.take xs k), balin ys)
        | [] -> Br([], balin (List.take xs k), balin [])
      end

  let birnam = Br("The", Br("wood", Lf,
                            Br("of", Br("Birnam", Lf, Lf),
                               Lf)),
                  Lf)
  let tree2 = Br(2, Br(1,Lf,Lf), Br(3,Lf,Lf))
  let tree5 = Br(5, Br(6,Lf,Lf), Br(7,Lf,Lf))
  (* MLftwp ex 4.20
     preorder (reflect tree2) = List.rev (postorder tree2)
     inorder (reflect tree2)  = List.rev (inorder tree2)
     postorder (reflect tree2) = List.rev (preorder tree2)
  *)
end
