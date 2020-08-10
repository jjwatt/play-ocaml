
let rec onoroff n a l =
    match l with
        | head :: tail when n % head = 0 && not a -> onoroff n true tail
        | head :: tail when n % head = 0 && a -> onoroff n false tail
        | head :: tail -> onoroff n a tail
        | [] -> a


// TODO: Testing functions
