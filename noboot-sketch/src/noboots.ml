print_endline "Hello, world!"

module DutFailureCommon = struct
  type t = { post_code: string;
             symptom_message: string;
             symptom_label: string
           }
end

module MoboLights = struct
  type t = { front: string }
end

type seriallog =
  | Present of bool
  | Nothing

(* Not quite right. The logs can be present and empty, present and non-empty or missing *)

type prefectlog =
  | Present of bool
  | Nothing

(* We can make custom types for mobo lights and post codes *)
