module Pings

let rec onoroff n a l =
    match l with
        | head :: tail when n % head = 0 && not a -> onoroff n true tail
        | head :: tail when n % head = 0 && a -> onoroff n false tail
        | head :: tail -> onoroff n a tail
        | [] -> a

let rec onoroff2 n (acc : bool) l =
    match l with
        | [] -> acc
        | head :: tail when n % head = 0 -> onoroff2 n (not acc) tail
        | head :: tail -> onoroff2 n acc tail

// TODO: Testing functions

let myt1 n acc l =
    let result1 = onoroff n acc l
    let result2 = onoroff2 n acc l
    result1 = result2
