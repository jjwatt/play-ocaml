module MinRefills

let minrefills distance tank stations =
    let needStop lastRefill nextStop =
        nextStop - lastRefill >= tank
    let allStops = stations @ [distance]
    let rec aux stations last acc =
        // if (List.head(stations) - last) - tank < 0 then None
        match stations with
            | [] -> acc
            | [curr] -> if needStop last curr then acc + 1 else acc
            | curr :: tail -> if needStop last curr then aux tail curr acc + 1 else aux tail last acc
            in
     aux allStops 0 0

// Do you have enough to get to the next stop?
// Yes: Go to the next stop, subtracting fuel
// No: refill here
// Or there is no next stop
