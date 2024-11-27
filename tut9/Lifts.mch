/* Lifts
* Author: User
* Creation date: 19/11/2024
*/
MACHINE Lifts
    
INCLUDES Shared, LiftA, LiftB
    
OPERATIONS
    
    addRequest(ff) =
    PRE
        ff : NAT & ff < maxFloor
    THEN
    // can also use the currentFloor(A or B) to do this. tbh it's more efficient.
        IF card(requestsA) <= card(requestsB)
        THEN
            addRequestA(ff)
        ELSE
            addRequestB(ff)
        END
    END;
    
    move =
    BEGIN
        moveA ||
        moveB
    END
    
END




