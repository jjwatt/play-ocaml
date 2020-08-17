module MinRefills

let minrefills distance tank stations =
    let needStop lastRefill nextStop =
        nextStop - lastRefill >= tank
    let allStops = stations @ [distance]
    let rec aux stations last acc =
        if (List.head(stations) - last) - tank < 0 then None
        else
        match stations with
            | [] -> Some(acc)
            | [curr] -> if needStop last curr
                          then Some(acc + 1)
                          else Some(acc)
            | curr :: tail -> if needStop last curr
                                then aux tail curr (Some(acc + 1))
                                else aux tail last (Some(acc))
            in
     aux allStops 0 0

// Do you have enough to get to the next stop?
// Yes: Go to the next stop, subtracting fuel
// No: refill here
// Or there is no next stop
