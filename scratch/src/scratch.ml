let rec insert lst x =
  match lst with
  |  [] -> [x]
  | y :: ys when x <= y -> x :: y :: ys
  | y :: ys -> y :: insert ys x
;;

(* let insertion_sort = List.fold_left insert [];; *)
(* Core.Std List.fold_left needs named args *)
let insertion_sort = List.fold_left ~f:insert ~init:[];;
