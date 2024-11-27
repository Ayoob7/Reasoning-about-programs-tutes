/* LiftA
* Author: User
* Creation date: 19/11/2024
*/
MACHINE 
    LiftB
    
SEES Shared
    
VARIABLES 
    currentFloorB, requestsB, directionB
    
INVARIANT
    currentFloorB : NAT & currentFloorB <= maxFloor &
    requestsB <: 0..maxFloor &
    directionB : Directions 
INITIALISATION
    currentFloorB := 0 || requestsB := {} || directionB := None
    
OPERATIONS
    
    addRequestB( ff ) = 
    PRE ff : NAT & ff < maxFloor
    THEN
        requestsB := requestsB \/ { ff }
    END;
    
    moveB =
    BEGIN
                
        IF requestsB = {}
        THEN
            // If no requests, set the direction to None 
            directionB := None
            
        ELSE
            IF currentFloorB : requestsB
            THEN
                requestsB := requestsB - {currentFloorB}
            END
            
            ||
            
            IF directionB = Down
            THEN
                // Check if there are any requests on floors below the current floor
                IF #(ff).(ff : requestsB & ff < currentFloorB)
                THEN
                    // If requests exist below, move down one floor
                    currentFloorB := currentFloorB - 1
                ELSE
                    // If no requests below, check if requests exist above
                    IF #(ff).(ff : requestsB & ff > currentFloorB)
                    THEN
                        // Change direction to Up and move up
                        directionB := Up||
                        currentFloorB := currentFloorB + 1
                    ELSE
                        // No requests in either direction, set to idle
                        directionB := None
                    END
                END
                
                
            ELSIF directionB = Up
            THEN
                // Check if there are any requests on floors above the current floor
                IF #(ff).(ff : requestsB & ff > currentFloorB)
                THEN
                    // If requests exist above, move up one floor
                    currentFloorB := currentFloorB + 1
                ELSE
                    // If no requests above, check if requests exist below
                    IF #(ff).(ff : requestsB & ff < currentFloorB)
                    THEN
                        // Change direction to Down and move down
                        directionB := Down||
                        currentFloorB := currentFloorB - 1
                    ELSE
                        // No requests in either direction, set to idle
                        directionB := None
                    END
                END
                
            ELSE
                // Try to find a direction to move
                IF #(ff).(ff : requestsB & ff > currentFloorB)
                THEN
                    // If requests exist above, start moving Up
                    directionB := Up||
                    currentFloorB := currentFloorB + 1
                ELSIF #(ff).(ff : requestsB & ff < currentFloorB)
                THEN
                    // If requests exist below, start moving Down
                    directionB := Down||
                    currentFloorB := currentFloorB - 1
                END
            END
        END 
    END
    
END

