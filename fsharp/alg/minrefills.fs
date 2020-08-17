module MinRefills

let minrefills distance tank stations =
    let needStop lastRefill nextStop =
        nextStop - lastRefill >= tank
    let allStops = stations @ [distance]
    let rec aux stations last acc =
        match stations, acc with
            | _, None -> None
            | [], Some(acc) -> Some(acc)
            | [curr], Some(acc) -> if needStop last curr
                                   then Some(acc + 1)
                                   else Some(acc)
            | curr :: tail, Some(acc) -> if needStop last curr
                                         then aux tail curr (Some(acc + 1))
                                         else aux tail last (Some(acc))
            in
     aux allStops 0 (Some(0))

// Do you have enough to get to the next stop?
// Yes: Go to the next stop, subtracting fuel
// No: refill here
// Or there is no next stop
