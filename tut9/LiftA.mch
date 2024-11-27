/* LiftA
* Author: User
* Creation date: 19/11/2024
*/
MACHINE 
    LiftA
    
SEES Shared
    
VARIABLES 
    currentFloorA, 
    requestsA, 
    directionA
    
INVARIANT
    currentFloorA : NAT & currentFloorA <= maxFloor &
    requestsA <: 0..maxFloor &
    directionA : Directions
    
INITIALISATION
    currentFloorA := 0 || 
    requestsA := {} || 
    directionA := None
    
OPERATIONS
    
    addRequestA(ff) =
    PRE 
        ff : NAT & ff < maxFloor
    THEN
        requestsA := requestsA \/ {ff}
    END;
    
    moveA = 
    BEGIN       
        IF requestsA = {}
        THEN 
            // If no requests, set the direction to None 
            directionA := None
            
        ELSE 
            IF currentFloorA : requestsA
            THEN
                requestsA := requestsA - {currentFloorA}
            END
            
            ||
            
            IF directionA = Down
            THEN
                // Check if there are any requests on floors below the current floor
                IF #(ff).(ff : requestsA & ff < currentFloorA)
                THEN
                    // If requests exist below, move down one floor
                    currentFloorA := currentFloorA - 1
                ELSE
                    // If no requests below, check if requests exist above
                    IF #(ff).(ff : requestsA & ff > currentFloorA)
                    THEN
                        // Change direction to Up and move up
                        directionA := Up||
                        currentFloorA := currentFloorA + 1
                    ELSE
                        // No requests in either direction, set to idle
                        directionA := None
                    END
                END
                
            ELSIF directionA = Up
            THEN
                // Check if there are any requests on floors above the current floor
                IF #(ff).(ff : requestsA & ff > currentFloorA)
                THEN
                    // If requests exist above, move up one floor
                    currentFloorA := currentFloorA + 1
                ELSE
                    // If no requests above, check if requests exist below
                    IF #(ff).(ff : requestsA & ff < currentFloorA)
                    THEN
                        // Change direction to Down and move down
                        directionA := Down||
                        currentFloorA := currentFloorA - 1
                    ELSE
                        // No requests in either direction, set to idle
                        directionA := None
                    END
                END
                
            ELSE
                // Try to find a direction to move
                IF #(ff).(ff : requestsA & ff > currentFloorA)
                THEN
                    // If requests exist above, start moving Up
                    directionA := Up||
                    currentFloorA := currentFloorA + 1
                ELSIF #(ff).(ff : requestsA & ff < currentFloorA)
                THEN
                    // If requests exist below, start moving Down
                    directionA := Down||
                    currentFloorA := currentFloorA - 1
                END
            END
        END 
    END
    
END

