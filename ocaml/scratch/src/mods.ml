open Core
open Base

(* FPiO Ch. 5 Modules *)

(* Queues *)
(* Queue Signature *)

module type Queue =
  sig
    type 'a queue
    val empty : 'a queue
    (** The empty queue. *)

    val is_empty : 'a queue -> bool

    val enqueue : 'a -> 'a queue -> 'a queue
    (** [enqueue x q] is the queue [q] with [x] added to the end. *)

    val peek : 'a queue -> 'a option
    (** [peek q] is [Some x], where [x] is the element at the front of the queue,
        or [None] if the queue is empty. *)

    val dequeue : 'a queue -> 'a queue option
    (** [dequeue q] is [Some q'] where [q'] is the queue containing all the elements
        of [q] except the front of [q], or [None] if [q] is empty. *)
end

module ListQueue =
struct
  (* Queue implementation using a list. dequeue is constant time,
     but enqueue is linear *)
    type 'a queue = 'a list

    let empty = []

    let is_empty = function
      | [] -> true
      | _::_ -> false

    let enqueue x q = q @ [x]

    let peek = function
      | [] -> None
      | x::_ -> Some x

    let dequeue = function
      | [] -> None
      | _::q -> Some q
end

(* Sharing Constraints *)
(* Keep type abstract *)
module LQAb : Queue = ListQueue
(* Expose type as 'a list *)
module LQEx : (Queue with type 'a queue = 'a list) = ListQueue

(* @@202010081700
   Could we use modules, sigs, includes, functors, etc. to build up tree implementations?
   Like a BST could share base structure and some functions with generic binary trees,
   but not all of them.
*)

(* FPiO 5.17 Includes *)
module type Set =
sig
  type 'a t
  val empty : 'a t
  val mem : 'a -> 'a t -> bool
  val add : 'a -> 'a t -> 'a t
  val elts : 'a t -> 'a list
end

module ListSetDups : Set =
struct
  type 'a t = 'a list
  let empty = []
  let mem x s = Stdlib.List.mem x s
  let add x s = x::s
  let elts s = Stdlib.List.sort_uniq Stdlib.compare s
end

module ListSetNoDupsImpl =
struct
  type 'a t = 'a list
  let empty = []
  let mem x s = Stdlib.List.mem x s
  let add x s =
    if mem x s
    then s
    else x::s
  let elts s = s
end

module ListSetNoDups : Set = ListSetNoDupsImpl

module ListSetDupsExtended = struct
  include ListSetDups
  let of_list lst = List.fold_right lst ~f:add ~init:empty
end

module type SetExtended =
sig
  include Set
  val of_list : 'a list -> 'a t
end

module ListSetDupsImpl =
struct
  type 'a t = 'a list
  let empty = []
  let mem x s = Stdlib.List.mem x s
  let add x s = x::s
  let elts s = Stdlib.List.sort_uniq Stdlib.compare s
end

module ListSetDups2 : Set = ListSetDupsImpl

module ListSetDupsExtendedOpen =
struct
  include ListSetDupsImpl
  let of_list lst = lst
end

module Lsdeo = ListSetDupsExtendedOpen

(* 5.22 Functors *)
module type X =
sig
  val x : int
end

module IncX (M: X) =
struct
  let x = M.x + 1
end

module AddAll(S: Set) =
struct
  let add_all lst set =
    let add' s x = S.add x s in
    List.fold_left lst ~init:set ~f:add'
end
