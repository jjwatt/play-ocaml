open Base
open Core

module type Dictionary =
sig
  type ('k, 'v) t

  (* The empty dictionary *)
  val empty : ('k, 'v) t

  val insert : 'k -> 'v -> ('k, 'v) t -> ('k, 'v) t
  (** [insert k v d] produces a new dictionary ['d] with the same mappings
   * as [d] and also mapping from [k] to [v], even if [k] was already
   * mapped in [d]. *)

  val lookup : 'k -> ('k, 'v) t -> 'v
  (** [lookup k d] returns the value associated with [k] in [d].
   * raises : [Not_found] if [k] is not mapped to any value in [d]. *)
end

module AssocListDictImpl =
struct
  type ('k, 'v) t = ('k * 'v) list

  let empty = []

  let insert k v d = (k, v)::d

  let lookup k d = Stdlib.List.assoc k d
end

module TreeDictImpl =
struct
  (* TODO: Implement a dictionary with trees. *)
end
