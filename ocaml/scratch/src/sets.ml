open Base
open Core

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

module ExtendSet (S: Set) =
struct
  include S

  let add_all lst set =
    let add' s x = S.add x s in
    List.fold_left lst ~init:set ~f:add'
end

module ListSetNoDupsExtended = ExtendSet(ListSetNoDups)
